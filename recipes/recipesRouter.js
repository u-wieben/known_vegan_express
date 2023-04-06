import { Router } from "express";
import { getRecipesFilter } from "./recipesController.js";

const recipesFilterRouter = Router(); 

recipesFilterRouter.get('/count/:filter', getRecipesFilter); 

export default recipesFilterRouter; 