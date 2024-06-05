create database sqlproj;

use sqlproj

select * from hr
-- count of employees with respect to attrition
select attrition ,count(*) as total_emp_count from hr
group by attrition

--1 means emp's left from company, 0 means emp's staying in company
-- we want to check from those are all left the company cause of specific reason.
-- the reasons we want to find

select attrition ,count(*) as total_emp_count from hr
where Attrition=1
group by attrition
-------- first parameter is overtime col----
---- because of this ,emp migrated from here?

select overtime ,count(*) as count_of_emp from hr
where attrition=1
group by overtime---this query output represents overtime col is not the reason for migration


-----how many female and male employees

select gender,count(*) as emp_count from hr
where attrition=1
group by gender


-----performance rating of the particular employees

select performancerating ,count(*) as attrition_count from hr
where Attrition=1
group by PerformanceRating---- this col is important cause lower performance emp's has made more migration


------- checking department & job roles , if this parameter is important for the emp for the migration?

select department ,jobrole ,count(*) as attrition_count,(count(*)*100/(select count(*) from hr where attrition=1) )as attrition_perc from hr
where attrition =1
group by jobrole,department
order by attrition_count desc--yes this cols also make sense for migration

------checking distance col parameter for emp for the migration

select distancefromhome,count(*) as attrition_count from hr
where Attrition=1
group by distancefromhome
order by attrition_count desc--- since its vice versa cause lower distance emp has migrated more.

-------checking percentagesalaryhike col paramter

select percentsalaryhike,count(*) as attrition_count from hr
where attrition=1
group by percentsalaryhike
order by percentsalaryhike desc----- this col make sense for the emp's for migration

------checking educationfield col

select educationfield,count(*) as attrition_count from hr
where attrition=1
group by EducationField
order by attrition_count desc------this col also make sense for the emp's for migration

---relationship between years in current role and attrition count

select yearsincurrentrole,count(*) as'attrition_count' from hr
where attrition =1
group by YearsInCurrentRole
having 
order by

----job satisfaction based on monthly income---

select jobsatisfaction ,count(*) as attrition_count from hr
where attrition=1 and monthlyincome< (select avg(cast(monthlyincome as int)) from hr)
group by JobSatisfaction-- monthly income plays vital role in attrition count irrespectively with the jobsatisfaction is on higher side

----employee attrition based on age range or bucket--

select  case when age <=29 then'18-29'
            when age >=30 and age <=39 then'30-39'
			when age >=40 and age <=49 then'40-49'
			when age >=50 and age <=59 then'50-59' 
			else '60 or older' end as age_bucket,count(*) as attrition_count from hr
where attrition=1 and YearsAtCompany >=1
group by case when age <=29 then'18-29'
            when age >=30 and age <=39 then'30-39'
			when age >=40 and age <=49 then'40-49'
			when age >=50 and age <=59 then'50-59' 
			else '60 or older' end 
order by attrition_count desc

----- calculating the attrition count based on avg monthly rate, avg hourly rate and avg monthly income
select count(*) as attrition_count from hr
where attrition=1 and DailyRate<(select avg(cast(DailyRate as int)) from hr) 
                  and MonthlyRate<(select avg(cast(MonthlyRate as int)) from hr)
				  and MonthlyIncome<(select avg(cast(MonthlyIncome as int)) from hr)

--calculating the attrition count based on relationshipsatisfication,environment satisfication
select count(*) as attrition_count,EnvironmentSatisfaction,RelationshipSatisfaction from hr
where attrition=1 
group by EnvironmentSatisfaction,RelationshipSatisfaction 
order by attrition_count desc--- Environment and relationship satisfication is 3 still attrition happened. so its not play vital role

select * from hr







