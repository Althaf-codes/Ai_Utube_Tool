 const mongoose = require('mongoose');
 const dotenv = require('dotenv');
 const connectDB = async()=>{
    dotenv.config({path:'./server/config.env'});
     try {
        const conn = await mongoose.connect(
            process.env.MONGO_URI||'undefined',async(err)=>{
                if(err) throw err;

                console.log("MONGODB CONNECTED SUCCESSFULLY");
               
            })
           // console.log(`connected host:${conn.connection.host}`);
     } catch (error) {
         console.log(error);
         process.exit(1);
         
     }
 }
 
 module.exports = connectDB;
 