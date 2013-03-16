class ProposalsController < ApplicationController
  before_filter :check_contact_info
  
  #There can be different forms to choose from but they are all modeled via one proposal model
  #the links on the splash page are just setting some variables in the new action e.g. student 
  #this page technically doesn't need to be access controlled since its generic but we will anyway
  def splash
    @itinerary = Itinerary.find(params[:itinerary_id])
    authorize! :update, @itinerary
  end
  
  #At the moment student is the only attribute getting preset but this framework allows for 
  #dynamic form generation, ie you can show different messages and fields depending on what gets set in this action
  def new
    @itinerary = Itinerary.find(params[:itinerary_id])
    student = params[:student] == 'yes'
    @proposal = @itinerary.proposals.build(student: student)
    authorize! :create, @proposal
  end
  
  #Nothing special here, proposal model takes care of nested presenter models.  Gotta love Rails :) 
  def create
    @itinerary = Itinerary.find(params[:itinerary_id])
    @proposal = @itinerary.proposals.build(params[:proposal])
    authorize! :create, @proposal
    if @proposal.save
      flash[:notice] = "Thank you for your proposal submission."
      redirect_to edit_itinerary_path(@itinerary)
    else
      render :action => "new"
    end
  end
  
  def edit
    @itinerary = Itinerary.find(params[:itinerary_id])
    @proposal = Proposal.find(params[:id])
    authorize! :update, @proposal
  end
  
  def update
    @itinerary = Itinerary.find(params[:itinerary_id])
    @proposal = Proposal.find(params[:id])
    authorize! :update, @proposal
    if @proposal.update_attributes(params[:proposal])
      redirect_to after_sign_in_path_for(current_user), :notice => 'Proposal successfully updated.'
    else
      render :action => 'edit'
    end
  end
end
