import sqlite3
import csv

conn = sqlite3.connect("data/inventory.db")
cursor = conn.cursor()

cursor.execute("""
CREATE TABLE IF NOT EXISTS suppliers (
    product_id INTEGER,
    supplier_id INTEGER,
    lead_time_days INTEGER
)
""")

with open("data/suppliers.csv") as f:
    reader = csv.reader(f)
    next(reader)
    for row in reader:
        cursor.execute("INSERT INTO suppliers VALUES (?, ?, ?)", row)

conn.commit()
conn.close()

print("suppliers loaded")
