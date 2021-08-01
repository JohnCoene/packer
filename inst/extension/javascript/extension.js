import 'shiny';

Shiny.addCustomMessageHandler('#name#-alert', (msg) => {
  let response = prompt(msg);
  Shiny.setInputValue('#name#Response', response);
})
