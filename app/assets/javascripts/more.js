/*!
 * classie - class helper functions
 * from bonzo https://github.com/ded/bonzo
 * 
 * classie.has( elem, 'my-class' ) -> true/false
 * classie.add( elem, 'my-new-class' )
 * classie.remove( elem, 'my-unwanted-class' )
 * classie.toggle( elem, 'my-class' )
 */

/*jshint browser: true, strict: true, undef: true */
/*global define: false */

( function( window ) {

'use strict';

// class helper functions from bonzo https://github.com/ded/bonzo

function classReg( className ) {
  return new RegExp("(^|\\s+)" + className + "(\\s+|$)");
}

// classList support for class management
// altho to be fair, the api sucks because it won't accept multiple classes at once
var hasClass, addClass, removeClass;

if ( 'classList' in document.documentElement ) {
  hasClass = function( elem, c ) {
    return elem.classList.contains( c );
  };
  addClass = function( elem, c ) {
    elem.classList.add( c );
  };
  removeClass = function( elem, c ) {
    elem.classList.remove( c );
  };
}
else {
  hasClass = function( elem, c ) {
    return classReg( c ).test( elem.className );
  };
  addClass = function( elem, c ) {
    if ( !hasClass( elem, c ) ) {
      elem.className = elem.className + ' ' + c;
    }
  };
  removeClass = function( elem, c ) {
    elem.className = elem.className.replace( classReg( c ), ' ' );
  };
}

function toggleClass( elem, c ) {
  var fn = hasClass( elem, c ) ? removeClass : addClass;
  fn( elem, c );
}

var classie = {
  // full names
  hasClass: hasClass,
  addClass: addClass,
  removeClass: removeClass,
  toggleClass: toggleClass,
  // short names
  has: hasClass,
  add: addClass,
  remove: removeClass,
  toggle: toggleClass
};

// transport
if ( typeof define === 'function' && define.amd ) {
  // AMD
  define( classie );
} else {
  // browser global
  window.classie = classie;
}

})( window );


// Copyright (c) 2013 Pieroxy <pieroxy@pieroxy.net>
// This work is free. You can redistribute it and/or modify it
// under the terms of the WTFPL, Version 2
// For more information see LICENSE.txt or http://www.wtfpl.net/
//
// For more information, the home page:
// http://pieroxy.net/blog/pages/color-finder/index.html
//
// Detection of the most prominent color in an image
// version 1.1.1

function ColorFinder(colorFactorCallback) {
  this.callback = colorFactorCallback;
  this.getMostProminentColor = function(imgEl) {
    var rgb = null;
    if (!this.callback) this.callback = function() { return 1; };
    var data = this.getImageData(imgEl);
    rgb = this.getMostProminentRGBImpl(data, 6, rgb, this.callback);
    rgb = this.getMostProminentRGBImpl(data, 4, rgb, this.callback);
    rgb = this.getMostProminentRGBImpl(data, 2, rgb, this.callback);
    rgb = this.getMostProminentRGBImpl(data, 0, rgb, this.callback);
    return rgb;
  };

  this.getImageData = function(imgEl, degrade, rgbMatch, colorFactorCallback) {
    
    var rgb,
        canvas = document.createElement('canvas'),
        context = canvas.getContext && canvas.getContext('2d'),
        data, width, height, key,
        i = -4,
        db={},
        length,r,g,b,
        count = 0;
    
    if (!context) {
      return defaultRGB;
    }
    
    height = canvas.height = imgEl.naturalHeight || imgEl.offsetHeight || imgEl.height;
    width = canvas.width = imgEl.naturalWidth || imgEl.offsetWidth || imgEl.width;
    
    context.drawImage(imgEl, 0, 0);
    
    try {
      data = context.getImageData(0, 0, width, height);
    } catch(e) {
      /* security error, img on diff domain */
      return null;
    }

    length = data.data.length;
    
    var factor = Math.max(1,Math.round(length/5000));
    var result = {};
    
    while ( (i += 4*factor) < length ) {
      if (data.data[i+3]>32) {
        key = (data.data[i]>>degrade) + "," + (data.data[i+1]>>degrade) + "," + (data.data[i+2]>>degrade);
        if (!result.hasOwnProperty(key)) {
          rgb = {r:data.data[i], g:data.data[i+1], b:data.data[i+2],count:1};
          rgb.weight = this.callback(rgb.r, rgb.g, rgb.b);
          if (rgb.weight<=0) rgb.weight = 1e-10;
          result[key]=rgb;
        } else {
          rgb=result[key];
          rgb.count++;
        }
      }
    }

    return result;

  };
  
  this.getMostProminentRGBImpl = function(pixels, degrade, rgbMatch, colorFactorCallback) {
    
    var rgb = {r:0,g:0,b:0,count:0,d:degrade},
        db={},
        pixel,pixelKey,pixelGroupKey,
        length,r,g,b,
        count = 0;
    
    
    for (pixelKey in pixels) {
      pixel = pixels[pixelKey];
      totalWeight = pixel.weight * pixel.count;
      ++count;
      if (this.doesRgbMatch(rgbMatch, pixel.r, pixel.g, pixel.b)) {
        pixelGroupKey = (pixel.r>>degrade) + "," + (pixel.g>>degrade) + "," + (pixel.b>>degrade);
        if (db.hasOwnProperty(pixelGroupKey))
          db[pixelGroupKey]+=totalWeight;
        else
          db[pixelGroupKey]=totalWeight;
      }
    }
    
    for (i in db) {
      data = i.split(",");
      r = data[0];
      g = data[1];
      b = data[2];
      count = db[i];
      
      if (count>rgb.count) {
        rgb.count = count;
        data = i.split(",");
        rgb.r = r;
        rgb.g = g;
        rgb.b = b;
      }
    }
    
    return rgb;
    
  };

  this.doesRgbMatch = function(rgb,r,g,b) {
    if (rgb==null) return true;
    r = r >> rgb.d;
    g = g >> rgb.d;
    b = b >> rgb.d;
    return rgb.r == r && rgb.g == g && rgb.b == b;
  }

}


