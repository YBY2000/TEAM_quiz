//Question2
//A


-- Drop the sequence if it exists
BEGIN
   EXECUTE IMMEDIATE 'DROP SEQUENCE brick_id_seq';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -2289 THEN
         RAISE;
      END IF;
END;
/

-- Drop the table if it exists
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE bricks';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

-- Create the table
CREATE TABLE bricks (
  brick_id INTEGER,
  color    VARCHAR2(40),
  shape    VARCHAR2(40),
  weight   INTEGER
);

-- Add the primary key
ALTER TABLE bricks ADD PRIMARY KEY (brick_id);

-- Create the sequence
CREATE SEQUENCE brick_id_seq START WITH 1;

-- Insert the data
INSERT INTO bricks (brick_id, color, shape, weight) VALUES (brick_id_seq.NEXTVAL, 'blue', 'cube', 1);
INSERT INTO bricks (brick_id, color, shape, weight) VALUES (brick_id_seq.NEXTVAL, 'blue', 'pyramid', 2);
INSERT INTO bricks (brick_id, color, shape, weight) VALUES (brick_id_seq.NEXTVAL, 'red', 'cube', 1);
INSERT INTO bricks (brick_id, color, shape, weight) VALUES (brick_id_seq.NEXTVAL, 'red', 'cube', 2);
INSERT INTO bricks (brick_id, color, shape, weight) VALUES (brick_id_seq.NEXTVAL, 'red', 'pyramid', 3);
INSERT INTO bricks (brick_id, color, shape, weight) VALUES (brick_id_seq.NEXTVAL, 'green', 'pyramid', 1);

//b
SELECT
  brick_id,
  color,
  shape,
  weight,
  ROW_NUMBER() OVER (ORDER BY brick_id) AS RUNNING_TOTAL,
  SUM(weight) OVER (ORDER BY brick_id) AS RUNNING_WEIGHT,
  ROUND(AVG(weight) OVER (ORDER BY brick_id), 2) AS RUNNING_AVERAGE_WEIGHT
FROM
  bricks
ORDER BY
  brick_id;

//c
SELECT 
  brick_id, 
  color, 
  shape, 
  weight, 
  LAG(shape) OVER (ORDER BY brick_id) AS prev_shape, 
  LEAD(shape) OVER (ORDER BY brick_id) AS next_shape
FROM 
  bricks
ORDER BY 
  brick_id;

