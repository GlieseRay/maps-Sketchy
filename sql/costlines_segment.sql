begin;
create table coastline_segments as (

	select 
		row_number() over () as gid,
		center_x,
		center_y,
		simplify,
		st_intersection(the_geom, st_makeenvelope(-180, -90, 180, 90, 4326)) as the_geom
	from 
	(
		(
		select 
			st_x(st_centroid(ST_MakeLine(start_x, start_y))) as center_x,
			st_y(st_centroid(ST_MakeLine(start_x, start_y))) as center_y,
			0.005 as simplify,
			ST_MakeLine(start_x, start_y) as the_geom
		from 
			(
			select  
				st_pointn(the_geom, generate_series(1, st_npoints(the_geom)-1)) as start_x,
				st_pointn(the_geom, generate_series(2, st_npoints(the_geom))) as start_y
			from coastline_0_005
			) as foo
		where 
			st_equals(start_x, start_y) is not true
		)
		union all
		(
		select 
			st_x(st_centroid(ST_MakeLine(start_x, start_y))) as center_x,
			st_y(st_centroid(ST_MakeLine(start_x, start_y))) as center_y,
			0.05 as simplify,
			ST_MakeLine(start_x, start_y) as the_geom
		from 
			(
			select  
				st_pointn(the_geom, generate_series(1, st_npoints(the_geom)-1)) as start_x,
				st_pointn(the_geom, generate_series(2, st_npoints(the_geom))) as start_y
			from coastline_0_05
			) as foo
		where 
			st_equals(start_x, start_y) is not true

		)
		union all
		(
		select 
			st_x(st_centroid(ST_MakeLine(start_x, start_y))) as center_x,
			st_y(st_centroid(ST_MakeLine(start_x, start_y))) as center_y,
			0.1 as simplify,
			ST_MakeLine(start_x, start_y) as the_geom
		from 
			(
			select  
				st_pointn(the_geom, generate_series(1, st_npoints(the_geom)-1)) as start_x,
				st_pointn(the_geom, generate_series(2, st_npoints(the_geom))) as start_y
			from coastline_0_1
			) as foo
		where 
			st_equals(start_x, start_y) is not true

		)
		union all
		(
		select 
			st_x(st_centroid(ST_MakeLine(start_x, start_y))) as center_x,
			st_y(st_centroid(ST_MakeLine(start_x, start_y))) as center_y,
			0.25 as simplify,
			ST_MakeLine(start_x, start_y) as the_geom
		from 
			(
			select  
				st_pointn(the_geom, generate_series(1, st_npoints(the_geom)-1)) as start_x,
				st_pointn(the_geom, generate_series(2, st_npoints(the_geom))) as start_y
			from coastline_0_25
			) as foo
		where 
			st_equals(start_x, start_y) is not true

		)
		union all
		(
		select 
			st_x(st_centroid(ST_MakeLine(start_x, start_y))) as center_x,
			st_y(st_centroid(ST_MakeLine(start_x, start_y))) as center_y,
			0.5 as simplify,
			ST_MakeLine(start_x, start_y) as the_geom
		from 
			(
			select  
				st_pointn(the_geom, generate_series(1, st_npoints(the_geom)-1)) as start_x,
				st_pointn(the_geom, generate_series(2, st_npoints(the_geom))) as start_y
			from coastline_0_5
			) as foo
		where 
			st_equals(start_x, start_y) is not true

		)
		union all
		(
		select 
			st_x(st_centroid(ST_MakeLine(start_x, start_y))) as center_x,
			st_y(st_centroid(ST_MakeLine(start_x, start_y))) as center_y,
			1 as simplify,
			ST_MakeLine(start_x, start_y) as the_geom
		from 
			(
			select  
				st_pointn(the_geom, generate_series(1, st_npoints(the_geom)-1)) as start_x,
				st_pointn(the_geom, generate_series(2, st_npoints(the_geom))) as start_y
			from coastline_1_0
			) as foo
		where 
			st_equals(start_x, start_y) is not true

		)
	) as boo
);

ALTER TABLE coastline_segments
  ADD CONSTRAINT coastline_segments_pkey PRIMARY KEY(gid );
  
SELECT Populate_Geometry_Columns('public.coastline_segments'::regclass);
end;