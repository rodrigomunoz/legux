class User < Sequel::Model
  plugin :validation_helpers

  def validate
    super
    validates_presence [:username, :password, :passwordSalt, :displayName, :type]
    validates_unique [:username]
    validates_min_length 4, :username
    # Test regex: http://rubular.com/
    # TODO: Figure out how to make helpers available inside the Model classes
    # TODO: Test proper validation (jUnits)
    validates_format /^[a-z0-9.]+$/, :username, :message => I18n.t("sequel.ERROR_USERNAME_FORMAT")
    validates_format /(^$|\b[a-z0-9._%-]+@[a-z0-9.-]+\.[a-z]{2,4}\b)/, :email, :message => I18n.t("sequel.ERROR_EMAIL_FORMAT")
  end

  def self.displayable_data
    select(:username, :displayName, :email, :type)
  end

end