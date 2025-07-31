CREATE DATABASE doris_coingecko;
CREATE DATABASE IF NOT EXISTS raw;
CREATE DATABASE IF NOT EXISTS refined;
CREATE DATABASE IF NOT EXISTS business;

-- ============================================
-- 🥉 BRONZE LAYER (DATABASE: raw)
-- ============================================

--identification table
CREATE TABLE raw.identification (
    id VARCHAR(64),
    symbol VARCHAR(64),
    name VARCHAR(64)
)
DUPLICATE KEY(id)
DISTRIBUTED BY HASH(id) BUCKETS 3
PROPERTIES (
    "replication_allocation" = "tag.location.default: 1"
);

--market_data table
CREATE TABLE raw.market_data (
    id VARCHAR(64),
    current_price DECIMAL(16,2),
    market_cap BIGINT,
    market_cap_rank INT,
    total_volume BIGINT,
    high_24h DECIMAL(16,2),
    low_24h DECIMAL(16,2)
)
DUPLICATE KEY(id)
DISTRIBUTED BY HASH(id) BUCKETS 3
PROPERTIES (
    "replication_allocation" = "tag.location.default: 1"
);


--supply_data table
CREATE TABLE raw.supply_data (
    id VARCHAR(64),
    circulating_supply DECIMAL(20,2),
    total_supply DECIMAL(20,2),
    max_supply DECIMAL(20,2)
)
DUPLICATE KEY(id)
DISTRIBUTED BY HASH(id) BUCKETS 3
PROPERTIES (
    "replication_allocation" = "tag.location.default: 1"
);


--price_change table
CREATE TABLE raw.price_change (
    id VARCHAR(64),
    price_change_24h DECIMAL(16,2),
    price_change_percentage_24h DECIMAL(7,4),
    ath DECIMAL(16,2),
    atl DECIMAL(16,2)
)
DUPLICATE KEY(id)
DISTRIBUTED BY HASH(id) BUCKETS 3
PROPERTIES (
    "replication_allocation" = "tag.location.default: 1"
);


--metadata table
CREATE TABLE raw.metadata (
    id VARCHAR(64),
    last_updated DATETIME,
    image TEXT
)
DUPLICATE KEY(id)
DISTRIBUTED BY HASH(id) BUCKETS 3
PROPERTIES (
    "replication_allocation" = "tag.location.default: 1"
);

-- ============================================
--  SILVER LAYER (DATABASE: refined)
-- ============================================
--coingecko_flat_table
CREATE TABLE refined.coingecko_flat (
    symbol VARCHAR(32),
    date DATE,
    name TEXT,
    current_price DECIMAL(16,2),
    market_cap BIGINT,
    market_cap_rank INT,
    total_volume BIGINT,
    high_24h DECIMAL(16,2),
    low_24h DECIMAL(16,2),
    circulating_supply DECIMAL(20,2),
    total_supply DECIMAL(20,2),
    max_supply DECIMAL(20,2),
    price_change_24h DECIMAL(16,2),
    price_change_pct_24h DECIMAL(7,4),
    ath DECIMAL(16,2),
    atl DECIMAL(16,2),
    image_url TEXT,
    last_updated DATETIME
)
DUPLICATE KEY(symbol, date)
DISTRIBUTED BY HASH(symbol) BUCKETS 3
PROPERTIES (
    "replication_allocation" = "tag.location.default: 1"
);



-- ============================================
--  GOLD LAYER (DATABASE: business)
-- ============================================
--asset_summary_table
CREATE TABLE business.asset_summary (
    symbol VARCHAR(32),
    name TEXT,
    current_price DECIMAL(16,2),
    market_cap BIGINT,
    market_cap_rank INT,
    total_volume BIGINT,
    last_updated DATETIME
)
UNIQUE KEY(symbol)
DISTRIBUTED BY HASH(symbol) BUCKETS 3
PROPERTIES (
    "replication_allocation" = "tag.location.default: 1"
);

--supply_metrics_table
CREATE TABLE business.supply_metrics (
    symbol VARCHAR(32),
    circulating_supply DECIMAL(20,2),
    total_supply DECIMAL(20,2),
    max_supply DECIMAL(20,2),
    supply_utilization_pct DECIMAL(7,4)
)
UNIQUE KEY(symbol)
DISTRIBUTED BY HASH(symbol) BUCKETS 3
PROPERTIES (
    "replication_allocation" = "tag.location.default: 1"
);

--price_performance_summary_table
CREATE TABLE business.price_performance_summary (
    symbol VARCHAR(32),
    price_change_24h DECIMAL(16,2),
    price_change_pct_24h DECIMAL(7,4),
    all_time_high DECIMAL(16,2),
    all_time_low DECIMAL(16,2)
)
UNIQUE KEY(symbol)
DISTRIBUTED BY HASH(symbol) BUCKETS 3
PROPERTIES (
    "replication_allocation" = "tag.location.default: 1"
);

--asset_profile_table
CREATE TABLE business.asset_profile (
    symbol VARCHAR(32),
    name TEXT,
    image_url TEXT,
    last_updated DATETIME
)
UNIQUE KEY(symbol)
DISTRIBUTED BY HASH(symbol) BUCKETS 3
PROPERTIES (
    "replication_allocation" = "tag.location.default: 1"
);