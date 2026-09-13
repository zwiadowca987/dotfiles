import sqlite3

with sqlite3.connect('database.db') as conn:
    cur = conn.cursor()

    conn.close()
