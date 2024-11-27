
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

WHERE
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25

/*
Here are some insights and trends from the provided list of top-paying skills for data analysts:

1. Emerging Technologies Command Premium Salaries
Skills such as PySpark ($208,172) and Bitbucket ($189,155) dominate the top tier, reflecting the demand for expertise in large-scale data processing and modern version control systems.
Tools associated with advanced analytics and automation, like DataRobot ($155,486), show strong demand for analysts with AI and machine learning automation skills.
2. Cloud and Distributed Systems Are Highly Valued
Cloud-related skills like Databricks ($141,907) and GCP ($122,500) are prominent. These platforms are critical for big data analysis and scalable solutions, emphasizing that cloud expertise is essential for high-paying data analyst roles.
3. Programming Proficiency Remains a Core Requirement
Programming languages such as Swift ($153,750), Scala ($124,903), and Golang ($145,000) command strong salaries, demonstrating the continued need for advanced coding capabilities.
Core data analysis libraries such as Pandas ($151,821), NumPy ($143,513), and Scikit-learn ($125,781) highlight the enduring importance of Python and its ecosystem.
4. DevOps and CI/CD Knowledge Boosts Analyst Salaries
Tools like GitLab ($154,500), Jenkins ($125,436), and Kubernetes ($132,500) indicate the growing need for analysts to work with development and deployment pipelines. This trend aligns with the shift towards MLOps and operationalizing analytics.
5. Visualization and Collaboration Platforms Play a Role
Skills like Jupyter ($152,777) and Notion ($125,000) are valued, suggesting that the ability to present findings and collaborate effectively is critical for top-paying roles.
6. Database and Query Optimization Knowledge
PostgreSQL ($123,879) and Elasticsearch ($145,000) illustrate the value of expertise in handling, querying, and optimizing large datasets, which is fundamental for data analysts.
7. Trend Toward Automation and AI Integration
Tools like Airflow ($126,103) and Watson ($160,515) reflect the increasing emphasis on automation and AI-driven decision-making, positioning data analysts with these skills for higher salaries.

Conclusion
To secure top-paying roles as a data analyst, individuals should:

Gain proficiency in big data tools (e.g., PySpark, Databricks).
Invest in cloud and distributed system knowledge (e.g., GCP, Kubernetes).
Develop advanced coding and machine learning automation skills (e.g., Swift, Scikit-learn, DataRobot).
Familiarize themselves with DevOps tools and CI/CD pipelines.
Enhance database expertise and visualization capabilities.
*/