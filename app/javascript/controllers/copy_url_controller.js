import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="copy-url"
export default class extends Controller {
  copy(event) {
    event.preventDefault();
    const button = event.currentTarget;
    const url = button.dataset.url;

    navigator.clipboard.writeText(url)
      .then(() => {
        console.log('URL copied to clipboard:', url);
        alert('URL copied to clipboard: ' + url);
      })
      .catch(err => {
        console.error('Failed to copy URL: ', err);
        alert('Failed to copy URL: ' + err);
      });
  }
}
