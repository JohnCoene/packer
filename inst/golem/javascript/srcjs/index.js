import { message } from './modules/message.js';

// In shiny server use:
// session$sendCustomMessage('show-packer', 'hello packer!')
Shiny.addMessageHandler('show-packer', (msg) => {
  message(msg);
})
