$(document).ready(function() {
$('.user_input_price').blur(function(e){
    var curVal = parseFloat($(this).val()),
        curInt = parseInt(curVal, 10),
        curDec = parseInt(curVal*100, 10) - parseInt(curInt*100, 10);

    curDec = (curDec < 10) ? "0" + curDec : curDec;

    if (!isNaN(curInt) && !isNaN(curDec)) {
        $(this).val(curInt+"."+curDec);
    }
});
});