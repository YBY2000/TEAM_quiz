-- (A)
drop table bricks;
drop table colors;

create table bricks (
  brick_id integer,
  color   varchar2(10)
);

create table colors (
  color_name           varchar2(10),
  minimum_bricks_needed integer
);

insert into colors values ( 'blue', 2 );
insert into colors values ( 'green', 3 );
insert into colors values ( 'red', 2 );
insert into colors values ( 'orange', 1);
insert into colors values ( 'yellow', 1 );
insert into colors values ( 'purple', 1 );

insert into bricks values ( 1, 'blue' );
insert into bricks values ( 2, 'blue' );
insert into bricks values ( 3, 'blue' );
insert into bricks values ( 4, 'green' );
insert into bricks values ( 5, 'green' );
insert into bricks values ( 6, 'red' );
insert into bricks values ( 7, 'red' );
insert into bricks values ( 8, 'red' );
insert into bricks values ( 9, null );

commit;


-- (B)
SELECT c.color_name AS COLOUR_NAME, MIN(b.brick_id) AS MIN_BRICK_ID
FROM colors c
LEFT JOIN bricks b ON c.color_name = b.color
GROUP BY c.color_name
ORDER BY c.color_name;


-- (C)
WITH BrickCounts AS (
  SELECT color, COUNT(brick_id) AS TotalBricks
  FROM bricks
  WHERE color IS NOT NULL
  GROUP BY color
),
AverageCount AS (
  SELECT AVG(TotalBricks) AS AvgBricks
  FROM BrickCounts
)

SELECT bc.color
FROM BrickCounts bc, AverageCount ac
WHERE bc.TotalBricks < ac.AvgBricks;
