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

    // Preload images
    images.forEach((key) => {
      const img = new Image();
      img.src = cloudinaryBaseUrl + key;
    });

    // Clear any existing interval
    if (element.data('intervalId')) {
      clearInterval(element.data('intervalId'));
    }

    const intervalId = setInterval(function() {
      currentIndex = (currentIndex + 1) % imageCount; // Update currentIndex before using it
      const imageUrl = cloudinaryBaseUrl + images[currentIndex];

      // Fade out current image, update src, fade in next image
      element.fadeOut(500, function() {
        element.attr('src', imageUrl).fadeIn(500);
      });

    }, 3000); // Change image every 3 seconds

    // Save the interval ID to the element's data to clear it later
    element.data('intervalId', intervalId);
  }).on('mouseleave', function() {
    // Clear the interval when the mouse leaves
    const element = $(this).find('.teapot-image');
    clearInterval(element.data('intervalId'));
    element.removeData('intervalId'); // Remove the interval ID data

    const images = element.data('images');
    const initialImage = images[0];
    const cloudinaryBaseUrl = 'https://res.cloudinary.com/djrrhiw1o/image/upload/v1/development/'; // replace with your Cloudinary cloud name

    // Reset to the initial image immediately
    element.attr('src', cloudinaryBaseUrl + initialImage).css('opacity', '1');
  });
});


