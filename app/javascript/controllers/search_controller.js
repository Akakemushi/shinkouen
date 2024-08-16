import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["inputContainer"]
  static values = {
    makers: Array,
    styles: Array,
    materials: Array
  }

  connect() {
    this.updateForm()  // Initialize the form based on the default selection
  }

  updateForm() {
    const searchBy = this.element.querySelector('input[name="search_by"]:checked').value;
    this.inputContainerTarget.innerHTML = this.getSearchInputHtml(searchBy);
  }

  getSearchInputHtml(searchBy) {
    switch (searchBy) {
      case 'price':
        return `
          <label>Price:</label>
          <select name="price_condition">
            <option value="less_than">Less than</option>
            <option value="more_than">More than</option>
          </select>
          <input type="number" name="price" placeholder="Enter price" />
        `;
      case 'maker':
        return `
          <label>Maker:</label>
          <select name="maker">
            ${this.makersValue.map(maker => `<option value="${maker}">${maker}</option>`).join("")}
          </select>
        `;
      case 'style':
        return `
          <label>Style:</label>
          <select name="style">
            ${this.stylesValue.map(style => `<option value="${style}">${style}</option>`).join("")}
          </select>
        `;
      case 'material':
        return `
          <label>Material:</label>
          <select name="material">
            ${this.materialsValue.map(material => `<option value="${material}">${material}</option>`).join("")}
          </select>
        `;
      case 'capacity':
        return `
          <label>Capacity:</label>
          <select name="capacity_condition">
            <option value="less_than">Less than</option>
            <option value="more_than">More than</option>
          </select>
          <input type="number" name="capacity" placeholder="Enter capacity in cc" />
        `;
      default:
        return '';
    }
  }
}
