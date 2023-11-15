-- ---------------------------------------------- --
-- --------------- Easy Questions --------------- --
-- ---------------------------------------------- --

-- Q1. Show first name, last name, and gender of patients whose gender is 'M'.
SELECT 
    first_name, last_name, gender
FROM
    patients
WHERE
    gender = 'M';

-- Q2. Show first name and last name of patients who does not have allergies. (null)
SELECT 
    first_name, last_name
FROM
    patients
WHERE
    allergies IS NULL;

-- Q3. Show first name of patients that start with the letter 'C'.
SELECT 
    first_name
FROM
    patients
WHERE
    first_name LIKE 'C%';

-- Q4. Show first name and last name of patients that weight within the range of 100 to 120 (inclusive).
SELECT 
    first_name, last_name
FROM
    patients
WHERE
    weight BETWEEN 100 AND 120;

-- Q5. Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'.
UPDATE patients 
SET 
    allergies = 'NKA'
WHERE
    allergies IS NULL;

-- Q6. Show first name and last name concatinated into one column to show their full name.
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name
FROM
    patients;

-- Q7. Show first name, last name, and the full province name of each patient.
SELECT 
    first_name, last_name, province_name
FROM
    patients
        JOIN
    province_names ON province_names.province_id = patients.province_id;
 
-- Q8. Show how many patients have a birth_date with 2010 as the birth year.
SELECT 
    COUNT(*) AS total_patients
FROM
    patients
WHERE
    YEAR(birth_date) = 2010;
  
-- Q9. Show the first_name, last_name, and height of the patient with the greatest height.
SELECT 
    first_name, last_name, MAX(height) AS height
FROM
    patients;

-- Q10. Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000.
SELECT 
    *
FROM
    patients
WHERE
    patient_id IN ('1', '45', '534', '879', '1000');

-- Q11. Show the total number of admissions.
SELECT 
    COUNT(*) AS total_admissions
FROM
    admissions;

-- Q12. Show all the columns from admissions where the patient was admitted and discharged on the same day.
SELECT 
    *
FROM
    admissions
WHERE
    admission_date = discharge_date;

-- Q13. Show the patient id and the total number of admissions for patient_id 579.
SELECT 
    patient_id, COUNT(*) AS total_admission
FROM
    admissions
WHERE
    patient_id = 579; 
  
-- Q14. Based on the cities that our patients live in, show unique cities that are in province_id 'NS'.
SELECT DISTINCT
    (city)
FROM
    patients
WHERE
    province_id = 'NS';

/* Q15. Write a query to find the first_name, last name and birth date of patients who has 
height greater than 160 and weight greater than 70?*/
SELECT 
    first_name, last_name, birth_date
FROM
    patients
WHERE
    height > 160 AND weight > 70;
  
/* Q16. Write a query to find list of patients first_name, last_name, and allergies from Hamilton where
 allergies are not null?*/
SELECT 
    first_name, last_name, allergies
FROM
    patients
WHERE
    city = 'Hamilton'
        AND allergies IS NOT NULL;

-- ------------------------------------------------ --
-- --------------- Medium Question ---------------- --
-- ------------------------------------------------ --

-- Q1. Show unique birth years from patients and order them by ascending.
SELECT DISTINCT
    (YEAR(birth_date)) AS unique_years
FROM
    patients
ORDER BY 1;

-- Q2. Show unique first names from the patients table which only occurs once in the list.
SELECT 
    first_name
FROM
    (SELECT 
        first_name, COUNT(*) AS Repeated
    FROM
        patients
    GROUP BY first_name)
WHERE
    Repeated = 1;

/* Q3. Show patient_id and first_name from patients where their first_name start and ends with 's' 
and is at least 6 characters long*/
-- Method 1
SELECT 
    patient_id, first_name
FROM
    patients
WHERE
    first_name LIKE 'S%S'
        AND LEN(first_name) >= 6;
