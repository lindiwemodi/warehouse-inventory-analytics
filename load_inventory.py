import sqlite3
import csv

conn = sqlite3.connect("data/inventory.db")
cursor = conn.cursor()

cursor.execute("""
CREATE TABLE IF NOT EXISTS inventory (
    product_id INTEGER,
    quantity_on_hand INTEGER)
""")

with open("data/inventory.csv", newline="") as f:
    reader = csv.reader(f)
    next(reader)
    for row in reader:
        cursor.execute("INSERT INTO inventory VALUES (?, ?)", row)

conn.commit()
conn.close()

print("inventory loaded.")
