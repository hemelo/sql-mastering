SELECT *
FROM V_$NLS_PARAMETERS;

-- Limiting the number of rows returned by a query
SELECT *
FROM V_$NLS_PARAMETERS FETCH FIRST 5 ROWS ONLY;

-- Limiting the number of rows returned by a query with ties
-- Means that if there are more than 5 rows with the same value, they will be returned as well
SELECT *
FROM V_$NLS_PARAMETERS
ORDER BY CON_ID FETCH FIRST 5 ROWS
WITH TIES;

-- Limiting the number of rows returned by a query with offset
SELECT *
FROM V_$NLS_PARAMETERS
OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY;

-- Ordering the result set in ascending order with NULLs first (NULLs are displayed first)
-- Usually, NULLs are displayed last
SELECT *
FROM V_$NLS_PARAMETERS
ORDER BY CON_ID NULLS FIRST;

-- Limiting the number of rows returned by a query by percentage
SELECT *
FROM V_$NLS_PARAMETERS FETCH FIRST 25 PERCENT ROWS ONLY;

-- Customizing Output with ABS
SELECT ABS(-10)
FROM DUAL;

-- Customizing Output with CEIL
SELECT CEIL(10.5)
FROM DUAL;

-- Customizing Output with FLOOR
SELECT FLOOR(10.5)
FROM DUAL;

-- Customizing Output with ROUND
-- ROUND is used to round a number to a specific number of decimal places
-- The 2nd argument is optional and defaults to 0
-- The 2nd argument can be negative
-- The 2nd argument can be used to round to a specific number of decimal places
-- If the 2nd argument is negative, the number is rounded to the left of the decimal point
-- If the 2nd argument is positive, the number is rounded to the right of the decimal point
SELECT ROUND(10.5)        "Round 01",
       ROUND(10.4)        "Round 02",
       ROUND(10.6)        "Round 03",
       ROUND(10.5, 0)     "Round 04",
       ROUND(10.5, 1)     "Round 05",
       ROUND(10.5, -1)    "Round 06",
       ROUND(127.623, 2)  "Round 07",
       ROUND(127.623, 1)  "Round 08",
       ROUND(127.623, -1) "Round 09",
       ROUND(127.623, -2) "Round 10"
FROM DUAL;

-- Customizing Output with TRUNC
-- TRUNC is used to truncate a number to a specific number of decimal places
-- The 2nd argument is optional and defaults to 0
-- The 2nd argument can be negative
-- The 2nd argument can be used to truncate to a specific number of decimal places
SELECT TRUNC(10.5)        "Trunc 01",
       TRUNC(10.4)        "Trunc 02",
       TRUNC(10.6)        "Trunc 03",
       TRUNC(10.5, 0)     "Trunc 04",
       TRUNC(10.5, 1)     "Trunc 05",
       TRUNC(10.5, -1)    "Trunc 06",
       TRUNC(127.623, 2)  "Trunc 07",
       TRUNC(127.623, 1)  "Trunc 08",
       TRUNC(127.623, -1) "Trunc 09",
       TRUNC(127.623, -2) "Trunc 10"
FROM DUAL;

-- Customizing Output with SIGN
SELECT SIGN(-10)  "Sign 01",
       SIGN(0)    "Sign 02",
       SIGN(10)   "Sign 03",
       SIGN(NULL) "Sign 04"
FROM DUAL;

-- Customizing Output with INITCAP
SELECT INITCAP('hello world') "Initcap 01",
       INITCAP('HELLO WORLD') "Initcap 02",
       INITCAP('Hello World') "Initcap 03"
FROM DUAL;

-- Customizing Output with LOWER
SELECT LOWER('HELLO WORLD') "Lower 01",
       LOWER('Hello World') "Lower 02",
       LOWER('hello world') "Lower 03"
FROM DUAL;

-- Customizing Output with UPPER
SELECT UPPER('hello world') "Upper 01",
       UPPER('Hello World') "Upper 02",
       UPPER('HELLO WORLD') "Upper 03"
FROM DUAL;

-- Customizing Output with LPAD
-- LPAD is used to pad the left side of a string with a specific set of characters
SELECT LPAD('hello', 10, 'x')   "Lpad 01",
       LPAD('hello', 10, 'xy')  "Lpad 02",
       LPAD('hello', 10, 'xyz') "Lpad 03",
       LPAD('hello', 10, '_')   "Lpad 04"
