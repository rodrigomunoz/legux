class Product < Sequel::Model
  plugin :validation_helpers
  plugin :json_serializer

  
end