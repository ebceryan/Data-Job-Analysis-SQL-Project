
WITH top_paying_jobs AS 

(SELECT
  job_id,
  job_title,
  salary_year_avg,
  name AS company_name
FROM
  job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
  job_title_short = 'Data Analyst' AND
  job_location = 'Anywhere' AND
  salary_year_avg IS NOT NULL
ORDER BY
  salary_year_avg DESC
LIMIT 10)

SELECT
    top_paying_jobs.*,
    skills

FROM 
    top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC

/* The top 10 in-demand skills for data analyst jobs in 2023 based on your dataset are:

SQL: Required in 8 postings.
Python: Mentioned in 7 postings.
Tableau: Sought in 6 postings.
R: Required in 4 postings.
Snowflake, Pandas, and Excel: Each appeared in 3 postings.
Azure, Go, and Bitbucket: Each listed in 2 postings.
This suggests a strong demand for technical proficiency in SQL, Python, and data visualization tools like Tableau, alongside familiarity with programming and data engineering tools. 


*/

