object @time_blocks
attributes :id, :code, :start_time, :end_time

child :slots do
  attributes :id, :time_block_id, :proposal_id, :room_id

  child :proposal do
    attributes :id, :format, :category, :title, :short_description, :long_description, :student, :no_equipment, :sound, :projector, :status, :keywords, :relative_number, :date_accepted, :user_id, :date_emailed, :invite_letter, :notes

    child :user do
      attributes :first_name, :last_name, :email, :member, :student, :country_category
      child :country do
        attributes :name
      end
    end

    child :presenters do
      :email
    end
  end

  child :room do
    attributes :id, :label
  end
end