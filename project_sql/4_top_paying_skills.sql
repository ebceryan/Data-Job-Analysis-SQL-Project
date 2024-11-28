
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

/*
Here are some insights and trends from the provided list of top-paying skills for data scientists:

Top Earners: Skills like Airflow and C# lead with $115,000, followed by PostgreSQL, Hadoop, and MongoDB ($108,000+), reflecting demand for orchestration, programming, and big data expertise.

Big Data Dominance: Tools such as Hadoop and Spark ($98,000) highlight the demand for handling large-scale data processing.

Cloud Skills: IBM Cloud ($102,200) and AWS ($100,822) show the importance of cloud computing in the job market.

Database Proficiency: Expertise in PostgreSQL, SQL Server ($100,000), and NoSQL technologies ($97,500) commands high salaries.

DevOps Tools: Skills in Git, Jenkins ($94,375), and Docker ($92,510) emphasize the value of CI/CD and containerization.

Programming Languages: C#, Java ($94,484), and C++ ($93,862) remain highly rewarded.

Data Visualization: Tools like Qlik ($105,900) and Tableau ($95,158) reflect the need for effective data communication.

AI and ML Frameworks: Keras ($95,496) highlights the demand for machine learning expertise.

Emerging Technologies: Skills in Kafka ($93,750) and Splunk ($93,538) demonstrate the value of real-time data processing.

Key Takeaway: Combining these skills with broader expertise increases earning potential and market competitiveness.

Recommendations:
Upskill in High-Paying Areas: Professionals should focus on acquiring or enhancing skills like Airflow, C#, Hadoop, and PostgreSQL to target the higher salary range.
Leverage Cloud and Big Data: Mastery of tools like AWS, MongoDB, and Spark is increasingly critical in industries like finance, healthcare, and e-commerce.
Develop Versatility: Combining skills in programming (e.g., C#, Java), database management (e.g., SQL Server), and visualization tools (e.g., Tableau, Qlik) can make candidates more versatile and attractive to employers.