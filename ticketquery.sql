--erwthma a
select category ,count(category)
from transactions inner join ticketbuy on transactions.ticketcode = ticketbuy.ticketcode
group by category;

--erwthma b
select category , sum(price) as euro
from transactions 
inner join ticketbuy on transactions.ticketcode = ticketbuy.ticketcode
group by category
having sum(price)=(select max(euro) as fooa
				   from
				   (select category , sum(price) as euro
				   from transactions
				   inner join ticketbuy on transactions.ticketcode = ticketbuy.ticketcode
				   group by category) as t
				  );
				  
				  
--erwthma c 
select category , cast(avg(price::numeric) as decimal(10,2))
from transactions 
inner join ticketbuy on transactions.ticketcode = ticketbuy.ticketcode
inner join customers on transactions.custcode = customers.custcode
where age >=16 and age<=44
group by category
order by cast(avg(price::numeric) as decimal(10,2)) desc;


--erwthma d		
select ticketbuy.ticketcode , count(ticketbuy.ticketcode) as maxsales
from transactions 
inner join ticketbuy on transactions.ticketcode = ticketbuy.ticketcode
group by ticketbuy.ticketcode
having count(price)=(select max(maxsales) as foo
				   from
				   (select ticketbuy.ticketcode , count(ticketbuy.ticketcode) as maxsales
				   from transactions
				   inner join ticketbuy on transactions.ticketcode = ticketbuy.ticketcode
				   group by ticketbuy.ticketcode) as t
				  );


--erwthma e 
select category , customers.custcode , count(transactions.custcode) as maxcateg
from transactions
inner join ticketbuy on transactions.ticketcode = ticketbuy.ticketcode
inner join customers on transactions.custcode = customers.custcode
group by category , customers.custcode
having count(transactions.custcode) = (select max(maxcateg) as foo
				   from
				   (select category  , customers.custcode ,  count (transactions.custcode) as maxcateg
				   from transactions
				   inner join ticketbuy on transactions.ticketcode = ticketbuy.ticketcode
     			   inner join customers on transactions.custcode = customers.custcode
				   group by category , customers.custcode) as t
				  );				  
		--to erwthma ayto emfanizei mono ton pelath me tis perissoteres agores alla oxi ana kathgoria 
				 
--erwthma f
select compname , max(transactions.compcode)
from transactions
inner join company on transactions.compcode = company.compcode
where transactions.compcode = (select max(compcode) from transactions)
group by compname;


--erwthma g
select transactions.ticketcode
from transactions 
inner join ticketbuy on transactions.ticketcode=ticketbuy.ticketcode
where datesale>='2019-03-05'
group by transactions.ticketcode;				 
				 