class ProposalsController < ApplicationController
  before_filter :check_contact_info
  
  #There can be different proposal forms to choose from but they are all different representations of one proposal model
  #the links on the splash page are just pass information to the new action ie. student 
  def splash
    @itinerary = Itinerary.find(params[:itinerary_id])
    authorize! :update, @itinerary
  end
  
  #At the moment student is the only query parameter but this design is easily extensible 
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
      redirect_to after_sign_in_path_for(current_user)
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
  
  #reviewers can review proposals right from the search results
  def index
    authorize! :index, Proposal
    @proposals = Proposal.search(params) #search returns an intersection not union
    @proposals = @proposals.page(params[:page]).per_page(5).includes(:itinerary, :presenters)
    @review = Review.new
  end
end
