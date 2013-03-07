class Legux < Sinatra::Base

  helpers do
    def request_body
      @body = JSON.parse(request.body.read.to_s)
    end
  end

  #TODO: Secure /api/users/ to admin only!!
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
      status 200
    rescue Sequel::ValidationFailed => e
      halt 422, e.to_json
    end
  end

  put '/api/users/:id' do
    begin
      User[params[:id]].update(request_body.reject{|k,v| k == 'id'})
      status 200
    rescue Sequel::ValidationFailed => e
      halt 422, e.to_json
    end
  end

  delete '/api/users/:id' do
    User[params[:id]].delete
    status 200
  end

  get '/api/me/*' do
    getMyUser.to_json(:only=>[:id, :username, :displayName, :email])
  end

  put '/api/me/*' do
    begin
      getMyUser.update(request_body.reject{|k,v| k == 'id'}) || halt(422, t("me.ERROR_UPDATE").to_json)
      status 200
      t("me.SUCCESS_UPDATE").to_json
    rescue Sequel::ValidationFailed => e
      halt 422, e.to_json
    end
  end

  get '/api/usertypes' do
    {
        UserType::BASIC_USER    => t("users.BASIC_USER"),
        UserType::ADMINISTRATOR => t("users.SYSTEM_ADMINISTRATOR"),
    }.to_json
  end

  #TODO: Delete
  get '/api/users/create/form' do
    createUserForm
    @form.to_json
  end
end