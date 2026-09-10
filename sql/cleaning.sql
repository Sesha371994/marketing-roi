-- ============================================================
-- MARKETING CAMPAIGN DATA CLEANING
-- ============================================================

-- 1. VALIDATION
SELECT COUNT(*) AS total_rows FROM raw_campaigns;
SELECT COUNT(*) AS invalid_spend FROM raw_campaigns WHERE spend <= 0 OR spend IS NULL;
SELECT COUNT(*) AS invalid_clicks FROM raw_campaigns WHERE clicks < 0 OR clicks IS NULL;
SELECT COUNT(*) AS missing_conversions FROM raw_campaigns WHERE conversions IS NULL;
SELECT COUNT(*) AS missing_revenue FROM raw_campaigns WHERE revenue IS NULL;
SELECT DISTINCT channel FROM raw_campaigns;

-- 2. CLEAN TABLE
-- Rule: a row needs valid spend AND valid clicks to be usable for
-- ROI/CTR calculations. Missing conversions/revenue default to 0
-- (no conversions recorded != invalid row, just zero performance).
DROP TABLE IF EXISTS clean_campaigns;
CREATE TABLE clean_campaigns AS
SELECT DISTINCT
  campaign_id,
  date_raw,
  CASE
    WHEN LOWER(TRIM(channel)) = 'facebook ads' THEN 'Facebook Ads'
    WHEN LOWER(TRIM(channel)) = 'google ads' THEN 'Google Ads'
    WHEN LOWER(TRIM(channel)) = 'instagram' THEN 'Instagram'
    WHEN LOWER(TRIM(channel)) = 'email' THEN 'Email'
    WHEN LOWER(TRIM(channel)) = 'linkedin ads' THEN 'LinkedIn Ads'
    ELSE TRIM(channel)
  END AS channel,
  campaign_name,
  spend,
  COALESCE(impressions, 0) AS impressions,
  clicks,
  COALESCE(conversions, 0) AS conversions,
  COALESCE(revenue, 0) AS revenue
FROM (
  SELECT campaign_id, date AS date_raw, channel, campaign_name,
         spend, impressions, clicks, conversions, revenue
  FROM raw_campaigns
)
WHERE spend > 0
  AND clicks >= 0
  AND clicks IS NOT NULL;

-- 3. Post-clean validation
SELECT COUNT(*) AS clean_row_count FROM clean_campaigns;
SELECT DISTINCT channel FROM clean_campaigns;
