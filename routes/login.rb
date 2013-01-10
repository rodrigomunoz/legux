class Legux < Sinatra::Base
  get '/login/form' do
    erb :login_form
  end

  post '/login/attempt' do
    session[:identity] = params['username']
    where_user_came_from = session[:previous_url] || '/'
    redirect to where_user_came_from
  end

  get '/logout' do
    session.delete(:identity)
    erb "<div class='alert alert-message'><%= t('login.LOGGED_OUT') %></div>"
  end
end