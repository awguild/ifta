IFTA Conference Managment System
================================

Non Gem Requirements
--------------------
OpenSSL

Purpose
-------
This application handles various aspects of running IFTA's annual conference including:

* Attendees signing up, registering for events, paying, and submitting proposals.
* Reviewers accepting/rejecting/wait-listing proposals.
* Admins declaring events, pricing events, declaring discounts, managing payments, scheduling, and other tasks. 

Some of the logic is specific to IFTA's conference needs but eventually large portions of the project can be refactored into a conference managment plugin.

Setup
-----
* Rename config/applicaiton.example.yml to config/applicaiton.yml and fill in blank values with your own information
* Certificate for paypal (commands should be run in the certs directory)

 1. Generate the private key *openssl genrsa -out app_key.pem 1024*
 2. Generate the certificate *openssl req -new -key app_key.pem -x509 -days 365 -out app_cert.pem*
 3. Upload your certificate to your paypal account
 4. Copy the certificate id paypal gives you and put it in your application.yml file
* Create production database if you intend to run in production mode
* Install gems *bundle install*
* Migrate and seed databases *bundle exec rake initial_setup*

Coming Soon
-------------------
Still haven't gotten to version 1.0 yet. The top of the todo list includes
  
* Discounts
* Scheduling
* RSpec tests :)

