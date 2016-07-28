$(function() {
    // draw the chess board
    for (var y = 0; y <= 7; y++) {
        $("#chess-board").append(
          "<tr>" +
            "<td data-x='0' data-y='" + y + "'></td>" +
            "<td data-x='1' data-y='" + y + "'></td>" +
            "<td data-x='2' data-y='" + y + "'></td>" +
            "<td data-x='3' data-y='" + y + "'></td>" +
            "<td data-x='4' data-y='" + y + "'></td>" +
            "<td data-x='5' data-y='" + y + "'></td>" +
            "<td data-x='6' data-y='" + y + "'></td>" +
            "<td data-x='7' data-y='" + y + "'></td>" +
          "</tr>");
    }

    // assign variables to initial positions based on
    // their data attributes
    // black piece variables
    var blackRookLeft = 'td[data-x="0"][data-y="0"]';
    var blackKnightLeft = 'td[data-x="1"][data-y="0"]';
    var blackBishopLeft = 'td[data-x="2"][data-y="0"]';
    var blackQueen = 'td[data-x="3"][data-y="0"]';

    var blackKing = 'td[data-x="4"][data-y="0"]';
    var blackBishopRight = 'td[data-x="5"][data-y="0"]';
    var blackKnightRight = 'td[data-x="6"][data-y="0"]';
    var blackRookRight = 'td[data-x="7"][data-y="0"]';

    // white piece variables
    var whiteRookLeft = 'td[data-x="0"][data-y="7"]';
    var whiteKnightLeft = 'td[data-x="1"][data-y="7"]';
    var whiteBishopLeft = 'td[data-x="2"][data-y="7"]';
    var whiteQueen = 'td[data-x="3"][data-y="7"]';

    var whiteKing = 'td[data-x="4"][data-y="7"]';
    var whiteBishopRight = 'td[data-x="5"][data-y="7"]';
    var whiteKnightRight = 'td[data-x="6"][data-y="7"]';
    var whiteRookRight = 'td[data-x="7"][data-y="7"]';

    // append BS glyphicons to each <td> elements with IDs
    // matching the IDs in database
    // draw black figures
    // left side
    $(blackRookLeft).append(
        '<i id="1" class="black-pcs glyphicon glyphicon-tower">');
    $(blackKnightLeft).append(
        '<i id="2" class="black-pcs glyphicon glyphicon-knight">');
    $(blackBishopLeft).append(
        '<i id="3" class="black-pcs glyphicon glyphicon-bishop">');
    $(blackQueen).append(
        '<i id="4" class="black-pcs glyphicon glyphicon-queen">');
    // right side
    $(blackKing).append(
        '<i id="5" class="black-pcs glyphicon glyphicon-king">');
    $(blackBishopRight).append(
        '<i id="6" class="black-pcs glyphicon glyphicon-bishop">');
    $(blackKnightRight).append(
        '<i id="7" class="black-pcs glyphicon glyphicon-knight">');
    $(blackRookRight).append(
        '<i id="8" class="black-pcs glyphicon glyphicon-tower">');


    // draw black pawns
    for (var i = 0, c = 9; i <= 7; i++, c++) {
        $('td[data-x="' + i + '"][data-y="1"]').append(
          '<i id="' + c + '" class="black-pcs glyphicon glyphicon-pawn">');
        }
    // draw white pawns
    for (var i = 0, c = 17; i <= 7; i++, c++) {
        $('td[data-x="' + i + '"][data-y="6"]').append(
          '<i id="' + c + '"class="white-pcs glyphicon glyphicon-pawn">');
        }

    // draw white figures
    // left side
    $(whiteRookLeft).append(
        '<i id="25" class="white-pcs glyphicon glyphicon-tower">');
    $(whiteKnightLeft).append(
        '<i id="26" class="white-pcs glyphicon glyphicon-knight">');
    $(whiteBishopLeft).append(
        '<i id="27" class="white-pcs glyphicon glyphicon-bishop">');
    $(whiteQueen).append(
        '<i id="28" class="white-pcs glyphicon glyphicon-queen">');
    // right side
    $(whiteKing).append(
        '<i id="29" class="white-pcs glyphicon glyphicon-king">');
    $(whiteBishopRight).append(
        '<i id="30" class="white-pcs glyphicon glyphicon-bishop">');
    $(whiteKnightRight).append(
        '<i id="31" class="white-pcs glyphicon glyphicon-knight">');
    $(whiteRookRight).append(
        '<i id="32" class="white-pcs glyphicon glyphicon-tower">');

    });

// in the future here is the logic to use to assign classes.
// It will just swith predefined classes in CSS
// write in ERB if player has black pieces do
// <script>
// $('.white-pcs').removeClass('white-pcs').addClass('black-pcs');
// $('black-pcs').addClass('white-pcs').removeClass('black-pcs');
// </script>