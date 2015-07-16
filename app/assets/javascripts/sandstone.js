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


  //   $('#masonry-container').imagesLoaded(
  //   	function(){
  //   		$('#masonry-container').masonry({
	 //  itemSelector: '.box',
	 //  // columnWidth: 300,
  //     gutter: 15,
	 //  isAnimated: !Modernizr.csstransitions,
	 //    isFitWidth: true,
	 //  // set columnWidth a fraction of the container width
	 //  // columnWidth: function( containerWidth ) {
	 //  //   return containerWidth / 6;

	 //  // }
		// });
	 //  });

  		  var $container = $('#masonry-container');

  $container.imagesLoaded(function(){
    $container.masonry({
      itemSelector: '.box',
      // columnWidth: 320,
      gutter: 0	,
      isAnimated: !Modernizr.csstransitions,
      isFitWidth: true,
      columnWidth: function( containerWidth ) {
          return containerWidth / 6;

        }
    });
  });

  });