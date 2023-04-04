import { Router } from "express";
import { getBlankFilterDefs } from "./filterController.js";

const filterRouter = Router(); 

filterRouter.get('/', getBlankFilterDefs); 

export default filterRouter; 