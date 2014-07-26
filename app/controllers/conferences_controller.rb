class ConferencesController < ApplicationController

  def show
   @conference = Conference.find_by_conference_year(params[:id])
   authorize! @conference, :update
  end

  def create
    @conference = Conference.new(params[:conference])
    authorize! :create, @conference

    if @conference.save
      flash[:notice] = 'Conference successfully created'
    else
      flash[:alert] = "Could not create conference because #{@conference.errors.full_messages.join(', ')}"
    end
    redirect_to after_sign_in_path_for(current_user)
  end

  def edit
    @conference = Conference.includes(conference_items: [:regular_prices]).find_by_conference_year(params[:id])
    @new_conference = Conference.new(conference_year: (@conference.conference_year + 1), tax_rate: @conference.tax_rate)
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
    @conference = Conference.find_by_conference_year(params[:id])
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

  def select_year
    session[:selected_conference_id] = params[:conference_id]
    redirect_to after_sign_in_path_for(current_user)
  end
end
