select applicants, count(publication_number) from t_smeo_unique_sme_patents
group by applicants
order by 2 desc
 
 
select count(publication_number) from t_smeo_unique_sme_patents
where publication_date > '01.01.2009' --441
select count(distinct applicants) from (
select * from t_smeo_unique_sme_patents
where publication_date > '01.01.2009'
) -- 229
 
select count(distinct applicants) from (
select * from t_smeo_unique_sme_patents
) -- 531
 
select count(distinct applicants) from (
select * from t_smeo_unique_sme_patents
where application_date > '01.01.2009'
) -- 193
 
 
select count(publication_number) from (
select * from t_smeo_unique_sme_patents
where application_date > '01.01.2009'
) -- 337
select count(publication_number) from
(
select * from t_smeo_unique_sme_patents
where patent_type like 'Granted Patent'
) --1333
select count(publication_number) from
(
select * from t_smeo_unique_sme_patents
where patent_type like 'Granted Patent'
) where application_date > '01.01.2009'
--0
 
 
select * from t_smeo_patent_data
 
select * from t_smeo_unique_sme_patents
 
 
create table t_smeo_patent_inventor as
select distinct t1.publication_number, t2.inventors from t_smeo_unique_sme_patents t1 inner join t_smeo_patent_data t2
on t1.publication_number = t2.publication_number
 
select * from t_smeo_patent_inventor
 
Create table t_smeo_unique_sme_patents_new
(
  Applicants varchar2(2000),
  Publication_Number varchar(255),
  Publication_Date date,
  Application_Date date,
  Patent_Type varchar(255),
  Cited_Count number(6,0)
);
 
Insert into t_smeo_unique_sme_patents
select distinct t1.applicants, t1.publication_number, t1.publication_date, t1.application_date, t1.patent_type, t1.cited_count from t_smeo_patent_data t1 inner join t_smeo_z
on replace(replace((upper(t1.applicants)),' ', ''),'.','')  = replace(replace(upper(t_smeo_z.a_partner_name_1), ' ', ''),'.','')
select * from t_smeo_unique_sme_patents
--patent inventors name table
select count(*) from t_smeo_patent_inventors_fields
where inventor1 like 'null'  --247, total 1793
-----inventor tables
create table temp_inventor1 as (
select t1.inventor1,t1.publication_number,  t2.a_geschlecht, t2.a_vorname, length(t2.a_vorname) as len1
from t_smeo_name_gender t2 inner join t_smeo_patent_inventors_fields t1
on upper(t1.inventor1)= upper(t2.a_vorname) or  t1.inventor1 like '%' || upper(t2.a_vorname) || '%' )
select * from temp_inventor6
drop table temp_inventor5
select s1.publication_number,s1.inventor1, s2.a_geschlecht 
from  temp_inventor1 s2 inner join
(select t3.inventor1,t3.publication_number,  max(len1) as len1 from
temp_inventor1 t3 group by t3.inventor1,t3.publication_number) s1
on s2.publication_number = s1.publication_number and s2.inventor1=s1.inventor1 and s2.len1=s1.len1
-------------------------------
--Total number of male inventors --- 1958
--Total number of female inventors ---155
 
create table temp_inventor6 as (
select t1.inventor6,t1.publication_number,  t2.a_geschlecht, t2.a_vorname, length(t2.a_vorname) as len1
from t_smeo_name_gender t2 inner join t_smeo_patent_inventors_first t1
on upper(t1.inventor6)= upper(t2.a_vorname) or  t1.inventor6 like '%' || upper(t2.a_vorname) || '%' )
 
select * from t_smeo_name_gender
select s1.publication_number,s1.inventor6, s2.a_geschlecht 
from  temp_inventor6 s2 inner join
(select t3.inventor6,t3.publication_number,  max(len1) as len1 from
temp_inventor6 t3 group by t3.inventor6,t3.publication_number) s1
on s2.publication_number = s1.publication_number and s2.inventor6=s1.inventor6 and s2.len1=s1.len1
 
 
----1810 males $ 309 females
 
 
-----------------------------------------
select * from t_smeo_name_gender
Create table t_smeo_patent_male_female
(
  Publication_Number varchar(255),
  Females number(6,0),
  Males number(6,0)
);
 
select * from t_smeo_patent_male_female
create table t_smeo_sme_append as (
select s1.*, s2.females as female_inventors, s2.males as male_inventors from
t_smeo_unique_sme_patents s1 inner join t_smeo_patent_male_female s2
on s1.publication_number = s2.publication_number)
select * from t_smeo_sme_append
select * from
t_smeo_sme_append s1 inner join t_smeo_patent_data s2
on s1.publication_number = s2.publication_number
----------------------------------
-- table t_smeo_mergedpatents
-- Next task is to join publication number from t_smeo_unique_sme_patents with t_smeo_patent_data
-- results in full relevant patent dataset
-- join partner mergedpatens with t_smeo_z on names = t_smeo_patrich
-- ... and then join the result together with t_smeo_charts
-- the result will give you a feature richt patent dataset with the revenues
 
