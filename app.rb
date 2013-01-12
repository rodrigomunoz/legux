require 'rubygems'
require 'bundler/setup'
require 'sinatra/base'
require 'i18n'
require 'haml'
require 'bcrypt'

class Legux < Sinatra::Base

  configure do
    set :public_folder, Proc.new { File.join(root, "static") }
    enable :sessions
  end

  # Method just to append a file to the Root Path
  ROOT_DIR = File.expand_path(File.dirname(__FILE__)) unless defined? ROOT_DIR

  # Configuration for i18n.
  # For now, we are setting Spanish as the default language. If no translation
  # is found then we fallback to English
  I18n.load_path += Dir[File.join(ROOT_DIR,'locales/*.yml').to_s]
  I18n.default_locale = :en
  I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
  I18n.fallbacks[:es] = [:en]

end

require_relative 'database/create'
require_relative 'model/init'
require_relative 'helpers/init'
require_relative 'routes/init'