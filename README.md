# Marketing Campaign ROI Dashboard

End-to-end pipeline: messy multi-channel ad spend data -> SQL cleaning -> Python transform -> Excel dashboard.

## What it does
- Cleans 335 campaign rows across Facebook/Google/Instagram/Email/LinkedIn (fixes channel name casing, invalid spend/clicks, duplicates)
- Calculates: CTR, Conversion Rate, CAC, ROAS (overall + by channel), monthly spend vs revenue trend
- Excel dashboard with live formulas (SUMIF/AVERAGE) + bar chart + line chart

## Run it
```bash
pip install pandas openpyxl numpy
python python/01_generate_data.py
python python/02_pipeline_and_dashboard.py
```
Output: `exports/Marketing_ROI_Dashboard.xlsx`

## Tech stack
SQL (SQLite) for cleaning · Python (Pandas) for transformation · Excel (openpyxl) for reporting

## Use YOUR real data
Replace `raw_data/campaign_data.csv` with your actual ad platform
export (same column structure) and re-run.
