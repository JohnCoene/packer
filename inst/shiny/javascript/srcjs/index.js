import { message } from './modules/message.js';

Shiny.addCustomMessageHandler('#name#-alert', (msg) => {
  message(msg);
})