--Next weeks task: basic table to run CAGR vs. patent filed within period, maybe additonal features
-- Training and validation set
-- add to charts the years 2015....2008, content = patent title
-- Further task: time series table
-- taken from smeo_z with all the revenues
-- take unique company, unique year (lowest month), column revenue, col. number of patents in year, blob of tiles, sum of citations, sum of cited count,
select * from t_smeo_charts
select * from t_smeo_z
select distinct t1.applicants, t_smeo_z.partnernummer,t1.publication_number, t1.publication_date, t1.application_date, t1.patent_type, t1.cited_count, t1.female_inventors, t1.male_inventors from t_smeo_sme_append t1 inner join t_smeo_z
on replace(replace((upper(t1.applicants)),' ', ''),'.','')  = replace(replace(upper(t_smeo_z.a_partner_name_1), ' ', ''),'.','')
select distinct t1.applicants,t2.partnernummer,t2.year ,t2.a_jahresumsatz_betr, t2.a_geb_gruend_jahr, t1.publication_number, t1.publication_date, t1.application_date, t1.patent_type, t1.cited_count, t1.male_inventors, t1.female_inventors from t_smeo_sme_append t1 inner join t_smeo_z t2
on replace(replace((upper(t1.applicants)),' ', ''),'.','')  = replace(replace(upper(t2.a_partner_name_1), ' ', ''),'.','')
order by 6
select * from
(select distinct t1.applicants, t_smeo_z.partnernummer,t1.publication_number, t1.publication_date, t1.application_date, t1.patent_type, t1.cited_count, t1.female_inventors, t1.male_inventors from t_smeo_sme_append t1 inner join t_smeo_z
on replace(replace((upper(t1.applicants)),' ', ''),'.','')  = replace(replace(upper(t_smeo_z.a_partner_name_1), ' ', ''),'.','')) temp1 inner join t_smeo_sme_append temp2
on temp1.publication_number=temp2.publication_number
select distinct t1.applicants, t2.a_jahresumsatz_betr
from t_smeo t1 inner join t_smeo_z t2
on replace(replace((upper(t1.applicants)),' ', ''),'.','')  = replace(replace(upper(t2.a_partner_name_1), ' ', ''),'.','')
select  unique t1.applicants , t2.a_jahresumsatz_betr from
(select unique applicants from t_smeo_sme_append) t1 inner join t_smeo_z t2
on replace(replace((upper(t1.applicants)),' ', ''),'.','')  = replace(replace(upper(t2.a_partner_name_1), ' ', ''),'.','')
 
select * from t_umsaetze
select * from t_smeo_z where partnernummer = '10313142'
select * from dwh.t_police where a_partner_nr_vn = '10313142'
-- look for differences in geschaefs_nr = policy numbers, meaning they relate to a different product, company, subsidee....
select distinct partnernummer, year,month ,a_jahresumsatz_betr from t_smeo_z where a_jahresumsatz_betr is not null
order by partnernummer,year,month
select distinct partnernummer,
select * from t_smeo_z_contracts_cagr
select * from t_smeo_z_contracts
select count(a_betr_art), a_betr_art from t_smeo_charts
group by a_betr_art
order by 1 desc
select * from t_smeo_troubles4
 
SELECT distinct partnernummer, count(year) as countjahr from (select t1.* from t_smeo_z t1 inner join t_smeo_troubles4 t2 on t1.partnernummer not in t2.partnernummer)
where 1=1
and A_Jahresumsatz_betr is not null
and to_number(A_Jahresumsatz_betr) > '18000'
and to_number(A_umsatz_ber) > '18000'
group by partnernummer
order by 2 desc
 
select distinct t1.partnernummer  from t_smeo_z t1 left outer join t_smeo_troubles4 t2 on t1.partnernummer= t2.partnernummer where t2.partnernummer IS NULL
and year=2008 and month between 7 and 9
and A_Jahresumsatz_betr is not null
and to_number(A_Jahresumsatz_betr) > '18000'
and to_number(A_umsatz_ber) > '18000'
group by partnernummer
 
-----SMEs with patents with their revenues yearwise
create table t_smeo_with_revenue as (
  select distinct partnernummer,applicants, year, a_jahresumsatz_betr from
  (
	select distinct t1.applicants,t2.partnernummer,t2.year,t2.month ,t2.a_jahresumsatz_betr, t2.a_geb_gruend_jahr, t1.publication_number, t1.publication_date, t1.application_date, t1.patent_type, t1.cited_count, t1.male_inventors, t1.female_inventors from
	(
  	select * from t_smeo_sme_append
	) t1 inner join t_smeo_z t2
	on replace(replace((upper(t1.applicants)),' ', ''),'.','')  = replace(replace(upper(t2.a_partner_name_1), ' ', ''),'.','')
	where t2.a_jahresumsatz_betr is not null
	order by t2.a_jahresumsatz_betr desc
  )
  order by 2 ,3,4 )
 
