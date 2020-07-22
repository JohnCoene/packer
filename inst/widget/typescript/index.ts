import { asHeader } from './modules/header';
import { HTMLWidgets } from './modules/htmlwidgets';

HTMLWidgets.widget({

  name: '#name#',

  type: 'output',

  factory: function(el: any, width: number, height: number) {

    // TODO: define shared variables for this instance

    return {

      renderValue: function(x: any) {

        // TODO: code to render the widget, e.g.
        el.innerHTML = asHeader(x.message);

      },

      resize: function(width: number, height: number) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
