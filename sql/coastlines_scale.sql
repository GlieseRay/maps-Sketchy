
create table coastline_scale as 
select 
	row_number() over () as gid,
	simplify,
	scale,
	the_geom
from (
(
	SELECT 
		simplify,
		1.5 as scale,
		ST_Intersection(
		ST_Translate(
			st_scale(
				ST_Translate(the_geom, -center_x, -center_y), 
				1.5, 
				1.5
				),
			center_x,
			center_y
			),
		ST_MakeEnvelope(-180, -90, 180, 90, 4326)
		) AS the_geom
	FROM coastline_segments
	WHERE st_isvalid(the_geom) is true
)

union all

(
	SELECT 
		simplify,
		1.2 as scale,
		ST_Intersection(
		ST_Translate(
			st_scale(
				ST_Translate(the_geom, -center_x, -center_y), 
				1.2, 
				1.2
				),
			center_x,
			center_y
			),
		ST_MakeEnvelope(-180, -90, 180, 90, 4326)
		) AS the_geom
	FROM coastline_segments
	WHERE st_isvalid(the_geom) is true
)
) as boo;

ALTER TABLE coastline_scale
  ADD CONSTRAINT coastline_scale_pkey PRIMARY KEY(gid );
  
SELECT Populate_Geometry_Columns('public.coastline_scale'::regclass);
end;