import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["list", "map", "lbtn", "mbtn"];

  displayMap() {
    this.mapTarget.classList.remove("d-none")
    this.listTarget.classList.add("d-none")
    this.lbtnTarget.classList.remove("second-button")
    this.lbtnTarget.classList.add("third-button")
    this.mbtnTarget.classList.add("second-button")
    this.mbtnTarget.classList.remove("third-button")
  }

  displayIndex() {
    this.mapTarget.classList.add("d-none")
    this.listTarget.classList.remove("d-none")
    this.lbtnTarget.classList.add("second-button")
    this.lbtnTarget.classList.remove("third-button")
    this.mbtnTarget.classList.remove("second-button")
    this.mbtnTarget.classList.add("third-button")
  }
}
