# Configuration for Database (Sequel)
# Use Heroku's environment variable or a postgres local database
DB = Sequel.connect(ENV['DATABASE_URL'] || 'postgres://postgres:root@localhost:5432/legux')

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