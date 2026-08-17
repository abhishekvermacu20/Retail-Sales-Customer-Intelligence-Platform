1. olist_customer_dataset:-
The customer_id changed, everytime you order something.
But customer_unique_id remained the same.
Exemple: 
First Order
Abhishek
Order #1001
customer_id = A123
customer_unique_id = U999

Second Order (One Month Later)
Abhishek
Order #1002
customer_id = B456
customer_unique_id = U999

2. olist_order_items_dataset:-
You noticed that order_item_id ranges from 1 to 21.
That's because the largest order in the dataset contains 21 products.
Exemple :-
order_id	order_item_id	Product
ORD1001			1	Laptop
ORD1001			2	Mouse
ORD1001			3	Keyboard

It is showing one to many relationships : A One-to-Many relationship exists when one record in the first table can be associated with multiple records in the second table, but each record in the second table belongs to only one record in the first table.

3. order_item_dataset : price v/s freight_value
price:-
The selling price of that individual product.
Laptop = ₹100
freight_value:-
The shipping cost (delivery charge) allocated to that item.
Example:
Shipping = ₹15

4. olist_order_reviews_dataset:- review_creation_date v/s review_answer_timestamp
1. review_creation_date:-
This is the date when the customer submitted (created) the review.
2. review_answer_timestamp
This is the timestamp when the review became available (published/processed) in the Olist system.

5. order_purchase_timestamp, order_approved_at, order_delivered_carrier_date, order_delivered_customer_date, order_estimated_delivery_date:-
1. order_purchase_timestamp
When did the customer click "Place Order"?
2. order_approved_at
When was the payment approved by the system?
3. order_delivered_carrier_date
When did the seller hand the package over to the delivery company (carrier)?
4. order_delivered_customer_date
When was the package actually delivered to the customer?
5. order_estimated_delivery_date
This is NOT an actual event.
It's the date the company promised the customer.



