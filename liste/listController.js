import pool from "../database/pool.js";

export const getRecipesList = async (request, response, next) => {
  const { rows } = await pool.query('select * from recipes_by_dish_name');
  const data = rows; 
  response.json({ data });
}