-- Method 2
SELECT 
    patient_id, first_name
FROM
    patients
WHERE
    first_name LIKE 'S____%S';

-- Q4. Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
SELECT 
    patients.patient_id, first_name, last_name
FROM
    patients
        JOIN
    admissions ON patients.patient_id = admissions.patient_id
WHERE
    diagnosis = 'Dementia';

-- Q5. Display every patient's first_name. Order the list by the length of each name and then by alphbetically.
SELECT 
    first_name
FROM
    patients
ORDER BY LEN(first_name) , first_name;

/* Q6. Show the total amount of male patients and the total amount of female patients in the patients table. 
Display the two results in the same row.*/
SELECT 
    SUM(Gender = 'M') AS male_count,
    SUM(Gender = 'F') AS female_count
FROM
    patients;

/* Q7. Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. 
Show results ordered ascending by allergies then by first_name then by last_name.*/
SELECT 
    first_name, last_name, allergies
FROM
    patients
WHERE
    allergies = 'Penicillin'
        OR allergies = 'Morphine'
ORDER BY allergies , first_name , last_name;

-- Q8. Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
SELECT 
    patient_id, diagnosis
FROM
    admissions
GROUP BY patient_id , diagnosis
HAVING COUNT(*) > 1;

/* Q9. Show the city and the total number of patients in the city. 
Order from most to least patients and then by city name ascending.*/
SELECT 
    city, COUNT(*) AS total_patients
FROM
    patients
GROUP BY city
ORDER BY total_patients DESC , city;

/* Q10. Show first name, last name and role of every person that is either patient or doctor. 
The roles are either "Patient" or "Doctor".*/
SELECT 
    first_name, last_name, 'Patient' AS role
FROM
    patients 
UNION ALL SELECT 
    first_name, last_name, 'Doctor'
FROM
    doctors;

-- Q11. Show all allergies ordered by popularity. Remove NULL values from query.
SELECT 
    allergies, COUNT(*) Popularity
FROM
    patients
WHERE
    allergies IS NOT NULL
GROUP BY 1
ORDER BY 2 DESC;

/* Q12. Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. 
Sort the list starting from the earliest birth_date.*/
SELECT 
    first_name, last_name, birth_date
FROM
    patients
WHERE
    YEAR(birth_date) BETWEEN 1970 AND 1979
ORDER BY 3;

/* Q13. We want to display each patient's full name in a single column. 
Their last_name in all upper letters must appear first, then first_name in all lower case letters. 
Separate the last_name and first_name with a comma. Order the list by the first_name in decending order EX: SMITH,jane*/

SELECT 
    CONCAT(UPPER(last_name), ',', LOWER(first_name)) AS new_name_format
FROM
    patients
ORDER BY first_name DESC;

-- Q14. Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.
-- Method 1
SELECT 
    *
FROM
    (SELECT 
        province_id, SUM(height) AS Height
    FROM
        patients
    GROUP BY province_id)
WHERE
    Height >= 7000;
-- Method 2
SELECT 
    province_id, SUM(height) AS sum_height
FROM
    patients
GROUP BY province_id
HAVING sum_height >= 7000;

-- Q15. Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'.
SELECT 
    (MAX(weight) - MIN(weight)) AS difference
FROM
    patients
WHERE
    last_name = 'Maroni';

/* Q16. Show all of the days of the month (1-31) and how many admission_dates occurred on that day. 
Sort by the day with most admissions to least admissions.*/
SELECT 
    DAY(admission_date) AS days, COUNT(*) AS addmission
FROM
    admissions
GROUP BY 1
ORDER BY 2 DESC;

-- Q17. Show all columns for patient_id 542's most recent admission_date.
SELECT 
    *
FROM
    admissions
WHERE
    patient_id = 542
ORDER BY admission_date DESC
LIMIT 1;

/* Q18. Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters. */
SELECT 
    patient_id, attending_doctor_id, diagnosis
