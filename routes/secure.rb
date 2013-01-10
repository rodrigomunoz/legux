class Legux < Sinatra::Base
  before '/secure/*' do
    if !session[:identity] then
      session[:previous_url] = request['REQUEST_PATH']
      @error = t("login.LOGIN_ERROR")
      halt erb(:login_form)
    end
  end

  get '/secure/place' do
    erb "This is a secret place that only <%=session[:identity]%> has access to!"
  end

  get '/secure/clients' do
    Client.new
    erb "This is a secret place that only <%=session[:identity]%> has access to!"
  end
end