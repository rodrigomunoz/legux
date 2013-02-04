class Legux < Sinatra::Base
  before '/secure/*' do
    # Uncomment for development purposes
    #session[:identity] = "test"
    #session[:identityDisplay] = "test display"
    # end block
    if !session[:identity] then
      session[:previous_url] = request['REQUEST_PATH']
      @error = t("login.LOGIN_ERROR")
      halt erb :login_page, :layout => false
    end
  end

  # Any route that contains /admin/ can be accessed only by System Administrators
  before /\/admin\// do
    if session[:privileges] > 0 then
      redirect to error(401)
    end
  end

  get '/secure/home' do
    halt erb (:home)
  end

  get '/secure/me/editprofile' do
    updateDisplayNameForm
    halt erb :form_template
  end

  post '/secure/me/editprofile' do
    updateUserDisplayName(params[:displayname])
    updateDisplayNameForm
    erb :form_template
  end

  get '/secure/me/changepassword' do
    updatePasswordForm
    halt erb :form_template
  end

  post '/secure/me/changepassword' do
    updateUserPassword(params[:password], params[:passwordconfirm])
    updatePasswordForm
    halt erb :form_template
  end

  # All /users/ page will have a left navigation panel
  before '/secure/users/*' do
    nav = NavigationMenu.new(session[:privileges])
    nav.addNavigationItem("/secure/users/admin/create", t("users.CREATE_USERS"))
    nav.addNavigationItem("/secure/users/all", t("users.DISPLAY_ALL_USERS"))
    @leftnav = nav.array
  end

  get '/secure/users/all' do
    @title = t("users.DISPLAY_ALL_USERS")
    @data = User.displayable_data
    @columns = [t("users.USERNAME"), t("users.DISPLAY_NAME"), t("users.E_MAIL"), t("users.TYPE")]
    halt erb (:display_all_template)
  end

  get '/secure/users/admin/create' do
    createUserForm
    halt erb :form_template
  end

  post '/secure/users/admin/create' do
    if params['password'] != params['passwordconfirm'] then
      @error = t("users.ERROR_PASSWORD_CONFIRMATION")
    else
      if createUserFromParams then
        @success = t("users.SUCCESS_CREATION", :username => params['username'])
      end
    end
    createUserForm(@success ? nil : params)
    erb :form_template
  end

  # TODO: Use JS
  get '/secure/users/edit' do
    editUserForm
    erb :form_template, :layout => false
  end

  # See the list of clients
  get '/secure/clients' do
    Client.new
    erb "This is a secret place that only <%=session[:identity]%> has access to!"
  end
end