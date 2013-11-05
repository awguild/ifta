class ReviewMailer < ActionMailer::Base
  default :from => CONFIG[:gmail_username]
  
  def review_notification(user, review)
    if review.status == 'accept'
      subject = Conference.active.proposal_acceptance_subject || 'Your IFTA Proposal has been accepted!'
    elsif review.status == 'decline'
      subject = Conference.active.proposal_rejection_subject || 'IFTA Proposal Review'
    elsif review.status == 'drop out'
      subject = 'Your IFTA Proposal has been withdrawn'
    else
      subject = Conference.active.proposal_wait_list_subject || 'Your IFTA Proposal has been Wait Listed'
    end
    @user = user
    @review = review
    mail(:to => user.email, :subject => subject)
  end
  
end
