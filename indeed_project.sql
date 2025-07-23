-- How many rows are in the data_analyst_jobs table?
-- A: 1793

SELECT
	COUNT (*) AS row_count
FROM
	data_analyst_jobs;

-- Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?
-- A: XTO Land Data Analyst

SELECT 
	*
FROM
	data_analyst_jobs
LIMIT 10;

-- How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?
--A: 21 in TN, 27 in KY or TN

SELECT
	COUNT(*) AS tn_jobs
FROM 
	data_analyst_jobs
WHERE
	location='TN';

SELECT
	COUNT(*) AS tn_or_ky_jobs
FROM
	data_analyst_jobs
WHERE 
	location IN ('KY','TN');

-- How many postings in Tennessee have a star rating above 4?
-- A: 3

SELECT
	COUNT(*) AS tn_high_rating_jobs
FROM 
	data_analyst_jobs
WHERE
	location = 'TN'
AND
	star_rating > 4;

-- How many postings in the dataset have a review count between 500 and 1000?
-- A: 151

SELECT
	COUNT (*) AS reviews_between_500_1000
FROM
	data_analyst_jobs
WHERE
	review_count BETWEEN 500 AND 1000;

-- Show the average star rating for companies in each state. The output should show the state as state and the average rating for the state as avg_rating. Which state shows the highest average rating?
-- A: NE

SELECT
	location AS state,
	ROUND(AVG(star_rating),2)AS avg_rating
FROM
	data_analyst_jobs
WHERE 
	star_rating IS NOT NULL
GROUP BY 
	state
ORDER BY
	avg_rating DESC;

-- Select unique job titles from the data_analyst_jobs table. How many are there?
-- A: 881

SELECT
	COUNT(DISTINCT title) AS unique_job_titles
FROM
	data_analyst_jobs;
	
-- How many unique job titles are there for California companies?
-- A: 230

SELECT
	COUNT(DISTINCT title) AS ca_job_titles
FROM
	data_analyst_jobs
WHERE
	location = 'CA';

-- Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?
--A: 70

SELECT 
	company, 
	ROUND(AVG(star_rating),2) AS avg_star_rating, 
	SUM(review_count) AS total_reviews
FROM 
	data_analyst_jobs
WHERE
	company IS NOT NULL
GROUP BY 
	company
HAVING 
	SUM(review_count) > 5000;

-- Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?
--A: Google, 4.3

SELECT 
	company, 
	ROUND(AVG(star_rating),2) AS avg_star_rating, 
	SUM(review_count) AS total_reviews
FROM 
	data_analyst_jobs
GROUP BY 
	company
HAVING 
	SUM(review_count) > 5000
ORDER BY 
	avg_star_rating DESC;

-- Find all the job titles that contain the word ‘Analyst’. How many different job titles are there?
-- A: 1669 - distinct 774

SELECT
	title AS job_titles
FROM
	data_analyst_jobs
WHERE 
	title ILIKE '%analyst%';

SELECT
	COUNT(DISTINCT title) AS job_titles
FROM
	data_analyst_jobs
WHERE 
	title ILIKE '%analyst%';

-- How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?
-- A: 4, all mention Tableau

SELECT
	title AS non_analyst_jobs
FROM 
	data_analyst_jobs
WHERE
	title NOT ILIKE '%analyst%'
AND
	title NOT ILIKE '%analytics%';

-- BONUS: You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks.

-- Disregard any postings where the domain is NULL.
-- Order your results so that the domain with the greatest number of hard to fill jobs is at the top.
-- Which three industries are in the top 4 on this list? How many jobs have been listed for more than 3 weeks for each of the top 4?
-- A: Internet and Software - 62, Banks and Financial Services - 61, Consulting and Business Services - 57, Health Care - 52

SELECT
	domain,
	COUNT(domain) AS jobs_by_industry
FROM 
	data_analyst_jobs
WHERE 
	skill ILIKE '%sql%'
AND
	days_since_posting > 21
AND	
	domain IS NOT NULL
GROUP BY
	domain
ORDER BY
	jobs_by_industry DESC
LIMIT
	4;

