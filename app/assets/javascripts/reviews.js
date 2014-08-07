$(function(){
  var submitButton;

  $('input[type=submit]').click(function(e) {
    submitButton = $(e.target);
  });

  $('.review_form').each(function(index, form){
    $(form).submit(submitForm);
  });

  function submitForm(e){
    var self = this;

    e.preventDefault();

    $.ajax({
      type: getMethod(self),
      dataType: 'json',
      url: getUrl(self),
      data: {
        send_emails: shouldSendEmails(self),
        review: {
          status: submitButton.val(),
          comments: getComments(self),
          proposal_id: getProposalId(self),
          reviewer_id: getReviewerId(self)
        }
      }
    }).done(function(data) {
      $(self).fadeOut();
      $(self).parent().prepend('<div class="notice">Saved review</div>');
    }).fail(function(data){
      console.log(data)
      $(self).parent().prepend('<div class="alert">Unable to save review</div>');
    });
  }

  function shouldSendEmails(form){
    return $(form).find('input[name=send_emails]').is(':checked');
  }

  function getUrl(form){
    return $(form).attr('action');
  }

  function getMethod(form){
    return $(form).find('input[name=_method]').val() || 'post';
  }

  function getComments(form){
    return $(form).find('textarea[name=review\\[comments\\]]').val();
  }

  function getProposalId(form){
    return $(form).find('input[name=review\\[proposal_id\\]]').val();
  }

  function getReviewerId(form){
   return $(form).find('input[name=review\\[reviewer_id\\]]').val();
  }
})