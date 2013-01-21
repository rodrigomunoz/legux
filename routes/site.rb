class Legux < Sinatra::Base
  get '/' do
    if !session[:identity] then
      halt erb :login_page, :layout => false
    else
      redirect to '/secure/home'
    end
  end

  not_found do
    @error = t("globalerror.404_NOT_FOUND")
    erb :error_page, :layout => false
  end

  error do
    @error = t("globalerror.500_COULD_NOT_CONNECT")
    erb :error_page, :layout => false
  end

end