/* Check the number of claims and claim payments. */
SELECT count(*) FROM claims; -- 497 claims in total
SELECT count(*) FROM claim_payments; -- 2418 claim payments in total

/* Aggregate the claim payments by claim id and payment year. */
SELECT c.claim_id, cp.payment_year, sum(cp.payment_amount)
FROM claims AS c
	LEFT JOIN claim_payments AS cp
    ON c.claim_id = cp.claim_id
GROUP BY c.claim_id, cp.payment_year
ORDER BY c.claim_id ASC, 
		 cp.payment_year ASC;
         
/* Order the claim types by total claim payment in descending order.*/
SELECT c.claim_type, sum(payment_amount) AS total_payment
FROM claims AS c
	LEFT JOIN claim_payments AS cp
	ON c.claim_id = cp.claim_id
GROUP BY c.claim_type
ORDER BY total_payment DESC;
-- In order of decreasing total payments: 
-- Fire, Water Damage, Wind/Hail, Flood, Theft.

/* Compute the average payment per claim type. */
SELECT c.claim_type, avg(payment_amount) AS avg_payment
FROM claims AS c
	LEFT JOIN claim_payments AS cp
	ON c.claim_id = cp.claim_id
GROUP BY c.claim_type;

/* Which claims have their claim payments total above $250,000, 
   and what are their claim types? */
WITH total_claim_payment (claim_id, claim_type, total_payment) AS (
	SELECT c.claim_id, c.claim_type, sum(cp.payment_amount) 
    FROM claims AS c
		LEFT JOIN claim_payments AS cp
			ON c.claim_id = cp.claim_id
	GROUP BY claim_id 
)
SELECT * FROM total_claim_payment
	WHERE total_payment > 250000;
-- claim_id 10309 with fire loss of amount $315,572.82

/* Create a table showing total payments from OPEN CLAIMS IN 2025
   according to claim type and accident year. 
   In the calculation for the total payments, exclude any
   claims with loss over $250,000.
   (This is used to compute the ultimate losses.) */
SELECT c.claim_type, c.accident_year, sum(cp.payment_amount) AS total_payment
FROM claims AS c
	LEFT JOIN claim_payments AS cp
    ON c.claim_id = cp.claim_id
WHERE c.accident_year = '2025' AND c.status = 'Open\r' AND cp.payment_amount < 250000
GROUP BY c.claim_type, c.accident_year
ORDER BY c.claim_type ASC;