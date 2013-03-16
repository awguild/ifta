desc "Preliminary work to set up IFTA App"
task :initial_setup => :environment do
  Rake::Task["db:migrate"].invoke
  Rake::Task["db:seed"].invoke
  user = User.new(:email => CONFIG[:super_admin_email], :password => CONFIG[:super_admin_password], :password_confirmation => CONFIG[:super_admin_password])
  user.role = 'admin'
  user.save
  Conference.create(:conference_year => Time.now.year, :active => true)
end

