import $ from 'jquery';
import 'shiny';

var #name#Binding = new Shiny.OutputBinding();

$.extend(#name#Binding, {
  find: (scope) => {
    return $(scope).find(".#name#");
  },
  getId: (el) => {
    return el.id;
  },
  renderValue: (el, data) => {
    $(el).html(data.html);
    $(el).css('color', data.color);
  }
});

Shiny.outputBindings.register(#name#Binding, "#pkgname#.#name#Binding");
