class Api::V1::SchedulesController < ApplicationController
  before_filter :load_conference
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def show
    authorize! :edit, @conference
    @time_blocks = @conference.schedule.time_blocks.includes({
      slots: [{
        proposal: [{
            user: [
              :country
            ]
          },
          :presenters
        ]},
        :room
      ]
    })
  end

  private
    def load_conference
      @conference = Conference.find_by(conference_year: params[:id])
    end
end
