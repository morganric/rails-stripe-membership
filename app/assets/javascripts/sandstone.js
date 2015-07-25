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
//= require jquery.ui.widget
//= require jquery.iframe-transport
//= require jquery.fileupload
//= require cloudinary/jquery.cloudinary
//= require attachinary



    $(document).ready(function(){




  //   $('#masonry-container').imagesLoaded(
  //    function(){
  //      $('#masonry-container').masonry({
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
      gutter: 0 ,
      isAnimated: !Modernizr.csstransitions,
      isFitWidth: true,
      columnWidth: function( containerWidth ) {
          return containerWidth / 6;

        }
    });
  });





  $container.infinitescroll({
    navSelector  : '.pagination',    // selector for the paged navigation 
    nextSelector : '.pagination a',  // selector for the NEXT link (to page 2)
    itemSelector : '.box',     // selector for all items you'll retrieve
    loading: {
        finishedMsg: 'No more pages to load.',
        img: 'http://i.imgur.com/6RMhx.gif'
      }
    },
    // trigger Masonry as a callback
    function( newElements ) {
      // hide new items while they are loading
      var $newElems = $( newElements ).css({ opacity: 0 });
      // ensure that images load before adding to masonry layout


      $newElems.imagesLoaded(function(){
        // show elems now they're ready
        $newElems.animate({ opacity: 1 });
        $container.masonry( 'appended', $newElems, true ); 

      });
    });


 

  });