class Order < Sequel::Model
  plugin :validation_helpers
  plugin :json_serializer

  many_to_one :employee

end