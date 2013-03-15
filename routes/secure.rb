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

  # See THINGS (Any other object)
  # If object doesn't exist, then 404
  get '/admin/:things' do
    get_html_response(params[:things])
  end

end