FROM DUAL;

-- Customizing Output with RPAD
-- RPAD is used to pad the right side of a string with a specific set of characters
SELECT RPAD('hello', 10, 'x')   "Rpad 01",
       RPAD('hello', 10, 'xy')  "Rpad 02",
       RPAD('hello', 10, 'xyz') "Rpad 03",
       RPAD('hello', 10, '_')   "Rpad 04"
FROM DUAL;

-- Customizing Output with LTRIM
-- LTRIM is used to remove all leading characters from a string
SELECT LTRIM('hello', 'h') "Ltrim 01",
       LTRIM('hello', 'e') "Ltrim 02",
       LTRIM('hello', 'l') "Ltrim 03",
       LTRIM('hello', 'o') "Ltrim 04",
       LTRIM('  hello   ') "Ltrim 05"
FROM DUAL;

-- Customizing Output with RTRIM
-- RTRIM is used to remove all trailing characters from a string
SELECT RTRIM('hello', 'h') "Rtrim 01",
       RTRIM('hello', 'e') "Rtrim 02",
       RTRIM('hello', 'l') "Rtrim 03",
       RTRIM('hello', 'o') "Rtrim 04",
       RTRIM('  hello   ') "Rtrim 05"
FROM DUAL;

-- Customizing Output with TRIM
-- TRIM is used to remove all leading and trailing characters from a string
SELECT TRIM('hello', 'h') "Trim 01",
       TRIM('hello', 'e') "Trim 02",
       TRIM('hello', 'l') "Trim 03",
       TRIM('hello', 'o') "Trim 04",
       TRIM('  hello   ') "Trim 05"
FROM DUAL;

-- Customizing Output with REPLACE
-- REPLACE is used to replace all occurrences of a substring within a string
SELECT REPLACE('hello world', 'world', 'universe') "Replace 01",
       REPLACE('hello world', 'o', 'x')            "Replace 02",
       REPLACE('hello world', 'l', 'x')            "Replace 03",
       REPLACE('hello world', 'l', 'xx')           "Replace 04"
FROM DUAL;

-- Customizing Output with TRANSLATE
-- TRANSLATE is used to replace all occurrences of a set of characters within a string
SELECT TRANSLATE('hello world', 'h', 'x')  "Translate 01",
       TRANSLATE('hello world', 'o', 'x')  "Translate 02",
       TRANSLATE('hello world', 'l', 'x')  "Translate 03",
       TRANSLATE('hello world', 'l', 'xx') "Translate 04"
FROM DUAL;

-- Customizing Output with SUBSTR
-- SUBSTR is used to extract a substring from a string
SELECT SUBSTR('hello world', 1, 5)  "Substr 01",
       SUBSTR('hello world', 7, 5)  "Substr 02",
       SUBSTR('hello world', 1, 10) "Substr 03",
       SUBSTR('hello world', 7)     "Substr 04"
FROM DUAL;

-- Customizing Output with INSTR
-- INSTR is used to find the position of a substring within a string
SELECT INSTR('hello world', 'h')       "Instr 01",
       INSTR('hello world', 'o')       "Instr 02",
       INSTR('hello world', 'l')       "Instr 03",
       INSTR('hello world', 'o', 6)    "Instr 04", -- Start from the 6th character
       INSTR('hello world', 'o', 3, 2) "Instr 05"  -- Start from the 3th character and find the second occurrence
FROM DUAL;

-- Customizing Output with LENGTH
-- LENGTH is used to find the length of a string
SELECT LENGTH('hello world') "Length 01",
       LENGTH('hello')       "Length 02",
       LENGTH('world')       "Length 03"
FROM DUAL;

-- Customizing Output with ASCII
-- ASCII is used to find the ASCII value of a character
SELECT ASCII('A') "Ascii 01",
       ASCII('a') "Ascii 02",
       ASCII('B') "Ascii 03",
       ASCII('b') "Ascii 04"
FROM DUAL;

-- Customizing Output with CONCAT
-- CONCAT is used to concatenate two strings
SELECT CONCAT('hello', ' world')          "Concat 01",
       CONCAT('hello', ' ', 'world')      "Concat 02",
       CONCAT('hello', ' ', 'world', '!') "Concat 03"
FROM DUAL;

