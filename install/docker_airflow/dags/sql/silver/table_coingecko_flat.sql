INSERT INTO refined.coingecko_flat
SELECT
  i.symbol,
  CURRENT_DATE() AS date,
  i.name,
  m.current_price,
  m.market_cap,
  m.market_cap_rank,
  m.total_volume,
  m.high_24h,
  m.low_24h,
  s.circulating_supply,
  s.total_supply,
  s.max_supply,
  p.price_change_24h,
  p.price_change_percentage_24h AS price_change_pct_24h,
  p.ath,
  p.atl,
  md.image AS image_url,
  CAST(md.last_updated AS DATETIME) AS last_updated
FROM raw.identification i
JOIN raw.market_data m ON i.id = m.id
JOIN raw.supply_data s ON i.id = s.id
JOIN raw.price_change p ON i.id = p.id
JOIN raw.metadata md ON i.id = md.id;