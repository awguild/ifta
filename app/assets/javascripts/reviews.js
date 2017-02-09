$(function(){
  $('.review_form').each(function(index, form){
    $(form).click(processForm);
  });

  function submit(reviewForm){
    return $.ajax({
      type: reviewForm.getMethod(),
      dataType: 'json',
      url: reviewForm.getUrl(),
      data: {
        send_emails: reviewForm.shouldSendEmails(),
        review: {
          status: reviewForm.status,
          comments: reviewForm.getComments(),
          proposal_id: reviewForm.getProposalId(),
          reviewer_id: reviewForm.getReviewerId()
        }
      }
    })
  };

  function processForm(e){
    var self = $(this);
    var reviewForm = new ReviewForm(self, e.target.value);
    e.preventDefault();

    submit(reviewForm).done(function(data) {
      self.fadeOut();
      self.parent().prepend('<div class="notice">Saved review</div>');
    }).fail(function(data){
      console.error(data)
      self.parent().prepend('<div class="alert">Unable to save review</div>');
    });
  }
})

function ReviewForm(form, status){
  this.form = form;
  this.status = status;
};

ReviewForm.prototype.shouldSendEmails = function(){
  return this.form.find('input[name=send_emails]').is(':checked');
}

ReviewForm.prototype.getUrl = function(){
  return this.form.attr('action');
}

ReviewForm.prototype.getMethod = function(){
  return this.form.find('input[name=_method]').val() || 'post';
}

ReviewForm.prototype.getComments = function(){
  return this.form.find('textarea[name=review\\[comments\\]]').val();
}

ReviewForm.prototype.getProposalId = function(){
  return this.form.find('input[name=review\\[proposal_id\\]]').val();
}

ReviewForm.prototype.getReviewerId = function(){
  return this.form.find('input[name=review\\[reviewer_id\\]]').val();
}
