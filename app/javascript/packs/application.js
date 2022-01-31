import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "controllers"
import "./sweetalert.js"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import 'bootstrap'
import "stylesheets/application.scss"

const images = require.context('../src/images/', true)
