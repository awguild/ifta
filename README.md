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



This application is designed to handle various aspects of running IFTA's annual conference.
*On the client front end this includes: sign up, event registration, payment, and proposal submission.
*On the reviewer backend this includes: accepting/rejecting/wait-listing proposals.
*On the admin backend this includes: declaring events, pricing those events, declaring discounts, setting messages to users, marking accepted payments, and other tasks. 



NON GEM REQUIREMENTS
OpenSSL


CREATING PAYPAL CERTS
Add cert to ifta's paypal




DEVELOPMENT
*Minimial steps for a working development environment 
1. Bundle install
2. Open the application.example.yml file and fill in relevant information, then rename the file applicaiton.yml
3. bundle exec rake initial_setup

*Extra Development Stuff
If you want to test the IPN process you'll need to have the project on a publicly available host
1. Go to developer.paypal.com make accounts
2. Create Certs and put them in certs folder
2. Upload certificates in certs folder





PRODUCTION
*To get the application up and running in production
1. Set up a virtual host entry on the server
2. Upload the rails files to the appropriate location (specified in your virtual host) 
3. Set up MySQL user/password
4. Create the MySQL database
5. Create/Upload the public certificate for paypal
6. Bundle install
7. Open the application.example.yml file and fill in relevant information, then rename the file applicaiton.yml
8. rake initial_setup




#TODO write the RSpec tests
#TODO I18n - pages and maybe even currency