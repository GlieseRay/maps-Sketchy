begin;
create table roads_segments as 
(
select
	row_number() over () as gid,
	scalerank,
	"type",
	sov_a3,
	simplify,
	st_x(st_centroid(ST_MakeLine(start_x, start_y))) as center_x,
	st_y(st_centroid(ST_MakeLine(start_x, start_y))) as center_y,
	ST_MakeLine(start_x, start_y) as the_geom
from

(
select 
	rid,
	scalerank,
	"type",
	sov_a3,
	simplify,
	st_pointn(the_geom, generate_series(1, st_npoints(the_geom)-1)) as start_x,
	st_pointn(the_geom, generate_series(2, st_npoints(the_geom))) as start_y
from roads_simplify
) as foo
);

ALTER TABLE roads_segments
  ADD CONSTRAINT roads_segments_pkey PRIMARY KEY(gid );
  
SELECT Populate_Geometry_Columns('public.roads_segments'::regclass);
end;