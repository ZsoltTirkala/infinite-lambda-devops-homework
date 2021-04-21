import boto3
import psycopg2


session = boto3.Session(region_name='eu-west-2')
ssm = session.client('ssm')
ENDPOINT = ssm.get_parameter(Name='rds_endpoint', WithDecryption=True)[
    'Parameter']['Value']
PORT = ssm.get_parameter(Name='rds_port', WithDecryption=True)[
    'Parameter']['Value']
USER = ssm.get_parameter(Name='rds_username', WithDecryption=True)[
    'Parameter']['Value']
PASSWORD = ssm.get_parameter(Name='rds_password', WithDecryption=True)[
    'Parameter']['Value']
DBNAME = ssm.get_parameter(Name='rds_db_name', WithDecryption=True)[
    'Parameter']['Value']

try:
    conn = psycopg2.connect(host=ENDPOINT, port=PORT, database=DBNAME, user=USER, password=PASSWORD)
    cur = conn.cursor()
    cur.execute("""SELECT current_database(), current_user, version()""")
    query_results = cur.fetchall()
    print(f"DB name: {query_results[0][0]}")
    print(f"Username: {query_results[0][1]}")
    print(f"Version: {query_results[0][2]}")
except Exception as e:
    print("Database connection failed due to {}".format(e))