# 1)Analyze the monthly rental trends over the available data period.
SELECT DATE_FORMAT(rental.rental_date, '%Y-%m') as rental_month,
COUNT(rental.rental_id) as total_rentals
FROM rental
group by  rental_month
order by  rental_month;


# 2)Determine the peak rental hours in a day based on rental transactions.
select HOUR(rental.rental_date) as rental_hour,
COUNT(rental.rental_id) as total_rentals
from rental
group by  rental_hour
order by  total_rentals desc;


# 3)Identify the top 10 most rented films.
select film.film_id,film.title,COUNT(rental.rental_id) as rental_count
from film 
join inventory on film.film_id = inventory.film_id
join rental on inventory.inventory_id = rental.inventory_id
join payment on rental.rental_id = payment.rental_id
group by film.film_id,film.title
order by rental_count desc limit 10;


#4)Determine which film categories have the highest number of rentals.
select film_category.film_id,category.category_id,category.name,count(rental.rental_id) as rental_count
from category join film_category 
on category.category_id = film_category.category_id
join inventory 
on film_category.film_id = inventory.film_id 
join rental
on  inventory.inventory_id = rental.inventory_id
group by film_id,category_id,name
order by rental_count desc limit 5;


# 5)Identify which store generates the highest rental revenue.
select store.store_id,sum(amount) as rental_revenue
from payment join staff on 
payment.staff_id = staff.staff_id
join store on
staff.store_id = store.store_id
group by store_id
order by rental_revenue desc;


# 6)Determine the distribution of rentals by staff members to assess performance.
select payment.staff_id,staff.first_name,staff.last_name,count(rental_id) as no_of_rentals
from payment join staff
on payment.staff_id = staff.staff_id
group by payment.staff_id,staff.first_name,staff.last_name
order by no_of_rentals desc;


