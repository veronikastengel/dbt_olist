{{ config(materialized='view') }}

WITH basestats AS (

	SELECT 'order_item_id' as col, COUNT(*)-COUNT(NULLIF("order_item_id",NULL)) as nullcount, 
    MIN("order_item_id"), MAX("order_item_id"), ROUND(AVG("order_item_id"),2) mean, ROUND(STDDEV("order_item_id"),2) std, 
    percentile_disc(0.25) WITHIN GROUP (ORDER BY "order_item_id") quantile25, 
    percentile_disc(0.5) WITHIN GROUP (ORDER BY "order_item_id") quantile50, 
    percentile_disc(0.75) WITHIN GROUP (ORDER BY "order_item_id") quantile75 FROM olist.tbl_olist_order_items union all 
    SELECT 'price' as col, COUNT(*)-COUNT(NULLIF("price",NULL)) as nullcount, 
    MIN("price"), MAX("price"), ROUND(CAST(AVG("price") AS NUMERIC),2) mean, ROUND(CAST(STDDEV("price")AS NUMERIC),2) std, 
    percentile_disc(0.25) WITHIN GROUP (ORDER BY "price") quantile25, 
    percentile_disc(0.5) WITHIN GROUP (ORDER BY "price") quantile50, 
    percentile_disc(0.75) WITHIN GROUP (ORDER BY "price") quantile75 FROM olist.tbl_olist_order_items union all 
	SELECT 'freight_value' as col, COUNT(*)-COUNT(NULLIF("freight_value",NULL)) as nullcount, 
    MIN("freight_value"), MAX("freight_value"), ROUND(CAST(AVG("freight_value")AS NUMERIC),2) mean, ROUND(CAST(STDDEV("freight_value") AS NUMERIC),2) std, 
    percentile_disc(0.25) WITHIN GROUP (ORDER BY "freight_value") quantile25, 
    percentile_disc(0.5) WITHIN GROUP (ORDER BY "freight_value") quantile50, 
    percentile_disc(0.75) WITHIN GROUP (ORDER BY "freight_value") quantile75 FROM olist.tbl_olist_order_items
	
)
SELECT *,
    CASE WHEN quantile25-1.5*(quantile75-quantile25) > min THEN TRUE ELSE FALSE END low_outliers,
    CASE WHEN quantile75+1.5*(quantile75-quantile25) < max THEN TRUE ELSE FALSE END high_outliers, 
    CASE WHEN quantile25-1.5*(quantile75-quantile25) > min THEN quantile25-1.5*(quantile75-quantile25) ELSE NULL END low_outl_thrshld,
    CASE WHEN quantile75+1.5*(quantile75-quantile25) < max THEN quantile75+1.5*(quantile75-quantile25) ELSE NULL END high_outl_thrshld
    FROM basestats