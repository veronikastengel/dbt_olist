{{ config(materialized='view') }}

WITH basestats AS (

    SELECT 'seller_zip_code_prefix' as col, COUNT(*)-COUNT(NULLIF("seller_zip_code_prefix",NULL)) as nullcount, 
    MIN("seller_zip_code_prefix"), MAX("seller_zip_code_prefix"), ROUND(AVG("seller_zip_code_prefix"),2) mean, 
    ROUND(STDDEV("seller_zip_code_prefix"),2) std, percentile_disc(0.25) WITHIN GROUP (ORDER BY "seller_zip_code_prefix") quantile25, 
    percentile_disc(0.5) WITHIN GROUP (ORDER BY "seller_zip_code_prefix") quantile50, 
    percentile_disc(0.75) WITHIN GROUP (ORDER BY "seller_zip_code_prefix") quantile75 FROM olist.tbl_olist_sellers 	

)
SELECT *,
    CASE WHEN quantile25-1.5*(quantile75-quantile25) > min THEN TRUE ELSE FALSE END low_outliers,
    CASE WHEN quantile75+1.5*(quantile75-quantile25) < max THEN TRUE ELSE FALSE END high_outliers, 
    CASE WHEN quantile25-1.5*(quantile75-quantile25) > min THEN quantile25-1.5*(quantile75-quantile25) ELSE NULL END low_outl_thrshld,
    CASE WHEN quantile75+1.5*(quantile75-quantile25) < max THEN quantile75+1.5*(quantile75-quantile25) ELSE NULL END high_outl_thrshld
    FROM basestats