CREATE MATERIALIZED VIEW public.vista_geo
TABLESPACE pg_default
AS SELECT v.vista_id,
    v.name,
    v.site_name,
    v.shape_type,
    v.latitude,
    v.longitude,
    v.category,
    v.category_id,
    v.operator,
    v.address,
    v.state,
    v.sector,
    v.city,
    vs.source_id,
    vs.facility_poly_contains_source,
    vs.distance,
    s.area_name,
    s.source_type,
    s.source_latitude_deg,
    s.source_longitude_deg,
    s.sector_level_1,
    s.sector_level_2,
    s.sector_level_3,
    s.nearest_facility,
    vf.flyover_count,
    vap.plume_count,
    v.facility_envelope,
    v.geojson,
    v.id
   FROM vista v
     LEFT JOIN vista_sources vs ON vs.vista_id = v.id
     LEFT JOIN sources s ON s.source_id::text = vs.source_id::text
     LEFT JOIN ( SELECT DISTINCT vista_flightlines.vista_id,
            count(1) AS flyover_count
           FROM vista_flightlines
          GROUP BY vista_flightlines.vista_id) vf ON vf.vista_id = v.id
     LEFT JOIN ( SELECT DISTINCT vista_aviris_plumes.vista_id,
            count(1) AS plume_count
           FROM vista_aviris_plumes
          GROUP BY vista_aviris_plumes.vista_id) vap ON vap.vista_id = v.id
WITH DATA;

