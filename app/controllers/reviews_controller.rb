class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    authorize! :create, @review

    respond_to do |format|
      if @review.save
        send_emails if send_emails?
        format.html { redirect_to after_sign_in_path_for(current_user), :notice => 'Proposal successfully reviewed.' }
        format.json { head :no_content }
      else
        format.html { render :action => 'edit', :alert => 'Unable to save your last review' }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @review = Review.find(params[:id])
    authorize! :create, @review

    respond_to do |format|
      if @review.update_attributes(review_params)
        send_emails if send_emails?
        format.html { redirect_to after_sign_in_path_for(current_user), :notice => 'Proposal successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => 'edit', :alert => 'Unable to save your last review' }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def send_emails?
    params[:send_emails] == "true" || params[:send_emails] == true || params[:send_emails] == '1'
  end

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

  def review_params
    params.require(:review).permit(:proposal_id, :status, :comments, :reviewer_id)
  end
end
