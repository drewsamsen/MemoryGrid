# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_memorygrid_session',
  :secret      => '8d86a8e811260c69cdb63c51030fbb390f924a803acd29a9e86e2cfa66d5d476a589bd705b154a10953ca618507f223bae3c8a558c6c77d2cbe51a5450c7fbae'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
