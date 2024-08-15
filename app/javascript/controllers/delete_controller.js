import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { teapotId: Number }

  confirm() {
    if (confirm("Are you sure you want to remove this teapot from the database?")) {
      this.deleteTeapot()
    }
  }

  deleteTeapot() {
    const teapotId = this.teapotIdValue;
    const token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');

    fetch(`/teapots/${teapotId}`, {
      method: 'DELETE',
      headers: {
        'X-CSRF-Token': token
      },
      redirect: 'follow'
    })
    .then(response => {
      if (response.redirected) {
        // If the response was redirected, navigate to the new URL.  This line wasn't present in previous versions and that caused problems
        window.location.href = response.url;
      } else if (response.ok) {
        window.location.href = '/teapots';
      } else {
        return response.json().then(data => {
          alert(data.error || 'There was an error deleting the teapot.');
        });
      }
    })
    .catch(error => {
      console.error('Fetch error:', error);
      alert('There was an error processing the request.');
    });
  }
}
