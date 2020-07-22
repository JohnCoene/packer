import { toggle } from './modules/toggle.js';

// In shiny server use:
// session$sendCustomMessage('show-packer', 'elementId')
Shiny.addMessageHandler('show-packer', (msg) => {
  toggle(msg);
})
