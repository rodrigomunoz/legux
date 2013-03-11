module LoginHelper

  def username
    session[:identityDisplay]
  end

  def loginAttempt
    user = User.filter(:username => params['username']).first
    if !user.nil? then
      if user[:password] == BCrypt::Engine.hash_secret(params['password'], user[:passwordSalt])
        session[:identity] = user[:username]
        session[:identityDisplay] = user[:displayName]
        session[:privileges] = user[:type]
      else
        @error = t("login.ERROR_INVALID_PASSWORD")
      end
    else
      @error = t("login.ERROR_INVALID_USERNAME")
    end
  rescue BCrypt::Errors::InvalidSalt => e
    @error = t("login.ERROR_INVALID_PASSWORD")
  end

end