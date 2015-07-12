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

  def bulk_create
    @slots = CreateSlotsApi.new(slots_params)
    if @slots.valid?
      @slots = @slots.persist!
      render json: @slots, status: :created
    else
      render json: @slots.errors, status: :unprocessable_entity
    end
  end

  private
    def load_conference
      @conference = Conference.find_by(conference_year: params[:id])
    end

    def slots_params
      {
        quantity: params[:quantity],
        start_time: params[:end_time],
        end_time: params[:end_time],
        schedule_id: @conference.schedule.id
      }
    end
end
