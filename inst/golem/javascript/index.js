import { message } from './modules/message.js';
import Shiny from 'shiny';

// In shiny server use:
// session$sendCustomMessage('show-packer', 'hello packer!')
Shiny.addMessageHandler('show-packer', (msg) => {
  message(msg);
})
