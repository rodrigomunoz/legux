module UsersHelper

  def checkPassword(password, passwordConfirm)
    if password != passwordConfirm then
      halt 422, t("users.ERROR_PASSWORD_CONFIRMATION").to_json
    end
  end
  module_function :checkPassword

  def createUser(username, password, passwordConfirm, displayName, email, type = UserType::BASIC_USER)
    checkPassword(password, passwordConfirm)
    password_salt = BCrypt::Engine.generate_salt
    password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    user = User.create(
        :username => username,
        :password => password_hash,
        :passwordSalt => password_salt,
        :displayName => displayName,
        :email => email,
        :type => type
    )
  end
  module_function :createUser

  def createAdministratorUser
    createUser("administrator", "a", "a", "Administrator", "", UserType::ADMINISTRATOR)
  end
  module_function :createAdministratorUser

  def getMyUser
    User.filter(:username => session[:identity]).first
  end
  module_function :getMyUser

  def updateMyProfile(password, passwordConfirm, displayName)
    user = getMyUser
    if !password.nil?
      checkPassword(password, passwordConfirm)
      password_salt = BCrypt::Engine.generate_salt
      password_hash = BCrypt::Engine.hash_secret(password, password_salt)
      user.set(:password => password_hash)
      user.set(:passwordSalt => password_salt)
    else
      user.set(:displayName => displayName)
    end
    begin
      result = user.save
      if result.nil?
        halt 400, t("me.ERROR_UPDATE").to_json
      else
        session[:identityDisplay] = displayName
        halt 200, t("me.SUCCESS_UPDATE").to_json
      end
    rescue Sequel::ValidationFailed => e
      halt 400, e.to_json
    end
  end

end