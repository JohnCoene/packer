import 'shiny';

Shiny.addCustomMessageHandler('#name#-alert', function(msg){
  let response = prompt(msg);
  Shiny.setInputValue('#name#Response', response);
})
