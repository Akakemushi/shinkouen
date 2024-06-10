import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["slide"];

  connect() {
    console.log("Teapot controller connected.");
    this.index = 0;
    this.slides = this.slideTargets;
    this.total = this.slides.length;
  }

  startSlideshow() {
    this.slides[this.index].classList.remove('teapot-image-hidden');
    this.slides[this.index].classList.add('teapot-image');
    this.slideshow = setInterval(() => {
      this.nextSlide();
    }, 2000);
  }

  nextSlide() {
    this.slides[this.index].classList.remove('teapot-image');
    this.slides[this.index].classList.add('teapot-image-hidden');
    this.index = (this.index + 1) % this.total;
    this.slides[this.index].classList.remove('teapot-image-hidden');
    this.slides[this.index].classList.add('teapot-image');
  }

  stopSlideshow() {
    console.log("Exited image, not hovering.");
    clearInterval(this.slideshow);
    this.resetSlides();
  }

  resetSlides() {
    this.slides.forEach((slide, i) => {
      slide.classList.remove('teapot-image');
      slide.classList.add('teapot-image-hidden');
    });
    this.slides[0].classList.remove('teapot-image-hidden');
    this.slides[0].classList.add('teapot-image');
    this.index = 0;
  }
}