----table having comapnies with patents and their yearlr revenue
----in case of multiple revenues of one year average value is taken. average done in excel.
CREATE TABLE SME_WITH_PATENT_REVENUE_YEARLY
(
partnernummer number(15,0),
Applicants varchar2(2000),
year number(4,0),
A_JAHRESUMSATZ_BETR number(20,0)
);
 
select * from SME_WITH_PATENT_REVENUE_YEARLY order by 2
--company count not having patents
select count(distinct partnernummer) from (
select distinct t1.* from t_smeo_z t1 left join sme_with_patent_revenue_yearly t2
on t1.partnernummer = t2.partnernummer
where t2.partnernummer is null
)
 
 
select count(distinct partnernummer) from t_smeo_sme_withPatents_revenue
 
select * from t_smeo_sme_noPatents_revenue
where revenue2016 is not null
order by 2,12 desc ,11 desc,10 desc,9 desc,8 desc,7 desc,6 desc,5 desc, 4 desc
------------------------------------------------------------------------------------------------------
 
 
select distinct * from t_smeo_sme_withPatents_revenue
where revenue2016 is not null
order by 2,12 desc ,11 desc,10 desc,9 desc,8 desc,7 desc,6 desc,5 desc, 4 desc
 
select t1.*,t2.Patent_count from
(
) t1
inner join
(select applicants, count(publication_number) as Patent_count from t_smeo_unique_sme_patents
group by applicants
order by 2 desc) t2
on replace(replace((upper(t1.applicants)),' ', ''),'.','')  = replace(replace(upper(t2.applicants), ' ', ''),'.','')
 
select * from t_smeo_sme_append
 
select distinct partnernummer from t_smeo_sme_withPatents_revenue
drop table tmp9
------------------ALL the companies without patents and their yearwise revenue in t_smeo_sme_noPatents_revenue and
--- sems with patents in t_smeo_sme_withPatents_revenue
 
select * from t_smeo_sme_noPatents_revenue
where revenue2016 is not null and revenue2016>1000  --exported
 
create table t_smeo_Innovation_industry as
select distinct s1.*,s2.a_betr_art from (
select t1.* from
sme_with_patent_revenue_yearly t1 left join t_smeo_troubles4 t2
on t1.partnernummer =  t2.partnernummer
where t2.partnernummer is null ) s1 , (select distinct partnernummer, a_betr_art from t_smeo_z) s2
where s1.partnernummer = s2.partnernummer
order by 2,3,4
--- 531
 
 
select a_jahresumsatz_betr from sme_with_patent_revenue_yearly
 
select avg(revenue2016) from
(
select partnernummer, max(revenue2016) as revenue2016 from t_smeo_sme_noPatents_revenue
where revenue2016 is not null
group by partnernummer
)
---927971.25
 
---2773356.17
 
select avg(revenue2016) from
(
select partnernummer, max(revenue2016) as revenue2016 from t_smeo_sme_withPatents_revenue
where revenue2016 is not null
group by partnernummer
)
 
---2773356.17
create table t_smeo_CAGR as
select s1.partnernummer, s1.a_betr_art  , power(div,frac)-1 as CAGR from
(select t1.*, endumsatz/startumsatz  as div, (1/loyalty) as frac
from t_smeo_charts t1 where t1.loyalty > '0') s1
select * from  t_smeo_sme_withPatents_revenue
select * from t_smeo_CAGR
 
select avg(CAGR) from (
select partnernummer, max(CAGR) as CAGR from
(
select s1.* , s2.CAGR
from t_smeo_sme_withPatents_revenue s1 inner join t_smeo_CAGR s2
on s1.partnernummer = s2.partnernummer
)
group by partnernummer
)
--0.0214317951587087315162646154990718971809
 
select avg(CAGR) from (
select partnernummer, max(CAGR) as CAGR from
(
select s1.* , s2.CAGR
from t_smeo_sme_noPatents_revenue s1 inner join t_smeo_CAGR s2
on s1.partnernummer = s2.partnernummer
)
group by partnernummer
)
---0.0188887540394128589075911625081431484989
 
--revenue wise t and p values
--t  12.090440226997083
--p  1.3149411796967711e-33
 
--growth wise t and p values
--t  0.35830685591168349
--p  0.72029311082847824
 
--growth  wise t and p values--only growing
--t -0.63810737228376491
--p 0.52477784369072822
 
---------RQ2
create table t_smeo_CAGR_append as
select distinct s1.*, s2.a_partner_name_1
from t_smeo_CAGR s1 inner join t_smeo_z s2
on s1.partnernummer = s2.partnernummer
 
create table t_smeo_sme_partnernummer as
select distinct s2.partnernummer,s1.* from t_smeo_sme_append s1
inner join t_smeo_z s2
on replace(replace((upper(s1.applicants)),' ', ''),'.','')  = replace(replace(upper(s2.a_partner_name_1), ' ', ''),'.','')
 
