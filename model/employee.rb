class Employee < Sequel::Model
  plugin :validation_helpers
  plugin :json_serializer

  
end