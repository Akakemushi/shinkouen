import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("Remove from Cart controller connected.");
  }

  remove(event) {
    event.preventDefault();
    const form = event.target.closest("form");
    const cartItemId = form.querySelector('input[name="cart_item_id"]').value;

    fetch(`/cart_items/${cartItemId}`, {
      method: "DELETE",
      headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
        "Accept": "application/json"
      }
    })
    .then(response => {
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      return response.json();
    })
    .then(data => {
      if (data.message === "Teapot removed from your cart.") {
        form.innerHTML = `
          <input type="hidden" name="teapot_id" value="${form.querySelector('input[name="teapot_id"]').value}">
          <input type="submit" value="Add to Cart" class="stretchy-action-button" data-action="click->add-to-cart#add">
        `;
        form.setAttribute("data-controller", "add-to-cart");
        form.action = `/cart_items`; // Update the form action
      }
    })
    .catch(error => {
      console.error("Error:", error);
    });
  }
}
