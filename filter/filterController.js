import pool from "../database/pool.js";

export const getBlankFilterDefs = async (request, response, next) => {
  const { rows } = await pool.query('select * from filterdefs');
  const data = rows[0]; 
  response.json({ data });
}