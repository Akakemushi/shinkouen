import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { teapotId: Number }

  confirm() {
    if (confirm("Are you sure you want to remove this teapot from the database?")) {
      this.deleteTeapot()
    }
  }

  deleteTeapot() {
    const teapotId = this.teapotIdValue
    const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content')

    fetch(`/teapots/${teapotId}`, {
      method: 'DELETE',
      headers: {
        'X-CSRF-Token': token,
        'Content-Type': 'application/json'
      }
    })
    .then(response => {
      if (response.ok) {
        window.location.href = '/teapots'
      } else {
        alert('There was an error deleting the teapot.')
      }
    })
  }
}
