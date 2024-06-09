import { Application } from "@hotwired/stimulus"
import TeapotSlidesController from "./teapot_slides_controller.js"

const application = Application.start();

application.debug = false;
window.Stimulus   = application;
Stimulus.register("teapot-slides", TeapotSlidesController);


export { application };
