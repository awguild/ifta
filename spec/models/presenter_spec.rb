require 'spec_helper'

describe Presenter do
  it { should validate_presence_of(:country_id) }
  it { should belong_to(:country) }

  context 'presenter_conference_status' do
    it 'should return no user when no user exists' do
      status = Presenter.presenter_conference_status 'fake@example.com', nil
      expect(status).to eql('No User')
    end

    it 'should return Registered when itinerary has a registered conference line item' do
      itinerary = create(:itinerary_with_item, paid: true)
      status = Presenter.presenter_conference_status(itinerary.user.email, itinerary.conference.id)
      expect(status).to eql('Registered')
    end

    it 'should return Pending Registration when itinerary has a pending registered line item' do
      itinerary = create(:itinerary_with_item, paid: false)
      status = Presenter.presenter_conference_status(itinerary.user.email, itinerary.conference.id)
      expect(status).to eql('Pending Registration')
    end

    it 'should return Not Registered when itinerary does not have line items' do
      itinerary = create(:itinerary)
      status = Presenter.presenter_conference_status(itinerary.user.email, itinerary.conference.id)
      expect(status).to eql('Not Registered')
    end
  end
end
