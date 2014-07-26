desc 'Preliminary work to set up IFTA App'
task :add_schedules_to_old_conferences => :environment do
  conferences = Conference.all
  conferences.each do |conference|
    if conference.schedule.nil?
      conference.create_schedule
    end
  end
end

desc 'Backfill proposals with the id of their confernce'
task :add_conferences_to_proposals => :environment do
  Proposal.where('conference_id IS NULL').includes(:itinerary).find_each do |proposal|
    proposal.conference_id = proposal.itinerary.conference_id
    begin
      proposal.save!
    rescue Exception => e
      Rails.logger.fatal("unable to add conference for proposal #{proposal.id}")
    end
  end
end