SELECT 'hello' || ' world'              "Concat 04",
       'hello' || ' ' || 'world'        "Concat 05",
       'hello' || ' ' || 'world' || '!' "Concat 06"
FROM DUAL;

-- Customizing Output with NVL
-- NVL is used to replace NULL values with a specific value
SELECT NVL(NULL, 'hello')    "Nvl 01",
       NVL('world', 'hello') "Nvl 02"
FROM DUAL;

-- Customizing Output with COALESCE
-- COALESCE is used to replace NULL values with the first non-NULL value
SELECT COALESCE(NULL, 'hello', 'world') "Coalesce 01",
       COALESCE(NULL, NULL, 'hello')    "Coalesce 02",
       COALESCE(NULL, NULL, NULL)       "Coalesce 03"
FROM DUAL;

-- Customizing Output with NULLIF
-- NULLIF is used to return NULL if two values are equal
SELECT NULLIF('hello', 'hello') "Nullif 01",
       NULLIF('hello', 'world') "Nullif 02"
FROM DUAL;



-- Customizing Output with SYSDATE, CURRENT_DATE, CURRENT_TIMESTAMP, SYSTIMESTAMP, LOCALTIMESTAMP,
-- SYSDATE is used to get the current date and time in the SYSTEM timezone
-- CURRENT_DATE is used to get the current date in the ORACLE LOCAL timezone
-- CURRENT_TIMESTAMP is used to get the current date and time in the ORACLE LOCAL timezone
-- SYSTIMESTAMP is used to get the current date and time in the SYSTEM timezone
-- LOCALTIMESTAMP is used to get the current date and time in the ORACLE LOCAL timezone
SELECT DBTIMEZONE        "Oracle Timezone",
       SYSDATE           "Sysdate",           -- LOCAL TIMEZONE
       CURRENT_DATE      "Current_Date",      --ORACLE SGBD LOCAL TIMEZONE
       CURRENT_TIMESTAMP "Current_Timestamp", -- ORACLE SGBD LOCAL TIMEZONE
       SYSTIMESTAMP      "Systimestamp",      --  SYSTEM TIMEZONE
       LOCALTIMESTAMP    "Localtimestamp"     -- ORACLE SGBD LOCAL TIMEZONE
FROM DUAL;

-- Customizing Output with ADD_MONTHS
-- ADD_MONTHS is used to add a number of months to a date
SELECT ADD_MONTHS(SYSDATE, 1) "Add_months 01",
       ADD_MONTHS(SYSDATE, 2) "Add_months 02",
       ADD_MONTHS(SYSDATE, 3) "Add_months 03"
FROM DUAL;

-- Customizing Output with MONTHS_BETWEEN
-- MONTHS_BETWEEN is used to find the number of months between two dates
SELECT MONTHS_BETWEEN(SYSDATE, SYSDATE)                "Months_between 01",
       MONTHS_BETWEEN(SYSDATE, ADD_MONTHS(SYSDATE, 1)) "Months_between 02",
       MONTHS_BETWEEN(SYSDATE, ADD_MONTHS(SYSDATE, 2)) "Months_between 03"
FROM DUAL;

-- Customizing Output with NEXT_DAY
-- NEXT_DAY is used to find the next day of the week after a date
SELECT NEXT_DAY(SYSDATE, 'MONDAY')    "Next_day 01",
       NEXT_DAY(SYSDATE, 'TUESDAY')   "Next_day 02",
       NEXT_DAY(SYSDATE, 'WEDNESDAY') "Next_day 03"
FROM DUAL;

-- Customizing Output with LAST_DAY
-- LAST_DAY is used to find the last day of the month for a date
SELECT LAST_DAY(SYSDATE)                "Last_day 01",
       LAST_DAY(ADD_MONTHS(SYSDATE, 1)) "Last_day 02",
       LAST_DAY(ADD_MONTHS(SYSDATE, 2)) "Last_day 03"
FROM DUAL;

-- Convert a string to a date
SELECT TO_DATE('2021-01-01', 'YYYY-MM-DD')                     "To_date 01",
       TO_DATE('2021-01-01 12:34:56', 'YYYY-MM-DD HH24:MI:SS') "To_date 02"
FROM DUAL;

-- Convert a date to a string
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD')            "To_char 01",
       TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') "To_char 02",
       TO_CHAR(SYSDATE, 'YYYY-MM-DD HH12:MI:SS') "To_char 03"
FROM DUAL;

