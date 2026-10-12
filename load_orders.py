import sqlite3
import csv

conn = sqlite3.connect("data/inventory.db")
cursor = conn.cursor()

cursor.execute("""
CREATE TABLE IF NOT EXISTS orders (
    order_id INTEGER,
    product_id INTEGER,
    quantity_ordered INTEGER,
    order_date TEXT
)
""")

with open("data/orders.csv", newline="") as f:
    reader = csv.reader(f)
    next(reader)
    for row in reader:
        cursor.execute("INSERT INTO orders VALUES (?, ?, ?, ?)", row)

conn.commit()
conn.close()

print("orders loaded.")
