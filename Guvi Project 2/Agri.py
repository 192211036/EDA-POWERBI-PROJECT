import pandas as pd
from sqlalchemy import create_engine
#file path
file_path=r"ICRISAT-District Level Data - ICRISAT-District Level Data.csv"
df=pd.read_csv(r"ICRISAT-District Level Data - ICRISAT-District Level Data.csv")
#handling all null values in the dataset
df.dropna(axis=1,how="all",inplace=True)
df.fillna("Nil",inplace=True)
#database connectivity
user="postgres"
host="localhost"
port=5432
database="Agri_db"
password="MSD77777"
#connection string (url for connecting to postgres account)
conn_str=f"postgresql+psycopg2://{user}:{password}@{host}:{port}/{database}"
#creating engine interface
engine=create_engine(conn_str)
table_name="agri_data"
df.to_sql(table_name,engine,if_exists="replace",index=False)

#confirmation
print("The data has been pushed to sql successfully")

