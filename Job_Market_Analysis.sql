use dataanalytics;
SELECT * FROM dataanalytics.market;
/*1.	States with Most Number of Jobs.*/
select job_location as states,count(*) as total_jobs from market
group by job_location
order by total_jobs desc
limit 10;
/*2.	Average Minimal and Maximal Salaries in Different States.*/
SELECT Job_Location AS State,
  ROUND(AVG(Lower_Salary), 1) AS Avg_Min_Salary_K,
  ROUND(AVG(Upper_Salary), 1) AS Avg_Max_Salary_K
FROM market
GROUP BY Job_Location
ORDER BY Avg_Min_Salary_K DESC
LIMIT 10;
/*3.	Average Salary in Different States.*/
SELECT Job_Location AS State,
  ROUND(AVG(Avg_SalaryK), 1) AS Avg_Salary_K
FROM market
GROUP BY Job_Location
ORDER BY Avg_Salary_K DESC
LIMIT 10;
/*4.	Top 5 Industries with Maximum Number of Data Science Related Job Postings.*/
SELECT Industry, COUNT(*) AS Job_Count
FROM market
WHERE Industry != 'Unknown'
GROUP BY Industry
ORDER BY Job_Count DESC
LIMIT 5;
/*5.	Companies with Maximum Number of Job Openings.*/
SELECT company_txt AS Company, COUNT(*) AS Job_Openings
FROM Market
GROUP BY company_txt
ORDER BY Job_Openings DESC
LIMIT 10;
/*6.	Job Titles with Most Number of Jobs.*/
SELECT job_title_sim AS Job_Title, COUNT(*) AS Total_Jobs
FROM Market
GROUP BY job_title_sim
ORDER BY Total_Jobs DESC;
/*7.	Salary of Job Titles with Most Number of Jobs.*/
SELECT job_title_sim AS Job_Title,
  COUNT(*) AS Total_Jobs,
  ROUND(AVG(Avg_SalaryK), 1) AS Avg_Salary_K,
  ROUND(MIN(Lower_Salary), 1) AS Min_Salary_K,
  ROUND(MAX(Upper_Salary), 1) AS Max_Salary_K
FROM Market
GROUP BY job_title_sim
ORDER BY Total_Jobs DESC;
/*8.	Skills Required by Companies for Each Job Title.*/
SELECT job_title_sim,
  ROUND(AVG(Python)*100,1) AS Python_Pct,
  ROUND(AVG(sql_)*100,1)   AS SQL_Pct,
  ROUND(AVG(aws)*100,1)     AS AWS_Pct,
  ROUND(AVG(spark)*100,1)   AS Spark_Pct,
  ROUND(AVG(tableau)*100,1) AS Tableau_Pct,
  ROUND(AVG(excel)*100,1)   AS Excel_Pct
FROM Market
GROUP BY job_title_sim
ORDER BY Python_Pct DESC;
/*9.	Relation between Average Salary and Education.*/
SELECT
  CASE
    WHEN Degree = 'M' THEN 'Masters Degree'
    WHEN Degree = 'P' THEN 'PhD'
    ELSE 'Not Required'
  END AS Education_Level,
  COUNT(*) AS Job_Count,
  ROUND(AVG(Avg_SalaryK), 1) AS Avg_Salary_K
FROM Market
GROUP BY Degree
ORDER BY Avg_Salary_K DESC;
/*Salary by seniority*/
SELECT seniority_by_title, COUNT(*),
  ROUND(AVG(Avg_SalaryK),1)
FROM Market
WHERE seniority_by_title != 'na'
GROUP BY seniority_by_title
ORDER BY AVG(Avg_SalaryK) DESC;
/*Hourly vs salaried*/
SELECT
  CASE WHEN Hourly=1 THEN 'Hourly'
       ELSE 'Salaried' END AS Pay_Type,
  COUNT(*), ROUND(AVG(Avg_SalaryK),1)
FROM Market
GROUP BY Hourly;
/*Salary by ownership type*/
SELECT Type_of_ownership,
  COUNT(*), ROUND(AVG(Avg_SalaryK),1)
FROM Market
GROUP BY Type_of_ownership
ORDER BY AVG(Avg_SalaryK) DESC
LIMIT 5;
/*Top sectors by avg salary*/
SELECT Sector, COUNT(*),
  ROUND(AVG(Avg_SalaryK),1)
FROM Market
WHERE Sector != 'Unknown'
GROUP BY Sector
ORDER BY AVG(Avg_SalaryK) DESC
LIMIT 5;
