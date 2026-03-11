/*
 * Create a report that shows the total revenue per month and year.
 *
 * HINT:
 * This query is very similar to the previous problem,
 * but requires an additional JOIN.
 */
SELECT
    EXTRACT(YEAR FROM r.rental_date) AS year,
    EXTRACT(MONTH FROM r.rental_date) AS month,
    SUM(p.amount) AS total_revenue
FROM rental r
JOIN payment p
    ON r.rental_id = p.rental_id
GROUP BY
    EXTRACT(YEAR FROM r.rental_date),
    ROLLUP(EXTRACT(MONTH FROM r.rental_date))
ORDER BY year, month;
