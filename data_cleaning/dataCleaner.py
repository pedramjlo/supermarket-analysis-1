import pandas as pd
import logging
import os




logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
)




class DataCleaner:
    def __init__(self, raw_dataset):
        self.raw_dataset = raw_dataset
        self.df = None


    """
    reading and encoding the csv file and converting to a Pandas dataframe
    """
    def read_raw_data(self):
        try:
            self.df = pd.read_csv(self.raw_dataset, encoding="ISO-8859-1", engine='python')
            logging.info("Read the dataset successfully.")
        except FileNotFoundError:
            logging.error("Error: The file was not found.")
        except pd.errors.EmptyDataError:
            logging.error("Error: The file is empty.")
        except pd.errors.ParserError:
            logging.error("Error: The file could not be parsed.")


    
    """
    converting column headers to lower cases due to the naming convention of a lot of databases (namely PostgreSQL which we'll be using
    in this project) and SQL prior to replacing the blank space inbetween with underscores
    """
    def convert_columns_to_lowercase(self):
        try:
            self.df.columns = self.df.columns.str.lower()
            logging.info("Columns names converted to lowercase")
        except Exception as e:
            logging.error(f"Failed to convert columns to lowercase, {e}")



    """
    some column headers contain blank space like <invoice id>
    - adding undercore to standardise the namings
    """
    def add_underline_to_columns(self):
        try:
            self.df.columns = self.df.columns.str.replace(" " , "_")
            logging.info("Added underscore to columns")
        except Exception as e:
            logging.error(f"Failed to add underscore to columns, {e}")





    """
    checking if the tax 5% column in the raw dataset conatins the correct values
    """

    def verify_tax_on_price(self):
        try:
            self.df["calculated_tax"] = (self.df['unit_price'] * self.df['quantity']) * 0.05
            logging.info(f"Calculated the %5 on total sum of rows")
        except Exception as e:
            logging.error(f"Failed to calculate the 5% tax, {e}")




    """
    USING IQR METHOD TO DETECT OUTLIERS IN COLUMNS
    """
    def outlier_detection(self, column):
        if not pd.api.types.is_numeric_dtype(self.df[column]):
            logging.warning(f"Column '{column}' is not numeric. Skipping outlier detection.")
            return pd.DataFrame()

        Q1 = self.df[column].quantile(0.25)
        Q3 = self.df[column].quantile(0.75)
        IQR = Q3 - Q1

        outliers = self.df[
            (self.df[column] < Q1 - 1.5 * IQR) |
            (self.df[column] > Q3 + 1.5 * IQR)
        ]
        percentage = (len(outliers) / len(self.df)) * 100
        logging.info(f"{percentage:.2f}% of the values in column '{column}' are outliers.")
        
        return outliers



    """
    dropping duplicate rows
    """
    def drop_duplicate_rows(self):
        total_rows = self.df.shape[0]
        duplicate_rows = self.df.duplicated().sum()
        
        try:
            if duplicate_rows == 0:
                logging.info("No duplicate rows were found")
            else:
                self.df = self.df.drop_duplicates()
                removed_rows = total_rows - self.df.shape[0]
                logging.info(f"{removed_rows} rows were removed")
        except Exception as e:
            logging.error(f"Failed to drop duplicate rows, {e}")


    """
    def save_cleaned_data(self, df, filename, output_dir="dataset/cleaned_data"):
        # Use current working directory if __file__ is unavailable
        script_dir = os.getcwd()
        full_output_dir = os.path.join(script_dir, output_dir)
    
        try:
            os.makedirs(full_output_dir, exist_ok=True)
            file_path = os.path.join(full_output_dir, filename)
            df.to_csv(file_path, index=False)
            logging.info(f"✅ Cleaned data saved to: {file_path}")
        except Exception as e:
            logging.error(f"❌ Failed to save cleaned data: {e}")
            raise e
    
        return file_path
    """



    def run_cleaner_pipeline(self):
        self.read_raw_data()
        self.convert_columns_to_lowercase()
        self.add_underline_to_columns()
        self.verify_tax_on_price()
        self.drop_duplicate_rows()
        #self.save_cleaned_data(df=self.df, filename="cleaned_market_sales.csv")
        
        return self.df
            
            




raw_dataset = "../dataset/raw/market_sales.csv"
data = pd.read_csv(raw_dataset)




cleaner = DataCleaning(raw_dataset=raw_dataset)


cleaner.drop_duplicate_rows()




data["Product line"].unique()


# # MISSING VALUES
# the dataset does not contain any missing or NaN values



data.isna().sum()


cleaner.run_cleaner_pipeline()

