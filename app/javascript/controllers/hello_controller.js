import { Controller } from "@hotwired/stimulus"
console.log("Aqui esta el error");

export default class extends Controller {
  connect() {
    this.element.textContent = "Hello World!"
  }
}
