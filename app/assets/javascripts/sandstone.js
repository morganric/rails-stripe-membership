// Sandstone
// Bootswatch


//= require jquery
//= require jquery_ujs
//= require sandstone/loader
//= require sandstone/bootswatch
//= require masonry/jquery.masonry
//= require masonry/jquery.event-drag
//= require masonry/jquery.imagesloaded.min
//= require masonry/jquery.infinitescroll.min
//= require masonry/modernizr-transitions
//= require masonry/box-maker
//= require masonry/jquery.loremimages.min



  $(document).ready(function(){
    $('#masonry-container').masonry({
	  itemSelector: '.box',
	  // gutterWidth: 15,
	  isAnimated: !Modernizr.csstransitions,
	    // isFitWidth: true,
	  // set columnWidth a fraction of the container width
	  columnWidth: function( containerWidth ) {
	    return containerWidth / 6;

	  }
	});



  });