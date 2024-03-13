// app/javascript/controllers/copy_url_controller.js
import { Controller } from "stimulus";

export default class extends Controller {
  connect() {
    console.log("CopyUrlController initialized");
  }

  copy() {
    console.log("Button clicked");
    const url = window.location.href;
    navigator.clipboard.writeText(url).then(() => {
      alert("URL copied to clipboard!");
    });
  }
}