---only females 33 companies
select distinct s1.*,s2.CAGR from
(select distinct * from (
select partnernummer,sum(female_inventors) as female,sum(male_inventors) as male
from t_smeo_sme_partnernummer
group by partnernummer
order by 1
)
where female > '0' and male='0') s1 inner join t_smeo_CAGR s2
on s1.partnernummer = s2.partnernummer
 
---only males
select distinct s1.*,s2.CAGR from
(select distinct * from (
select partnernummer,sum(female_inventors) as female,sum(male_inventors) as male
from t_smeo_sme_partnernummer
group by partnernummer
order by 1
)
where female = '0' and male>'0') s1 inner join t_smeo_CAGR s2
on s1.partnernummer = s2.partnernummer
---mixed
select distinct s1.*,s2.CAGR from
(select distinct * from (
select partnernummer,sum(female_inventors) as female,sum(male_inventors) as male
from t_smeo_sme_partnernummer
group by partnernummer
order by 1
)
where female > '0' and male>'0') s1 inner join t_smeo_CAGR s2
on s1.partnernummer = s2.partnernummer
 
select * from t_smeo_cagr
where partnernummer not in ( select partnernummer from t_smeo_troubles4)
order by 3 desc
 
select * from t_smeo_charts where partnernummer = '16824281'
 
select * from t_smeo_sme_noPatents_revenue where partnernummer = '16914384'
select * from dwh.t_partner where a_partner_nr = '13745331'
-- Define cut-off value for growth
--select distinct * from t_smeo_sme_noPatents_revenue
select distinct t1.partnernummer,  t1.a_betr_art, t2.revenue2009, t2.revenue2010, t2.revenue2011 from t_smeo_charts t1
left join t_smeo_sme_noPatents_revenue t2
on t1.partnernummer = t2.partnernummer
order by 1
 
 
-----all the companies distinct
create table temporary1 as
select distinct t1.partnernummer,  t1.a_betr_art, t2.revenue2009, t2.revenue2010, t2.revenue2011,t2.revenue2012, t2.revenue2013, t2.revenue2014,t2.revenue2015, t2.revenue2016 from t_smeo_charts t1
INNER JOIN
 	(select t2.*, row_number() over (partition by partnernummer order by revenue2016 desc,revenue2015 desc,revenue2014 desc,revenue2013 desc,revenue2012 desc,revenue2011 desc,revenue2010 desc,revenue2009 desc) as seqnum
  	from  t_smeo_sme_noPatents_revenue t2
 	) t2
	on t1.partnernummer = t2.partnernummer and seqnum=1
order by 1
 
create table temporary2 as
select distinct t1.partnernummer,  t1.a_betr_art, t2.revenue2009, t2.revenue2010, t2.revenue2011,t2.revenue2012, t2.revenue2013, t2.revenue2014,t2.revenue2015, t2.revenue2016 from t_smeo_charts t1
INNER JOIN
 	(select t2.*, row_number() over (partition by partnernummer order by revenue2016 desc,revenue2015 desc,revenue2014 desc,revenue2013 desc,revenue2012 desc,revenue2011 desc,revenue2010 desc,revenue2009 desc) as seqnum
  	from  t_smeo_sme_withPatents_revenue t2
 	) t2
	on t1.partnernummer = t2.partnernummer and seqnum=1
order by 1
 
select * from t_smeo_sme_withPatents_revenue
select * from temporary2
select distinct t1.partnernummer,  t1.a_betr_art, t2.revenue2009, t2.revenue2010, t2.revenue2011,t2.revenue2012, t2.revenue2013, t2.revenue2014,t2.revenue2015, t2.revenue2016 from t_smeo_charts t1
INNER JOIN
 	(select t2.*, row_number() over (partition by partnernummer order by revenue2016 desc,revenue2015 desc,revenue2014 desc,revenue2013 desc,revenue2012 desc,revenue2011 desc,revenue2010 desc,revenue2009 desc) as seqnum
  	from  t_smeo_sme_withPatents_revenue t2
 	) t2
	on t1.partnernummer = t2.partnernummer and seqnum=1
order by 1
select * from temporary1
select * from t_smeo_sme_partnernummer
select partnernummer,
(revenue2010/revenue2009) -1 as CAGR2010,
(revenue2011/revenue2010) -1 as CAGR2011,
(revenue2012/revenue2011) -1 as CAGR2012,
(revenue2013/revenue2012) -1 as CAGR2013,
(revenue2014/revenue2013) -1 as CAGR2014,
(revenue2015/revenue2014) -1 as CAGR2015,
(revenue2016/revenue2015) -1 as CAGR2016
from temporary1
order by 8,7,6,5,4,3,2
 
