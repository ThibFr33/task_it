import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="submit-task"
export default class extends Controller {
  connect() {
    console.log("hello from submit_task")
  }
  submit() {
    this.element.submit()

  }
}
