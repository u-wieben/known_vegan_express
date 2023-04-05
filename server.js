import express from "express";										
import cors from "cors";													
import dotenv from "dotenv";	
import filterRouter from "./filter/filterRouter.js";
import recipesListRouter  from "./liste/listRouter.js"

dotenv.config();
const port = process.env.port || process.env.PORT || 5000; 
const app = express(); 

app.use(express.json());											
app.use(cors({ origin: /http:\/\/localhost/ }));  
app.options('*', cors());													

app.use('/filter', filterRouter); 
app.use("/list", recipesListRouter);

app.listen(port, () => { console.log(`Known Vegan API-Service listen on ${port}`) })