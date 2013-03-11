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

  # All /users/ page will have a left navigation panel
  #before '/users/*' do
  #  nav = NavigationMenu.new(session[:privileges])
  #  nav.addNavigationItem("/users/admin/create", t("users.CREATE_USERS"))
  #  nav.addNavigationItem("/users/all", t("users.DISPLAY_ALL_USERS"))
  #  @leftnav = nav.array
  #end

  get '/admin/users' do
    halt erb :users
  end

  # See the list of clients
  get '/clients' do
    Client.new
    erb "This is a secret place that only <%=session[:identity]%> has access to!"
  end
end