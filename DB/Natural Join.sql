SELECT filter.description, recipes.description FROM filter, recipes, recipes_filter_rel 
 WHERE recipes.id = 1 AND recipes.id = recipes_filter_rel.recipes_id AND filter.id = recipes_filter_rel.filter_id