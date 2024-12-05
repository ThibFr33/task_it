import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="submit-photo"
export default class extends Controller {
  submitFormPhoto(event) {
    this.element.submit()
  }
}
