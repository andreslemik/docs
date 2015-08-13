# Load the Rails application.
require File.expand_path('../application', __FILE__)

Time::DATE_FORMATS[:ru_datetime] = "%d.%m.%Y %k:%M" 
Time::DATE_FORMATS[:ru_date] = "%d.%m.%Y"
# Initialize the Rails application.
Docs::Application.initialize!
