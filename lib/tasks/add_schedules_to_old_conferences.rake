desc "Preliminary work to set up IFTA App"
task :add_schedules_to_old_conferences => :environment do
  conferences = Conference.all
  conferences.each do |conference|
    if conference.schedule.nil?
      conference.create_schedule
    end  
  end
end

