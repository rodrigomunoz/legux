class Legux < Sinatra::Base

  # Any route that contains /admin/ can be accessed only by System Administrators
  before /\/admin\// do
    if session[:privileges] > 0 then
      redirect to error(401)
    end
  end

  get '/home' do
    halt erb (:home)
  end

  get '/me' do
    halt erb :user_profile
  end

  get '/admin/users' do
    halt erb :users
  end

  # See the list of employees
  get '/admin/employees' do
    @columns = [t("employees.FIRST_NAME"), t("employees.LAST_NAME"), t("employees.TYPE")]
    halt erb :things
  end

  # See the list of employees
  get '/admin/products' do
    @columns = [t("products.DESCRIPTION"), t("products.QUANTITY"), t("products.PRICE"), t("products.PACKAGING")]
    halt erb :things
  end

end