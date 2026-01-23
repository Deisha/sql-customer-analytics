-- Drop table if it already exists
DROP TABLE IF EXISTS transactions;

-- Create transactions table
CREATE TABLE transactions (
    transaction_id INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    transaction_date DATE NOT NULL,
    signup_date DATE NOT NULL,
    product_category TEXT NOT NULL,
    order_value REAL NOT NULL
);
