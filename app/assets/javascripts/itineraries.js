//formats currency after a user enters it in an input with the class user_input_price
//currently all conference items are loaded with the DOM but eventually users might be
//allowed to add conference items if they are flagged as multiple=t 
//in preperation for that functionality we attach the handler through live
$(function() {
$('.user_input_price').on("blur", function(){
    var curVal = parseFloat($(this).val()),
        curInt = parseInt(curVal, 10),
        curDec = parseInt(curVal*100, 10) - parseInt(curInt*100, 10);

    curDec = (curDec < 10) ? "0" + curDec : curDec;

    if (!isNaN(curInt) && !isNaN(curDec)) {
        $(this).val(curInt+"."+curDec);
    }
});
});