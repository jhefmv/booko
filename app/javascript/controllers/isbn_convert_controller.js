import { Controller } from "@hotwired/stimulus"
import { isbnValid } from "custom_modules/isbn/validate"
import { isbnConvert } from "custom_modules/isbn/convert"

// Connects to data-controller="isbn-convert"
export default class extends Controller {
  static targets = [ "fromIsbn", "toIsbn" ]

  convert(e) {
    e.preventDefault()

    if (isbnValid(this.fromIsbnTarget.value)) {
      this.toIsbnTarget.value = isbnConvert(this.fromIsbnTarget.value)
    }
  }
}
