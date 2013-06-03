class DiscountsController < ApplicationController
  
  def index
    @discounts = Discount.all
    @conference = Conference.find(params[:conference_id])
  end
  
  def new
    @conference = Conference.find(params[:conference_id])
    @discount = @conference.discounts.build
  end
  
  def create
    @conference = Conference.find(params[:conference_id])
    @discount = @conference.discounts.build params[:discount]
    if @discount.save
      redirect_to after_sign_in_path_for(current_user) 
    else
      render 'new'
    end
  end
  
  def edit
    @discount = Discount.find(params[:id])
    @conference = Conference.find(params[:conference_id])
  end
  
  def update
    @conference = Conference.find(params[:conference_id])
    @discount = Discount.find(params[:id])
    if @discount.update_attributes params[:discount]
      redirect_to after_sign_in_path_for(current_user)
    else
      render "edit"
    end  
  end
end
