import pandas as pd

from data_cleaning.dataCleaner import DataCleaner
from data_saving.dataSaver import DataSaver
from database_utils.databseUtils import Database



class Pipeline:

    def __init__(self, raw_data: pd.DataFrame):
        self.raw_data = raw_data
        self.cleaned_data = None


    def clean_data(self):
        cleaner = DataCleaner(raw_dataset=self.raw_data)
        self.cleaned_data = cleaner.run_cleaner_pipeline()


    def save_data(self):
        saver = DataSaver()
        saver.save_clean_data(df=self.cleaned_data, filename="cleaned_market_sales.csv")


    def load_to_db(self):
        db = Database()
        db.run_db()


    


if __name__ == "__main__":
    raw_data = "dataset/raw/market_sales.csv"

    pl = Pipeline(raw_data=raw_data)
    pl.clean_data()
    pl.save_data()
    pl.load_to_db()