import csv
import random
import os
import sys

NUM_ROWS = 50

COLUMNS = ["price", "nights", "rating", "destination"]

def generate_row():

    return {
        "price": random.randint(300, 2500),
        "nights": random.randint(1, 14),
        "rating": round(random.uniform(3.0, 5.0), 1),
        "destination": random.choice(["Moldova", "Romania", "Italy", "Turkey", "Greece"]),
    }

OUTPUT_DIR = sys.argv[1] if len(sys.argv) > 1 else "/data"
OUTPUT_FILE = os.path.join(OUTPUT_DIR, "data.csv")

os.makedirs(OUTPUT_DIR, exist_ok=True)

rows = [generate_row() for _ in range(NUM_ROWS)]

with open(OUTPUT_FILE, "w", newline="", encoding="utf-8") as f:
    writer = csv.DictWriter(f, fieldnames=COLUMNS)
    writer.writeheader()
    writer.writerows(rows)