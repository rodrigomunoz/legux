class Legux < Sinatra::Base
  before /^(?!\/(login|logout))/ do
    if !session[:identity] then
      session[:previous_url] = request['REQUEST_PATH']
      #TODO: Don't show the message if path is '/'
      #TODO: Redirect to previous path after login
      @error = t("login.LOGIN_ERROR")
      halt erb :login_page, :layout => false
    end
  end

  get '/' do
    redirect to '/home'
  end

  not_found do
    @error = t("globalerror.404_NOT_FOUND")
    erb :error_page, :layout => false
  end

  error 401 do
    @error = t("globalerror.401_NOT_AUTHORIZED")
    erb :error_page, :layout => false
  end

  error do
    @error = t("globalerror.500_COULD_NOT_CONNECT")
    erb :error_page, :layout => false
  end

end