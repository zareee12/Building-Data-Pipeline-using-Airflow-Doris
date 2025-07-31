INSERT INTO business.asset_summary
SELECT
  symbol,
  name,
  current_price,
  market_cap,
  market_cap_rank,
  total_volume,
  last_updated
FROM refined.coingecko_flat;