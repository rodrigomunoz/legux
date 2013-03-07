module UsersHelper

  def checkPassword(password, passwordConfirm)
    if password != passwordConfirm then
      halt 422, t("users.ERROR_PASSWORD_CONFIRMATION").to_json
    end
  end

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

  def updateUserPassword(newPassword, confirmation)
    if params[:password] != params[:passwordconfirm] then
      @error = t("users.ERROR_PASSWORD_CONFIRMATION")
    else
      password_salt = BCrypt::Engine.generate_salt
      password_hash = BCrypt::Engine.hash_secret(params[:password], password_salt)
      user = User.filter(:username => session[:identity]).first
      user.set(:password => password_hash)
      user.set(:passwordSalt => password_salt)
      result = user.save # return nil if failure
      if result then
        @success = t("me.SUCCESS_UPDATE")
      else
        @error = t("me.ERROR_UPDATE")
      end
    end
  rescue Sequel::ValidationFailed
    @error = t("me.ERROR_UPDATE")
  end

end