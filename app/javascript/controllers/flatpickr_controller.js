import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"
import "flatpickr/dist/l10n/fr.js"

// Connects to data-controller="datepicker"
export default class extends Controller {
  static values = {endDate: String }
  connect() {

    flatpickr(this.element, {
    dateFormat: "d-m-Y",
    defaultDate: new Date(this.endDateValue),
    disableMobile: true,
    "locale": "fr",
    })
  }
}
