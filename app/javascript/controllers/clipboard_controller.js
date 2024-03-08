import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "source" ]
    static classes = [ "supported" ]

  copy() {
    event.preventDefault()
    if ("clipboard" in navigator) {
        this.element.classList.add(this.supportedClass);
      }
    navigator.clipboard.writeText(this.sourceTarget.value)
  }
}