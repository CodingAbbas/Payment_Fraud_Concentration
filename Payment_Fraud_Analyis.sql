SELECT
    
    CASE
        WHEN amount < 100 THEN 'Under £100'
        WHEN amount < 1000 THEN '£100 to £1,000'
        WHEN amount < 10000 THEN '£1,000 to £10,000'
        WHEN amount < 100000 THEN '£10,000 to £100,000'
        WHEN amount < 1000000 THEN '£100,000 to £1,000,000'
        ELSE '£1,000,000 and above'
    END AS payment_band,
    
    COUNT(*) AS transaction_count,
    CONCAT(ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 2), '%') AS percent_of_total,
    SUM(isfraud) AS fraud_count,
    CONCAT(ROUND(100.0 * SUM(isfraud) / SUM(SUM(isfraud)) OVER (), 2), '%') AS percent_of_all_fraud

FROM transactions
GROUP BY payment_band
ORDER BY payment_band;