FROM
    admissions
WHERE
    (patient_id % 2 <> 0
        AND attending_doctor_id IN ('1', '5', '19'))
        OR (attending_doctor_id LIKE '%2%'
        AND LEN(patient_id) = 3);

/* Q19. Show first_name, last_name, and the total number of admissions attended for each doctor. 
Every admission has been attended by a doctor.*/
SELECT 
    first_name, last_name, COUNT(*) AS total_admission
FROM
    admissions
        JOIN
    doctors ON admissions.attending_doctor_id = doctors.doctor_id
GROUP BY 1 , 2;

-- Q20. For each doctor, display their id, full name, and the first and last admission date they attended.
SELECT 
    admissions.attending_doctor_id,
    CONCAT(first_name, ' ', last_name) AS full_name,
    MIN(admission_date) AS first_admission_date,
    MAX(admission_date) AS last_admission_date
FROM
    doctors
        JOIN
    admissions ON admissions.attending_doctor_id = doctors.doctor_id
GROUP BY 1;

-- Q21. Display the total amount of patients for each province. Order by descending.
SELECT 
    province_name, COUNT(*) AS total_patients
FROM
    patients
        JOIN
    province_names ON patients.province_id = province_names.province_id
GROUP BY 1
ORDER BY 2 DESC;

/* Q22. For every admission, display the patient's full name, their admission diagnosis, 
and their doctor's full name who diagnosed their problem.*/
SELECT 
    CONCAT(patients.first_name,
            ' ',
            patients.last_name) AS patient_name,
    diagnosis,
    CONCAT(doctors.first_name,
            ' ',
            doctors.last_name) AS doctor_name
FROM
    patients
        JOIN
    admissions ON patients.patient_id = admissions.patient_id
        JOIN
    doctors ON admissions.attending_doctor_id = doctors.doctor_id;

-- Q23. Display the number of duplicate patients based on their first_name and last_name.
SELECT 
    first_name, last_name, COUNT(*) AS Num_of_duplicates
FROM
    patients
GROUP BY 1 , 2
HAVING Num_of_duplicates > 1;

/* Q24. Display patient's full name, height in the units feet rounded to 1 decimal, 
weight in the unit pounds rounded to 0 decimals, birth_date, gender non abbreviated.
Convert CM to feet by dividing by 30.48.
Convert KG to pounds by multiplying by 2.205.*/
SELECT 
    CONCAT(first_name, ' ', last_name) AS 'patient_name',
    ROUND(height / 30.48, 1) AS 'height "Feet"',
    ROUND(weight * 2.205, 0) AS 'weight "Pounds"',
    birth_date,
    CASE
        WHEN gender = 'M' THEN 'MALE'
        ELSE 'FEMALE'
    END AS 'gender_type'
FROM
    patients;
    
/* Q25. Show patient_id, first_name, last_name from patients whose does not have any records in the admissions table. 
(Their patient_id does not exist in any admissions.patient_id rows.)*/
SELECT 
    patient_id, first_name, last_name
FROM
    patients
WHERE
    patients.patient_id NOT IN (SELECT 
            admissions.patient_id
        FROM
            admissions);
            
-- ---------------------------------------------- --
-- --------------- Hard Question ---------------- --
-- ---------------------------------------------- --         

/* Q1. Show all of the patients grouped into weight groups.
Show the total amount of patients in each weight group.
Order the list by the weight group descending.
For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.*/
SELECT 
    COUNT(*) AS patients_in_group,
    FLOOR(weight / 10) * 10 AS weight_group
FROM
    patients
GROUP BY weight_group
ORDER BY weight_group DESC;
   
/* Q2. Show patient_id, weight, height, isObese from the patients table.
Display isObese as a boolean 0 or 1.
Obese is defined as weight(kg)/(height(m)2) >= 30.
weight is in units kg.
height is in units cm. */
SELECT 
    patient_id,
    weight,
    height,
    (CASE
        WHEN weight / (POWER(height / 100.0, 2)) >= 30 THEN 1
        ELSE 0
    END) AS isObese
