class Api::V1::TimeBlocksController < ApplicationController
  before_filter :load_conference
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def create
    authorize! :edit, @conference

    @time_block = @conference.schedule.time_blocks.build(time_block_params)
    if @time_block.save
      render :show, status: :created
    else
      render json: @time_block.errors, status: :unprocessable_entity
    end
  end

  private

    def time_block_params
      params.permit(:start_time, :end_time, :code, :label)
    end

    def load_conference
      @conference = Conference.find_by(conference_year: params[:id])
    end
end