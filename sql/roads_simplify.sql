create or replace view roads_simplify as 

select rid, scalerank, "type", sov_a3, simplify, the_geom  from 
(

select gid as rid, scalerank, "type", sov_a3, st_simplify(the_geom, 1.0) as the_geom, 1.0 as simplify from ne_10m_roads

union all

select gid as rid, scalerank, "type", sov_a3, st_simplify(the_geom, 0.1) as the_geom, 0.1 as simplify from ne_10m_roads

union all

select gid as rid, scalerank, "type", sov_a3, st_simplify(the_geom, 0.05) as the_geom, 0.05 as simplify from ne_10m_roads

union all

select gid as rid, scalerank, "type", sov_a3, st_simplify(the_geom, 0.01) as the_geom, 0.01 as simplify from ne_10m_roads

union all

select gid as rid, scalerank, "type", sov_a3, st_simplify(the_geom, 0.005) as the_geom, 0.005 as simplify from ne_10m_roads

union all

select gid as rid, scalerank, "type", sov_a3, st_simplify(the_geom, 0.001) as the_geom, 0.001 as simplify from ne_10m_roads
) as foo

where st_isvalid(the_geom) is true
;