-- Convert a number to a string
SELECT TO_CHAR(12345)               "To_char 04",
       TO_CHAR(12345, '99999')      "To_char 05",
       TO_CHAR(12345, '99999.99')   "To_char 06",
       TO_CHAR(12345, '99999.999')  "To_char 07",
       TO_CHAR(12345, '99999.9999') "To_char 08"
FROM DUAL;

-- Convert a string to a number
SELECT TO_NUMBER('12345')      "To_number 01",
       TO_NUMBER('12345.67')   "To_number 02",
       TO_NUMBER('12345.678')  "To_number 03",
       TO_NUMBER('12345.6789') "To_number 04"
FROM DUAL;

-- Adding to date
SELECT SYSDATE,
       SYSDATE + 1                "1 day",     -- 1 day
       SYSDATE + 7                "7 days",    -- 7 days
       SYSDATE + 7 / 24           "7 hours",   -- 7 hours
       SYSDATE + 7 / 24 / 60      "7 minutes", -- 7 minutes
       SYSDATE + 7 / 24 / 60 / 60 "7 seconds"  -- 7 seconds
FROM DUAL;

-- Trunc date
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS')                "Original",
       TO_CHAR(TRUNC(SYSDATE, 'YYYY'), 'YYYY-MM-DD HH24:MI:SS') "Trunc Year",
       TO_CHAR(TRUNC(SYSDATE, 'MM'), 'YYYY-MM-DD HH24:MI:SS')   "Trunc Month",
       TO_CHAR(TRUNC(SYSDATE), 'YYYY-MM-DD HH24:MI:SS')         "Trunc Day",
       TO_CHAR(TRUNC(SYSDATE, 'HH'), 'YYYY-MM-DD HH24:MI:SS')   "Trunc Hour",
       TO_CHAR(TRUNC(SYSDATE, 'MI'), 'YYYY-MM-DD HH24:MI:SS')   "Trunc Minute"
FROM DUAL;

-- Create the sales table
CREATE TABLE sales
(
    sale_id    NUMBER PRIMARY KEY,
    product_id NUMBER,
    sale_date  DATE,
    amount     NUMBER
);

-- Insert sample data into the sales table
INSERT INTO sales (sale_id, product_id, sale_date, amount)
VALUES (1, 101, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 100);
INSERT INTO sales (sale_id, product_id, sale_date, amount)
VALUES (2, 102, TO_DATE('2023-01-02', 'YYYY-MM-DD'), 150);
INSERT INTO sales (sale_id, product_id, sale_date, amount)
VALUES (3, 101, TO_DATE('2023-01-03', 'YYYY-MM-DD'), 200);
INSERT INTO sales (sale_id, product_id, sale_date, amount)
VALUES (4, 103, TO_DATE('2023-01-04', 'YYYY-MM-DD'), 250);
INSERT INTO sales (sale_id, product_id, sale_date, amount)
VALUES (5, 102, TO_DATE('2023-01-05', 'YYYY-MM-DD'), 300);
INSERT INTO sales (sale_id, product_id, sale_date, amount)
VALUES (6, 101, TO_DATE('2023-01-06', 'YYYY-MM-DD'), 350);
INSERT INTO sales (sale_id, product_id, sale_date, amount)
VALUES (7, 103, TO_DATE('2023-01-07', 'YYYY-MM-DD'), 400);
INSERT INTO sales (sale_id, product_id, sale_date, amount)
VALUES (8, 102, TO_DATE('2023-01-08', 'YYYY-MM-DD'), 450);
INSERT INTO sales (sale_id, product_id, sale_date, amount)
VALUES (9, 101, TO_DATE('2023-01-09', 'YYYY-MM-DD'), 500);
INSERT INTO sales (sale_id, product_id, sale_date, amount)
VALUES (10, 103, TO_DATE('2023-01-10', 'YYYY-MM-DD'), 550);

-- Analytic functions
-- AVG is used to find the average value of a set of values
SELECT product_id,
       AVG(amount) "Avg"
FROM sales
GROUP BY product_id;

-- AVG with partition
SELECT product_id,
       sale_date,
       amount,
       AVG(amount) OVER (PARTITION BY product_id) "Avg"
FROM sales;

-- AVG with no partition
SELECT product_id,
       sale_date,
       amount,
       AVG(amount) OVER () "Avg"
FROM sales;

DROP TABLE sales;