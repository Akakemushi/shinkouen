// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"


$(document).ready(function() {
  let currentIndex = 0;
  const images = $('.carousel-image');
  const imageCount = images.length;

  $('.carousel-container').hover(
    function() {
      startCarousel();
    },
    function() {
      stopCarousel();
    }
  );

  let carouselInterval;

  function startCarousel() {
    carouselInterval = setInterval(function() {
      images.eq(currentIndex).removeClass('active');
      currentIndex = (currentIndex + 1) % imageCount;
      images.eq(currentIndex).addClass('active');
    }, 3000); // Change image every 3 seconds
  }

  function stopCarousel() {
    clearInterval(carouselInterval);
  }
});
