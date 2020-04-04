class Api::V1::TimeBlocksController < ApplicationController
  before_action :find_conference, only: [:create, :index]
  before_action :find_time_block, only: [:update, :destroy]
  skip_before_action :verify_authenticity_token
  respond_to :json

  def index
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

  def create
    authorize! :edit, @conference

    @time_block = @conference.schedule.time_blocks.build(time_block_params)
    if @time_block.save
      render :show, status: :created
    else
      render json: @time_block.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize! :edit, @time_block

    if @time_block.update_attributes(time_block_params)
      head :no_content
    else
      render json: @time_block.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :edit, @time_block

    @time_block.destroy
    head :no_content
  end

  private

    def find_time_block
      @time_block = TimeBlock.find(params[:id])
    end

    def time_block_params
      params.permit(:start_time, :end_time, :code, :label)
    end

    def find_conference
      @conference = Conference.find_by(conference_year: params[:conference_id])
    end
end
