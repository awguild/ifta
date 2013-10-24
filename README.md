IFTA Conference Managment System
=========================

##Purpose
This application handles various aspects of running IFTA's annual conference including:

* Attendees signing up, registering for events, paying, and submitting proposals.
* Reviewers accepting/rejecting/wait-listing proposals.
* Admins declaring events, pricing events, declaring discounts, managing payments, scheduling, and other tasks. 


##Developer Setup

### Supporting Software
1. [Download Git](http://git-scm.com/downloads)
1. [Virtualbox](https://www.virtualbox.org/wiki/Downloads) & [Vagrant](http://www.vagrantup.com/) or Install MySQL natively with [XAMPP](http://www.apachefriends.org/en/xampp.html)
1. Download a Ruby manger [Pik](http://rubyinstaller.org/add-ons/pik/) (Windows)  [rbenv](https://github.com/sstephenson/rbenv) or [RVM](https://rvm.io/rvm/install), (Mac) 
1. Install Ruby 2.0.0 as per your Ruby manger's guide
1. Suggested Text editor [Sublime](http://www.sublimetext.com/2)
1. Suggested MySQL GUI's [Heidi SQL](http://www.heidisql.com/download.php) (Windows) [Seque Pro](http://www.sequelpro.com/) (Mac)
1. Suggested Git GUI [Offical](http://git-scm.com/downloads/guis)

### Supporting files
1. Request the latest sql dump from the Augie Web guild 
1. Copy the application.example.yml file and rename it application.yml 
1. Fill in application.yml with your own information (contact the web guild for help)
1. Generate certificates as described below

### Vagrant Setup
Vagrant is a tool that helps you easily create and destroy virtual machines by using a Vagrantfile.  This repo has two Vagrantfiles.  

* Vagrantfile.base - sets up an Ubuntu 13.04 box running Ruby 1.9.3. You can then install MySQL, install the app's gems, run database migrations, seed the database, and package that fully provisioned box into a vagrant box called *ifta.pkg*

* Vagrantfile.developer -This Vagrantfile gets used to start up the ifta box 

*Note: Commands should be run from your project directory*

1. Add the ubuntu box locally ``` vagrant box add ubuntu http://goo.gl/Y4aRr ```
1. Copy Vagrantfile.base and rename the copy Vagrantfile
1. Start your VM
```
vagrant up 
```
1. Install gems 

```
vagrant ssh
cd /vagrant
bundle install
exit
```
1. Install MySQL (set root password to password)
```
apt-get install mysql-server
```
1. Allow remote access to mysql server (so that you can access it from your host machine)

```
vagrant ssh
sudo vi /etc/my.cnf
[set bind-address=0.0.0.0]
mysql -u root -p [when prompted the password is password]
GRANT ALL ON *.* TO root@'%' IDENTIFIED BY 'password';
exit
exit
```
1. Load SQL data.  The easiest way to do this is to use your MySQL GUI.
1. Package the box 
```
vagrant package --output ifta.pkg
```
1. Add the box to your local list
```
vagrant box add ifta ifta.pkg
```
1. Bring down your VM ``` vagrant destroy ```
1. Delete Vagrantfile
1. Copy Vagrantfile.developer and rename the copy Vagrantfile 
###Testing Paypal
If you want to test the IPN process you'll need to host the app on a publicly available host. Then follow these steps 

1. Go to developer.paypal.com and make a sandbox account
1. Upload the certificate to your paypal sandbox account
1. Copy the certificate id paypal gives you and put it in your application.yml file



## TODO 
1. Write the RSpec tests
1. I18n 