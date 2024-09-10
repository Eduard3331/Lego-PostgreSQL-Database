--After importing the raw Lego data into the 'staging' schema:
CREATE SCHEMA analysis;

--Checking the upper (and lower) limit of all data types used initially so we may cut down on the memory used
SELECT 
	MIN(id),
	MAX(id),
	MAX(LENGTH(name)),
	MAX(LENGTH(rgb)),
	MAX(LENGTH(is_trans))
FROM staging.colors;

SELECT 
	MIN(id),
	MAX(id),
	MIN(version),
	MAX(version),
	MAX(LENGTH(set_num))
FROM staging.inventories;

SELECT
	MIN(inventory_id),
	MAX(inventory_id),
	MAX(LENGTH(part_num)),
	MIN(color_id),
	MAX(color_id),
	MIN(quantity),
	MAX(quantity),
	MAX(LENGTH(is_spare))
FROM staging.inventory_parts;

SELECT 
	MIN(id),
	MAX(id),
	MAX(LENGTH(name))
FROM staging.part_categories;

SELECT  
	MIN(inventory_id),
	MAX(inventory_id),
	MAX(LENGTH(set_num)),
	MIN(quantity),
	MAX(quantity)
FROM staging.inventory_sets;

SELECT
	MAX(LENGTH(part_num)),
	MAX(LENGTH(name)), 
	MIN(part_cat_id),
	MAX(part_cat_id)
FROM staging.parts;

SELECT 
	MAX(LENGTH(set_num)), 
	MAX(LENGTH(name)),
	MIN(year),
	MAX(year),
	MIN(theme_id),
	MAX(theme_id),
	MIN(num_parts),
	MAX(num_parts)
FROM staging.sets;

SELECT 
	MIN(id),
	MAX(id),
	MAX(LENGTH(name)), 
	MIN(parent_id),
	MAX(parent_id)
FROM staging.themes;

--We create new tables with properly assigned data types
CREATE TABLE analysis.colors (
	id smallint,
	name varchar(50),
	rgb varchar(6),
	is_trans varchar(1)
);

CREATE TABLE analysis.inventories (
	id smallint,
	version smallint,
	set_num varchar(20)
);

CREATE TABLE analysis.inventory_parts (
	inventory_id smallint,
	part_num varchar(15),
	color_id smallint,
	quantity smallint,
	is_spare varchar(1)
);

CREATE TABLE analysis.inventory_sets (
	inventory_id smallint,
	set_num varchar(10),
	quantity smallint
	);

CREATE TABLE analysis.part_categories (
	id smallint,
	name varchar(50)
);

CREATE TABLE analysis.parts (
	part_num varchar(15),
	name varchar(225),
	part_cat_id smallint
);

CREATE TABLE analysis.sets (
	set_num varchar(20),
	name varchar(100),
	year smallint,
	theme_id smallint,
	num_parts smallint
);

CREATE TABLE analysis.themes (
	id smallint,
	name varchar(50),
	parent_id smallint
);


--We insert the raw data into the new tables
INSERT INTO analysis.colors (
	SELECT * FROM staging.colors
);

INSERT INTO analysis.inventories (
	SELECT * FROM staging.inventories
);

INSERT INTO analysis.inventory_parts (
	SELECT * FROM staging.inventory_parts
);

INSERT INTO analysis.inventory_sets (
	SELECT * FROM staging.inventory_sets
);

INSERT INTO analysis.part_categories (
	SELECT * FROM staging.part_categories
);

INSERT INTO analysis.parts (
	SELECT * FROM staging.parts
);

INSERT INTO analysis.sets (
	SELECT * FROM staging.sets
);

INSERT INTO analysis.themes (
	SELECT 
		id,
		name,
		CAST(parent_id as smallint)
	FROM staging.themes
);

INSERT INTO analysis.parts (
	SELECT DISTINCT
		IP.part_num,
		NULL as name,
		CAST(NULL as smallint) as part_cat_id
		FROM analysis.inventory_parts as IP
	LEFT JOIN analysis.parts as P ON IP.part_num = P.part_num
	WHERE P.part_num IS NULL
);

-- We add primary keys for the tables
ALTER TABLE analysis.colors ADD PRIMARY KEY (id);
ALTER TABLE analysis.inventories ADD PRIMARY KEY (id);
ALTER TABLE analysis.parts ADD PRIMARY KEY (part_num);
ALTER TABLE analysis.part_categories ADD PRIMARY KEY (id);
ALTER TABLE analysis.sets ADD PRIMARY KEY (set_num);
ALTER TABLE analysis.themes ADD PRIMARY KEY (id);

-- We add foreign keys
ALTER TABLE analysis.parts ADD FOREIGN KEY (part_cat_id) 
	REFERENCES analysis.part_categories(id);

ALTER TABLE analysis.inventory_parts ADD FOREIGN KEY (inventory_id) 
	REFERENCES analysis.inventories(id);

ALTER TABLE analysis.inventory_parts ADD FOREIGN KEY (part_num) 
	REFERENCES analysis.parts(part_num);

ALTER TABLE analysis.inventory_parts ADD FOREIGN KEY (color_id) 
	REFERENCES analysis.colors(id);

ALTER TABLE analysis.inventory_sets ADD FOREIGN KEY (inventory_id) 
	REFERENCES analysis.inventories(id);

ALTER TABLE analysis.inventory_sets ADD FOREIGN KEY (set_num) 
	REFERENCES analysis.sets(set_num);

ALTER TABLE analysis.sets ADD FOREIGN KEY (theme_id) 
	REFERENCES analysis.themes(id);

ALTER TABLE analysis.inventories ADD FOREIGN KEY (set_num) 
	REFERENCES analysis.sets(set_num);