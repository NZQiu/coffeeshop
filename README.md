

# Mini Coffee Shop for demo RoR


This mini project is created for demo RoR. [Click me to have a try](https://fathomless-savannah-94343.herokuapp.com/)

### Requirements

---------------------------------

Menu of a coffee shop:

|            | Tall | Grande | Venti |
| ---------- | ---- | ------ | ----- |
| Espresso   | 1.95 | 2.05   | 2.35 |
| Latte      | 3.4  | 4.45   | 4.65 |
| Cappuccino | 3.15 | 3.75   | 4.15 |
| Green Tea  | 3.45 | 4.25   | 4.45 |
| Hot Tea    |   -  | 1.95   | -    |

0. Adding orders
1. Keep track of all orders (total sales)
2. Group orders by type of orders (coffee or tea)
3. Group orders by type of size (tall, grande or venti)

### MockUp Layer Design

---------------------------------

This one single page mockup will design as below (Draw by [Balsamiq](https://balsamiq.com/products/mockups/)).

![MockUp Design](http://ww2.sinaimg.cn/large/5ed3c1c2gw1f1e10xblabj20dp0d9ack.jpg)

1. Click dropdown **Make a order** to make a new order. Order listing below will auto update once order create successfully.
2. Click dropdown **Group by Type** to filter all orders with that drink type.
3. Click dropdown **Group by Cup** to filter all orders with that Cup size.
4. Group **Group by Type** and **Group by Cup** is combinational support.
5. Order listing will show most 5 orders per page.
  - If the result count is larger than 5, pagination will show.
  - If no result found, text 'No result found' will show.
6. Click **Refresh icon** to refresh the order listing.
  - Here assume server response time is 2 second. 'Debounce' was use here to protect server overload in case of keep pressing 'Refresh'.
7. **Total sales** will auto update once the orders listing was updated.

### App Layer Design

---------------------------------

[Font Awesome](https://fortawesome.github.io/Font-Awesome/) + [Bootstrap](http://getbootstrap.com/) + [jQuery](https://jquery.com/) + [Rails](http://rubyonrails.org/)+ [Postgresql](http://www.postgresql.org/) + [Heroku](https://www.heroku.com/) (Host)

| HTTP Verb | Path | Controller#Action |
| ----------| ---- | ----------------- |
| GET       | /orders/listing | orders#listing |
| GET      | /orders  | orders#index |
| POST | /orders | orders#create |
| GET  | / | orders#index |

  gem [rspec-rails](https://github.com/rspec/rspec-rails) was used to test rails model && controller.

### Database Layer Design

---------------------------------

![coffeeshop UML](http://ww1.sinaimg.cn/large/5ed3c1c2gw1f1e21l9qy1j20ih05aweu.jpg)

Three tables was designed for the mini app:

1. `drinks`
  - [name:varchar]: Name of the drink like 'Espresso' 'Hot Tea'
  - [drink_type:varchar]: drink type: 'coffee' or 'tea'
2. `items`
  - [drink_id:integer]: foreign key of table `drinks`, refer the drink.
  - [price:integer]: price of that drink. Use **integer** here, if need show on front-end, divide by 100.
  - [cup_size:varchar]: Cup size of the drink, i.e. 'tall' 'grande' 'venti'
3. `orders`
  - [item_id]: foreign key of table `items`, refer the item ordered.


### Additional questions:

---------------------------------

1. *What if we want a new type of coffee, a new type of tea?*
  > If have a new type of coffee or tea like 'Red Tea', firstly create new drink with [name='Red Tea', drink_type='teas'], then create new items base on the cup size like [drink_id: 'id of red tea drink', cup_size: 'tall|grande|venti', price: 6.66]

2. *What if we want a new size?*
  > Current design assume that the cup size not change so frequently. There are two ways for that feature change. One way is create new record in table `items`, for example, 'Espresso' with cup size 'mini': [drink_id:'espresso drink id', cup_size: 'mini', 'price': 1.22]. Code and test case need change for this feature. The other ways is refactor the database: create a new table to store cup_size which similar as table `drinks`. We may call it table `cups`: [name:varchar]. If have a new size like 'mini', create a new record in that table.

  ![ coffeeshop newSize](http://ww1.sinaimg.cn/large/5ed3c1c2gw1f1e48fvb68j20ih06y3yz.jpg)

3. *How would you change the model to add hot/cold options?*
  > Depends on the product logic. If price is same for hot and cold, add a new column to table `orders`, otherwise add a new column to table `items`.

4. *(optional) How would you change the model to support adding condiments to drinks (perl, grass jelly,...)*
  >Suppose that each drink item can add many condiments and the price is different for different combinations.  We may create new table called `condiments` with two columns [name:varchar, price:integer], and add two new columns to table `orders` [c_price:integer, c_list:varchar]. When create new order, sum all the choose condiments price then store it in `orders:c_price`, and concat the name of condiments then store it in `orders:c_list`.

  ![coffeeshop condiments](http://ww3.sinaimg.cn/large/5ed3c1c2gw1f1e3prwctgj20ih08mgm9.jpg)


-----------------

- In the case images not shown properly, please refer the [asset folder](https://github.com/NZQiu/coffeeshop/tree/master/app/assets/images).
