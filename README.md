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

### 2. Skills for Top Paying Jobs
To understand required skills for the top-paying jobs, the job postings with the skills data are joined, providing insights into what employers value for high-compensation roles.

```sql
WITH top_paying_jobs AS 
(SELECT
 job_id,
  job_title,
  job_location,
  job_schedule_type,
  salary_year_avg,
  job_posted_date,
  name AS company_name
FROM
  job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
  job_title_short = 'Data Scientist' AND
  job_schedule_type = 'Full-time' AND
  (job_title LIKE '%Junior%' OR job_title LIKE '%Entry%') AND
  salary_year_avg IS NOT NULL
ORDER BY
  salary_year_avg DESC)

SELECT
    top_paying_jobs.*,
    skills
FROM 
    top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC
```
These insights highlight a strong demand for programming languages (Python, SQL, R) and data tools (SAS, Tableau, Spark), alongside cloud computing skills (AWS).

![image](https://github.com/user-attachments/assets/b9711bd7-6adb-477d-a311-87f5f02d930c)

### 3. In-Demand Skills for Data Scientists
This query identified the most frequently requested skills in job postings, directing focus to areas with high demand.

```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Scientist' AND
    job_schedule_type = 'Full-time' AND
    (job_title LIKE '%Junior%' OR job_title LIKE '%Entry%')
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5
```
- Python and SQL are foundational skills for almost every data science role.
- Specialized tools like R and SAS are valuable for statistical modeling and industry-specific applications.
- Proficiency in visualization tools like Tableau is essential for presenting data-driven insights effectively.
- Aspiring data scientists should prioritize learning Python and SQL while supplementing their skill set with at least one statistical tool (R/SAS) and a visualization tool (Tableau) to stay competitive.

![image](https://github.com/user-attachments/assets/be5d8689-c7ee-4f10-aa58-3c3706216a1c)


### 4. Skills Based on Salary

Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

WHERE
    job_title_short = 'Data Scientist' AND
    job_schedule_type = 'Full-time' AND
    (job_title LIKE '%Junior%' OR job_title LIKE '%Entry%')
    AND salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25
```

- Specialized Tools Command Premium Salaries: Airflow, Hadoop, and Qlik emphasize the value of advanced data engineering, big data, and visualization skills.
- Cloud and Database Expertise Are Highly Valued: PostgreSQL, MongoDB, IBM Cloud, and AWS illustrate the importance of managing and analyzing data in modern environments.
- Versatile Programming and Deployment Skills Add Value: C# and Bitbucket reflect the integration of software development and data science.

Data scientists aiming for high-paying roles should:

- Focus on acquiring data engineering tools like Airflow and Hadoop.
- Build proficiency in database management (PostgreSQL, MongoDB) and cloud platforms (AWS, IBM Cloud).
- Consider specialization in business intelligence tools (Qlik, MicroStrategy) to align with enterprise-level analytics roles.

![image](https://github.com/user-attachments/assets/e1e89dc6-58bd-4295-9104-b6a7277255fe)


### 5. Most Optimal Skills to Learn

This query aimed to identify skills that are both in high demand and command high salaries by analyzing demand and salary data, providing strategic guidance for skill development.

```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

WHERE
    job_title_short = 'Data Scientist'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```
![image](https://github.com/user-attachments/assets/491ae212-e243-4bd3-a949-f1c61dda1c51)

### Key Observations:

High-Paying and High-Demand Skills:
- Go, Snowflake, and PyTorch stand out for their combination of demand and competitive salaries.
These skills represent a mix of backend systems, cloud-based data management, and machine learning.

Emerging Technologies:

- Tools like Airflow and BigQuery are critical for modern data pipelines and cloud analytics.
BI tools like Qlik and Looker highlight the continued value of turning data into actionable business insights.

Programming Languages:

- C, Go, and Scala emphasize the need for efficient, high-performance, and big data-focused programming.

### Recommendation:
To maximize earning potential and job opportunities, data scientists should:

Invest in AI and ML skills:
- Learn PyTorch for cutting-edge AI roles.

Master cloud-based tools:
- Focus on Snowflake, GCP, and Airflow for data engineering and analytics in scalable environments.

Explore BI platforms:
- Gain expertise in Looker and Qlik for high-impact roles in data visualization and business decision-making.

Expand programming expertise:
- Complement Python knowledge with Go and Scala for backend and big data tasks.
This skillset positions professionals to excel in both high-demand and high-paying roles in the evolving data science landscape.


# Conclusions

### Insights

1. Top-Paying Data Analyst Jobs: The highest-paying jobs for entry level data scientists offer a wide range of salaries, the highest at $155,000.
2. Skills for Top-Paying Jobs: Top-paying jobs require advanced programming languages (Python, SQL, R) and data tools (SAS, Tableau, Spark) knowledge.
3. Most In-Demand Skills: Python and SQL are the most demanded skills in the data science job market, while at least one statistical tool (R/SAS) and a visualization tool (Tableau) are required to stay competitive.
4. Skills with Higher Salaries: Data engineering tools(Airflow and Hadoop), database management tools(PostgreSQL, MongoDB) and cloud platforms(AWS, IBM Cloud) and BI tools(Qlik, MicroStrategy) are associated with the highest average salaries.
5. Optimal Skills for Job Market Value: AI and ML skills(PyTorch), data engineering tools(Snowflake, GCP, Airflow), BI platforms(Looker, Qlik) should be prioritized to maximize job opportunities for data scientists.

This project enhanced my SQL skills and provided valuable insights into data science job market. For a junior data scientist who is looking for his/her first job, this exploration highlights the importance of learning and adaptation to emerging trends in the field of data science.
  
