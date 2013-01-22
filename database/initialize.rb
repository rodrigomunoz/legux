require_relative '../helpers/init'
# File to initialize information on the database

class Initialize
  include UsersHelper

  # If administrator doesn't exist, create the user
  unless User.where(:username => "administrator").count > 0
    UsersHelper.createAdministratorUser
  end

end