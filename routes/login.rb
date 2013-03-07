class Legux < Sinatra::Base
  get '/login/form' do
    erb :login_page, :layout => false
  end

  post '/login/attempt' do
    loginAttempt
    if @error then
      halt erb :login_page, :layout => false
    else
      # TODO: This doesn't work
      where_user_came_from = session[:previous_url] || '/'
      redirect to where_user_came_from
    end
  end

  get '/logout' do
    session.delete(:identity)
    @warning = t('login.LOGGED_OUT')
    erb :login_page, :layout => false
  end
end