import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="edit"
export default class extends Controller {
  static targets =["listTitle","editForm"]
  connect() {
    console.log("hello from edit")
    console.log(this.editFormTarget)
  }
  addOnClick() {
    this.listTitleTarget.classList.add("d-none")
    this.editFormTarget.classList.remove("d-none")
  }


}
