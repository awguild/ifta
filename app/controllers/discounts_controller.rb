class DiscountsController < ApplicationController
  before_action :load_conference

  def index
    @discounts = @conference.discounts
    authorize! :show, @discounts
  end

  def new
    @discount = @conference.discounts.build
    @discount.build_prices_for_conference_items
    authorize! :create, @discount
  end

  def create
    @discount = @conference.discounts.build discount_params
    authorize! :create, @discount
    if @discount.save
      redirect_to conference_discounts_path(@conference)
    else
      render 'new'
    end
  end

  def edit
    @discount = Discount.find(params[:id])
    authorize! :update, @discount
  end

  def update
    @discount = Discount.find(params[:id])
    authorize! :update, @discount
    if @discount.update discount_params
      redirect_to conference_discounts_path(@conference)
    else
      render "edit"
    end
  end

  def destroy
    @discount = Discount.find(params[:id])
    authorize! :destroy, @discount
    @discount.destroy
    redirect_to after_sign_in_path_for(current_user)
  end

  private
    def load_conference
      @conference = Conference.find_by(conference_year: params[:conference_id])
    end

    def discount_params
      params.require(:discount).permit(:discount_key, :description, prices_attributes: Price::WHITE_LISTED)
    end
end
