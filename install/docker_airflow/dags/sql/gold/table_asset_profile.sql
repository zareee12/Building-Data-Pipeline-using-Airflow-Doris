INSERT INTO business.asset_profile
SELECT 
    symbol, 
    name, 
    image_url, 
    last_updated
FROM refined.coingecko_flat;