-- sample for means, t-test required by daniel
select partnernummer,
(revenue2010/revenue2009) -1 as CAGR2010,
(revenue2011/revenue2010) -1 as CAGR2011,
(revenue2012/revenue2011) -1 as CAGR2012,
(revenue2013/revenue2012) -1 as CAGR2013,
(revenue2014/revenue2013) -1 as CAGR2014,
(revenue2015/revenue2014) -1 as CAGR2015,
(revenue2016/revenue2015) -1 as CAGR2016
from temporary1
where revenue2010 > 100000
and revenue2016 > 100000
order by 8,7,6,5,4,3,2
 
select * from t_smeo_rev_years
---
select t1.*,t2.*
from t_smeo_sme_partnernummer t1 inner join t_smeo_sme_withPatents_revenue t2
on t1.partnernummer=t2.partnernummer
select count(distinct partnernummer ) from temporary2
select s1.* , t2.* from
(select partnernummer, count(*) as patent_count, sum(female_inventors) as female,sum(male_inventors) as male, sum(cited_count) as cites from t_smeo_sme_partnernummer
group by partnernummer) s1
inner join temporary2 t2
on s1.partnernummer=t2.partnernummer
 
create table temporary3
(
partnernummer varchar2(2000),
a_betr_art varchar2(2000),
revenue2009 number(20,0),
revenue2010 number(20,0),
revenue2011 number(20,0),
revenue2012 number(20,0),
revenue2013 number(20,0),
revenue2014 number(20,0),
revenue2015 number(20,0),
revenue2016 number(20,0)
)
insert into temporary3
(select * from temporary1)
create table t_smeo_revenue_by_years as
(
select * from temporary3
union
select * from temporary2
)
drop table temporary1
 
select * from t_smeo_revenue_by_years
select * from t_smeo_patent_data
select count (*) from dwh.t_partner
--8225487
select distinct publication_number, male_inventors, female_inventors, cited_count from t_smeo_sme_partnernummer
 
--big table
select distinct * from (
select *
from t_smeo_revenue_by_years t1 left outer join dwh.t_partner  t2
on t1.partnernummer=t2.a_partner_nr) s1 left outer join t_smeo_sme_partnernummer s2
on s1.partnernummer=s2.partnernummer
order by 1
 
------------------------------------------------------------------------------------------------------------
select count (*) from t_smeo_revenue_by_years
select * from T_SMEO_INDUSTRY_CODES
 
create table t_smeo_industryJoinRevenues as
select t1.partnernummer, t1.a_betr_art as Industry ,t2.*, t1.revenue2009,t1.revenue2010,t1.revenue2011,t1.revenue2012,t1.revenue2013,t1.revenue2014,t1.revenue2015,t1.revenue2016 from t_smeo_revenue_by_years t1
left outer join T_SMEO_INDUSTRY_CODES t2
on t1.a_betr_art=t2.label
select count(*) from t_smeo_industryJoinRevenues  ---107318
create table t_smeo_partners as
select a_partner_nr, max(A_versions_nr) as PVers, a_hist_gueltig_ab as Tstamp, ao_partnerart, ac_partnerart, replace(replace((upper(a_partner_name_1)),' ', ''),'.','') as matchname, a_partner_name_1, a_partner_name_2, a_partner_strasse as street, a_partner_haus_nr, a_partner_plz as zip, A_partner_ort as city, a_geb_gruend_jahr, a_anzahl_mitarbeit as employees, ac_mieter_eigentum, ac_zivilstand as civil, ao_nationalitaet as nationality, ac_nationalitaet, ao_rechtsform, ac_rechtsform, a_anzahl_kinder as kids, a_erst_datum, a_uid_nr
from dwh.t_partner
group by a_partner_nr, a_hist_gueltig_ab, ao_partnerart, ac_partnerart, ac_partnerart, replace(replace((upper(a_partner_name_1)),' ', ''),'.',''), a_partner_name_1, a_partner_name_2, a_partner_strasse, a_partner_haus_nr, a_partner_plz, A_partner_ort, a_geb_gruend_jahr, a_anzahl_mitarbeit, ac_mieter_eigentum, ac_zivilstand, ao_nationalitaet, ac_nationalitaet, ao_rechtsform, ac_rechtsform, a_anzahl_kinder, a_erst_datum, a_uid_nr
 
select * from t_smeo_partners
order by 1
--4525339
create table t_smeo_partners_cleaned as
select t1.* from
t_smeo_partners t1 inner join
(select distinct a_partner_nr, max(PVERS) as PVERS from t_smeo_partners group by a_partner_nr) t2
on t1.a_partner_nr=t2.a_partner_nr and t1.PVERS=t2.PVERS
order by 1
select * from t_smeo_partners_cleaned
--100 percent match
select * from t_smeo_industryJoinRevenues t1
left outer join t_smeo_partners_cleaned t2
on t1.partnernummer=t2.a_partner_nr
 
select * from T_MLAB_PLZ_URBAN
order by 1
 
select t11.*, t2.a_stadt_land
from
(select * from t_smeo_industryJoinRevenues t1
left outer join t_smeo_partners_cleaned t2
on t1.partnernummer=t2.a_partner_nr
) t11
left outer join
T_MLAB_PLZ_URBAN t2
on t11.zip  = t2.a_plz
select * from T_MLAB_PLZ_DETAILS
 
