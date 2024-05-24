// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "jquery"
import "@hotwired/turbo-rails"
import "controllers"



$(function() {
  $('.teapot-link').on('mouseenter', function() {
    const images = $(this).find('.teapot-image').data('images');
    let currentIndex = 0;
    const imageCount = images.length;
    const element = $(this).find('.teapot-image');
    const cloudinaryBaseUrl = 'https://res.cloudinary.com/djrrhiw1o/image/upload/v1/development/'; // replace with your Cloudinary cloud name

    const intervalId = setInterval(function() {
      const imageUrl = cloudinaryBaseUrl + images[currentIndex];
      element.css('opacity', '0'); // Start fade out
      setTimeout(() => {
        element.attr('src', imageUrl);
        element.css('opacity', '1'); // Fade in the new image
      }, 500); // Match this duration with the CSS transition duration
      currentIndex = (currentIndex + 1) % imageCount;
    }, 2000); // Change image every 2 seconds

    // Save the interval ID to the element's data to clear it later
    element.data('intervalId', intervalId);
  }).on('mouseleave', function() {
    // Clear the interval when the mouse leaves
    clearInterval($(this).find('.teapot-image').data('intervalId'));
  });
});
