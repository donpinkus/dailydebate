var selectizeControl;

$(document).ready(function(){
  var options = [];

  gon.categories.forEach(function(category) {
    var option = {value: category["name"], text: category["name"] };
    options.push(option);
  });

  var $selectize = $('#categories').selectize({
    delimiter: ',',
    persist: false,
    plugins: ['remove_button'],
    selectOnTab: true,
    create: function(input) {
      return {
        value: input,
        text: input
      }
    },
    options: options
  });

  selectizeControl = $selectize[0].selectize;

  $("#new_topic").submit(function(e){
    var categories_json = JSON.stringify(selectizeControl.getValue());
    console.log(categories_json);
    $("#topic_categories").val(categories_json);
  });
});
