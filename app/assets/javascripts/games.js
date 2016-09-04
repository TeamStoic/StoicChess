$(function() {
//     // Picks up all the latest positions from
//     // the database and updates the view
//     var $currentPositions = $('#piece_pos').data('positions');
//
//     $.each( $currentPositions, function(key, value) {
//       var currentCell = 'td[data-x="' + value.x_position + '"]' +
//                         '[data-y="' + value.y_position + '"]';
//       //formula to map DB piece IDs to the IDs in front view
//       var pieceIdOnBoard = value.id % 32;
//       $('#' + pieceIdOnBoard).appendTo(currentCell);
//     });
//
    // Makes all cells that have <i> elements
    // draggble. If move is invalid, the piece will
    // return to its cell
    $('#chess-board td > span').draggable({
      containment: "#chess-board",
      cursor: "all-scroll",
      opacity: 0.6,
      revert: 'invalid'
    });
//
    // Each cell will accept only <i> elements.
    // Only when pointer hovers over the cell
    // the drop will occur.
    $('#chess-board td').droppable( {
      // white cannot be dropped on white and vice versa
      // this logic can be removed when move! method works
      // properly
      tolerance: 'pointer',
      hoverClass: 'highlighted-cell'
    });
});
