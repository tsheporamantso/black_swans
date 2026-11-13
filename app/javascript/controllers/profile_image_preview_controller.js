import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "preview", "placeholder", "error"];

  preview() {
    const file = this.inputTarget.files[0];

    if (!file) return;

    // Make sure the selected file is an image
    if (!file.type.startsWith("image/")) {
      this.inputTarget.value = "";
      this.errorTarget.textContent = "Please select a valid image.";
      this.errorTarget.classList.remove("hidden");
      return;
    }

    // Clear previous error messages
    this.errorTarget.classList.add("hidden");

    // Release the previous preview URL
    if (this.previewUrl) {
      URL.revokeObjectURL(this.previewUrl);
    }

    // Create a temporary URL for the selected image
    this.previewUrl = URL.createObjectURL(file);

    // Update the image preview
    this.previewTarget.src = this.previewUrl;
    this.previewTarget.classList.remove("hidden");

    // Hide the placeholder
    this.placeholderTarget.classList.add("hidden");
  }

  disconnect() {
    if (this.previewUrl) {
      URL.revokeObjectURL(this.previewUrl);
    }
  }
}
