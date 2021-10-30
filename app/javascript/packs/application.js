require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
import "channels"
import "controllers"
import 'bootstrap'
import "stylesheets/application.scss"

const images = require.context('../src/images/', true)
