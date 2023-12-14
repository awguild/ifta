IFTA Conference Managment System
=========================

## Purpose
This application handles various aspects of running IFTA's annual conference including:

* Attendees signing up, registering for events, paying, and submitting proposals.
* Reviewers accepting/rejecting/wait-listing proposals.
* Admins declaring events, pricing events, declaring discounts, managing payments, scheduling, and other tasks.

The Web Guild also runs IFTA's membership system which is relevant to their conference (because conference pricing is defined differently for members vs non members). Member lists are manually synced to this application for pricing reasons.

## Developer Setup

### App Dependencies
*You can install these dependencies natively on your machine or install them on a VM and run the app on the VM instead of your native host machine*

Install [Docker Desktop](https://www.docker.com/products/docker-desktop/) and [Docker Compose](https://docs.docker.com/compose/)

### Starting the app
1. Clone this project to your local machine
1. Create a ifta_conference_development database in MySQL
1. Request the latest sql dump from the Augie Web guild and import it into the development database
1. Request a copy of the developer .env file and put it in the root of this project
1. Run `docker-compose up`

### Rspec Tests
1. Connect to the docker container running the app `docker container exec -it ifta_ifta_1 bash`
1. Setup the test database `RAILS_ENV=test DATABASE_URL=mysql2://db/ifta_conference_test bundle exec rake db:create`
1. Run the specs `RAILS_ENV=test bundle exec rspec`

## Integration with external services
**Github Actions**: Whenever new code is merged into the master branch and pushed to Github, Github actions will checkout the code and run all the Rspec tests.

**Heroku**: The staging version of the application can be found at http://ifta-stage.herokuapp.com/

**PayPal** After a user creates a transaction on the conference site there is a button that says "Checkout with PayPal" backed with a hidden form that's been encrypted with all of the information that PayPal needs to allow someone to pay on their site. After PayPal confirms the payment they'll post a notification back to your site which we use to confirm that the payment was successfully completed. The callback is called Instant Payment Notification (IPN).

If you want to test the IPN process you'll need to have the app on a publicly available host (like the heroku staging app). The guild has a sandbox account on PayPal set up with the public key from the certificate that the Heroku staging app uses to encrypt communication to PayPal. PayPal will use that key to decrypt the form it gets from the staging app.

**Code Climate** Code Climate is a static code analysis tool that parses the code you've written to look for code smells (like huge methods or duplication)  and known security problems. Since this project is open source we get free partial analytics.
[![Code Climate](https://codeclimate.com/github/awguild/ifta.png)](https://codeclimate.com/github/awguild/ifta)

**Gmail** The system sends emails for forgotten passwords, payment notifications, and proposal reviews through Gmail. In all environment's except production those emails are intercepted and redirected to the value of the GMAIL_USERNAME environment variable.

**Recaptcha** The signup form uses a captcha from Recaptcha. Getting this to work with devise required monkey patching the registrations controller. You can see how that works inside of the Users::RegistrationsController class.
