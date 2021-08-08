import { message } from './modules/message.js';
import 'shiny';

// In shiny server use:
// session$sendCustomMessage('show-packer', 'hello packer!')
Shiny.addCustomMessageHandler('show-packer', (msg) => {
  message(msg.text);
})