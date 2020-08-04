import $ from 'jquery';
import 'shiny';

$(document).on("click", "button.#name#Binding", function(evt) {
  // evt.target is the button that was clicked
  var el = $(evt.target);

  // Set the button's text to its current value plus 1
  el.text(parseInt(el.text()) + 1);

  // Raise an event to signal that the value changed
  el.trigger("change");
});

var #name#Binding = new Shiny.InputBinding();

$.extend(#name#Binding, {
  find: function(scope) {
    return $(scope).find(".#name#Binding");
  },
  getValue: function(el) {
    return parseInt($(el).text());
  },
  setValue: function(el, value) {
    $(el).text(value);
  },
  subscribe: function(el, callback) {
    $(el).on("change.#name#Binding", function(e) {
      callback();
    });
  },
  unsubscribe: function(el) {
    $(el).off(".#name#Binding");
  }
});

Shiny.inputBindings.register(#name#Binding, "#pkgname#.#name#Binding");
