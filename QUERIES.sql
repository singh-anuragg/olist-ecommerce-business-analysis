--                                  25 Real Business Questions

-- Q1 What are the main revenue drivers?
	
	 
		SELECT
		    p.product_category_name,
		    SUM(oi.price) AS total_revenue,
		    COUNT(DISTINCT oi.order_id) AS total_orders,
		    SUM(oi.price) / COUNT(DISTINCT oi.order_id) AS avg_order_value
		FROM order_items oi
		JOIN products p	
		    ON oi.product_id = p.product_id
		GROUP BY p.product_category_name
		ORDER BY total_revenue DESC;



-- Q2 Which months had revenue increases or decreases?
		
		SELECT
		    DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
		    SUM(oi.price) AS revenue
		FROM orders o
		JOIN order_items oi
		    ON o.order_id = oi.order_id
		GROUP BY month
		ORDER BY month;



-- Q3 Which categories have high sales but low average order value?

		SELECT
		    p.product_category_name,
		    SUM(oi.price) AS revenue,
		    COUNT(DISTINCT oi.order_id) AS orders,
		    ROUND(
		        SUM(oi.price) / COUNT(DISTINCT oi.order_id),
		        2
		    ) AS avg_order_value
		FROM order_items oi
		JOIN products p
		    ON oi.product_id = p.product_id
		GROUP BY p.product_category_name
		HAVING COUNT(DISTINCT oi.order_id) >= 100
		ORDER BY avg_order_value;



-- Q4 How many customers purchased only once?

		SELECT
		    COUNT(*) AS one_time_customers
		FROM (
		    SELECT
		        customer_unique_id,
		        COUNT(DISTINCT order_id) AS orders
		    FROM customers c
		    JOIN orders o
		        ON c.customer_id = o.customer_id
		    GROUP BY customer_unique_id
		    HAVING COUNT(DISTINCT order_id) = 1
		) x;	



-- Q5 What customer segments have the highest repeat-purchase rate ?

WITH customer_orders AS (
		    SELECT
		        c.customer_unique_id,
		        COUNT(DISTINCT o.order_id) AS total_orders
		    FROM customers c
		    JOIN orders o
		        ON c.customer_id = o.customer_id
		    GROUP BY c.customer_unique_id
		)
		
		SELECT
		    CASE
		        WHEN total_orders = 1 THEN 'One-time'
		        WHEN total_orders BETWEEN 2 AND 3 THEN 'Repeat'
		        ELSE 'Highly Repeat'
		    END AS customer_segment,
		    COUNT(*) AS customers
		FROM customer_orders
		GROUP BY customer_segment
		ORDER BY customers DESC;




-- Q6 Who are the highest-value customers?

		SELECT
		    c.customer_unique_id,
		    SUM(oi.price) AS lifetime_revenue,
		    COUNT(DISTINCT o.order_id) AS total_orders
		FROM customers c
		JOIN orders o
		    ON c.customer_id = o.customer_id
		JOIN order_items oi
		    ON o.order_id = oi.order_id
		GROUP BY c.customer_unique_id
		ORDER BY lifetime_revenue DESC
		LIMIT 20;



-- Q7 How long does it take customers to make their second purchase?

		WITH customer_orders AS (
		    SELECT
		        c.customer_unique_id,
		        o.order_purchase_timestamp,
		        ROW_NUMBER() OVER (
		            PARTITION BY c.customer_unique_id
		            ORDER BY o.order_purchase_timestamp
		        ) AS order_number
		    FROM customers c
		    JOIN orders o
		        ON c.customer_id = o.customer_id
		),
		
		first_second AS (
		    SELECT
		        customer_unique_id,
		        MAX(
		            CASE
		                WHEN order_number = 1
		                THEN order_purchase_timestamp
		            END
		        ) AS first_order,
		        MAX(
		            CASE
		                WHEN order_number = 2
		                THEN order_purchase_timestamp
		            END
		        ) AS second_order
		    FROM customer_orders
		    GROUP BY customer_unique_id
		)
		
		SELECT
		    AVG(second_order - first_order) AS avg_time_to_second_purchase
		FROM first_second
		WHERE second_order IS NOT NULL;




-- Q8 Which states generate the most revenue?

		SELECT
		    c.customer_state,
		    SUM(oi.price) AS revenue,
		    COUNT(DISTINCT o.order_id) AS orders
		FROM customers c
		JOIN orders o
		    ON c.customer_id = o.customer_id
		JOIN order_items oi
		    ON o.order_id = oi.order_id
		GROUP BY c.customer_state
		ORDER BY revenue DESC;



-- Q9 What categories receive the lowest review scores ?

		SELECT
		    p.product_category_name,
		    ROUND(AVG(r.review_score)::numeric, 2) AS avg_review_score,
		    COUNT(r.review_id) AS total_reviews
		FROM order_items oi
		JOIN products p
		    ON oi.product_id = p.product_id
		JOIN order_reviews r
		    ON oi.order_id = r.order_id
		GROUP BY p.product_category_name
		HAVING COUNT(r.review_id) >= 50
		ORDER BY avg_review_score;


-- Q10 Does delivery delay affect review scores?
		
		SELECT
		    CASE
		        WHEN o.order_delivered_customer_date >
		             o.order_estimated_delivery_date
		        THEN 'Late'
		        ELSE 'On Time'
		    END AS delivery_status,
		
		    ROUND(AVG(r.review_score)::numeric, 2) AS avg_review_score,
		    COUNT(*) AS orders
		FROM orders o
		JOIN order_reviews r
		    ON o.order_id = r.order_id
		WHERE o.order_delivered_customer_date IS NOT NULL
		GROUP BY delivery_status;


-- Q11 What high-revenue sellers have poor ratings or delivery performance?

		SELECT
		    oi.seller_id,
		    SUM(oi.price) AS revenue,
		    ROUND(AVG(r.review_score)::numeric, 2) AS avg_review_score,
		    COUNT(DISTINCT oi.order_id) AS orders
		FROM order_items oi
		JOIN order_reviews r
		    ON oi.order_id = r.order_id
		GROUP BY oi.seller_id
		HAVING SUM(oi.price) > 10000
		   AND AVG(r.review_score) < 3.5
		ORDER BY revenue DESC;

-- Q12 Which payment methods do customers prefer ?
		
		SELECT
		    payment_type,
		    COUNT(*) AS transactions,
		    SUM(payment_value) AS total_payment
		FROM order_payments
		GROUP BY payment_type
		ORDER BY transactions DESC;



-- Q13 How common are installment payments?

		SELECT
		    CASE
		        WHEN payment_installments = 1
		            THEN 'One-time'
		        ELSE 'Installment'
		    END AS payment_category,
		
		    COUNT(*) AS transactions,
		
		    ROUND(
		        100.0 * COUNT(*) /
		        SUM(COUNT(*)) OVER (),
		        2
		    ) AS percentage
		
		FROM order_payments
		
		GROUP BY payment_category
		ORDER BY percentage DESC;



-- Q14 What categories or sellers have the highest cancellation rates?
		
		SELECT
		    COUNT(*) FILTER (
		        WHERE order_status = 'canceled'
		    ) AS cancelled_orders,
		
		    COUNT(*) AS total_orders,
		
		    ROUND(
		        100.0 *
		        COUNT(*) FILTER (
		            WHERE order_status = 'canceled'
		        ) / COUNT(*),
		        2
		    ) AS cancellation_rate
		
		FROM orders;
