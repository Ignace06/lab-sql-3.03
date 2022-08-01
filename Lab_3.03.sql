use sakila;

-- How many copies of the film Hunchback Impossible exist in the inventory system?

select f.title, count(inventory_id) as Nb_copy from inventory as i
join film as f
on f.film_id = i.film_id
where title ="Hunchback Impossible"
group by f.film_id;
-- 6 copies


-- List all films whose length is longer than the average of all the films.
select  avg(length) from film;

select title, length from film
where length > (select avg(length) from film);

-- Use subqueries to display all actors who appear in the film Alone Trip.
-- option 1
select a.first_name, a.last_name, f.title from actor as a
join film_actor as fa
on fa.actor_id = a.actor_id
join film as f
on f.film_id = fa.film_id
group by f.title
having f.title = "Alone Trip";

-- option 2
select * from (
	select a.first_name, a.last_name, f.title from actor as a
	join film_actor as fa
	on fa.actor_id = a.actor_id
	join film as f
	on f.film_id = fa.film_id
) as sub1
group by title
having title = "Alone Trip";

-- Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
select name from category;

select f.title, c.name from category as c
join film_category as fc
on fc.category_id = c.category_id
join film as f
on f.film_id=fc.film_id
where c.name ="Family"; 
-- 69 films

-- Get name and email from customers from Canada using subqueries. Do the same with joins. 
-- option 1
select cu.last_name, cu.email, c.country from country as c
join city as ci
on ci.country_id = c.country_id
join address as a 
on a.city_id = ci.city_id
join customer as cu
on cu.address_id = a.address_id
where c.country = "Canada";

-- option 2 
select * from (
	select cu.last_name, cu.email, c.country from country as c
	join city as ci
	on ci.country_id = c.country_id
	join address as a 
	on a.city_id = ci.city_id
	join customer as cu
	on cu.address_id = a.address_id
) as sub1
where country = "Canada";

-- Which are films starred by the most prolific actor? 
select a.first_name, a.last_name, count(f.film_id) as Nb_film from film as f
join film_actor as fa
on fa.film_id = f.film_id
join actor as a
on a.actor_id = fa.actor_id
group by a.last_name
order by Nb_film desc
limit 5;
-- Sandra Kilmer with 134 films

-- Films rented by most profitable customer.

