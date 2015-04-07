$(function() {
    var forms = $('.deleteTransaction').closest("form")
      , hasDeleteTransactionForms = forms.length;
    if (hasDeleteTransactionForms) {
      forms.submit(function(e) {
        var section = $(e.target).closest(".unpaid");
        e.preventDefault();
        $.ajax(e.target.attributes.action.value,{
            type: "DELETE"
        })
        .done(function(data) {
            section.hide(1000);
        })
        .fail(function(err) {
            section.append("Opps, we couldn't remove this transaction.");
        });
      });
    }
});