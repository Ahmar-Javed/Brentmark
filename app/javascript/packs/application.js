import 'bootstrap';
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")
import $ from 'jquery'
require('./confirm')
require('./new')
require('./select2')
require('./cart_item')
require('./city_state')
global.$ = jQuery;
require ('allow_numeric')

require("trix")
require("@rails/actiontext")
