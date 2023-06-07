import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  copy(event) {
    event.preventDefault()
    navigator.clipboard.writeText(window.location.href)
  }
}
