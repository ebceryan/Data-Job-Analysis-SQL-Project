# Introduction
Focusing on entry level data scientist roles, this project explores, top-paying jobs, in-demand skills, and where high demand meets high salary in data science.
# Background
Data was taken from (https://www.lukebarousse.com/sql).

It's packed with insights on job titles, salaries, locations, and essential skills.

The questions to ponder through SQL queries were:

  1)What are the top-paying data scientist jobs?

  2)What skills are required for these top-paying jobs?

  3)What skills are most in demand for data scientists?

  4)Which skills are associated with higher salaries?

  5)What are the most optimal skills to learn?

# Tools

- **SQL:** The foundation of my analysis, enabling efficient querying and extraction of valuable insights from the database.

- **PostgreSQL:** My preferred database management system, perfectly suited for managing and analyzing job posting data.

- **Visual Studio Code:** My primary tool for database management and executing SQL queries with precision.

- **Git & GitHub:** Crucial for version control and seamless collaboration, ensuring organized sharing and tracking of SQL scripts and analyses.

# Analysis
Each query aimed to investigate specific aspects of the data scientist job market. Here’s how I approached each question:

### 1. Top Paying Jobs
To identify the highest-paying roles, I filtered entry level data scientist positions by average yearly salary. This query highlights the high paying opportunities in the field.

```sql
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
```

Here's the breakdown of the top data scientist jobs:

- **Wide Salary Range:** Top 10 paying roles span from $105,000 to $155,000.
- **Diverse Employers:** Companies like SteelPerlot, PlayStation, and Booz Allen Hamilton are offering high salaries, showing a broad interest across different industries.
- **Job Title Variety:** There's a high diversity in job titles, including Entry level and Junior, reflecting varied roles and specializations within data science.

![image](https://github.com/user-attachments/assets/7bfdceb6-9bf2-4a6a-98b8-0fda88e321e4)



# Learnings
# Conclusions
