function includes(textToSearch, value){
    return textToSearch.toUpperCase().indexOf(value) > -1;
}

function hide(element){
  element.style.display = "none";
}

function show(element){
  element.style.display = "";
}

function search(searchBarId, itemClass) {
  $(searchBarId).keyup(function(){
    var input = this.value.toUpperCase();
    var items = document.getElementsByClassName(itemClass);
    for(var i = 0; i < items.length; i++) {
       var txtValue = items[i].innerText;
       if(includes(txtValue, input)) {
         show(items[i]);
       } else {
         hide(items[i]);
       }
    }
  });
}

$(document).on('turbolinks:load', function() {
   search('#search', 'item');
   search('#note-search', 'note-item') ;
});
