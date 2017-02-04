$(function() {
	$('.user_input_price').on("blur", function(e){
    var formatted = formatCurrency(e.target.value);
    $(this).val(formatted);
  });
});

function formatCurrency (input){
  var curVal = parseFloat(input),
      dollars = parseInt(curVal, 10),
      cents = parseInt(curVal*100, 10) - parseInt(dollars*100, 10);

  cents = (cents < 10) ? "0" + cents : cents;

  return !isNaN(dollars) && !isNaN(cents) ? dollars+"."+cents : null;
}