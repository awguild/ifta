class ReviewsController < ApplicationController
  
  def create
    @review = Review.new(params[:review])
    authorize! :create, @review
    
    if @review.save
      send_emails if params[:send_emails] 
      flash[:notice] = 'Proposal successfully reviewed'
    else
      flash[:alert] = 'Unable to save your last review'
    end
    redirect_to after_sign_in_path_for(current_user) 
  end
  
  def update
    @review = Review.find(params[:id])
    if @review.update_attributes(params[:review])
      send_emails if params[:send_emails]
    else
      flash[:alert] = 'Unable to save your last review'
    end
    redirect_to after_sign_in_path_for(current_user) 
  end
  
  private
  
  def send_emails
    @review.proposal.presenters.each do |presenter|
      begin
        #email subject/message changes depending on the status of the review (accept, decline, wait-list)
        ReviewMailer.review_notification(presenter, @review).deliver 
      rescue
        warning = "Unable to send email to #{presenter.email} for #{presenter.first_name + " " + presenter.last_name}"
        flash[:alert] = flash[:alert].blank? ? warning : flash[:alert] + ". #{warning}"   
      end
    end
  end
end
