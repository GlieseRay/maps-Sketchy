begin;
create table roads_scale_2 as 
select 
	row_number() over () as gid,
	scalerank,
	"type",
	sov_a3,
	simplify,
	scale,
	the_geom
from (
(
	SELECT 
		scalerank,
		"type",
		sov_a3,
		simplify,
		2 as scale,
		ST_Intersection(
		ST_Translate(
			st_scale(
				ST_Translate(the_geom, -center_x, -center_y), 
				2, 
				2
				),
			center_x,
			center_y
			),
		ST_MakeEnvelope(-180, -90, 180, 90, 4326)
		) AS the_geom
	FROM roads_segments
	WHERE st_isvalid(the_geom) is true
)

union all

(
	SELECT 
		scalerank,
		"type",
		sov_a3,
		simplify,
		2.5 as scale,
		ST_Intersection(
		ST_Translate(
			st_scale(
				ST_Translate(the_geom, -center_x, -center_y), 
				2.5, 
				2.5
				),
			center_x,
			center_y
			),
		ST_MakeEnvelope(-180, -90, 180, 90, 4326)
		) AS the_geom
	FROM roads_segments
	WHERE st_isvalid(the_geom) is true
)
) as boo;

ALTER TABLE roads_scale_2
  ADD CONSTRAINT roads_scale_2_pkey PRIMARY KEY(gid );
  
SELECT Populate_Geometry_Columns('public.roads_scale_2'::regclass);
end;