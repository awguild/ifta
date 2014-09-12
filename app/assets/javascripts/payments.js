$(function() {
    var forms = $('.deleteTransaction').closest("form")
      , hasDeleteTransactionForms = forms.length;
      console.log(forms);

    if (hasDeleteTransactionForms) {
      forms.submit(function(e) {
        e.preventDefault();
        console.log("Event happened ", e);
      });
    }
});