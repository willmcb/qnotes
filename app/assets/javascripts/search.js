$(document).on('turbolinks:load', function() {
  $('#search').keyup(function(){
    var input = this.value.toUpperCase();
    var items = document.getElementsByClassName("item");
    for(var i = 0; i < items.length; i++) {
       var txtValue = items[i].innerText;
       console.log(txtValue);
       if(txtValue.toUpperCase().indexOf(input) > -1) {
         items[i].style.display = "";
       } else {
         items[i].style.display = "none";
       }
    }
  });
});
