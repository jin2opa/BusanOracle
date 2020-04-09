--3.1 JOIN

--1. ���缭���� ���� �䱸

 --5) �������� ������ ������ ���ǻ� �� 
SELECT COUNT(DISTINCT PUBLISHER)   -- DISTINCT �����϶�.
FROM ORDERS, CUSTOMER, BOOK
WHERE ORDERS.CUSTID = customer.CUSTID
      AND orders.bookid = book.bookid
      AND name LIKE '������';      -- LIKE ����

 --6) �������� ������ ������ �̸�, ����, ������ �ǸŰ����� ����
SELECT bookname, PRICE, PRICE - saleprice
FROM ORDERS, CUSTOMER, BOOK
WHERE ORDERS.CUSTID = customer.CUSTID
      AND orders.bookid = book.bookid
      AND name LIKE '������';
 
 --7) �������� �������� ���� ������ �̸�
 --MINUS, NOT IN, NOT EXIST Ȱ��
 
  --(1) MINUS
SELECT BOOKNAME
FROM BOOK
MINUS
SELECT bookname
FROM ORDERS, CUSTOMER, BOOK
WHERE ORDERS.CUSTID = customer.CUSTID
  AND orders.bookid = book.bookid
  AND name LIKE '������';
  
  --(2) NOT IN
select bookname
from book
where bookname not in 
                (SELECT bookname
                FROM ORDERS, CUSTOMER, BOOK
                WHERE ORDERS.CUSTID = customer.CUSTID
                  AND orders.bookid = book.bookid
                  AND name LIKE '������');
     
  --(3) not exists
select bookname
from book
where not exists 
                (SELECT bookname
                FROM ORDERS, CUSTOMER 
                WHERE ORDERS.CUSTID = customer.CUSTID
                  AND orders.bookid = book.bookid
                  AND name LIKE '������');     
     
--2. ���缭���� ��ڿ� �濵�ڰ� �䱸

 --8) �ֹ����� ���� ���� �̸�(JOIN)
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
 
 --9) �ֹ� �ݾ��� �Ѿװ� �ֹ��� ��� �ݾ�
 SELECT SUM(saleprice), AVG(SALEPRICE)
 FROM ORDERS;
 
 --10) ���� �̸��� ���� ���ž�
 SELECT NAME, SUM(orders.saleprice)
 FROM CUSTOMER, ORDERS
 WHERE ORDERS.CUSTID = customer.custid
 GROUP BY name;
 
 --11) ���� �̸��� ���� ������ ���� ���
 SELECT name, BOOKNAME
 FROM CUSTOMER, ORDERS, book
 WHERE ORDERS.CUSTID = customer.CUSTID
   AND orders.bookid = book.bookid;
 
 --12) ������ ����(BOOK TABLE)�� �ǸŰ���(ORDERS TABLE)�� ���̰� ���� ���� �ֹ�
 SELECT orders.orderid
 FROM ORDERS, BOOK
 WHERE orders.bookid = book.bookid
       AND PRICE-SALEPRICE = 
       (SELECT MAX(PRICE-saleprice)
          FROM ORDERS, BOOK
         WHERE orders.bookid = book.bookid);
                                             
 --13) ������ �Ǹž� ��պ��� �ڽ��� ���ž� ����� �� ���� ���� �̸�
 SELECT NAME, AVG(SALEPRICE)
 FROM ORDERS, CUSTOMER
 WHERE orders.custid = customer.custid
 GROUP BY NAME
 HAVING AVG(SALEPRICE) > (SELECT AVG(SALEPRICE) FROM ORDERS);  --(select ~) ��ȣ ����
    
   
           

           
      



