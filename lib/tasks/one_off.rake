desc 'Preliminary work to set up IFTA App'
task :add_schedules_to_old_conferences => :environment do
  conferences = Conference.all
  conferences.each do |conference|
    if conference.schedule.nil?
      conference.create_schedule
    end
  end
end

desc 'Backfill proposals with the id of their conference'
task :add_conferences_to_proposals => :environment do
  Proposal.where('conference_id IS NULL').includes(:itinerary).find_each do |proposal|
    begin
      proposal.update_attribute(:conference_id, proposal.itinerary.conference_id)
    rescue Exception => e
      Rails.logger.fatal("unable to add conference for proposal #{proposal.id}")
    end
  end
end

desc 'Backfill proposals with the id of their user'
task :add_users_to_proposals => :environment do
  Proposal.where('user_id IS NULL').includes(:itinerary).find_each do |proposal|
    begin
      proposal.update_attribute(:user_id, proposal.itinerary.user_id)
    rescue Exception => e
      Rails.logger.fatal("unable to add user for proposal #{proposal.id}")
    end
  end
end

desc 'Backfill relative numbers on all the proposals'
task :add_relative_numbers_to_proposals => :environment do
  Proposal.where(relative_number: nil).order('created_at').find_each do |proposal|
    begin
      proposal.save!
    rescue Exception => e
      Rails.logger.fatal("unable to add relative number for proposal #{proposal.id}")
    end
  end
end

