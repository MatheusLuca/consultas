# Seleciona id/fist name/lastname/email da tabela customer
# juntando os campos address.address_id = customer.address_id em comum nas tabelas address e customer
# quando o customer_id  estiver entre 50 e 599 e ordenando first_name crescente

select customer_id, first_name, last_name, email
	from customer
		inner join address on address.address_id = customer.address_id
			where customer_id between 50 and 599
			group by first_name ASC;

# retorna staff nome, id data de pagamento ordenada ascendente e preço.
select first_name, s.staff_id, payment_date, amount
	from staff s
		inner join payment p on s.staff_id = p.staff_id
			where s.staff_id = 2 group by payment_date ASC;

#seleciona os campos da tabelas film e languege
# junta essas tabelas pelo idioma do filme
# separa apenas aqueles filmes que contem classificação indicativa NC-17 maiores de 17

select title, release_year, f.language_id, rating as 'Classificação indicativa', l.name, f.last_update
	from film f
		inner join language l 
        on f.language_id = l.language_id
			where rating like '%___17';

# PEGA nome do cliente, preço e funcionario. das tabelas customer, payment e staff
# retorna 

select  C.first_name as 'Cliente', P.amount, S.first_name as 'Funcionário'
	from customer C
		inner join payment P
			on C.customer_id = P.customer_id
		inner join staff S
			on S.staff_id = P.staff_id
				where S.first_name like '%jon' AND
                P.amount > '0.99'
                group by P.amount ASC;

select F.title, F.release_year, F.rental_duration , fc.last_update, c.name 
    from film F
		inner join film_category FC
			on F.film_id = FC.film_id
		inner join category C 
			on C.category_id = FC.category_id
			where F.rental_duration >= 4
			order by c.name ASC;

#LEFT-JOIN retorna todos os registros da tabela A mesmo que não estejam na tabela b.
# os registros de b que seja comum a A

#seleciona nome data de criação código postal e telefone dos clientes com o active em 0
	select C.first_name, C.last_name, C.create_date, A.postal_code, A.phone
		From customer C
			left join address A
				on C.address_id = A.address_id
					where C.active = 0
                    order by C.first_name Desc;
	
 # retorna o total de vendas dos staff com id 1 e 2   
		select Sum(P.amount)  as vendastotais
			from staff S
				inner join payment P
					on S.staff_id = P.staff_id
                    where P.staff_id between '1' and '2';
	


# retorna quanto cada cliente gastou maior que 100 ordenando por distrito e somente de clientes ativos
		select C.first_name , C.active, sum(P.amount), A.district
			from customer C
				inner join payment P
					on P.customer_id = C.customer_id
				inner join address A
					on A.address_id = C.address_id
                    where A.district not like ''
                    group by A.district ASC
                    having sum(P.amount) > 100;
    
# Seleciona os filmes com as melhores taxas de aluguel e ordena pela categoria
	select F.title, F.rental_rate, C.name
		from film F
			inner join film_category FC
				on FC.film_id = F.film_id
			inner join category C
				on C.category_id = FC.category_id
                where F.rental_rate = '4.99';
	              
#Seleciona os paises que possuem 5 ou menos cidades.
	select C.country, count(CIT.city) as total_cidade
		from country C
		left join city CIT
			on CIT.country_id = C.country_id
            group by  C.country
            having total_cidade <= 5
            ;

# seleciona o nome, sobrenome email do cliente
#O id e o distrito da tabela address
#cidade da tabela cidade e pais da tabela pais
#onde o pais nao é brasil, argetina e india
#address id entre 0 e 190 e agrupando por address_id
select CUS.first_name, CUS.last_name, CUS.email, AD.address_id, AD.district, CIT.city, COU.country
	from customer CUS
		inner join address AD
			on AD.address_id = CUS.address_id
		inner join city CIT
			on CIT.city_id = AD.city_id
		inner join country COU
			on COU.country_id = CIT.country_id
            where COU.country not in ('Brazil', 'Argentina', 'India')
            AND AD.address_id between 0 AND 190
            GROUP BY AD.address_id;


#Busca quantos filmes tem em cada categoria 
    select C.name, count(FC.category_id) as 'qtd_film_categoria'
		From category C
			inner join film_category FC
				on FC.category_id = C.category_id
			inner join film F
				on F.film_id = FC.film_id
                group by C.name;
                
#select colunas
#from tabelas
#where coluna_operador
#		( select coluna frmo tabela where condições)#
select *from staff;
select *from payment ;
select *from customer ;

	select Avg (P.amount) AS 'MEDIA VENDAS MIKE', S.first_name
		from customer C
			inner join payment P
				on P.customer_id = C.customer_id
			inner join staff S
				on S.staff_id = P.staff_id
					where S.first_name like '%mike' ;
	
   	select min(P.amount) AS 'MEDIA VENDAS jon', S.first_name
		from customer C
			inner join payment P
				on P.customer_id = C.customer_id
			inner join staff S
				on S.staff_id = P.staff_id 
                where S.first_name like  '%jon';
						
			
	select COU.country, count(CIT.city_id)
    from customer C
			inner join address Ad
				on AD.address_id = C.address_id
			inner join city CIT
				on CIT.city_id = AD.city_id
			inner join country COU
				on COU.country_id = CIT.country_id;
					
			
