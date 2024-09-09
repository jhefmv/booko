import { Controller } from "@hotwired/stimulus"
import { FetchRequest, get } from '@rails/request.js'

// Connects to data-controller="isbn-search"
export default class extends Controller {
  static targets = ["isbn"]
 
  async search(e) {
    const isbn = this.isbnTarget.value

    e.preventDefault();

    const response = await get(`/isbn/${isbn}`, {responseKind: "json"})
                      .then((response) => response.json)
    if (response["data"]) {
      console.log("response: ", response.json);
      const data = response["data"],
        isbn = data && data["attributes"] && data["attributes"]["isbn13"];
      if (isbn) window.location = `/book/${isbn}`;
    }
  }
}
