import psycopg2

username = "lego_analyst"
password = "postgres"

conn = psycopg2.connect(
    dbname="lego",
    user=username,
    password=password,
    host="localhost",
    port="5432"
)

query = "SELECT * FROM staging.colors;"

cursor = conn.cursor()
cursor.execute(query)
results = cursor.fetchall()
print(results)

cursor.close()