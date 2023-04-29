{{ config(materialized='view') }}

SELECT 'tbl_total' as col, NULL as nullcount, COUNT(*) from olist.tbl_olist_order_items union all 
SELECT 'order_id' as col, COUNT(*)-COUNT(NULLIF("order_id",NULL)) as nullcount, 
COUNT(DISTINCT("order_id")) dist_cnt FROM olist.tbl_olist_order_items union all 
SELECT 'product_id' as col, COUNT(*)-COUNT(NULLIF("product_id",NULL)) as nullcount, 
COUNT(DISTINCT("product_id")) dist_cnt FROM olist.tbl_olist_order_items union all 
SELECT 'seller_id' as col, COUNT(*)-COUNT(NULLIF("seller_id",NULL)) as nullcount, 
COUNT(DISTINCT("seller_id")) dist_cnt FROM olist.tbl_olist_order_items union all 
SELECT 'shipping_limit_date' as col, COUNT(*)-COUNT(NULLIF("shipping_limit_date",NULL)) as nullcount, 
COUNT(DISTINCT("shipping_limit_date")) dist_cnt FROM olist.tbl_olist_order_items 

