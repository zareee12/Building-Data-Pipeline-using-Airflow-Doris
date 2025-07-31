INSERT INTO business.price_performance_summary
SELECT
  symbol,
  price_change_24h,
  price_change_pct_24h,
  ath AS all_time_high,
  atl AS all_time_low
FROM refined.coingecko_flat;