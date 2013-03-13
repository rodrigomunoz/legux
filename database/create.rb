# Configuration for Database (Sequel)
DB = Sequel.connect(
    :adapter => 'mysql2',
    :host => 'localhost',
    :port => 3307,
    :database => 'legux',
    :user => 'root',
    :password=> 'root')

# Create tables for database
# String, Integer, Fixnum, Bignum, Float, Numeric, BigDecimal,
# Date, DateTime, Time, File, TrueClass, FalseClass

# CLIENTS table.
unless DB.table_exists?( :clients )
  DB.create_table :clients  do
    primary_key  :id
    String   :name
    String   :firstLastName
    String   :secondLastName
    Integer  :contactNumber
    Integer  :eventId
    String   :rfc
  end
end

# EMPLOYEES table.
unless DB.table_exists?( :employees )
  DB.create_table :employees  do
    primary_key  :id
    String   :firstName
    String   :lastName
    String   :position
  end
end

# PRODUCTS table.
unless DB.table_exists?( :products )
  DB.create_table :products  do
    primary_key  :id
    String   :description
    Integer  :quantity
    Integer  :price
    String   :packaging
  end
end

# ORDERS table.
unless DB.table_exists?( :orders )
  DB.create_table :orders  do
    primary_key  :id
    Integer  :tableNumber
    Integer  :employee_id
    String   :product
    Integer  :client
  end
end

# USERS table.
## These are the users in our system who can log-in and access
## secured routes
unless DB.table_exists?( :users )
  DB.create_table :users  do
    primary_key :id
    String   :username
    String   :displayName
    String   :password, :null => false
    String   :passwordSalt, :null => false
    String   :email
    Integer  :type
  end
end