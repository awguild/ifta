json.extract! @room, :id, :schedule_id, :label, :audio, :video, :created_at, :updated_at
json.conference_id @room.conference.id