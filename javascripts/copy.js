(function(global, document) {

  function selectFocus(e) {
    this.select();
  }

  document.addEventListener('DOMContentLoaded', function() {
    var copyInputs = document.getElementsByClassName('copy');
    for (var i = 0; i < copyInputs.length; i++) {
      copyInputs[i].addEventListener('focus', selectFocus);
    }
  });

})(this, document);
