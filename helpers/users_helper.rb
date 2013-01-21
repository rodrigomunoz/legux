module UsersHelper

  def createUser
    password_salt = BCrypt::Engine.generate_salt
    password_hash = BCrypt::Engine.hash_secret(params[:password], password_salt)
    displayName = params[:displayname]
    if displayName.nil?
      displayName = username
    end
    user = User.create(
        :username => params[:username],
        :password => password_hash,
        :passwordSalt => password_salt,
        :displayName => displayName,
        :email => params[:email],
        :type => 0
    )
  rescue Sequel::ValidationFailed => e
    @error = e
    false
  end

  def updateUserDisplayName(displayName)
    user = User.filter(:username => session[:identity]).first
    user.set(:displayName => displayName)
    result = user.save # return nil if failure
    if result then
      session[:identityDisplay] = displayName
      @success = t("me.SUCCESS_UPDATE")
    else
      @error = t("me.ERROR_UPDATE")
    end
  rescue Sequel::ValidationFailed
    @error = t("me.ERROR_UPDATE")
  end

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