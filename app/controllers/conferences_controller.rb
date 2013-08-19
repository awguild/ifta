class ConferencesController < ApplicationController
  
  def show
   @conference = Conference.find(params[:id])
   authorize! @conference, :update
  end
  
  def edit
    @conference = Conference.includes(conference_items: [:regular_prices]).find(params[:id])
    authorize! @conference, :update
    if params[:pricing]
      #this form is for editing the nested conference_items, I inappropriately named it after the narrower action of pricing confernece items
      render :pricing
    else
      #this form is for editing other confernce settings (e.g. tax rate, year, etc)
      render :edit
    end
  end
  
  def update
    @conference = Conference.find(params[:id])
    authorize! @conference, :update
    if @conference.update_attributes(params[:conference])
      redirect_to conference_path(@conference)
    else
      if params[:pricing]
        #there were errors and the pricing flag was set, indicating the user was editing the nested conference_items
        render :pricing
      else
        render :edit
      end
    end
  end
end
