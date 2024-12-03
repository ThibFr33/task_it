import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"

// Connects to data-controller="timepicker"
export default class extends Controller {
  static values = { hour: String, minutes: String }
  connect() {

    flatpickr(this.element, {
      enableTime: true,
      noCalendar: true,
      dateFormat: "H:i",
      disableMobile: true,
      defaultHour: this.hourValue,
      defaultMinute: this.minutesValue,
      time_24hr: true
    })
  }
}
