import os
import logging
import pandas as pd

from sqlalchemy import create_engine
from dotenv import load_dotenv

# Dynamically get the root directory of the project
PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

env_path = os.path.join(PROJECT_ROOT, '.env')
load_dotenv(dotenv_path=env_path)

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)


class Database:
    def __init__(self, 
                 file_path=os.path.join(PROJECT_ROOT, "dataset", "cleaned_data", "cleaned_market_sales.csv"),
                 sqlite_db_path=os.path.join(PROJECT_ROOT, "sqlite_db", "market_sales.db")):
        self.sqlite_db_path = sqlite_db_path
        self.connection_url = f"sqlite:///{self.sqlite_db_path}"
        self.target_dataset = pd.read_csv(file_path)

    def create_engine(self):
        try:
            os.makedirs(os.path.dirname(self.sqlite_db_path), exist_ok=True)
            engine = create_engine(self.connection_url)
            logging.info("SQLite engine created.")
            return engine
        except Exception as e:
            logging.error("Failed to create SQLite engine", exc_info=True)
            raise

    def load_to_db(self, table_name="market_sales", if_exists='replace'):
        engine = self.create_engine()
        try:
            self.target_dataset.to_sql(table_name, engine, index=False, if_exists=if_exists)
            logging.info(f"Data loaded to the table '{table_name}' successfully.")
        except Exception as e:
            logging.error(f"Failed to load the data to SQLite: {e}")

    def run_db(self):
        self.load_to_db()
