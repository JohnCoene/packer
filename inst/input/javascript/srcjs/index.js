import Shiny from 'shiny';
import $ from 'jquery';
import { trigger } from './modules/trigger.js';

$(document).on("click", "button.#name#Binding", function(evt) {
  trigger(evt);
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
