Legux
=====

Management application

Installation
------------
1. Download and install Ruby. [Download Ruby](http://www.ruby-lang.org/en/downloads/)
 * Install Ruby (if installing on Windows make sure to choose 'C:/' as your base path and not 'Program Files')
1. Install the Bundler gem. [Bundler](http://bundler.com)
 * ``gem install bundler``
1. Download mySQL
 * Create a new schema called Legux
 * If running on Windows, copy libmysql.dll to Ruby's 'bin' directory (e.g. C:\Ruby192\bin)
 > * [Explanation of the issue 1](http://stackoverflow.com/questions/1208029/193-1-is-not-a-valid-win32-application-bug-with-a-new-rails-application)
 > * [Explanation of the issue 2](http://stackoverflow.com/questions/8740868/mysql2-gem-compiled-for-wrong-mysql-client-library)
1. Clone the repository and go to the folder where you downloaded it
 * ``cd legux``
 * configure database/create.rb	to use the Port, User and Password of your local database
1. Run Bundler in order to download the other required gems for the app
 * ``bundle install``
1. Run the application
 * ``bundle exec rackup config.ru``
 * The page will be in localhost:4567 by default