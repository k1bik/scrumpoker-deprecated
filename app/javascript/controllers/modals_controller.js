import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal"]

  close() {
    const modal = document.getElementById("modal")
    modal.innerHTML = ""
    modal.removeAttribute("src")
    modal.removeAttribute("complete")
  }

  closeWithKeyboard(e) {
    if (e.code == "Escape") this.close()
  }

  closeBackground(e) {
    if (e && this.modalTarget.contains(e.target)) return
  
    this.close()
  }
}
