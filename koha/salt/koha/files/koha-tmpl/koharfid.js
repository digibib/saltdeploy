/*
 * JavaScript to inject Table for RFID items
 * connects to rfid hub with Websocket
 * creates <div> with <table>
 * inserts table to #patronlists and adds highlighted items as they arrive from websocket
 */

$(document).ready(function() {
  var ws=new WebSocket('ws://localhost:8899/ws');
  ws.onopen = function() {
    console.log("connected");

    ws.onmessage = function(resp) {
      var data = JSON.parse(resp.data);
      switch (data.Action) {
        case "CONNECT":
          if (data.RFIDError) { // RFIDhun cannot access RFID
            alert("ERROR connecting to RFID, please refresh Browser with F5 to try again!");
          } else if (data.SIPError) { // RFIDhub cannot access SIP Server
            alert("ERROR connecting to SIP Server, please ask Zarathustra for help!");
          } else {
            console.log("Connected to RFIDhub");
            ws.send(JSON.stringify({Action: "CHECKIN"}));
          }
          break;
        case "DISCONNECT":
          console.log("Disconnected from RFIDhub");
          break;
        case "CHECKIN":
          console.log(" <- "+resp.data);
          if (data.Item.OK) { handleCheckinItem(data.Item) };
          break;
        case "CHECKOUT":
          // TODO: handle checkout
          console.log(" <- "+resp.data);
          break;
        case "WRITE":
          // TODO: handle write
          console.log(" <- "+resp.data);
          break;
      }
    }
  }
  ws.onclose = function() {
    console.log("disconnected");
  }
  ws.onerror = function() {
    console.log("No connection to RFIDhub!");
    alert("ERROR connecting to RFIDhub, please refresh Browser with F5 to try again!");
  }
});

function handleCheckinItem(msg) {
  
  // Create div if not exists
  if ($('#rfidlist').length == 0) {
    var rfiddiv = $('<div/>', {
      id: 'rfidlist',
      class: 'toptabs ui-tabs ui-widget ui-widget-content ui-corner-all'
    }).prependTo('#patronlists');
  } else {
    var rfiddiv = $('#rfidlist');
  }

  // create table, headers and tbody if not exists
  if ($('#rfidissues').length == 0) {
    var table = $('<table/>', { id: 'rfidissues' });
    table.append('<thead>' +
      '<tr>' +
        '<th scope="col">Levert</th>' +
        '<th scope="col">Tittel</th>' +
        '<th scope="col">Forfatter</th>' +
        '<th scope="col">Lånt ut fra</th>' +
        '<th scope="col">Hyllesignatur</th>' +
        '<th scope="col">Strekkode</th>' +
        '<th scope="col">Beskjed</th>');
    table.append('<tbody/>');

    rfiddiv.append(table);
  }

  // create row
  var row = $('<tr>').attr('id', msg.Barcode)
    .append('<td><span title="dato">'+Date.parse(msg.Date)+'</span></td>')
    .append('<td>' +
        '<strong>'+msg.Label+'</strong></a>' +
      '</td>')
    .append($('<td>')) +
    .append($('<td>')) +
    .append($('<td>')) +
    .append('<td><a href="/cgi-bin/koha/catalogue/detail.pl?biblionumber='+
        msg.Barcode+'&amp;type=intra">'+msg.Barcode+'</a></td>')
    .append('<td>'+msg.Status);

  rfiddiv.find('tbody').prepend(row);

  // highlight according to result 
  if(msg.OK) {
    console.log("OKEY");
    row.children('td').effect("highlight", {color: "lightgreen"}, 3000);
  } else {
    console.log("NOT OKEY");
    row.children('td').css("backgroundColor", "pink");
  }
}