import { Application } from "@hotwired/stimulus"
import TeapotSlidesController from "./teapot_slides_controller.js"
import AddToCartController from "./add_to_cart_controller.js"
import RemoveFromCartController from "./remove_from_cart_controller.js"
import CartPageItemRemoveController from "./cart_page_item_remove_controller.js"
import StripeController from "./stripe_controller.js"
import DeleteController from "./delete_controller.js"
import SearchController from "./search_controller.js"

const application = Application.start();

application.debug = false;
window.Stimulus   = application;
Stimulus.register("teapot-slides", TeapotSlidesController);
Stimulus.register("add-to-cart", AddToCartController);
Stimulus.register("remove-from-cart", RemoveFromCartController);
Stimulus.register("cart-page-item-remove", CartPageItemRemoveController);
Stimulus.register("stripe", StripeController);
Stimulus.register("delete", DeleteController);
Stimulus.register("search", SearchController);


export { application };
