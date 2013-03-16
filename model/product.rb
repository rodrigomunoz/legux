class Product < Sequel::Model
  plugin :validation_helpers
  plugin :json_serializer

  def validate
    super
    validates_presence [:description, :quantity, :price, :packaging]
  end
  
end