
// MongoDB Operations:


// Import the provided JSON file into collection 'products'

// Initialize your project: Run npm init -y in your terminal.

//Install the driver: Run npm install mongodb

const { MongoClient } = require('mongodb');
const fs = require('fs');

async function main() {
    //Connection URL local MongoDB
    const url = 'mongodb://localhost:27017';
    const client = new MongoClient(url);

   
    const dbName = 'products_catalog';
    const collectionName = 'products';

    try {
        // Connect to the MongoDB server
        await client.connect();
        console.log('Connected successfully to server');

        const db = client.db(dbName);
        const collection = db.collection(collectionName);

        // Read the JSON file
        const rawData = fs.readFileSync('products_catalog.json', 'utf8');
        const jsonData = JSON.parse(rawData);

        // Insert data into MongoDB
        // We use insertMany because your data is an Array of objects
        const result = await collection.insertMany(jsonData);

        console.log(`${result.insertedCount} products were successfully loaded!`);

    } catch (err) {
        console.error('Error loading data:', err);
    } finally {
        // Close connection
        await client.close();
    }
}

main();


// Find all products in "Electronics" category with price less than 50000
// Return only: name, price, stock
db.products.find(
  { 
    category: "Electronics", 
    price: { $lt: 50000 } 
  },
  { 
    name: 1, 
    price: 1, 
    stock: 1, 
    _id: 0 
  }
);


// Find all products that have average rating >= 4.0
// Use aggregation to calculate average from reviews array
db.products.aggregate([
  {
    $project: {
      name: 1,
      category: 1,
      // Calculate the average rating from the reviews array
      averageRating: { $avg: "$reviews.rating" }
    }
  },
  {
    // Filter the results to include only those with avg >= 4.0
    $match: {
      averageRating: { $gte: 4.0 }
    }
  },
  {
    // Sort by rating descending
    $sort: { averageRating: -1 }
  }
]);


// Add a new review to product "ELEC001"
// Review: {user: "U999", rating: 4, comment: "Good value", date: ISODate()}
db.products.updateOne(
  { product_id: "ELEC001" }, 
  { 
    $push: { 
      reviews: { 
        user_id: "U999", 
        username: "NewReviewAdder", 
        rating: 4, 
        comment: "Good value", 
        date: new Date() 
      } 
    } 
  }
);


// Calculate average price by category
// Return: category, avg_price, product_count
// Sort by avg_price descending

db.products.aggregate([
  {
    $group: {
      _id: "$category",                 // Group by category 
      avg_price: { $avg: "$price" },     //  mean price
      product_count: { $sum: 1 }         // Count 1 for each document
    }
  },
  {
    $project: {
      _id: 0,                          
      category: "$_id",                 // Rename _id back to category
      avg_price: { $round: ["$avg_price", 2] }, // Round to 2 decimal places
      product_count: 1
    }
  },
  {
    $sort: { avg_price: -1 }             // Sort descending by price
  }
]);





