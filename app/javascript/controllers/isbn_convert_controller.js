import { Controller } from "@hotwired/stimulus"
import { isbnValid } from "custom_modules/isbn/validate"
import { isbnConvert } from "custom_modules/isbn/convert"

// Connects to data-controller="isbn-convert"
export default class extends Controller {
  static targets = [ "fromIsbn", "toIsbn" ]

  invalidateFormInput(msg) {
    const isbnErrorEl = document.getElementById('validationIsbnFeedback')
    isbnErrorEl.innerText = msg
    this.fromIsbnTarget.classList.add("is-invalid")
  }

  convert(e) {
    e.preventDefault()

    const fromIsbn = this.fromIsbnTarget.value

    if (!fromIsbn) {
      this.invalidateFormInput("ISBN is required")
    } else {
      if (isbnValid(this.fromIsbnTarget.value)) {
        this.toIsbnTarget.value = isbnConvert(this.fromIsbnTarget.value)
        this.toIsbnTarget.classList.add("is-valid")
      } else {
        this.invalidateFormInput("ISBN is invalid")
      }
    }
  }
}
