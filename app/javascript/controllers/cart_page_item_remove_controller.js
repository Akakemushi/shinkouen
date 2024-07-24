import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["cartItem", "totalPrice"];

  connect() {
    console.log("Cart page item remove controller connected.");
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
        // Remove the item from the UI
        form.closest('.cart-item').remove();
        // Update total price
        this.updateTotalPrice();
      }
    })
    .catch(error => {
      console.error("Error:", error);
    });
  }

  updateTotalPrice() {
    if (this.hasTotalPriceTarget) {
      fetch("/cart_items/total_price")
        .then(response => {
          if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
          }
          return response.json();
        })
        .then(data => {
          this.totalPriceTarget.innerHTML = `<p>Total Price: ${data.total_price}</p>`;
        })
        .catch(error => {
          console.error("Error fetching total price:", error);
          return error.response.text().then(text => {
            console.error("Response text:", text);
          });
        });
    } else {
      console.error("Missing target element 'totalPrice' for 'cart-page-item-remove' controller.");
    }
  }
}
