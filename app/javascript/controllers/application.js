import { Application } from "@hotwired/stimulus";

const application = Application.start();

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

export { application };

document.addEventListener("turbo:load", () => {
  const flash = document.querySelector("#flash-message");

  if (flash) {
    setTimeout(() => {
      flash.remove();
    }, 3000);
  }
});
