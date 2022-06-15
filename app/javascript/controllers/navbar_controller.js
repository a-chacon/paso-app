import {
  Controller
} from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  connect() {
    console.log("navbar controller conected.")
  }

  toggle_menu(event) {
    if (this.menuTarget.classList.contains("hidden")) {
      this.menuTarget.classList.add("fadeIn");
      this.menuTarget.classList.remove("hidden");
    } else {
      this.menuTarget.classList.remove("fadeIn");
      this.menuTarget.classList.add("hidden");
    }
  }
}
