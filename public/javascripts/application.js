function Karousel(karousel) {
  this.element = karousel;
  this.facesCount = 0;
  this.degrees = 0;
  this.position = 0;
}

Karousel.prototype.apply = function() {
  this.degrees = (360 / this.facesCount * this.position * -1);
  this.rotate();
}

Karousel.prototype.rotate = function() {
  var attributes = ['-webkit-transform', '-moz-tranform', '-o-transform', 'transform'];
  var style = 'translate(0) rotateY('+this.degrees+'deg)';

  for (var i = 0; i < attributes.length; i++) {
    $(this.element).css(attributes[i], style);
  };

};

$(document).ready(function() {
  // set observers and behaviour
  var init = function() {
    var $navigation  = $('.navbar-nav a'),
        $karousel    = $('.karousel-inner'),
        $karouselNav = $('.karousel-navigation > input'),
        facesCount   = $('.karousel-inner > .face').size(),
        karousel     = new Karousel($karousel);

    var rotateTo = function(event) {
      var position = $(event.target).data('position');

      if ((position !== null) && (position !== undefined)) {
        karousel.position = position;
        karousel.apply();
      }
    };

    karousel.facesCount = facesCount;

    $karouselNav.bind('click', function(event){
      rotateTo(event);
    });

    $navigation.bind('click', function(event){
      event.preventDefault();
      rotateTo(event);
    });
  };

  init();
});