select distinct a_plz, a_kanton, a_ds_einkommen_kopf_gemeinde as Average_area_income , a_index_laendlichkeit_plz as cityRural_index
from T_MLAB_PLZ_DETAILS
drop table  t_ind_rev_partner_city
create table t_ind_rev_partner_city as
select * from
(select t11.*, t2.a_stadt_land as small_large_index
from
(select * from t_smeo_industryJoinRevenues t1
left outer join t_smeo_partners_cleaned t2
on t1.partnernummer=t2.a_partner_nr
) t11
left outer join
T_MLAB_PLZ_URBAN t2
on t11.zip  = t2.a_plz) s1 left outer join
(
select distinct a_plz, a_kanton, a_ds_einkommen_kopf_gemeinde as Average_area_income , a_index_laendlichkeit_plz as cityRural_index
from T_MLAB_PLZ_DETAILS
)s2
on s1.zip = s2.a_plz
 
select * from T_MLAB_PLZ_DETAILS
select nationality,count(small_large_index) from t_ind_rev_partner_city
where nationality is not null and small_large_index is not null
group by nationality
select nationality,count(a_plz) from t_ind_rev_partner_city
where nationality is not null and a_plz is not null
group by nationality
order by 2
 
select * from t_ind_rev_partner_city
where partnernummer='12912723'
alter table t_ind_rev_partner_city
drop (a_plz)
select partnernummer, count(partnernummer) from t_ind_rev_partner_city
group by partnernummer
order by 2 desc
 
select * from
t_ind_rev_partner_city t1 left outer join t_smeo_canton_coding t2
on t1.a_kanton = t2.Canton
 
 
create table t_ind_rev_par_cit_kan_natio as
select *
from (
select *  from
t_ind_rev_partner_city t1 left outer join t_smeo_canton_coding t2
on t1.a_kanton = t2.Canton ) t1
left outer join
(select Nationality as Nationality1 ,Nationality2 ,Rank as NationRank, Natio_CH, Natio_IT ,Natio_PT, Natio_DE, Natio_NL ,Natio_ES, Natio_SE, Natio_FR ,Natio_AL, Natio_AT, Natio_LI, Natio_GR, Natio_EC ,Natio_BE ,Natio_BA ,Natio_US ,Natio_LT ,Natio_MK ,Natio_RS
from t_smeo_nationality_codes )t2
on t1.nationality=t2.Nationality1
 
------small industry as well
select *
from t_ind_rev_par_cit_kan_natio t1 left outer join t_smeo_industry_small_codes t2
on t1.industry= t2.a_betr_art
 
select count(distinct partnernummer) from t_ind_rev_par_cit_kan_natio
---107318
select partnernummer, count(partnernummer) from t_ind_rev_par_cit_kan_natio
group by partnernummer
order by 2 desc
--108021
 
select distinct t1.* from t_ind_rev_par_cit_kan_natio t1 inner join
(select t2.*,row_number() over() (partition by partnernummer order by revenue2016 desc ) as seqnum
from t_ind_rev_par_cit_kan_natio) t2
on t1.partnernummer = t2.partnernummer and seqnum=1
order by 1
 
---cleaned duplicates
create table t_ind_rev_par_cit_kan_natio2 as
select * from (
select t2.*,row_number() over (partition by t2.partnernummer order by t2.partnernummer, t2.a_kanton) seqnum
from t_ind_rev_par_cit_kan_natio t2
)
where seqnum='1'
 
select * from t_ind_rev_par_cit_kan_natio2
alter table t_ind_rev_par_cit_kan_natio2
drop (seqnum)
 
select count(*) from
t_smeo_hreg_combi t1
inner join t_ind_rev_par_cit_kan_natio2 t2
on replace(replace(replace(replace((upper(t1.firm_name)),' ', ''),'.',''),'-','' ),'+','') = replace(replace(t2.matchname,'-',''),'+','')
--22775 not a good match
 
select count(*) from
t_smeo_hreg_combi t1
right outer join t_ind_rev_par_cit_kan_natio2 t2
on upper(t1.firm_name)=t2.matchname or replace(replace(replace(replace((upper(t1.firm_name)),' ', ''),'.',''),'-','' ),',','') = replace(replace(t2.matchname,'-',''),',','')
where t1.firm_name is null
---73908
 
select count(*) from (select distinct * from t_smeo_hreg_combi)
--24568
 
select * from t_smeo_hreg_combi
 
select count(*) from (
select distinct u_id_ax as uid_axon, mitarbeiterzahl_von as min_employee, mitarbeiterzahl_bis as max_employee , revfrom_ax as minRevenue , revto_ax as maxrevenue , purpose_ax
from t_smeo_axon2
)
--587687
 
