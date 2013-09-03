$(function(){
    $('.timepicker').each(formatInputDate);
})

function formatInputDate(){
    var date = new Date($(this).val());
    if(date != "Invalid Date"){
        $(this).val(formatDate(date));    
    }
    
}
function formatDate(date) {
    var d = new Date(date);
    var hh = d.getHours();
    var m = d.getMinutes();
    var s = d.getSeconds();
    var dd = "AM";
    var h = hh;
    if (h >= 12) {
        h = hh-12;
        dd = "PM";
    }
    if (h == 0) {
        h = 12;
    }
    m = m<10?"0"+m:m;

    s = s<10?"0"+s:s;

    /* if you want 2 digit hours:
    h = h<10?"0"+h:h; */

    var pattern = new RegExp("0?"+hh+":"+m+":"+s);

    var repalcement = h+":"+m;
    /* if you want to add seconds
    repalcement += ":"+s;  */
    return repalcement += " "+dd;  
}