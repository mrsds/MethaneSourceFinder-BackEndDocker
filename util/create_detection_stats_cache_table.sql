-- This creates a table to store precalculated detection stats which can be used to significantly speed up the query in StatsHandler.py.  
-- The detection stats query takes a long time but ultimately only returns 6 rows per date range.  So this provides a significant speedup with only a little bit or additional storage
-- Only the actual date ranges that contain stats are computed, and the query is smart enough to "snap" to the proper start and end date when getting an arbitrary input date range
-- Note that you still need to populate the table using the populateCache.py script. 

-- DROP TABLE public.detectionstats;

CREATE TABLE public.detectionstats (
	startday date NOT NULL,
	endday date NOT NULL,
	sector_level_1 varchar(75) NOT NULL,
	sector_level_2 varchar(75) NOT NULL,
	facilities int8 NULL,
	facility_flyovers int8 NULL,
	unique_facilities_flown_over int8 NULL,
	unique_facilities_with_plume_detections int8 NULL,
	CONSTRAINT detectionstats_pkey PRIMARY KEY (startday, endday, sector_level_1, sector_level_2),
	CONSTRAINT valid_day_range CHECK ((endday >= startday))
);
CREATE INDEX daypair_idx ON public.detectionstats USING btree (startday, endday);
CREATE INDEX endday_idx ON public.detectionstats USING btree (endday);
CREATE INDEX startday_idx ON public.detectionstats USING btree (startday);

