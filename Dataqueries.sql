--Oldest age of customer
select *
from client
where ClientDoB = (select min(ClientDoB) from client)

--Youngest age of customer
select *
from client
where ClientDoB = (select MAX(ClientDoB) from client)


--Total number of purchases by age 
select client.clientdob, count(borrower.bookid) as Numberofpurchases
from borrower
Inner Join client
	on borrower.clientid=client.clientid
group by client.clientdob
order by Numberofpurchases DESC


--Total number of purchases by Generation x in year 2018
select Sum(NumberofPurchases) as numberofpurchasesgenx
FROM (select client.clientdob, COUNT(borrower.bookid) as NumberofPurchases
from borrower
Inner Join client
	on borrower.clientid=client.clientid
where clientdob BETWEEN '1960' and '1980'
and borrowdate between '2018-01-01' and '2018-12-31'
group by client.clientdob
order by NumberofPurchases DESC) as numberofPurchasesgenx

--Total number of purchases by Millenials in year 2018
select Sum(numberofborrows) numberofpurchasesmillenials
FROM (select client.clientdob, COUNT(borrower.bookid) as NumberofBorrows
from borrower
Inner Join client
	on borrower.clientid=client.clientid
where clientdob BETWEEN '1981' and '1996'
and borrowdate between '2018-01-01' and '2018-12-31'
group by client.clientdob
order by NumberofBorrows DESC) as numberofborrowsmillenials

--Total number of purchases by Gen Z in year 2018
select Sum(numberofborrows) numberofpurchasesgenz
FROM (select client.clientdob, COUNT(borrower.bookid) as NumberofBorrows
from borrower
Inner Join client
	on borrower.clientid=client.clientid
where clientdob > '1996'
and borrowdate between '2018-01-01' and '2018-12-31'
group by client.clientdob
order by NumberofBorrows DESC) as numberofborrowsgenz


--Top 5 Authors 
select author.authorfirstname, author.authorlasttname, count(book.bookauthor)
from author
inner join book 
	on book.bookauthor=author.authorid
inner join borrower
	on book.bookid=borrower.bookid
group by book.bookauthor, author.authorfirstname, author.authorlasttname
order by count(book.bookauthor) DESC
limit 5

--Top 5 author nationalities in 2018
select distinct author.authornationality, count(author.authornationality) as Countofpurchases
from borrower
inner join book 
	on borrower.bookid=book.bookid
inner join author
	on book.bookauthor=author.authorid
where borrower.borrowdate between '2018-01-01' and '2018-12-31'
group by author.authornationality
order by count(author.authornationality) DESC
limit 5	

--Top 5 genres in 2018
select book.genre, count(book.genre) as Countofpurchases
from borrower
inner join book 
	on borrower.bookid=book.bookid
inner join client
	on borrower.clientid=client.clientid
where borrower.borrowdate between '2018-01-01' and '2018-12-31'
group by book.genre
order by count(book.genre) DESC
limit 5	
