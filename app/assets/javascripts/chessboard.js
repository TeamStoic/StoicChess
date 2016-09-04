// $(function() {
//     // draw the chess board
//     for (var y = 0; y <= 7; y++) {
//         $("#chess-board").append(
//           "<tr>" +
//             "<td data-x='0' data-y='" + y + "'></td>" +
//             "<td data-x='1' data-y='" + y + "'></td>" +
//             "<td data-x='2' data-y='" + y + "'></td>" +
//             "<td data-x='3' data-y='" + y + "'></td>" +
//             "<td data-x='4' data-y='" + y + "'></td>" +
//             "<td data-x='5' data-y='" + y + "'></td>" +
//             "<td data-x='6' data-y='" + y + "'></td>" +
//             "<td data-x='7' data-y='" + y + "'></td>" +
//           "</tr>");
//     }
//
//     // assign variables to initial positions based on
//     // their data attributes
//     // black piece variables
//     var blackRookLeftTile = 'td[data-x="0"][data-y="0"]';
//     var blackKnightLeftTile = 'td[data-x="1"][data-y="0"]';
//     var blackBishopLeftTile = 'td[data-x="2"][data-y="0"]';
//     var blackQueenTile = 'td[data-x="3"][data-y="0"]';
//
//     var blackKingTile = 'td[data-x="4"][data-y="0"]';
//     var blackBishopRightTile = 'td[data-x="5"][data-y="0"]';
//     var blackKnightRightTile = 'td[data-x="6"][data-y="0"]';
//     var blackRookRightTile = 'td[data-x="7"][data-y="0"]';
//
//     // white piece variables
//     var whiteRookLeftTile = 'td[data-x="0"][data-y="7"]';
//     var whiteKnightLeftTile = 'td[data-x="1"][data-y="7"]';
//     var whiteBishopLeftTile = 'td[data-x="2"][data-y="7"]';
//     var whiteQueenTile = 'td[data-x="3"][data-y="7"]';
//
//     var whiteKingTile = 'td[data-x="4"][data-y="7"]';
//     var whiteBishopRightTile = 'td[data-x="5"][data-y="7"]';
//     var whiteKnightRightTile = 'td[data-x="6"][data-y="7"]';
//     var whiteRookRightTile = 'td[data-x="7"][data-y="7"]';
//
//     // append BS glyphicons to each <td> elements with IDs
//     // matching the IDs in database
//     // draw black figures
//     // left side
//     $(blackRookLeftTile).append(
//         '<i id="1" class="black-pcs glyphicon glyphicon-tower">');
//     $(blackKnightLeftTile).append(
//         '<i id="2" class="black-pcs glyphicon glyphicon-knight">');
//     $(blackBishopLeftTile).append(
//         '<i id="3" class="black-pcs glyphicon glyphicon-bishop">');
//     $(blackQueenTile).append(
//         '<i id="4" class="black-pcs glyphicon glyphicon-queen">');
//     // right side
//     $(blackKingTile).append(
//         '<i id="5" class="black-pcs glyphicon glyphicon-king">');
//     $(blackBishopRightTile).append(
//         '<i id="6" class="black-pcs glyphicon glyphicon-bishop">');
//     $(blackKnightRightTile).append(
//         '<i id="7" class="black-pcs glyphicon glyphicon-knight">');
//     $(blackRookRightTile).append(
//         '<i id="8" class="black-pcs glyphicon glyphicon-tower">');
//
//
//     // draw black pawns
//     for (var i = 0, c = 9; i <= 7; i++, c++) {
//         $('td[data-x="' + i + '"][data-y="1"]').append(
//           '<i id="' + c + '" class="black-pcs glyphicon glyphicon-pawn">');
//         }
//     // draw white pawns
//     for (var i = 0, c = 17; i <= 7; i++, c++) {
//         $('td[data-x="' + i + '"][data-y="6"]').append(
//           '<i id="' + c + '"class="white-pcs glyphicon glyphicon-pawn">');
//         }
//
//     // draw white figures
//     // left side
//     $(whiteRookLeftTile).append(
//         '<i id="25" class="white-pcs glyphicon glyphicon-tower">');
//     $(whiteKnightLeftTile).append(
//         '<i id="26" class="white-pcs glyphicon glyphicon-knight">');
//     $(whiteBishopLeftTile).append(
//         '<i id="27" class="white-pcs glyphicon glyphicon-bishop">');
//     $(whiteQueenTile).append(
//         '<i id="28" class="white-pcs glyphicon glyphicon-queen">');
//     // right side
//     $(whiteKingTile).append(
//         '<i id="29" class="white-pcs glyphicon glyphicon-king">');
//     $(whiteBishopRightTile).append(
//         '<i id="30" class="white-pcs glyphicon glyphicon-bishop">');
//     $(whiteKnightRightTile).append(
//         '<i id="31" class="white-pcs glyphicon glyphicon-knight">');
//     $(whiteRookRightTile).append(
//         '<i id="32" class="white-pcs glyphicon glyphicon-tower">');
//
//     });
//
// // in the future here is the logic to use to assign classes.
// // It will just swith predefined classes in CSS
// // write in ERB if player has black pieces do
// // <script>
// // $('.white-pcs').removeClass('white-pcs').addClass('black-pcs');
// // $('black-pcs').addClass('white-pcs').removeClass('black-pcs');
// // </script>
