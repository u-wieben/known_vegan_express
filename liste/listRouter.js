import { Router } from "express";
import { getRecipesList } from "./listController.js";

const recipesListRouter = Router(); 


recipesListRouter.get('/', getRecipesList); 

export default recipesListRouter; 