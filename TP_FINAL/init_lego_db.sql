CREATE TABLE colors (
    id INT PRIMARY KEY,
    name VARCHAR(30),
    rgb VARCHAR(8),
    is_trans BOOLEAN
);

COPY colors(id, name, rgb, is_trans)
FROM '/csv_data/colors.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"');

CREATE TABLE part_categories (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

COPY part_categories(id, name)
FROM '/csv_data/part_categories.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"');

CREATE TABLE parts (
    part_num VARCHAR(20) PRIMARY KEY,
    name VARCHAR(250),
    part_cat_id INT,
    FOREIGN KEY (part_cat_id) REFERENCES part_categories(id)    
);

COPY parts(part_num, name, part_cat_id)
FROM '/csv_data/parts.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"');

CREATE TABLE themes (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    parent_id INT,
    FOREIGN KEY (parent_id) REFERENCES themes(id)    
);

COPY themes(id, name, parent_id)
FROM '/csv_data/themes.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"');

CREATE TABLE sets (
    set_num VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100),
    year INT,
    theme_id INT,
    num_parts INT,
    FOREIGN KEY (theme_id) REFERENCES themes(id)    
);

COPY sets(set_num, name, year, theme_id, num_parts)
FROM '/csv_data/sets.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"');

CREATE TABLE inventories (
    id INT PRIMARY KEY,
    version INT,
    set_num VARCHAR(20),
    FOREIGN KEY (set_num) REFERENCES sets(set_num)
);

COPY inventories(id, version, set_num)
FROM '/csv_data/inventories.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"');

CREATE TABLE inventory_parts (
    inventory_id INT,
    part_num VARCHAR(20),
    color_id INT,
    quantity INT,
    is_spare BOOLEAN,
    PRIMARY KEY (inventory_id, part_num, color_id, is_spare),
    FOREIGN KEY (inventory_id) REFERENCES inventories(id),
--    FOREIGN KEY (part_num) REFERENCES parts(part_num),
    FOREIGN KEY (color_id) REFERENCES colors(id)    
);

/*
Se comenta la FK porque el conjunto de datos da error, no es consistente con esa definición.
Varios de los part_num que figuran en inventory_parts.csv no existen en parts.csv
Por ejemplo:
ERROR:  insert or update on table "inventory_parts" violates foreign key constraint "inventory_parts_part_num_fkey"
DETAIL:  Key (part_num)=(48002) is not present in table "parts".
*/

COPY inventory_parts(inventory_id, part_num, color_id, quantity, is_spare)
FROM '/csv_data/inventory_parts.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"');

CREATE TABLE inventory_sets (
    inventory_id INT,
    set_num VARCHAR(20),
    quantity INT,
    PRIMARY KEY (inventory_id, set_num),
    FOREIGN KEY (set_num) REFERENCES sets(set_num),
    FOREIGN KEY (inventory_id) REFERENCES inventories(id)
);

COPY inventory_sets(inventory_id, set_num, quantity)
FROM '/csv_data/inventory_sets.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"');