create table t_smeo_axon_hreg as
select * from (
select distinct u_id_ax as uid_axon, mitarbeiterzahl_von as min_employee, mitarbeiterzahl_bis as max_employee , revfrom_ax as minRevenue , revto_ax as maxrevenue , purpose_ax
from t_smeo_axon2
) s1 left outer join
t_smeo_hreg_combi s2
on replace(s1.uid_axon,'CHE','') = s2.firm_uid
 
---23548 matches appx 100%
 
select * from t_smeo_axon_hreg
select UID_AXON, count(UID_AXON)
from (select distinct * from t_smeo_axon_hreg)
group by uid_axon
order by 2 desc
 
select distinct * from t_smeo_axon_hreg
where uid_axon='CHE112822564'
select distinct * from t_smeo_axon_hreg
alter table t_smeo_axon_hreg
drop(registry_office_canton)
update t_smeo_axon_hreg
set firm_name=replace(replace(firm_name,'(',''),')','')
update t_smeo_axon_hreg
set firm_name=replace(replace(firm_name,'(',''),')','')
update t_smeo_axon_hreg
set unternehmenszweck=replace(unternehmenszweck,'Ã¿','Ue')
alter table t_smeo_axon_hreg
drop (gemeinde)
 
create table t_smeo_axon_hreg_clean as
select distinct * from (
select t2.*,row_number() over (partition by t2.uid_axon order by  t2.uid_axon, t2.firm_uid) seqnum
from (select distinct * from t_smeo_axon_hreg) t2
)
where seqnum=1
create table t_smeo_industry_small_correct as
select distinct * from (
select t2.*,row_number() over (partition by t2.a_betr_art order by t2.a_betr_art ) seqnum
from (select distinct * from t_smeo_industry_small_codes) t2
)
where seqnum=1
alter table t_smeo_industry_small_correct
drop (seqnum)
 
select * from t_smeo_axon_hreg_clean
drop table t_smeo_axon_hreg_clean
alter table t_smeo_axon_hreg_clean
drop(seqnum)
select count(*) from t_smeo_axon_hreg_clean
where firm_name is not null
--22070
 
select distinct * from t_smeo_axon_hreg
where uid_axon='CHE114294593'
---------------------------------------------------------------------
select count(*) from t_smeo_axon_hreg_clean
select * from t_ind_rev_par_cit_kan_natio2
create table t_Indrevpar_cit_kannation_inds as
select *
from t_ind_rev_par_cit_kan_natio2 t1 left outer join (select distinct * from t_smeo_industry_small_correct )t2
on t1.industry= t2.a_betr_art
 
drop table t_Indrevpar_cit_kannation_inds
select partnernummer ,count(partnernummer ) from t_Indrevpar_cit_kannation_inds
group by partnernummer
order by 2 desc
select * from t_Indrevpar_cit_kannation_inds
where partnernummer ='13259115'
select  a_betr_art , count(a_betr_art) from (select distinct * from t_smeo_industry_small_correct)
group by a_betr_art order by 2 desc
select distinct * from t_smeo_industry_small_codes where
a_betr_art='Zimmerei'
--revnue table entries 107628
 
select count(*) from (
select distinct * from
t_Indrevpar_cit_kannation_inds t1 inner join t_smeo_axon_hreg_clean t2
on
replace(replace(replace(replace(replace(upper(t1.a_partner_name_1), ' ', ''),'.',''),'(',''),')',''),'','')=
replace(replace(replace(upper(t2.firm_name), ' ', ''),'.',''),'','')
or
replace(replace(replace(replace(replace(upper(t1.a_partner_name_2), ' ', ''),'.',''),'(',''),')',''),'','')=
replace(replace(replace(upper(t2.firm_name), ' ', ''),'.',''),'','')
)
--20517
 
select count(*) from (
select distinct * from
t_Indrevpar_cit_kannation_inds t1 left outer join t_smeo_axon_hreg_clean t2
on
replace(regexp_replace(upper(t1.a_partner_name_1), '[^A-Z0-9]', ''),'.','')=
replace(regexp_replace(upper(t2.firm_name), '[^A-Z0-9]', ''),'.','')
)
---20539
select distinct  regexp_replace(upper(t1.a_partner_name_1), '[^0-9A-Z][^0-9]', '') as matchname
from t_Indrevpar_cit_kannation_inds t1
order by 1 desc
 
create table t_smeo_rev_par_hreg_axon as
select distinct * from
t_Indrevpar_cit_kannation_inds t1 left outer join temp_axon_hreg t2
on
replace(regexp_replace(upper(t1.a_partner_name_1), '[^A-Z0-9]', ''),'.','')=
replace(regexp_replace(upper(t2.firm_name), '[^A-Z0-9]', ''),'.','')
 
select firm_name, count(firm_name)
from t_smeo_axon_hreg_clean
group by firm_name
order by 2 desc
create table temp_axon_hreg as
select distinct * from (
select t2.*,row_number() over (partition by t2.firm_name order by t2.rechtsform asc ) seqnum
from (select distinct * from t_smeo_axon_hreg_clean) t2
)
order by firm_name ,seqnum desc
 
