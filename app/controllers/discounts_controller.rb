class DiscountsController < ApplicationController
  before_filter :load_conference

  def index
    @discounts = @conference.discounts
    authorize! :show, @discounts
  end

  def new
    @discount = @conference.discounts.build
    authorize! :create, @discount
  end

  def create
    @discount = @conference.discounts.build params[:discount]
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
    if @discount.update_attributes params[:discount]
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
      @conference = Conference.find(params[:conference_id])
    end
end
