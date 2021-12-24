import { Controller } from "stimulus"
import SlimSelect from "slim-select"
import "slim-select/dist/slimselect.min.css"

export default class extends Controller {
  connect() {
    this.slimselect = new SlimSelect({
      select: this.element,
      placeholder: this.data.get("placeholder")
    });
  }

  disconnect() {
    this.slimselect.destroy();
  }
}
