BASE_PATH="/opt/airflow/data/files"

##Table_identification
curl --location-trusted \
  -u root:"" \
  -H "Expect:100-continue" \
  -H "format: json" \
  -H "strip_outer_array: true" \
  -H "read_json_by_line: false" \
  -H "columns: id, symbol, name" \
  -H "max_filter_ratio: 0.1" \
  -T "$BASE_PATH/identification.json" \
  -XPUT http://host.docker.internal:8040/api/raw/identification/_stream_load

#market_data_table
curl --location-trusted \
  -u root:"" \
  -H "Expect:100-continue" \
  -H "format: json" \
  -H "strip_outer_array: true" \
  -H "read_json_by_line: false" \
  -H "columns: id, current_price, market_cap, market_cap_rank, total_volume, high_24h, low_24h" \
  -H "max_filter_ratio: 0.1" \
  -T "$BASE_PATH/market_data.json" \
  -XPUT http://host.docker.internal:8040/api/raw/market_data/_stream_load

##metadata_table
curl --location-trusted \
  -u root:"" \
  -H "Expect:100-continue" \
  -H "format: json" \
  -H "strip_outer_array: true" \
  -H "read_json_by_line: false" \
  -H "columns: id, last_updated, image" \
  -H "max_filter_ratio: 0.1" \
  -T "$BASE_PATH/metadata.json" \
  -XPUT http://host.docker.internal:8040/api/raw/metadata/_stream_load

##price_change_table
curl --location-trusted \
  -u root:"" \
  -H "Expect:100-continue" \
  -H "format: json" \
  -H "strip_outer_array: true" \
  -H "read_json_by_line: false" \
  -H "columns: id, price_change_24h, price_change_percentage_24h, ath, atl" \
  -H "max_filter_ratio: 0.1" \
  -T "$BASE_PATH/price_change.json" \
  -XPUT http://host.docker.internal:8040/api/raw/price_change/_stream_load

##suply_data_table
curl --location-trusted \
  -u root:"" \
  -H "Expect:100-continue" \
  -H "format: json" \
  -H "strip_outer_array: true" \
  -H "read_json_by_line: false" \
  -H "columns: id, circulating_supply, total_supply, max_supply " \
  -H "max_filter_ratio: 0.1" \
  -T "$BASE_PATH/supply_data.json" \
  -XPUT http://host.docker.internal:8040/api/raw/supply_data/_stream_load