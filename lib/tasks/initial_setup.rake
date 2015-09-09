desc "Preliminary work to set up IFTA App"
task :initial_setup => :environment do
  Rake::Task["db:migrate"].invoke
  Rake::Task["db:seed"].invoke
  user = User.new(:email => ENV["SUPER_ADMIN_EMAIL"], :password => ENV["SUPER_ADMIN_PASSWORD"], :password_confirmation => ENV["SUPER_ADMIN_PASSWORD"])
  user.role = 'admin'
  user.save
  Conference.create(:conference_year => Time.now.year, :active => true, :tax_rate => 0.07)
end

