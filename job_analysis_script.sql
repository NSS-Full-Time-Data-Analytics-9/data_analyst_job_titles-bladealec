

--To glance at the table

SELECT *
FROM data_analyst_jobs
LIMIT 5;


-- 1. How many rows are in the data_analyst_jobs table

SELECT COUNT(*)
FROM data_analyst_jobs;
-- 1793


-- 2. Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?

SELECT company
FROM data_analyst_jobs
LIMIT 10;
-- ExxonMobil


-- 3. How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?

SELECT COUNT(location) AS tennessee_job_count
FROM data_analyst_jobs
WHERE location ILIKE 'tn';
-- 21

SELECT COUNT(location) AS tn_ky_job_count
FROM data_analyst_jobs
WHERE location ILIKE 'tn'
	OR location ILIKE 'ky';
-- 27


-- 4. How many postings in Tennessee have a star rating above 4?

SELECT COUNT(*)
FROM data_analyst_jobs
WHERE star_rating > 4;
--416


-- 5. How many postings in the dataset have a review count between 500 and 1000?

SELECT COUNT(*)
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;
-- 151


-- 6. Show the average star rating for companies in each state. The output should show the state as `state` and the average rating for the state as `avg_rating`. Which state shows the highest average rating?

SELECT location AS state, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE star_rating IS NOT NULL
GROUP BY location
ORDER BY avg_rating DESC;
-- NE

-- 7. Select unique job titles from the data_analyst_jobs table. How many are there?

SELECT COUNT(DISTINCT(title))
FROM data_analyst_jobs;
-- 881


-- 8. How many unique job titles are there for California companies?

SELECT COUNT(DISTINCT(title)) AS cali_title_count
FROM data_analyst_jobs
WHERE location ILIKE 'CA';
-- 230


-- 9. Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?

SELECT company, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE review_count > 5000
GROUP BY company;
-- 40


-- 10. Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?

SELECT company, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE review_count > 5000
GROUP BY company
ORDER BY avg_rating DESC;
-- General Motors


-- 11. Find all the job titles that contain the word ‘Analyst’. How many different job titles are there? 

SELECT COUNT(DISTINCT(title))
FROM data_analyst_jobs
WHERE title ILIKE '%analyst%';
-- 774

-- 12.  How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?

SELECT title, COUNT(DISTINCT(title))
FROM data_analyst_jobs
WHERE title NOT ILIKE '%Analyst%'
	AND title NOT ILIKE '%Analytics%'
GROUP BY title;
-- 4 diff. titles, and 3 have 'data'


-- BONUS. You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks. 
 -- Disregard any postings where the domain is NULL. 
 -- Order your results so that the domain with the greatest number of `hard to fill` jobs is at the top. 
 -- Which three industries are in the top 4 on this list?
 -- How many jobs have been listed for more than 3 weeks for each of the top 4?


SELECT COUNT(domain)
FROM data_analyst_jobs
WHERE skill ILIKE '%sql%'
	AND days_since_posting > (3*7);
	
-- 403 hard to fill jobs
 
 
SELECT domain, COUNT(domain) AS domain_count
FROM data_analyst_jobs
WHERE skill ILIKE '%sql%'
	AND days_since_posting > (3*7)
	AND domain IS NOT NULL
GROUP BY domain
ORDER BY domain_count DESC;

-- Banks and Financial Services 
-- InsuranceHealth Care
-- Consulting and Business Services


SELECT domain, COUNT(domain) AS domain_count
FROM data_analyst_jobs
WHERE skill ILIKE '%sql%'
	AND days_since_posting > (3*7)
GROUP BY domain
HAVING domain ILIKE 'Banks and Financial Services'
	OR domain ILIKE 'InsuranceHealth Care'
	OR domain ILIKE 'Consulting and Business Services';

-- Banks and Financial Services		(57)
-- InsuranceHealth Care 			(61)
-- Consulting and Business Services	(21)
	

