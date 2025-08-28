-- DATA CLEANING
SELECT *
FROM layoffs;

-- Creating a duplicate table to avoid messing up original dataset
CREATE TABLE layoffs_staging 
LIKe layoffs;

SELECT * 
FROM layoffs_staging;
-- Inserting my data into my new table
 INSERT layoffs_staging
 SELECT *
 FROM layoffs;
-- Now lets get to cleaning
 -- -------------------------Removing Duplicates Rows if any----------------------------------------------------------------
 -- creating new table to help remove duplicate (no unique indexing column, hence the hassle)
 CREATE TABLE `layoffs_staging_2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO layoffs_staging_2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company,location,industry,total_laid_off,
percentage_laid_off,`date`,country,funds_raised_millions) AS row_num
FROM layoffs_staging;

-- now lets get those Duplicates
DELETE
FROM layoffs_staging_2
WHERE row_num > 1;

-- -------------------------------------STANDARDIZING OUR DATA-----------------------------------------------------------
--  Removing whitespaces
SELECT TRIM(company),
  TRIM(location) ,
  TRIM(industry),
  TRIM(total_laid_off),
  TRIM(percentage_laid_off),
  TRIM(date),
  TRIM(stage),
  TRIM(country),
  TRIM(funds_raised_millions)
FROM layoffs_staging_2;

UPDATE layoffs_staging_2
SET company=TRIM(company), location = TRIM(location) , industry = TRIM(industry),
 total_laid_off = TRIM(total_laid_off), percentage_laid_off = TRIM(percentage_laid_off),
 date = TRIM(date), stage= TRIM(stage), country= TRIM(country), funds_raised_millions= TRIM(funds_raised_millions);

-- Taking care of redundant repetition (in the case of our dataset, crypto-currency= crypto, )-----
SELECT *
FROM layoffs_staging_2
WHERE industry LIKE'Crypto%';

UPDATE layoffs_staging_2
SET industry='Crypto'
WHERE  industry LIKE 'Crypto%';

-- Formatting the date enable possible time analysis later
UPDATE layoffs_staging_2
SET `date`= str_to_date(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging_2
MODIFY COLUMN `date`  DATE;

-- --------------------------Taking Care of the Nulls and Blanks-------------------------------------------------------
-- NOTE: not all nulls need a "special care", discovering those that do and dont is part of the process
-- knowing what care to give to which nulls is also part of the process
-- one of the ways to care  for nulls is by populating them(in the case of this dataset we look at the indusrty column)
SELECT *
FROM layoffs_staging_2
WHERE industry IS NULL
OR industry = '';
-- discovered Airbnb rows under column company are missing a couple of industry label
-- lets try to fix that
-- first step; nullify all blank spaces to make encourage uniformity( lets put a single name to similar issues)
UPDATE layoffs_staging_2
SET industry = NULL 
WHERE industry='';
-- Now lets get the nulls
UPDATE layoffs_staging_2 t1
JOIN layoffs_staging_2 t2
    ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL OR t1.industry='')
AND t2.industry IS NOT NULL;
-- curtains on nulls (for now)

-- ----------------------REMOVING REDUNDANT COLUMNS AND ROWS-------------------------------------------------------- 
--  removing and deleting data is a slippery slope, lets tread  carefully
-- total_laid_off and percentage_laid_off is our focus now, if theyre both nulls, its unecessary for my analysis
DELETE
FROM layoffs_staging_2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- now lets get rid of "row_num" column that has outlived its purpose
ALTER TABLE layoffs_staging_2
DROP COLUMN row_num;

