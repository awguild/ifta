require 'spec_helper'

describe Presenter do
  context 'presenter_conference_status' do
    it 'should return no user when no user exists' do
      status = Presenter.presenter_conference_status 'fake@example.com', nil
      expect(status).to eql('No User')
    end

    it 'should return Registered when itinerary has a registered conference line item' do
      itinerary = FactoryGirl.create(:itinerary_with_paid_conference)
      status = Presenter.presenter_conference_status(itinerary.user.email, itinerary.conference.id)
      expect(status).to eql('Registered')
    end

    it 'should return Pending Registration when itinerary has a pending registered line item' do
      itinerary = FactoryGirl.create(:itinerary_with_pending_conference)
      status = Presenter.presenter_conference_status(itinerary.user.email, itinerary.conference.id)
      expect(status).to eql('Pending Registration')
    end

    it 'should return Not Registered when itinerary does not have line items' do
      itinerary = FactoryGirl.create(:itinerary)
      status = Presenter.presenter_conference_status(itinerary.user.email, itinerary.conference.id)
      expect(status).to eql('Not Registered')
    end
  end
end