/*
 * Create a report that shows the total revenue per month and year.
 *
 * HINT:
 * This query is very similar to the previous problem,
 * but requires an additional JOIN.
 */
SELECT
    EXTRACT (YEAR FROM rental_date) as "Year",
    EXTRACT (MONTH FROM rental_date) as "Month",
    SUM(amount) as "Total Revenue"
FROM
    rental
JOIN payment ON payment.rental_id = rental.rental_id
GROUP BY
    ROLLUP (
        EXTRACT (YEAR FROM rental_date),
        EXTRACT (MONTH FROM rental_date)
    )
ORDER BY "Year", "Month";
