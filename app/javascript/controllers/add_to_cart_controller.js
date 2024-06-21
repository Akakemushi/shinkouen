import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("Add to Cart controller connected.");
  }

  add(event) {
    event.preventDefault();
    const form = event.target.closest("form");

    fetch(form.action, {
      method: "POST",
      body: new FormData(form),
      headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
        "Accept": "application/json"
      }
    })
    .then(response => response.json())
    .then(data => {
      if (data.message === "Teapot successfully added to your cart.") {
        form.innerHTML = `
          <input type="hidden" name="teapot_id" value="${form.querySelector('input[name="teapot_id"]').value}">
          <input type="submit" value="Remove from Cart" class="small-action-button" data-action="click->remove-from-cart#remove">
        `;
        form.setAttribute("data-controller", "remove-from-cart");
      }
    })
    .catch(error => {
      console.error("Error:", error);
    });
  }
}
