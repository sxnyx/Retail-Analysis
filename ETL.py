import pandas as pd

# Step 1: Extract Data
customers_df = pd.read_csv('Input Tables\customers.csv')
inventory_df = pd.read_csv('Input Tables\inventory_levels.csv')
products_df = pd.read_csv('Input Tables\products.csv')
promotions_df = pd.read_csv('Input Tables\promotions.csv')
sales_df = pd.read_csv('Input Tables/sales_transactions.csv')

# Function to transform date columns
def transform_dates(df):
    # Identify columns with dates (assuming they contain 'date' or 'Date' in their names)
    date_columns = [col for col in df.columns if 'date' in col.lower() or 'Date' in col]
    
    for col in date_columns:
        # Convert the column to datetime format
        df[col] = pd.to_datetime(df[col])
        
        # Create new columns for day, month, and year
        df[f'{col}_Day'] = df[col].dt.day
        df[f'{col}_Month'] = df[col].dt.month
        df[f'{col}_Year'] = df[col].dt.year
        
        # Create a new column for the formatted date (e.g., "01 January 2025")
        df[f'{col}_Formatted'] = df[col].dt.strftime('%d %B %Y')
    
    return df

# Step 2: Transform Data
# Apply the transformation to all tables
customers_df = transform_dates(customers_df)
inventory_df = transform_dates(inventory_df)
products_df = transform_dates(products_df)
promotions_df = transform_dates(promotions_df)
sales_df = transform_dates(sales_df)

# Step 3: Load Data
# Save the transformed data to an Excel sheet
with pd.ExcelWriter('Transformed_Data.xlsx') as writer:
    customers_df.to_excel(writer, sheet_name='Customers', index=False)
    inventory_df.to_excel(writer, sheet_name='Inventory', index=False)
    products_df.to_excel(writer, sheet_name='Products', index=False)
    promotions_df.to_excel(writer, sheet_name='Promotions', index=False)
    sales_df.to_excel(writer, sheet_name='Sales', index=False)

print("ETL process completed and data saved to 'transformed_Data.xlsx'")
