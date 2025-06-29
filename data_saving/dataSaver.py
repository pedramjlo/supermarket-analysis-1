import os
import logging
from config import settings


logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s',
)


class DataSaver:
    def save_clean_data(self, df, filename, output_dir="dataset/cleaned_data"):
        # Ensure the directory exists, create if necessary
        os.makedirs(output_dir, exist_ok=True)

        # Ensure filename has the correct extension
        if not filename.endswith('.csv'):
            filename += '.csv'

        file_path = os.path.join(output_dir, filename)

        try:
            # Save DataFrame to CSV
            df.to_csv(file_path, index=False)
            settings.cleaned_dataset_path = file_path  # Update the settings

            logging.info(f"Cleaned data saved to {file_path}, and set the variable in config/settings.py")
        except Exception as e:
            logging.error(f"Failed to save cleaned data: {e}")
        
        return file_path
