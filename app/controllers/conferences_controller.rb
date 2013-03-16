class ConferencesController < ApplicationController
  
  def show
   @conference = Conference.find(params[:id])
   authorize! @conference, :update
  end
  
  #Conference resource is so big that editing it has been split into two screens event pricing and other
  def edit
    @conference = Conference.find(params[:id])
    authorize! @conference, :update
    if params[:pricing]
      render :pricing
    else
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
        render :pricing
      else
        render :edit
      end
    end
  end
end
