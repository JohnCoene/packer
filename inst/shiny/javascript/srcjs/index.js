import { message } from './modules/message.js';
import Shiny from 'shiny';

Shiny.addCustomMessageHandler('#name#-alert', (msg) => {
  message(msg);
})