alter table temp_axon_hreg
drop(seqnum)
 
select distinct * from (
select t2.*,row_number() over (partition by t2.firm_name order by t2.rechtsform asc ) seqnum
from (select distinct * from temp_axon_hreg) t2
)
order by seqnum desc
 
 
select partnernummer, count(partnernummer)
from t_smeo_rev_par_hreg_axon
group by partnernummer
order by 2 desc
select distinct *
from t_smeo_rev_par_hreg_axon
where partnernummer='10524268'
drop table t_smeo_rev_par_hreg_axon
 
select  count(partnernummer)
from t_smeo_rev_par_hreg_axon
---107318
select * from t_smeo_rev_par_hreg_axon
select * from t_smeo_sme_partnernummer
select count( distinct applicants) from (
select * from t_smeo_patent_data t1 inner join t_smeo_rev_par_hreg_axon t2
on
replace(regexp_replace(upper(t1.applicants), '[^A-Z0-9]', ''),'.','')=
replace(regexp_replace(upper(t2.matchname), '[^A-Z0-9]', ''),'.','')
or
replace(regexp_replace(upper(t1.applicants), '[^A-Z0-9]', ''),'.','')=
replace(regexp_replace(upper(t2.firm_name), '[^A-Z0-9]', ''),'.','')
)
--496 companies
--1715 patents
 
select count( *) from (
select * from t_smeo_sme_partnernummer t1 left outer join t_smeo_rev_par_hreg_axon t2
on t1.partnernummer = t2.partnernummer
)
select count( distinct partnernummer ) from
t_smeo_sme_partnernummer
 
create table t_smeo_patent_full as
select t1.applicants,t1.publication_number, t1.publication_date,t1.application_date,t1.patent_type,t1.cited_count, t1.female_inventors,t1.male_inventors,t2.* from t_smeo_sme_partnernummer t1 inner join t_smeo_rev_par_hreg_axon t2
on t1.partnernummer = t2.partnernummer
 
select * from t_smeo_patent_full
 
select partnernummer,applicants,industry,rank as industry_rank,patent_type,cited_count,female_inventors,male_inventors,
revenue2010,revenue2011,revenue2012,revenue2013,revenue2014,revenue2015,revenue2016,zip,city,a_geb_gruend_jahr,small_large_index,canton,
average_area_income*100000 as Area_income, cityrural_index,Ind_ManufacturingEngineering,Ind_ServiceIndustry,Ind_RealEstate,Ind_Trade,min_employee,max_employee,
rechtsform,nominalkapital,lang_german,lang_german_french, lang_french_german, lang_german_romansh_italian, lang_italien,lang_frenc
from t_smeo_patent_full
 
select *
from t_smeo_rev_par_hreg_axon t1 left outer join t_smeo_sme_partnernummer t2
on t1.partnernummer=t2.partnernummer
where par
 
 
 
 
select distinct * from t_smeo_carz t1
inner join T_SMEO_IMPUTED_REVENUES t2
on t1.a_partner_nr = t2.partnernummer
inner join t_smeo_rev_par_hreg_axon t3
on t1.a_partner_nr = t3.partnernummer
inner join t_smeo_car_code t4
on upper(SUBSTR(t1.marke_typ, 1, 3)) = upper(t4.row_labels)
where 1=1
and t2.revenue2009 > 19999
and t2.revenue2010 > 19999
and t2.revenue2011 > 19999
and t2.revenue2012 > 19999
and t2.revenue2013 > 19999
and t2.revenue2014 > 19999
and t2.revenue2015 > 19999
and t2.revenue2016 > 19999
and t2.indexed2011 > 0.09
and t2.indexed2012 > 0.09
and t2.indexed2013 > 0.09
and t2.indexed2014 > 0.09
and t2.indexed2015 > 0.09
and t2.indexed2016 > 0.09
and t2.indexed2011 < 2
and t2.indexed2012 < 2
and t2.indexed2013 < 2
and t2.indexed2014 < 2
and t2.indexed2015 < 2
and t2.indexed2016 < 2
and t1.treibstoffart is not null
and t1.vn_geburts_datum is not null
and t1.vn_geburts_datum < '20.03.2017'
and t1.lenker_geburts_datum is not null
order by 1
)
select * from
(select t2.*
from t_smeo_industry_small_correct  t1 inner join t_smeo_rev_par_hreg_axon t2
on t1.a_betr_art = t2.industry
where t2.partnernummer not in (select partnernummer from  t_smeo_patent_full)) s1
inner join T_SMEO_IMPUTED_REVENUES s2
on s1.partnernummer = s2.partnernummer
where s2.indexed2011 < 2
and s2.indexed2012 < 2
and s2.indexed2013 < 2
and s2.indexed2014 < 2
and s2.indexed2015 < 2
and s2.indexed2016 < 2
and rownum <= 10000
 
