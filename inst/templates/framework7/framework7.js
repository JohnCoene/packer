// Import Framework7
import Framework7 from 'framework7';
// Import Framework7 Styles
import 'framework7/framework7-bundle.min.css';

import App from './components/app.f7.jsx';
let app = new Framework7({
  el: '#app',
  theme: 'ios',
  // specify main app component
  component: App
});