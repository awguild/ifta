IFTA Conference Managment System
=========================

[![Code Climate](https://codeclimate.com/github/awguild/ifta.png)](https://codeclimate.com/github/awguild/ifta)
[![Build Status](https://travis-ci.org/awguild/ifta.png?branch=heroku)](https://travis-ci.org/awguild/ifta)


## Purpose
This application handles various aspects of running IFTA's annual conference including:

* Attendees signing up, registering for events, paying, and submitting proposals.
* Reviewers accepting/rejecting/wait-listing proposals.
* Admins declaring events, pricing events, declaring discounts, managing payments, scheduling, and other tasks.



## History
The Web Guild took over running IFTA's annual conference in 2011.  At that time two separate PHP apps were built independently of each other. One app handled proposal submissions and the review process, the other app handled event registration.  The original code was pretty bad.  It was mostly procedural spaghetti code with a couple of omnibus classes that should have been called Thing1 and Thing2.

The PHP code successfully ran the conference for two years, but during the second year the code base was rewritten from scratch using RoR. What began as two separate PHP applications became one Rails app.  The biggest benefit of that move is that there is an association between a user, the proposals they submit, and the events they register for.

IFTA also runs a membership system which is tangentially related to their conference (conference pricing is defined differently for members vs non members).  During the first year of the Rails app (2013) the web guild began work on a separate application that will handle the membership process.


##Developer Setup

### Supporting Development Software
1. Git Version Control System - [Download Git](http://git-scm.com/downloads)
1. Suggested Text editor [Sublime](http://www.sublimetext.com/2)
1. Suggested MySQL GUI [Heidi SQL](http://www.heidisql.com/download.php) (Windows) [Seque Pro](http://www.sequelpro.com/) (Mac)
1. Suggested Git GUI [Offical](http://git-scm.com/downloads/guis)

### App Dependencies
*You can install these dependencies natively on your machine or install them on a VM and run the app on the VM instead of your native host machine*

VM:  Install [Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/) (If your on Mac they come bundled together in docker for mac. But you might also want [Docker Sync](https://github.com/EugenMayer/docker-sync) Then Run
```bash
  docker-compose up
```

### Starting the app
1. Clone this project to your local machine
1. Create a ifta_conference_development database in MySQL
1. Request the latest sql dump from the Augie Web guild and import it into the development database
1. Request a copy of the developer .env file and put it in the root of this project
1. Run `docker-compose up`

### Rspec Tests
1. Connect to the docker container running the app `docker container exec -it ifta_ifta_1 bash`
1. Setup the test database `RAILS_ENV=test DATABASE_URL=mysql2://mariadb/ifta_conference_test rake db:create`
1. Run the specs `bin/tests`

### JS tests
The angular app that handles scheduling has its own jasmine test suite. To run the tests first install the dependencies
```
    npm install -g grunt-cli
    npm install
```

Then you can run the tests with `` grunt test ``

## Integration with external services
**Travis CI**: Whenever new code is moved into the staging branch and pushed to Github, Github will notify travis Travis CI which will then checkout the code from Github and run all the Rspec tests against the staging branch.  Travis configuration can be found in the .travis.yml file

**Heroku**: If the builds pass on Travis CI, Travis will push the staging branch to the ifta-stage app on Heroku which can be viewed at http://ifta-stage.herokuapp.com/

**PayPal** After a user creates a transaction on the conference site there is a button that says "Checkout with PayPal" backed with a hidden form that's been encrypted with all of the information that PayPal needs to allow someone to pay on their site. After PayPal confirms the payment they'll post a notification back to your site which we use to confirm that the payment was successfully completed. The callback is called Instant Payment Notification (IPN).

If you want to test the IPN process you'll need to have the app on a publicly available host (like the heroku staging app). The guild has a sandbox account on PayPal set up with the public key from the certificate that the Heroku staging app uses to encrypt communication to PayPal. PayPal will use that key to decrypt the form it gets from the staging app.

**Circle CI** Circle CI is a static code analysis tool that parses the code you've written to look for code smells (like huge methods or duplication)  and known security problems. Since this project is open source we get free partial analytics.

**Gmail** The system sends emails for forgotten passwords, payment notifications, and proposal reviews through Gmail. In all environment's except production those emails are intercepted and redirected to the value of the GMAIL_USERNAME environment variable.

**Recaptcha** The signup form uses a captcha from Recaptcha. Getting this to work with devise required monkey patching the registrations controller. You can see how that works inside of the Users::RegistrationsController class.
