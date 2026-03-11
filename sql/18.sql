/*
 * Compute the total revenue for each film.
 * The output should include another new column "revenue percent" that shows the percent of total revenue that comes from the current film and all previous films.
 * That is, the "revenue percent" column is 100*"total revenue"/sum(revenue)
 *
 * HINT:
 * The `to_char` function can be used to achieve the correct formatting of your percentage.
 * See: <https://www.postgresql.org/docs/current/functions-formatting.html#FUNCTIONS-FORMATTING-EXAMPLES-TABLE>
 */
SELECT a.rank,
       a.title,
       a.revenue,
       SUM(a.revenue) OVER (ORDER BY a.revenue DESC, a.rank) as "total revenue",
       to_char((100 * SUM(a.revenue) OVER (ORDER BY a.revenue DESC, a.rank) / SUM(a.revenue) OVER ()), 'FM900.00') AS "percent revenue"
FROM (
    SELECT RANK() OVER(ORDER BY COALESCE(SUM(amount), 0.00) DESC) rank, film.title, COALESCE(SUM(amount), 0.00) AS revenue
    FROM film                                    
    LEFT JOIN inventory USING (film_id)                                                                    LEFT JOIN rental USING (inventory_id)                                                                  LEFT JOIN payment USING (rental_id)                                                                    GROUP BY film_id
    ORDER BY revenue DESC
) as a
GROUP BY a.rank, a.title, a.revenue
ORDER BY a.rank, a.title; 
