// Sandstone
// Bootswatch

//= require masonry/jquery.masonry
//= require masonry/jquery.event-drag
//= require masonry/jquery.imagesloaded.min
//= require masonry/jquery.infinitescroll.min
//= require masonry/modernizr-transitions
//= require masonry/box-maker
//= require masonry/jquery.loremimages.min
//= require jquery
//= require jquery_ujs
//= require sandstone/loader
//= require sandstone/bootswatch



  $(document).ready(function(){
    $('#masonry-container').masonry({
	  itemSelector: '.box',
	  gutterWidth: 0,
	  isAnimated: !Modernizr.csstransitions,
	    // isFitWidth: true,
	  // set columnWidth a fraction of the container width
	  columnWidth: function( containerWidth ) {
	    return containerWidth / 5;

	  }
	});

	  $('.col3 a').hover(function(){
		   $(this).next().toggleClass('hidden');
		  });

	  
  });