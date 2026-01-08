## limitations of RDBMS
---

# Products having different attributes (e.g., laptops have RAM/processor, shoes have size/color)
 When it comes to RDMS, the data is stored in databases which consits of tables, further breaking down to rows and columns. When you plan to store data inside a database you need to design a schema, which defines the attributes of the data to be stored. The strict/Rigid structure is both its greatest strength and its biggest weakness.
 It is excellent for financial consistency, but it struggles with semi-structured or ever-changing data.

# Frequent schema changes when adding new product types.
Suppose we are storing data of electronics prodcuts, in this condition we will need to have multiple tables to store different sub-products. The reason being that theattributes of one sub-product will not be applicable for the other one, in this case the columns will have no value or Null values which may cause further issues or skew our results, in other words it will give us a "holey" database where most cells are empty, wasting storage and making queries messy. Expanding the bussiness will be a major challenege due to the schema rigidity. On a live database with millions of rows, this task can be slow and risky. It locks the table, meaning your website might go down or become "Read Only" while the database structure is being updated

# Storing customer reviews as nested data
The RDMS hates nested data, and also as part of optimisation and to stay in 3NF rules the nested data should be stored in separate table. A review can be as short as upto few words or may go up to paragraphs and each products can have multiple reviews. The Struggle is to show a single product page with its reviews and comments, the database has to perform a massive JOIN operation across 3 or 4 tables.Product ---> Reviews ---> Review_Comments ---> Users.
As your data grows, these joins become mathematically expensive and slow down the page load time significantly. SQL is designed to point to one thing, not to hold a "nest" of many things.
---

## NoSQL Benefits
---

Explain how MongoDB solves these problems using:

# Flexible schema (document structure)
# Embedded documents (reviews within products)
# Horizontal scalability

1. In MongoDB, a "Collection" is like a table, but it has no fixed structure/schema. Each document can have its own unique fields. we can store different category of product data in one, can store a Laptop and a pair of Shoes in the same products collection. The Laptop document contains a ram field, while the Shoe document contains a size field.
The Benefit is that there are no NULL values. If a product doesn't have a feature, that field simply doesn't exist in that document. This makes adding new product types (like Perfume with a scent field) as easy as saving a new file—no modifications to table required unlike RDBMS system.

2. Embedded Documents (Nested Data)
RDBMS system split data into multiple tables to stay organized (Normalization). MongoDB prefers Denormalization, where you keep related data together in one record.
For nested data, instead of having a separate reviews table that requires a JOIN, you "embed" an array of reviews directly inside the product document.
The upside is that to load any data or even huge data set, the database performs one single read operation. It pulls the product info, price, and all 50 reviews in one go. This drastically improves performance for read-heavy applications like e-commerce.

3. Horizontal Scalability (Sharding)
Relational databases usually scale Vertically i.e. buying a bigger, more expensive server. MongoDB is designed to scale Horizontally.
Working wise the MongoDB uses a process called Sharding. It breaks your massive dataset into small chunks and distributes them across a "cluster" of many different servers.
The Pros are that if the data volume traffic grows from 1,000 users to 10 million, we you don't need a supercomputer. We just add more standard servers to the cluster. MongoDB automatically balances the data and the traffic across them.

---
## Trade-offs
---

# What are two disadvantages of using MongoDB instead of MySQL for this product catalog?
The two disadvantages of using MongoDB instead of MySQL specifically for this catalogue:

1. Risk of Orphaned User Data in Reviews
In data the product contains a list of reviews with user_id and username.
- The MySQL Advantage: In MySQL it would have a users table. If a user deleted their account, MySQL could automatically delete their reviews or block the account deletion to keep data clean.
- The MongoDB Disadvantage: Since the reviews are embedded directly inside the product documents (like ELEC001), MongoDB has no built-in way to know that the user_id: "U001" in the review belongs to a real user in another collection.

*The Result:* If "TechGuru" deletes their account, their review remains stuck inside the Samsung Galaxy document. This data becomes inconsistent unless addressed.

2. Data Redundancy
In Fashion items (FASH001, FASH003), repeated keys "brand", "material", and "sizes_available" inside every single document.

- The MySQL Advantage: MySQL stores the schema once at the top of the table. The rows only contain the actual values (e.g., "Levi's").

- The MongoDB Disadvantage: MongoDB stores the field names inside every single document. If we have 10,000 fashion items, we are storing the string "sizes_available" 10,000 times.

*The Result:* This catalogue will take up significantly more disk space and RAM in MongoDB than in MySQL. For a large-scale version of this catalogue, hosting cost would be higher.

---
