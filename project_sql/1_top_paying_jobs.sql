/*
Question: What are the top paying entry level full-time data scientist jobs?
- Identify the top highest paying full-time entry level data scientist roles.
*/

SELECT
 job_id,
  job_title,
  job_location,
  job_schedule_type,
  salary_year_avg,
  job_posted_date,
  name AS company_name

FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
  job_title_short = 'Data Scientist' AND
  job_schedule_type = 'Full-time' AND
  (job_title LIKE '%Junior%' OR job_title LIKE '%Entry%') AND
  salary_year_avg IS NOT NULL
ORDER BY
  salary_year_avg DESC


/* 127 entry level roles out of 5641 */