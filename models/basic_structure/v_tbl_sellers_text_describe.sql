{{ config(materialized='view') }}

SELECT 'tbl_total' as col, COUNT(*) from olist.tbl_olist_sellers union all 
SELECT 'seller_id' as col, COUNT(DISTINCT("seller_id")) FROM olist.tbl_olist_sellers union all 
SELECT 'seller_city' as col, COUNT(DISTINCT("seller_city")) FROM olist.tbl_olist_sellers union all 
SELECT 'seller_state' as col, COUNT(DISTINCT("seller_state")) FROM olist.tbl_olist_sellers 
