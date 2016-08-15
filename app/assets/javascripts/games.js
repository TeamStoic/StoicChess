$(function() {
    // Picks up all the latest positions from
    // the database and updates the view
    var $currentPositions = $('#piece_pos').data('positions');

    $.each( $currentPositions, function(key, value) {
      var currentCell = 'td[data-x="' + value.x_position + '"]' +
                        '[data-y="' + value.y_position + '"]';
      //formula to map DB piece IDs to the IDs in front view
      var pieceIdOnBoard = value.id % 32;
      $('#' + pieceIdOnBoard).appendTo(currentCell);
    });

    // Makes all cells that have <i> elements
    // draggble. If move is invalid, the piece will
    // return to its cell
    $('#chess-board td > i').draggable({
      containment: "#chess-board",
      cursor: "all-scroll",
      opacity: 0.6,
      revert: 'invalid'
    });

    // Each cell will accept only <i> elements.
    // Only when pointer hovers over the cell
    // the drop will occur.
    $('#chess-board td').droppable( {
      // white cannot be dropped on white and vice versa
      // this logic can be removed when move! method works
      // properly
      accept: function(draggablePiece) {
        if ( (draggablePiece.hasClass('black-pcs') &&
            $(this).children('i').hasClass('black-pcs') ) ) {
          return false;
        } else if ( (draggablePiece.hasClass('white-pcs') &&
            $(this).children('i').hasClass('white-pcs') ) ) {
          return false;
        } else {
          return true;
        }
      },
      tolerance: 'pointer',
      hoverClass: 'highlighted-cell',
      drop: function(event, ui) {
        // gets the x_y coords of the place where to
        // drop the piece
        var $posX = $(event.target).data('x');
        var $posY = $(event.target).data('y');

        // get which HTML <i> element
        // is being dragged
        var $droppedItem = ui.draggable;

        // gets the ID of the game and removes the last slash
        // char if needed
        var $currentUri = (window.location.pathname)

        var $gameId = $currentUri.substring($currentUri.lastIndexOf('/') + 1);

        // get the current host to use in AJAX
        var $currentHost = window.location.protocol + '//' + window.location.host;
        var $thisCell = this;

        // formula to calculate the current piece ID in DB
        var $pieceIdInDB = Number( $droppedItem.attr('id') ) +
                                ( ($gameId - 1) * 32 );
        // sends the new coords update to DB
        $.ajax( {
          type: 'PATCH',
          url: $currentHost + '/games/' + $gameId,
          dataType: 'json',
          data: {
            piece_id: $pieceIdInDB,
            x_position: $posX,
            y_position: $posY
          }
        })
        // If move is valid - removes draggable
        // element from old cell and appends to
        // new coordinates - 'thisCell'.
        .success( function() {
          $droppedItem.detach().css({top: 0, left: 0}).appendTo($thisCell);
        });
      }
    });
});
