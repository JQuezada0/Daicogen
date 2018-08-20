/* ---------------------------------------------
 common scripts
 --------------------------------------------- */

;(function () {

    "use strict"; // use strict to start


    /* ---------------------------------------------
     wow animation
     --------------------------------------------- */

    new WOW().init();

    if ($(window).width() <= 991){
        $(".wow").removeClass("wow");
    }


    /* ---------------------------------------------
     Smooth scrolling using jQuery easing
     --------------------------------------------- */

    $('a.js-scroll-trigger[href*="#"]:not([href="#"])').on('click', function() {
        if (location.pathname.replace(/^\//, '') == this.pathname.replace(/^\//, '') && location.hostname == this.hostname) {
            var target = $(this.hash);
            target = target.length ? target : $('[name=' + this.hash.slice(1) + ']');
            if (target.length) {
                target.css('paddingTop','50px');
                $('html, body').animate({
                    scrollTop: (target.offset().top)
                }, 1000, "easeInOutExpo");
                return false;
            }
        }
    });

    // Closes responsive menu when a scroll trigger link is clicked
    $('.js-scroll-trigger').on('click', function() {
        $('.navbar-collapse').collapse('hide');
    });

    $('.dropdown-item').on('click', function() {
        $('.dropdown-menu').removeClass('show');
    });

    // Activate scrollspy to add active class to navbar items on scroll
    $('body').scrollspy({
        target: '#mainNav'
    });


    /* ---------------------------------------------
     add sticky
     --------------------------------------------- */

    $(window).on('scroll', function () {
        var wSize = $(window).width();
        if (wSize > 767 && $(this).scrollTop() > 1) {
            $('.app-header').addClass("navbar-sticky");
        }
        else {
            $('.app-header').removeClass("navbar-sticky");
        }
    });


    /* ---------------------------------------------
     steps carousel
     --------------------------------------------- */

    $('.js_steps_carousel').owlCarousel({
        loop: true,
        margin: 0,
        autoplay: true,
        nav:false,
        //navText: ["<a><span></span></a>","<a><span></span></a>"],
        autoHeight:true,
        dots: true,
        dotsData: true,
        //animateOut: 'slideOutUp',
        //animateIn: 'slideInUp',
        responsive: {
            0: {
                items: 1
            },
            600: {
                items: 1
            },
            1000: {
                items: 1
            }
        }
    });

    /* ---------------------------------------------
     team carousel
     --------------------------------------------- */

    $('.js_team_member').owlCarousel({
        items: 4,
        loop: true,
        margin: 5,
        autoplay: true,
        nav:false,
        //navText: ["<a><span></span></a>","<a><span></span></a>"],
        autoHeight:true,
        dots: true,
        //animateOut: 'slideOutUp',
        //animateIn: 'slideInUp',
        responsive: {
            0: {items: 1, margin: 10},
            480: {items: 2, margin: 10, center: true},
            599: {items: 2,  margin: 10},
            768: {items: 3},
            1170: {items: 4}
        }
    });

    /* ---------------------------------------------
     advisory board carousel
     --------------------------------------------- */

    $('.js_advisory_board').owlCarousel({
        loop: true,
        margin: 0,
        autoplay: true,
        nav:false,
        //navText: ["<a><span></span></a>","<a><span></span></a>"],
        autoHeight:true,
        dots: true,
        dotsData: true,
        //animateOut: 'slideOutUp',
        //animateIn: 'slideInUp',
        responsive: {
            0: {
                items: 1
            },
            600: {
                items: 1
            },
            1000: {
                items: 1
            }
        }
    });

    /* ---------------------------------------------
     road map carousel
     --------------------------------------------- */

    $('.js_road_map').owlCarousel({
        items: 5,
        nav: true,
        dots: true,
        margin: 30,
        navText: ["<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>"],
        responsive: {
            0: {items: 1},
            400: {items: 2, center: true},
            599: {items: 3},
            1024: {items: 4},
            1170: {items: 5}
        }
    });

    /*==============================================
     Countdown
     ===============================================*/

    $('#counting-date').countdown('2020/10/10').on('update.countdown', function(event) {
        var $this = $(this).html(event.strftime(''
        + '<div class="count-block"><h2>%D</h2> <span>Days</span></div>' + '<span class="colon">:</span>'
        + '<div class="count-block"><h2>%H</h2> <span>Hours</span> </div>' + '<span class="colon">:</span>'
        + '<div class="count-block"><h2>%M</h2> <span>Minutes</span> </div>' + '<span class="colon">:</span>'
        + '<div class="count-block"><h2>%S</h2> <span>Seconds</span></div>'));
    });


    /*==============================================
     magnific popup
     ===============================================*/

    $(".popup-youtube, .popup-vimeo, .popup-gmaps").magnificPopup({
        disableOn: 700,
        type: "iframe",
        mainClass: "mfp-fade",
        removalDelay: 160,
        preloader: false,
        fixedContentPos: false
    });



})(jQuery);