FROM
    patients;
    
/* Q3. Show patient_id, first_name, last_name, and attending doctor's specialty.
Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'*/
SELECT 
    p.patient_id, p.first_name, p.last_name, specialty
FROM
    patients p
        JOIN
    admissions a ON p.patient_id = a.patient_id
        JOIN
    doctors d ON a.attending_doctor_id = d.doctor_id
WHERE
    diagnosis = 'Epilepsy'
        AND d.first_name = 'Lisa';

/* Q4 .All patients who have gone through admissions, can see their medical documents on our site. 
Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.

The password must be the following, in order:
1. patient_id
2. the numerical length of patient's last_name
3. year of patient's birth_date*/
SELECT 
    a.patient_id,
    CONCAT(a.patient_id,
            LEN(last_name),
            YEAR(birth_date)) AS password
FROM
    patients p
        JOIN
    admissions a ON p.patient_id = a.patient_id
GROUP BY 1;

/* Q5. Each admission costs $50 for patients without insurance, and $10 for patients with insurance. 
All patients with an even patient_id have insurance.
Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. 
Add up the admission_total cost for each has_insurance group.*/
SELECT 
    'No' AS has_insurance, COUNT(*) * 50 AS cost
FROM
    admissions
WHERE
    patient_id % 2 = 1
GROUP BY has_insurance 
UNION SELECT 
    'Yes' AS has_insurance, COUNT(*) * 10 AS cost
FROM
    admissions
WHERE
    patient_id % 2 = 0
GROUP BY has_insurance;

-- Q6. Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name.
SELECT 
    province_name
FROM
    province_names
        JOIN
    patients ON patients.province_id = province_names.province_id
GROUP BY province_name
HAVING (SUM(gender = 'M') > SUM(gender = 'F'));

/*Q7. We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:
- First_name contains an 'r' after the first two letters.
- Identifies their gender as 'F'
- Born in February, May, or December
- Their weight would be between 60kg and 80kg
- Their patient_id is an odd number
- They are from the city 'Kingston'*/
SELECT 
    *
FROM
    patients
WHERE
    first_name LIKE '__r%' AND gender = 'F'
        AND MONTH(birth_date) IN (2 , 5, 12)
        AND weight BETWEEN 60 AND 80
        AND patient_id % 2 <> 0
        AND city = 'Kingston';

/* Q8. Show the percent of patients that have 'M' as their gender. 
Round the answer to the nearest hundreth number and in percent form.*/
SELECT 
    ROUND(AVG(gender = 'M') * 100, 2) || '%' AS Percent_of_male_patients
FROM
    patients;
    
/*Q9. For each day display the total amount of admissions on that day. 
Display the amount changed from the previous date.*/
SELECT
 admission_date,
 COUNT(admission_date) AS admission_day,
 COUNT(admission_date) - LAG(COUNT(admission_date)) OVER(ORDER BY admission_date) AS admission_count_change 
FROM admissions
 GROUP BY admission_date;
    
-- Q10. Sort the province names in ascending order in such a way that the province 'Ontario' is always on top.    
SELECT 
    province_name
FROM
    province_names
ORDER BY (NOT province_name = 'Ontario') , province_name;

/* Q11. We need a breakdown for the total amount of admissions each doctor has started each year. 
Show the doctor_id, doctor_full_name, specialty, year, total_admissions for that year.*/
SELECT 
    d.doctor_id AS doctor_id,
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
    d.specialty,
    YEAR(a.admission_date) AS selected_year,
    COUNT(*) AS total_admissions
FROM
    doctors AS d
        LEFT JOIN
    admissions AS a ON d.doctor_id = a.attending_doctor_id
GROUP BY doctor_name , selected_year
ORDER BY doctor_id , selected_year;