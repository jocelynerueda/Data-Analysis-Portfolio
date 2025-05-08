## DASHBOARD 

# --- Orders activity
SELECT o.order_id, m.item_price, o.quantity, m.item_name, o.purchase_datetime, 
a.delivery_street, a.delivery_region, a.delivery_city, o.delivery
FROM Orders o 
LEFT JOIN menu m ON o.item_id = m.item_id
LEFT JOIN address a ON o.address_id = o.address_id

# --- Inventory Management

# Number of orders and ingredients per item
SELECT s1.item_name, s1.ing_id, s1.ing_name, s1.ing_weight, 
s1.ing_price, s1.order_quantity, s1.recipe_quantity, 
s1.order_quantity * s1.recipe_quantity as ordered_weight, # quantity of ingredients needed to fullfill order history
s1.ing_price / s1.ing_weight as unit_cost, # unit corst of ingredients
(s1.order_quantity * s1.recipe_quantity) * (s1.ing_price / s1. ing_weight) as ingredient_cost # ingredient costs to fulfill orders

FROM (SELECT o.item_id, m.item_name, r.ing_id, i.ing_name,
r.quantity as recipe_quantity, sum(o.quantity) as order_quantity,
i.ing_weight, i.ing_price # table with orders and ingredients per item
FROM Orders o
LEFT JOIN menu m ON o.item_id = m.item_id
LEFT JOIN recipe r ON m.item_name = r.recipe_id
LEFT JOIN ingredient i ON i.ing_id = r.ing_id
GROUP BY o.item_id, m.item_name, r.ing_id, r.quantity, 
i.ing_name, i.ing_weight, i.ing_price ) AS s1
# save this query as atock1

# Calculate 
# a) total weight ordered 
# b) inventory amount
# c) inventory remaining per ingredient

SELECT s2.ing_name, s2.ordered_weight,
ing.ing_weight * inv.quantity AS total_inv_weight, # actual inventory weight for each ingredient
(ing.ing_weight * inv.quantity) - s2.ordered_weight AS remaining_weight # inventory minous orders 
FROM (SELECT ing_id, ing_name, 
sum(ordered_weight) AS ordered_weight
FROM stock1
GROUP BY ing_id, ing_name ) AS s2
LEFT JOIN inventory inv ON inv.item_id = s2.ing_id
LEFT JOIN ingredient ing ON ing.ing_id = s2.ing_id

# Staff cost

SELECT r.date, s.first_name, s.last_name, s.hourly_rate,
sh.start_time, sh.end_time,
((hour(TIMEDIFF(sh.end_time,sh.start_time))*60 )+ (minute(timediff(sh.end_time,sh.start_time))))/60 AS hours_in_shift,
((hour(TIMEDIFF(sh.end_time,sh.start_time))*60 )+ (minute(timediff(sh.end_time, sh.start_time))))/60 * s.hourly_rate AS staff_cost
FROM rota r
LEFT JOIN  staff s ON r.staff_id = s.staff_id
LEFT JOIN  shift sh ON r.shift_id = sh.shift_id












