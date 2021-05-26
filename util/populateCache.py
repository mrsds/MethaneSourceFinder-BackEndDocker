
import psycopg2
import datetime
import pprint


conn = psycopg2.connect(dbname="methanesourcefinder",
                        user="svc_methanesourcefinder",
                        password="-8$zzpPS)usrVMVh>H2v",
                        host="prj-prod-jplmsf-aurora-postgresql-10-serverless.cluster-c5w0nprylzvi.us-west-2.rds.amazonaws.com",
                        port="5432")

cur = conn.cursor()

sql="""
select distinct date(flight_timestamp) as obstimestamp from flightlines
union 
select distinct date(detection_timestamp) as obstimestamp from plumes
order by obstimestamp asc
"""
cur.execute(sql)
daylist = cur.fetchall()

insertSql = """
insert into detectionStats
with snapDays as (
select * from 
(select obsDay as startDay from (
select distinct flight_timestamp::date as obsDay from flightlines
union 
select distinct detection_timestamp::date as obsDay from plumes) as getDay
where obsDay>=%s 
order by obsDay
limit 1
) as startDaySubQuery,
(select obsDay as endDay from (
select distinct flight_timestamp::date as obsDay from flightlines
union 
select distinct detection_timestamp::date as obsDay from plumes
) as getDay
where obsDay<=%s 
order by obsday desc
limit 1
) as endDaySubQuery)
select * from snapDays,(
select 
distinct
v.sector_level_1,
v.sector_level_2,
count(distinct v.vista_id) as facilities,
count(distinct vf.flightline_id) as facility_flyovers,
count(distinct vf.vista_id) as unique_facilities_flown_over,
count(distinct p.vista_id) as unique_facilities_with_plume_detections
from
counties as c,
county_vista as cv,
vista as v
left join (select vf.vista_id, vf.flightline_id from vista_flightlines as vf, flightlines as f,snapdays where vf.flightline_id = f.flightline_id and f.flight_timestamp::date between snapdays.startday and snapdays.endday) vf
on v.id = vf.vista_id
left join (select * from plumes as p,snapdays where p.detection_timestamp::date between snapdays.startday and snapdays.endday) as p
on p.vista_id = v.vista_id
where
c.name like '%%'
and cv.county_id = c.county_id
and v.id = cv.vista_id
and v.sector_level_1 like '%%'
and v.sector_level_2 like '%%'
group by
v.sector_level_1,
v.sector_level_2
) as mainQuery
"""

total=len(daylist)
counter=1
for day1 in daylist:
    for day2 in daylist:
        if day2 >= day1:
            print("Combo %s of %s ... (%s to %s)" % (counter,total**2,day1,day2))
            cur.execute("select * from detectionStats where startday=%s and endday=%s",(day1,day2))
            results = cur.fetchall()
            if len(results)==0:
                cur.execute(insertSql,(day1,day2))
                conn.commit()
        counter+=1







