Legux
=====

Management application

Installation
------------
1. Download and install Ruby. [Download Ruby](http://www.ruby-lang.org/en/downloads/)
 * Install Ruby (if installing on Windows make sure to choose 'C:/' as your base path and not 'Program Files')
1. Install the Bundler gem. [Bundler](http://gembundler.com/)
 * ``gem install bundler``
1. Download mySQL
 * Create a new schema called Legux
 * If running on Windows, copy libmysql.dll to Ruby's 'bin' directory (e.g. C:\Ruby192\bin)
 * [Explanation of the issue 1](http://stackoverflow.com/questions/1208029/193-1-is-not-a-valid-win32-application-bug-with-a-new-rails-application)
 * [Explanation of the issue 2](http://stackoverflow.com/questions/8740868/mysql2-gem-compiled-for-wrong-mysql-client-library)
1. Clone the repository and go to the folder where you downloaded it
 * ``cd legux``
 * configure ``database/create.rb`` to use the Port, User and Password of your local database
1. Run Bundler in order to download the other required gems for the app
 * Run it using the command prompt/terminal with Ruby
 * ``bundle install``
1. Run the application
 * ``bundle exec rackup config.ru``
 * The page will be in http://localhost:4567 by default
 
Deployment in Heroku
------------
1. Make sure to have your Gemfile and require dependencies to PostgreSQL (gem 'pg')
1. Login to Heroku ``heroku login`` using your Git Bash
 * If a site hasn't been created ``heroku create``
1. Deploy your code
 * ``git push heroku master``
 * ``git push heroku yourbranch:master``
1. Make sure to have the PostgreSQL available by typing ``heroku addons``
 * If a DB is not available create one with ``heroku addons:add heroku-postgresql:dev``
 * And promote it to the environment varialbe ``DATABASE_URL`` by running ``heroku pg:promote HEROKU_POSTGRESQL_<NAME>_URL``
 * [More information](https://devcenter.heroku.com/articles/heroku-postgresql)
1. Start dyno so your application can be available on the web ``heroku ps:scale web=1``
 * When not using it, make sure to change it back to ``0``. Heroku provides a limited number of free hours a month
 * Check the status with ``heroku ps``
 * Open the logs with ``heroku logs``

If you have issues installing the JSON gem
------------
1. Download [Development Kit](http://rubyinstaller.org/downloads/)
 * Unzip the file and open a command prompt on that folder
 * ``ruby dk.rb init``
 * ``ruby dk.rb install``
 * ``gem install json``