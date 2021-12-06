import 'bootstrap';

require('@rails/ujs').start();
require('turbolinks').start();
require('@rails/activestorage').start();
require('channels');
require('jquery');

require('./confirm');
require('./signup');
require('./select2');
require('./cart_item');
require('./city_state');
global.$ = jQuery;

require('trix');
require('@rails/actiontext');
