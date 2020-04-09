--3.1 JOIN

--1. 마당서점의 고객이 요구

 --5) 박지성이 구매한 도서의 출판사 수 
SELECT COUNT(DISTINCT PUBLISHER)   -- DISTINCT 주의하라.
FROM ORDERS, CUSTOMER, BOOK
WHERE ORDERS.CUSTID = customer.CUSTID
      AND orders.bookid = book.bookid
      AND name LIKE '박지성';      -- LIKE 주의

 --6) 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이
SELECT bookname, PRICE, PRICE - saleprice
FROM ORDERS, CUSTOMER, BOOK
WHERE ORDERS.CUSTID = customer.CUSTID
      AND orders.bookid = book.bookid
      AND name LIKE '박지성';
 
 --7) 박지성이 구매하지 않은 도서의 이름
 --MINUS, NOT IN, NOT EXIST 활용
 
  --(1) MINUS
SELECT BOOKNAME
FROM BOOK
MINUS
SELECT bookname
FROM ORDERS, CUSTOMER, BOOK
WHERE ORDERS.CUSTID = customer.CUSTID
  AND orders.bookid = book.bookid
  AND name LIKE '박지성';
  
  --(2) NOT IN
select bookname
from book
where bookname not in 
                (SELECT bookname
                FROM ORDERS, CUSTOMER, BOOK
                WHERE ORDERS.CUSTID = customer.CUSTID
                  AND orders.bookid = book.bookid
                  AND name LIKE '박지성');
     
  --(3) not exists
select bookname
from book
where not exists 
                (SELECT bookname
                FROM ORDERS, CUSTOMER 
                WHERE ORDERS.CUSTID = customer.CUSTID
                  AND orders.bookid = book.bookid
                  AND name LIKE '박지성');     
     
--2. 마당서점의 운영자와 경영자가 요구

 --8) 주문하지 않은 고객의 이름(JOIN)
 --MINUS, NOT IN, NOT EXIST
  
   --(1) minus
 SELECT NAME
 FROM customer
 MINUS
 SELECT NAME
 FROM ORDERS, CUSTOMER
 WHERE ORDERS.CUSTID = customer.custid;
 
   --(2) not in
 select name
 from customer
 where name not in 
                (SELECT NAME
                 FROM ORDERS, CUSTOMER
                 WHERE ORDERS.CUSTID = customer.custid);
 
  --(3) not exists
 select name
 from customer
 where not exists 
                (SELECT NAME
                 FROM ORDERS
                 WHERE ORDERS.CUSTID = customer.custid);    
 
 --9) 주문 금액의 총액과 주문의 평균 금액
 SELECT SUM(saleprice), AVG(SALEPRICE)
 FROM ORDERS;
 
 --10) 고객의 이름과 고객별 구매액
 SELECT NAME, SUM(orders.saleprice)
 FROM CUSTOMER, ORDERS
 WHERE ORDERS.CUSTID = customer.custid
 GROUP BY name;
 
 --11) 고객의 이름과 고객이 구매한 도서 목록
 SELECT name, BOOKNAME
 FROM CUSTOMER, ORDERS, book
 WHERE ORDERS.CUSTID = customer.CUSTID
   AND orders.bookid = book.bookid;
 
 --12) 도서의 가격(BOOK TABLE)과 판매가격(ORDERS TABLE)의 차이가 가장 많은 주문
 SELECT orders.orderid
 FROM ORDERS, BOOK
 WHERE orders.bookid = book.bookid
       AND PRICE-SALEPRICE = 
       (SELECT MAX(PRICE-saleprice)
          FROM ORDERS, BOOK
         WHERE orders.bookid = book.bookid);
                                             
 --13) 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름
 SELECT NAME, AVG(SALEPRICE)
 FROM ORDERS, CUSTOMER
 WHERE orders.custid = customer.custid
 GROUP BY NAME
 HAVING AVG(SALEPRICE) > (SELECT AVG(SALEPRICE) FROM ORDERS);  --(select ~) 괄호 주의
    
   
           

           
      



