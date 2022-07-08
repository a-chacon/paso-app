import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    hcaptcha.render('captcha-1', {
      "sitekey": "5414efad-0154-4a58-9b35-04efdb6405ec"
    });
  }
}
