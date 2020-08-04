import $ from 'jquery';
import 'shiny';

var #name#Binding = new Shiny.OutputBinding();

$.extend(#name#Binding, {
  find: function(scope) {
    return $(scope).find(".#name#");
  },
  getId: function(el){
    return el.id;
  },
  renderValue: function(el, data) {
    $(el).html(data.html);
    $(el).css('color', data.color);
  }
});

Shiny.outputBindings.register(#name#Binding, "#pkgname#.#name#Binding");
