var addDraggable = function() {
  $('.piece').draggable({
    containment: "#chess-board",
    cursor: "all-scroll",
    opacity: 0.6,
    revert: 'invalid',
    cancel: '.captured-piece',
    stop: function( event, ui ) {
      $('#chess-board td').each(function( element ) {
        $(this).removeClass( 'valid-move-tile' );
      });
    },
    start: function( event, ui ) {
      var draggedPiece = this;
      showValidMoves( draggedPiece );
    }
  });
};

var addDroppable = function() {
  $('#chess-board td').droppable( {
    tolerance: 'pointer',
    hoverClass: 'selected-tile',
    accept: function( draggablePiece ) {
      var targetTile = this;
      if ($(targetTile).hasClass('valid-move-tile')) {
        return true;
      } else {
        return false;
      }
    },
    drop: function( event, ui ) {
      var targetTile = this;
      var victim = $(targetTile).children();
      var droppedPiece = ui.draggable;
      var tileX = $(event.target).data('x');
      var tileY = $(event.target).data('y');
      sendPieceMove( droppedPiece, tileX, tileY );
      $(victim).detach();
      $(droppedPiece).detach().css({top: 0, left: 0}).appendTo(targetTile);
    }
  });
}

var toggleDraggable = function() {
  $('.piece').draggable( 'disable' );
  var turn = $('#chess-board').data('turn');
  if (turn % 2 === 0 && $('#chess-board').data('player') === 'black'){
    $('.black').draggable( 'enable' );
  }
  if (turn % 2 != 0 && $('#chess-board').data('player') === 'white'){
    $('.white').draggable ( 'enable' );
  }
};

var addValidMoveTile = function( validMoves ) {
  $('#chess-board td').each(function( element ) {
    var tile = this;
    var tileX = $(this).data('x');
    var tileY = $(this).data('y');
    for (var i = 0; i < validMoves.length; i++) {
      if (tileX === validMoves[i][0] && tileY === validMoves[i][1]) {
        $(tile).addClass( 'valid-move-tile' );
      }
    }
  });
}

var refreshGame = function () {
  $.ajax({
    method: 'GET',
    url: '/games/' + $('#chess-board').data('id') + '/refresh',
    dataType: 'html',
    success: function( data ) {
      $('#game').html(data);
      addDraggable();
      addDroppable();
      toggleDraggable();
    }
  })
}

var showValidMoves = function ( draggedPiece ) {
  $.ajax({
    method: 'GET',
    url: '/pieces/' + $(draggedPiece).data('id'),
    dataType: 'json',
    success: function( validMoves ){
      addValidMoveTile( validMoves );
    }
  })
}

var sendPieceMove = function ( droppedPiece, tileX, tileY ) {
  $.ajax({
    method: 'PATCH',
    url: '/pieces/' + $(droppedPiece).data('id'),
    data: {x: tileX, y: tileY},
    success: refreshGame
  })
}

var isActiveTurn = function() {
  var turn = $('#chess-board').data('turn');
  return turn % 2 === 0 && $('#chess-board').data('player') === 'black' ||
         turn % 2 != 0 && $('#chess-board').data('player') === 'white';
}

var pollingRefreshGame = function () {
  $.ajax({
    method: 'GET',
    url: '/games/' + $('#chess-board').data('id') + '/refresh',
    dataType: 'html',
    success: function( data ) {
      $('#game').html(data);
      addDraggable();
      addDroppable();
      toggleDraggable();
      setInterval(function() {
        if (!isActiveTurn()) {
          refreshGame();
        }
      }, 3000);
    }
  })
}

$(function() {
  addDraggable();
  addDroppable();
  toggleDraggable();
  pollingRefreshGame();
});







// setTimeout(function(){
//   window.location.reload(1);
// }, 15000);

// $('#chess-board td').hover(
//   function() {
//     var hoveredTile = this;
//     var hoveredPiece = $(this).children('span');
//     if (typeof $(hoveredPiece).data('id') === 'number') {
//       $.ajax({
//         method: 'GET',
//         url: '/pieces/' + $(hoveredPiece).data('id'),
//         dataType: 'json',
//         success: function( validMoves ){
//           $('#chess-board td').each(function( element ) {
//             var tile = this;
//             var tileX = $(this).data('x');
//             var tileY = $(this).data('y');
//             for (var i = 0; i < validMoves.length; i++) {
//               if (tileX === validMoves[i][0] && tileY === validMoves[i][1]) {
//                 $(tile).addClass( 'valid-move-tile' );
//               }
//             }
//           });
//         }
//       })
//     }
//   }, function() {
//     $('#chess-board td').removeClass( 'valid-move-tile' );
//   }
// );