/**
 * gridScrollFx.js v1.0.0
 * http://www.codrops.com
 *
 * Licensed under the MIT license.
 * http://www.opensource.org/licenses/mit-license.php
 * 
 * Copyright 2013, Codrops
 * http://www.codrops.com
 */
;( function( window ) {
  
  'use strict';
  
  var docElem = window.document.documentElement,
    support = { animations : Modernizr.cssanimations },
    animEndEventNames = {
      'WebkitAnimation' : 'webkitAnimationEnd',
      'OAnimation' : 'oAnimationEnd',
      'msAnimation' : 'MSAnimationEnd',
      'animation' : 'animationend'
    },
    // animation end event name
    animEndEventName = animEndEventNames[ Modernizr.prefixed( 'animation' ) ];

  function getViewportH() {
    var client = docElem['clientHeight'],
      inner = window['innerHeight'];
    
    if( client < inner )
      return inner;
    else
      return client;
  }

  function scrollY() {
    return window.pageYOffset || docElem.scrollTop;
  }

  // http://stackoverflow.com/a/5598797/989439
  function getOffset( el ) {
    var offsetTop = 0, offsetLeft = 0;
    do {
      if ( !isNaN( el.offsetTop ) ) {
        offsetTop += el.offsetTop;
      }
      if ( !isNaN( el.offsetLeft ) ) {
        offsetLeft += el.offsetLeft;
      }
    } while( el = el.offsetParent )

    return {
      top : offsetTop,
      left : offsetLeft
    }
  }

  function inViewport( el, h ) {
    var elH = el.offsetHeight,
      scrolled = scrollY(),
      viewed = scrolled + getViewportH(),
      elTop = getOffset(el).top,
      elBottom = elTop + elH,
      // if 0, the element is considered in the viewport as soon as it enters.
      // if 1, the element is considered in the viewport only when it's fully inside
      // value in percentage (1 >= h >= 0)
      h = h || 0;

    return (elTop + elH * h) <= viewed && (elBottom - elH * h) >= scrolled;
  }

  function extend( a, b ) {
    for( var key in b ) { 
      if( b.hasOwnProperty( key ) ) {
        a[key] = b[key];
      }
    }
    return a;
  }

  function GridItem( el ) {
    this.el = el;
    this.anchor = el.querySelector( 'a' ) 
    this.image = el.querySelector( 'img' );
    this.desc = el.querySelector( 'h3' );
  }

  GridItem.prototype.addCurtain = function() {
    if( !this.image ) return;
    this.curtain = document.createElement( 'div' );
    this.curtain.className = 'curtain';
    var rgb = new ColorFinder( function favorHue(r,g,b) {
      // exclude white
      //if (r>245 && g>245 && b>245) return 0;
      return (Math.abs(r-g)*Math.abs(r-g) + Math.abs(r-b)*Math.abs(r-b) + Math.abs(g-b)*Math.abs(g-b))/65535*50+1;
    } ).getMostProminentColor( this.image );
    if( rgb.r && rgb.g && rgb.b ) {
      this.curtain.style.background = 'rgb('+rgb.r+','+rgb.g+','+rgb.b+')';
    }
    this.anchor.appendChild( this.curtain );
  }

  GridItem.prototype.changeAnimationDelay = function( time ) {
    if( this.curtain ) {
      this.curtain.style.WebkitAnimationDelay = time + 'ms';
      this.curtain.style.animationDelay = time + 'ms';
    }
    if( this.image ) {
      this.image.style.WebkitAnimationDelay = time + 'ms';
      this.image.style.animationDelay = time + 'ms';
    }
    if( this.desc ) {
      this.desc.style.WebkitAnimationDelay = time + 'ms';
      this.desc.style.animationDelay = time + 'ms';
    }
  }

  function GridScrollFx( el, options ) {  
    this.el = el;
    this.options = extend( {}, this.options );
    extend( this.options, options );
    this._init();
  }

  GridScrollFx.prototype.options = {
    // Minimum and maximum delay of the animation (random value is chosen)
    minDelay : 0,
    maxDelay : 500,
    // The viewportFactor defines how much of the appearing item has to be visible in order for the animation to start
    // if we'd use a value of 0, this would mean that it would add the animation class as soon as the item is in the viewport. 
    // If we were to use the value of 1, the animation would only be triggered when we see all of the item in the viewport (100% of it)
    viewportFactor : 0
  }

  GridScrollFx.prototype._init = function() {
    var self = this, items = [];

    [].slice.call( this.el.children ).forEach( function( el, i ) {
      var item = new GridItem( el );
      items.push( item );
    } );

    this.items = items;
    this.itemsCount = this.items.length;
    this.itemsRenderedCount = 0;
    this.didScroll = false;

    imagesLoaded( this.el, function() {
      // show grid
      classie.add( self.el, 'loaded' );

      // initialize masonry
      new Masonry( self.el, {
        itemSelector : 'li',
        isFitWidth : true,
        transitionDuration : 0
      } );
      
      // the items already shown...
      self.items.forEach( function( item ) {
        if( inViewport( item.el ) ) {
          ++self.itemsRenderedCount;
          classie.add( item.el, 'shown' );
        }
        else {
          item.addCurtain();
          // add random delay
          item.changeAnimationDelay( Math.random() * ( self.options.maxDelay - self.options.minDelay ) + self.options.minDelay );
        }
      } );

      var onScrollFn = function() {
        if( !self.didScroll ) {
          self.didScroll = true;
          setTimeout( function() { self._scrollPage(); }, 200 );
        }
        
        if( self.itemsRenderedCount === self.itemsCount ) {
          window.removeEventListener( 'scroll', onScrollFn, false );
        }
      }

      // animate the items inside the viewport (on scroll)
      window.addEventListener( 'scroll', onScrollFn, false );
      // check if new items are in the viewport after a resize
      window.addEventListener( 'resize', function() { self._resizeHandler(); }, false );
    });
  }

  GridScrollFx.prototype._scrollPage = function() {
    var self = this;
    this.items.forEach( function( item ) {
      if( !classie.has( item.el, 'shown' ) && !classie.has( item.el, 'animate' ) && inViewport( item.el, self.options.viewportFactor ) ) {
        ++self.itemsRenderedCount;

        if( !item.curtain ) {
          classie.add( item.el, 'shown' );
          return;
        };

        classie.add( item.el, 'animate' );
        
        // after animation ends add class shown
        var onEndAnimationFn = function( ev ) {
          if( support.animations ) {
            this.removeEventListener( animEndEventName, onEndAnimationFn );
          }
          classie.remove( item.el, 'animate' );
          classie.add( item.el, 'shown' );
        };

        if( support.animations ) {
          item.curtain.addEventListener( animEndEventName, onEndAnimationFn );
        }
        else {
          onEndAnimationFn();
        }
      }
    });
    this.didScroll = false;
  }

  GridScrollFx.prototype._resizeHandler = function() {
    var self = this;
    function delayed() {
      self._scrollPage();
      self.resizeTimeout = null;
    }
    if ( this.resizeTimeout ) {
      clearTimeout( this.resizeTimeout );
    }
    this.resizeTimeout = setTimeout( delayed, 1000 );
  }

  // add to global namespace
  window.GridScrollFx = GridScrollFx;

} )( window );