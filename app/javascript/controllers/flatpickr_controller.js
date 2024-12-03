import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"
import "flatpickr/dist/l10n/fr.js"

// Connects to data-controller="datepicker"
export default class extends Controller {
  connect() {
    flatpickr(this.element, {
    dateFormat: "Y-d-m",
    disableMobile: true,
    "locale": "fr",
    })
  }
}
