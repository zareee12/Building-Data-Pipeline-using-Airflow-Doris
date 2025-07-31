import json
import os

input_file = 'coingecko_grouped_top_1000_tokens.json'

# Pastikan file input ada
if not os.path.isfile(input_file):
    raise FileNotFoundError(f"File not found: {input_file}")

# Load isi JSON utama
with open(input_file, 'r', encoding='utf-8') as f:
    data = json.load(f)

# Simpan setiap tabel sebagai file JSON array
for table_name, records in data.items():
    output_file = f'{table_name}.json'
    with open(output_file, 'w', encoding='utf-8') as out:
        json.dump(records, out, ensure_ascii=False, indent=2)

    print(f'Saved: {output_file} ({len(records)} records)')
