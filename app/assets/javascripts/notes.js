$(document).on('turbolinks:load', function() {
  $('#note_tag_ids').chosen({
    allow_single_deselect: true,
    placeholder_text: "Select a tag...",
    width: '100%'
  });
  return;
});
