import { application } from "./application"

import ClipboardController from "./clipboard_controller"
application.register("clipboard", ClipboardController)

import NotificationsController from "./notifications_controller"
application.register("notifications", NotificationsController)

