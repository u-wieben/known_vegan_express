-- --------------------------------------------------------
-- Host:                         sirius.uwe-wieben.de
-- Server-Version:               PostgreSQL 15.2 (Debian 15.2-1.pgdg110+1) on x86_64-pc-linux-gnu, compiled by gcc (Debian 10.2.1-6) 10.2.1 20210110, 64-bit
-- Server-Betriebssystem:        
-- HeidiSQL Version:             12.4.0.6659
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES  */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Exportiere Struktur von Tabelle public.filter
CREATE TABLE IF NOT EXISTS "filter" (
	"id" BIGINT NOT NULL DEFAULT 'nextval(''filter_id_seq''::regclass)',
	"description" VARCHAR(40) NULL DEFAULT NULL,
	"filtercategories_id" BIGINT NOT NULL,
	PRIMARY KEY ("id"),
	CONSTRAINT "filter_filtercategories_id_fkey" FOREIGN KEY ("filtercategories_id") REFERENCES "filtercategories" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION
);

-- Exportiere Daten aus Tabelle public.filter: 12 rows
/*!40000 ALTER TABLE "filter" DISABLE KEYS */;
INSERT IGNORE INTO "filter" ("id", "description", "filtercategories_id") VALUES
	(1, 'Deutschland', 1),
	(3, 'Senegal', 1),
	(5, 'Frankreich', 1),
	(7, 'Indien', 1),
	(9, 'Frühstück', 6),
	(11, 'Mittag', 6),
	(13, 'Abend', 6),
	(15, 'Snack', 6),
	(17, 'Einfache Küche', 3),
	(20, 'Eintopf', 3),
	(22, 'Mehrgängiges Menü', 3),
	(24, 'Alltagstauglich', 3);
/*!40000 ALTER TABLE "filter" ENABLE KEYS */;

-- Exportiere Struktur von Tabelle public.filtercategories
CREATE TABLE IF NOT EXISTS "filtercategories" (
	"id" BIGINT NOT NULL DEFAULT 'nextval(''filtercategories_id_seq''::regclass)',
	"decription" VARCHAR(40) NULL DEFAULT NULL,
	PRIMARY KEY ("id")
);

-- Exportiere Daten aus Tabelle public.filtercategories: -1 rows
/*!40000 ALTER TABLE "filtercategories" DISABLE KEYS */;
INSERT IGNORE INTO "filtercategories" ("id", "decription") VALUES
	(1, 'Länder'),
	(3, 'Aufwand'),
	(6, 'Tageszeit');
/*!40000 ALTER TABLE "filtercategories" ENABLE KEYS */;

-- Exportiere Struktur von View public.filterdefs
-- Erstelle temporäre Tabelle, um View-Abhängigkeiten zuvorzukommen
CREATE TABLE "filterdefs" (
	"filterdefs" JSON NULL
) ENGINE=MyISAM;

-- Exportiere Struktur von Tabelle public.Ingredients
CREATE TABLE IF NOT EXISTS "Ingredients" (
	"ID" INTEGER NOT NULL DEFAULT 'nextval(''"Ingredients_ID_seq"''::regclass)',
	"Description" VARCHAR(255) NULL DEFAULT NULL,
	PRIMARY KEY ("ID")
);

-- Exportiere Daten aus Tabelle public.Ingredients: -1 rows
/*!40000 ALTER TABLE "Ingredients" DISABLE KEYS */;
INSERT IGNORE INTO "Ingredients" ("ID", "Description") VALUES
	(1, 'Tomaten'),
	(3, 'Paprika');
/*!40000 ALTER TABLE "Ingredients" ENABLE KEYS */;

-- Exportiere Struktur von Tabelle public.Preparation
CREATE TABLE IF NOT EXISTS "Preparation" (
	"Id" INTEGER NOT NULL DEFAULT 'nextval(''"Preparation_Id_seq"''::regclass)',
	"Nummer" INTEGER NOT NULL,
	"Step" TEXT NULL DEFAULT NULL,
	PRIMARY KEY ("Id")
);

-- Exportiere Daten aus Tabelle public.Preparation: -1 rows
/*!40000 ALTER TABLE "Preparation" DISABLE KEYS */;
/*!40000 ALTER TABLE "Preparation" ENABLE KEYS */;

-- Exportiere Struktur von Tabelle public.recipes
CREATE TABLE IF NOT EXISTS "recipes" (
	"id" BIGINT NOT NULL DEFAULT 'nextval(''recipes_id_seq''::regclass)',
	"description" VARCHAR(250) NULL DEFAULT NULL,
	PRIMARY KEY ("id")
);

-- Exportiere Daten aus Tabelle public.recipes: -1 rows
/*!40000 ALTER TABLE "recipes" DISABLE KEYS */;
INSERT IGNORE INTO "recipes" ("id", "description") VALUES
	(1, 'Butter Chicken mit Tofu und Blumenkohl'),
	(3, 'Linsentopf'),
	(6, 'Kaiserschmarn'),
	(10, 'Ofengemüse mit Topinambour Purée');
/*!40000 ALTER TABLE "recipes" ENABLE KEYS */;

-- Exportiere Struktur von Tabelle public.recipes_filter_rel
CREATE TABLE IF NOT EXISTS "recipes_filter_rel" (
	"recipes_id" BIGINT NOT NULL,
	"filter_id" BIGINT NOT NULL,
	CONSTRAINT "recipes_filter_rel_filter_id_fkey" FOREIGN KEY ("filter_id") REFERENCES "filter" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT "recipes_filter_rel_recipes_id_fkey" FOREIGN KEY ("recipes_id") REFERENCES "recipes" ("id") ON UPDATE NO ACTION ON DELETE NO ACTION
);

-- Exportiere Daten aus Tabelle public.recipes_filter_rel: -1 rows
/*!40000 ALTER TABLE "recipes_filter_rel" DISABLE KEYS */;
INSERT IGNORE INTO "recipes_filter_rel" ("recipes_id", "filter_id") VALUES
	(1, 7),
	(6, 9),
	(3, 20),
	(1, 11);
/*!40000 ALTER TABLE "recipes_filter_rel" ENABLE KEYS */;

-- Exportiere Struktur von View public.filterdefs
-- Entferne temporäre Tabelle und erstelle die eigentliche View
DROP TABLE IF EXISTS "filterdefs";
CREATE VIEW "filterdefs" AS  SELECT json_agg(tab.tupel) AS filterdefs
   FROM ( SELECT json_build_object('id', filtercategories.id, 'descr', filtercategories.decription, 'filter', json_agg(json_build_object('id', filter.id, 'descr', filter.description, 'checked', false))) AS tupel
           FROM filter,
            filtercategories
          WHERE (filter.filtercategories_id = filtercategories.id)
          GROUP BY filtercategories.id) tab;;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
