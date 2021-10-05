import 'shiny';

// In shiny server use:
// session$sendCustomMessage('packer-alert', 'hello packer!')
Shiny.addCustomMessageHandler('packer-alert', (msg) => {
  alert(msg)
});
