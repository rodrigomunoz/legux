class Legux < Sinatra::Base

  helpers do
    def request_body
      @body = JSON.parse(request.body.read.to_s)
    end
    def request_body_no_id
      @reqbody = request_body.reject{|k,v| k == 'id'}
    end
    def get_thing_model
      @thingmodel = get_db_model(params[:thing])
    end
    def get_thing
      @thing = get_thing_model[params[:id]]
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
      halt 200, t("common.SUCCESS_CREATION").to_json
    rescue Sequel::ValidationFailed => e
      halt 422, e.to_json
    end
  end

  put '/api/users/:id' do
    begin
      User[params[:id]].update(request_body_no_id)
      halt 200, t("common.SUCCESS_UPDATE").to_json
    rescue Sequel::ValidationFailed => e
      halt 422, e.to_json
    end
  end

  delete '/api/users/:id' do
    User[params[:id]].delete
    halt 200, t("common.SUCCESS_DELETION").to_json
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
    get_user_types.to_json
  end

  # THINGS (Any other object)
  # For any new table on the database, you just need to add the
  # new model on the 'get_db_model' method and it will automatically
  # be considered on the following paths

  get '/api/:thing' do
    get_thing_model.to_json
  end

  get '/api/:thing/:id' do
    get_thing.to_json
  end

  post '/api/:thing' do
    begin
      get_thing_model.create(request_body_no_id)
      halt 200, t("common.SUCCESS_CREATION").to_json
    rescue => e
      halt 422, e.to_json
    end
  end

  put '/api/:thing/:id' do
    begin
      get_thing.update(request_body_no_id)
      halt 200, t("common.SUCCESS_UPDATE").to_json
    rescue => e
      halt 422, e.to_json
    end
  end

  delete '/api/:thing/:id' do
    get_thing.delete
    halt 200, t("common.SUCCESS_DELETION").to_json
  end

end