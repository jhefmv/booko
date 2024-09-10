import { Controller } from "@hotwired/stimulus"
import { get } from '@rails/request.js'
import { isbnValid } from "custom_modules/isbn/validate"

export default class extends Controller {
  static targets = ["isbn"]

  showToast(msg) {
    const isbnToastEl = document.getElementById('isbnToast')
    const isbnToast = bootstrap.Toast.getOrCreateInstance(isbnToastEl)
    document.getElementById('isbnToastMessage').innerText = msg
    isbnToast.show()
  }
 
  async search(e) {
    const isbn = this.isbnTarget.value

    e.preventDefault()

    if (isbnValid(isbn)) {
      const response = await get(`/isbn/${isbn}`, {responseKind: "json"})
                                .then((response) => response.json)
      const isbn13 = response?.data?.attributes?.isbn13
      if (isbn13) window.location.href = `/book/${isbn13}`
      else {
        this.showToast("Book not found")
      }
    } else {
      this.showToast("Invalid ISBN")
    }
  }
}
