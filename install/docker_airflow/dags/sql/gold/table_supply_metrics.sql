INSERT INTO business.supply_metrics
SELECT
  symbol,
  circulating_supply,
  total_supply,
  max_supply,
  CASE
    WHEN max_supply = 0 THEN NULL
    ELSE (circulating_supply / max_supply) * 100
  END AS supply_utilization_pct
FROM refined.coingecko_flat;
