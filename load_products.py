import sqlite3
import csv

conn = sqlite3.connect("data/inventory.db")
cur = conn.cursor()

# create the table with the right columns
cur.execute("""
CREATE TABLE IF NOT EXISTS products (
    product_id INTEGER,
    name TEXT,
    category TEXT,
    storage_cost_per_unit REAL
)
""")

# open the CSV and insert each row
with open("data/products.csv", newline="") as f:
    reader = csv.reader(f)
    next(reader)  # skip the header row — we already defined columns above
    for row in reader:
        cur.execute("INSERT INTO products VALUES (?, ?, ?, ?)", row)

conn.commit()
conn.close()
print("products loaded.")
