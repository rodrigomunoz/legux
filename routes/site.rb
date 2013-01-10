class Legux < Sinatra::Base
  get '/' do
    erb :home
  end
end