jQuery.extend( jQuery.easing,
{
    def: 'easeOutQuad',
    easeInOutExpo: function (x, t, b, c, d) {
        if (t==0) return b;
        if (t==d) return b+c;
        if ((t/=d/2) < 1) return c/2 * Math.pow(2, 10 * (t - 1)) + b;
        return c/2 * (-Math.pow(2, -10 * --t) + 2) + b;
    }
});

!function ($) {

  $(function(){

    $('[data-ride="animated"]').appear();
    if( !$('html').hasClass('ie no-ie10') ) {
        $('[data-ride="animated"]').addClass('appear');
        $('[data-ride="animated"]').on('appear', function() {
            var $el = $(this), $ani = ($el.data('animation') || 'fadeIn'), $delay;
            if ( !$el.hasClass('animated') ) {
                $delay = $el.data('delay') || 0;
                setTimeout(function(){
                    $el.removeClass('appear').addClass( $ani + " animated" );
                }, $delay);
            }
        });
    };
    
    $(document).on('click.app','[data-ride="scroll"]',function (e) {
        e.preventDefault();
        var $target = this.hash;
        $('html, body').stop().animate({
            'scrollTop': $($target).offset().top
        }, 1000, 'easeInOutExpo', function () {
            window.location.hash = $target;
        });
    });
    
  });
}(window.jQuery);


// Google maps
//---------------------------------------------

function rgb2hex(rgb){
    rgb = rgb.match(/^rgba?[\s+]?\([\s+]?(\d+)[\s+]?,[\s+]?(\d+)[\s+]?,[\s+]?(\d+)[\s+]?/i);
    return (rgb && rgb.length === 4) ? "#" +
    ("0" + parseInt(rgb[1], 10).toString(16)).slice(-2) +
    ("0" + parseInt(rgb[2], 10).toString(16)).slice(-2) +
    ("0" + parseInt(rgb[3], 10).toString(16)).slice(-2) : '';
}

var gmMapDiv = $("#map-canvas");

var gmCenterAddress = gmMapDiv.attr("data-address");
var gmMarkerAddress = gmMapDiv.attr("data-address");
var gmText = gmMapDiv.attr("data-text");
var gmColor = rgb2hex(gmMapDiv.css("background-color"));
    
function gmInit(){
    gmMapDiv.initMap({
        
        /* *****Enter Your Address Here ***** */
        center: gmCenterAddress,
        
        markers : {
            /* *****Enter Your Point Address Here ***** */
            marker_1: { 
                position: gmMarkerAddress,
                options : { icon: "images/favicon.png" },
                info_window : { content : gmText,maxWidth: 240, zIndex: 2} 
            }
        },
        
        type: "roadmap",
        
        // Google Maps Api Options
            options: {
                zoom: 14,
                zoomControl: true,
                zoomControlOptions: { style: google.maps.ZoomControlStyle.SMALL },
                disableDoubleClickZoom: false,
                mapTypeControl: false,
                scaleControl: false,
                scrollwheel: false,
                streetViewControl: false,
                draggable : true,
                overviewMapControl: false,
                overviewMapControlOptions: {
                opened: false
            },
            styles: [{
                "featureType": "water",
                "elementType": "geometry",
                "stylers": [{
                    "color": gmColor
                }, {
                    "lightness": 17
                }]
            }, {
                "featureType": "landscape",
                "elementType": "geometry",
                "stylers": [{
                    "color": gmColor
                }, {
                    "lightness": 20
                }]
            }, {
                "featureType": "road.highway",
                "elementType": "geometry.fill",
                "stylers": [{
                    "color": gmColor
                }, {
                    "lightness": 17
                }]
            }, {
                "featureType": "road.highway",
                "elementType": "geometry.stroke",
                "stylers": [{
                    "color": gmColor
                }, {
                    "lightness": 29
                }, {
                    "weight": 0.2
                }]
            }, {
                "featureType": "road.arterial",
                "elementType": "geometry",
                "stylers": [{
                    "color": gmColor
                }, {
                    "lightness": 18
                }]
            }, {
                "featureType": "road.local",
                "elementType": "geometry",
                "stylers": [{
                    "color": gmColor
                }, {
                    "lightness": 16
                }]
            }, {
                "featureType": "poi",
                "elementType": "geometry",
                "stylers": [{
                    "color": gmColor
                }, {
                    "lightness": 21
                }]
            }, {
                "elementType": "labels.text.stroke",
                "stylers": [{
                    "visibility": "on"
                }, {
                    "color": gmColor
                }, {
                    "lightness": 16
                }]
            }, {
                "elementType": "labels.text.fill",
                "stylers": [{
                    "saturation": 36
                }, {
                    "color": gmColor
                }, {
                    "lightness": 40
                }]
            }, {
                "elementType": "labels.icon",
                "stylers": [{
                    "visibility": "off"
                }]
            }, {
                "featureType": "transit",
                "elementType": "geometry",
                "stylers": [{
                    "color": gmColor
                }, {
                    "lightness": 19
                }]
            }, {
                "featureType": "administrative",
                "elementType": "geometry.fill",
                "stylers": [{
                    "color": gmColor
                }, {
                    "lightness": 20
                }]
            }, {
                "featureType": "administrative",
                "elementType": "geometry.stroke",
                "stylers": [{
                    "color": gmColor
                }, {
                    "lightness": 17
                }, {
                    "weight": 1.2
                }]
            }]
        }
    });
}
$(document).ready(function(){
    gmInit();
});