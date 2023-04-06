import pool from "../database/pool.js";

export const getRecipesFilter = async (req, res, next) => {
  const { filter } = req.params;
  const { rows } =
    filter.length > 0
      ? await pool.query(
          `SELECT COUNT(*) FROM (SELECT r.id, COUNT(*) AS fcount FROM recipes r, recipes_filter_rel rfr WHERE r.id = rfr.recipes_id AND (rfr.filter_id IN (${filter})) GROUP BY r.id HAVING COUNT(*) = array_length(ARRAY[${filter}], 1)) AS fcount2`
        )
      : await pool.query(`SELECT COUNT(*) FROM recipes`);

  const data = rows;
  res.json({ data });
};
