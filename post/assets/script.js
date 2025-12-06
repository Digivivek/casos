// Mobile Navigation Toggle
const navToggle = document.querySelector('.nav__toggle');
const navList = document.querySelector('.nav__list');

if (navToggle && navList) {
  navToggle.addEventListener('click', () => {
    navList.classList.toggle('nav__list--active');
    navToggle.innerHTML = navList.classList.contains('nav__list--active') 
      ? '&times;' 
      : '&#9776;';
  });
}

// Active Link Highlighting
function setActiveLink() {
  const currentPage = window.location.pathname.split('/').pop() || 'index.html';
  const navLinks = document.querySelectorAll('.nav__link');
  
  navLinks.forEach(link => {
    const linkHref = link.getAttribute('href');
    if (linkHref === currentPage || 
        (currentPage === 'index.html' && linkHref === '../index.html')) {
      link.classList.add('nav__link--active');
    } else {
      link.classList.remove('nav__link--active');
    }
  });
}

// Smooth Scrolling for Internal Anchors
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
  anchor.addEventListener('click', function (e) {
    e.preventDefault();
    
    const targetId = this.getAttribute('href');
    if (targetId === '#') return;
    
    const targetElement = document.querySelector(targetId);
    if (targetElement) {
      window.scrollTo({
        top: targetElement.offsetTop - 80,
        behavior: 'smooth'
      });
      
      // Close mobile menu if open
      if (navList && navList.classList.contains('nav__list--active')) {
        navList.classList.remove('nav__list--active');
        navToggle.innerHTML = '&#9776;';
      }
    }
  });
});

// Cookie Consent Banner
function initCookieConsent() {
  const consentBanner = document.getElementById('cookieConsent');
  const acceptBtn = document.getElementById('acceptCookies');
  const declineBtn = document.getElementById('declineCookies');
  
  // Check if user has already made a choice
  if (!localStorage.getItem('cookieConsent')) {
    // Show banner after a short delay
    setTimeout(() => {
      if (consentBanner) consentBanner.style.display = 'block';
    }, 1000);
  }
  
  // Handle accept button
  if (acceptBtn) {
    acceptBtn.addEventListener('click', () => {
      localStorage.setItem('cookieConsent', 'accepted');
      if (consentBanner) consentBanner.style.display = 'none';
    });
  }
  
  // Handle decline button
  if (declineBtn) {
    declineBtn.addEventListener('click', () => {
      localStorage.setItem('cookieConsent', 'declined');
      if (consentBanner) consentBanner.style.display = 'none';
    });
  }
}

// Initialize all functionality when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
  setActiveLink();
  initCookieConsent();
});