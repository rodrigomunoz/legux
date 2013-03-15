class Legux < Sinatra::Base

  helpers do
    def request_body
      @body = JSON.parse(request.body.read.to_s)
    end
  end

  #TODO: Secure /api/users/ to admin only!!
  # USERS ADMINISTRATION
  get '/api/users' do
    User.get_users.to_json
  end

  get '/api/users/:id' do
    User.get_user(params[:id]).to_json
  end

  post '/api/users' do
    begin
      body = request_body
      createUser(body['username'], body['password'], body['passwordConfirm'], body['displayName'], body['email'], body['type'])
      halt 200, t("users.SUCCESS_CREATION").to_json
    rescue Sequel::ValidationFailed => e
      halt 422, e.to_json
    end
  end

  put '/api/users/:id' do
    begin
      User[params[:id]].update(request_body.reject{|k,v| k == 'id'})
      halt 200, t("users.SUCCESS_UPDATE").to_json
    rescue Sequel::ValidationFailed => e
      halt 422, e.to_json
    end
  end

  delete '/api/users/:id' do
    User[params[:id]].delete
    halt 200, t("users.SUCCESS_DELETION").to_json
  end

  # USER PROFILE
  get '/api/me/*' do
    getMyUser.to_json(:only=>[:id, :username, :displayName, :email])
  end

  put '/api/me/*' do
    body = request_body
    updateMyProfile(body['password'], body['passwordConfirm'], body['displayName'])
  end

  # USER TYPES
  get '/api/usertypes' do
    {
        UserType::BASIC_USER    => t("users.BASIC_USER"),
        UserType::ADMINISTRATOR => t("users.SYSTEM_ADMINISTRATOR"),
    }.to_json
  end

  # THINGS (Any other object)
  get '/api/:thing' do
    get_db_model(params[:thing]).to_json
  end

  get '/api/:thing/:id' do
    get_db_model(params[:thing])[:id].to_json
  end

end