$(function(){
  $('.remove').on('click', function(){
    
    if($(this).closest('form').hasClass('new_discount')){
      $(this).closest('.removable').remove();  
    }else{
      $(this).closest('.removable').hide('normal');
      $(this).prev('[name*="destroy"]').val("true");
    }
  })
})
