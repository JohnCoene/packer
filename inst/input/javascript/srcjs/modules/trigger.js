import $ from 'jquery';

const trigger = function(evt){
  // evt.target is the button that was clicked
  var el = $(evt.target);

  // Set the button's text to its current value plus 1
  el.text(parseInt(el.text()) + 1);

  // Raise an event to signal that the value changed
  el.trigger("change");
}

export { trigger };
