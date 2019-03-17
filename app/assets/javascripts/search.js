function search(searchBarId, itemClass) {
  $(searchBarId).keyup(function(){
    var input = this.value.toUpperCase();
    var items = document.getElementsByClassName(itemClass);
    for(var i = 0; i < items.length; i++) {
       var txtValue = items[i].innerText;
       if(txtValue.toUpperCase().indexOf(input) > -1) {
         items[i].style.display = "";
       } else {
         items[i].style.display = "none";
       }
    }
  });
}

$(document).on('turbolinks:load', function() {
   search('#search', 'item');
   search('#note-search', 'note-item') ;
});
