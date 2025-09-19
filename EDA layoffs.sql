-- Exploratory Data Analysis------------------
-- Questions Answered with this dataset includes:
-- 1.Companies with most layoffs
-- 2.Industries most/least affected by layoffs
-- 3. What regions experienced most/least layoffs
--  4. Layoffs of compaines based on what stage they are in?
-- 5. Impact of funding on layoffs?
-- 5. Trends of layoffs over time
-- ------ Lets Solve these puzzles with codes
-- -----------------companies with most/least layoffs---------------------
-- Most layoffs
SELECT SUM(total_laid_off) as "Total_layoffs", company
FROM layoffs_staging_2
GROUP BY company
ORDER BY 1 DESC
LIMIT  5;

-- --------------Industries and layoffs----------------------
-- least layoff per industry
SELECT avg(total_laid_off) as "Average_layoffs", industry
FROM layoffs_staging_2
WHERE total_laid_off IS NOT NULL
GROUP BY industry
ORDER BY 1 ASC
LIMIT  10;
-- most layoff per industry
SELECT avg(total_laid_off) AS "average layoffs", industry
FROM layoffs_staging_2
GROUP BY industry
ORDER BY 1 DESC
LIMIT  10;
-- -------layoffs according to companies stage?---------------
SELECT  stage,
 SUM(total_laid_off) AS total_laid_off, 
 COUNT(DISTINCT company) AS companies_affected
 FROM layoffs_staging_2
 GROUP BY(stage)
 ORDER BY total_laid_off DESC;
 
-- ---------Which countries are more affected by layoffs-------------
SELECT country,
SUM(total_laid_off) as Total_laid_off,
Count(DISTINCT company) as company_affected
FROM layoffs_staging_2
GROUP BY country
ORDER BY 2 DESC;

-- -----Impact of funding on  layoffs---------
SELECT stage,
AVG(total_laid_off) AS total_laidoff,
SUM(funds_raised_millions) AS total_fund_raised
FROM layoffs_staging_2
GROUP BY stage
ORDER BY total_laidoff DESC;

-- -----------------rolling total layoffs by month
WITH rolling_total AS 
(
SELECT substring(`date`,1,7) AS `MONTH`, SUM(total_laid_off) AS total_off
FROM layoffs_staging_2
WHERE substring(`date`,1,7) IS NOT NULL
GROUP BY substring(`date`,1,7)
ORDER BY 1 ASC
)
SELECT `MONTH`, total_off,
 SUM(total_off) OVER(ORDER BY `MONTH`) AS roll_total
FROM rolling_total; 

-- --Ranking company layoffs per year with CTE
WITH company_year(company,total_laid_off,years) AS
(
SELECT company, SUM(total_laid_off),YEAR(`date`)
FROM layoffs_staging_2
GROUP BY company, YEAR(`date`)
ORDER BY  2 DESC
), Company_year_rank AS
(
SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) as layoff_rank
FROM company_year
WHERE years IS NOT NULL
)
SELECT *
FROM company_year_rank
WHERE layoff_rank <= 5;