class Employee < Sequel::Model
  plugin :validation_helpers
  plugin :json_serializer

  def validate
    super
    validates_presence [:firstName, :lastName, :position]
  end
  
end