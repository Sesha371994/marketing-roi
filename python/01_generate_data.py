"""
Generate messy marketing campaign performance data across channels.
"""
import csv
import random
from datetime import datetime, timedelta

random.seed(21)

channels = ["Facebook Ads", "facebook ads", "Google Ads", "google ads",
            "Instagram", "instagram", "Email", "email", "LinkedIn Ads"]
channel_clean = ["Facebook Ads", "Google Ads", "Instagram", "Email", "LinkedIn Ads"]

campaigns = ["Summer Sale", "New Launch", "Diwali Offer", "Retargeting",
             "Brand Awareness", "Flash Sale"]

rows = []
row_id = 1
start = datetime(2024, 1, 1)

for _ in range(320):
    date = start + timedelta(days=random.randint(0, 250))
    date_fmt = random.choice(["%Y-%m-%d", "%d/%m/%Y", "%m/%d/%Y"])
    channel = random.choice(channels)
    campaign = random.choice(campaigns)

    spend = random.choices(
        [round(random.uniform(500, 15000), 2), None, -200],
        weights=[80, 12, 8], k=1
    )[0]
    clicks = random.choices(
        [random.randint(10, 3000), None, -5],
        weights=[82, 10, 8], k=1
    )[0]
    impressions = random.choices(
        [random.randint(1000, 200000), None],
        weights=[90, 10], k=1
    )[0]
    conversions = random.choices(
        [random.randint(0, 150), None],
        weights=[88, 12], k=1
    )[0]
    revenue = random.choices(
        [round(random.uniform(0, 40000), 2), None],
        weights=[90, 10], k=1
    )[0]

    rows.append({
        "campaign_id": f"CMP{row_id:04d}",
        "date": date.strftime(date_fmt),
        "channel": channel,
        "campaign_name": campaign,
        "spend": spend,
        "impressions": impressions,
        "clicks": clicks,
        "conversions": conversions,
        "revenue": revenue,
    })
    row_id += 1

# inject dupes
for _ in range(15):
    rows.append(random.choice(rows).copy())

with open("raw_data/campaign_data.csv", "w", newline="") as f:
    writer = csv.DictWriter(f, fieldnames=rows[0].keys())
    writer.writeheader()
    writer.writerows(rows)

print(f"Generated {len(rows)} campaign rows -> raw_data/campaign_data.csv")
