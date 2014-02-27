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
      switch (data.Type) {
        case "CONNECT":
          console.log(" -- RFID-unit connected: "+data.ID);
          break;
        case "DISCONNECT":
          $(document.getElementById('unit-'+data.ID)).remove();
          console.log(" -- RFID-unit disconnected: "+data.ID);
          break;
        case "CHECKIN":
          console.log(" <- "+resp.data);
          break;
        case "CHECKOUT":
          console.log(" <- "+resp.data);
          break;
        case "INFO":
          console.log(" <- "+resp.data);
          if (data.Message.cmd == "READ") { handleItem(data.Message) };
      }
    }
  }
  ws.onclose = function() {
    console.log("disconnected");
  }
});

function handleItem(msg) {
  
  // Create div if not exists
  if ($('#rfidlist').length == 0) {
    var rfiddiv = $('<div/>', {
      id: 'rfidlist',
      class: 'toptabs ui-tabs ui-widget ui-widget-content ui-corner-all'
    }).prependTo('#patronlists');

    var table = $('<table/>', { id: 'rfidissues' });
    table.append('<thead>' +
      '<tr>' +
        '<th scope="col">Forfallsdato</th>' +
        '<th scope="col">Tittel</th>' +
        '<th scope="col">Lånt ut den</th>' +
        '<th scope="col">Lånt ut fra</th>' +
        '<th scope="col">Hyllesignatur</th>' +
        '<th scope="col">Strekkode</th>' +
        '<th scope="col">Beskjed</th>');
    table.append('<tbody/>');

    rfiddiv.append(table);
  } else {
    var rfiddiv = $('#rfidlist');
  }

  // create row
  var row = $('<tr>').attr('id', msg.data.barcode)
    .append('<td><span title="dato">'+Date()+'</span></td>')
    .append('<td>' +
        '<strong>En SIP-tittel</strong></a>' +
      '</td>')
    .append('<td><span title="date">dato</span></td>')
    .append($('<td>').text("Hovedbiblioteket"))
    .append($('<td>').text("E2"))
    .append('<td><a href="/cgi-bin/koha/catalogue/detail.pl?biblionumber='+
        msg.data.barcode+'&amp;type=intra">'+msg.data.barcode+'</a></td>')
    .append('<td>'+msg.status);

  rfiddiv.find('tbody').prepend(row);

  // highlight according to result 
  if(msg.status == "TAGS-OK") {
    row.children('td').effect("highlight", {color: "lightgreen"}, 3000);
  } else {
    row.children('td').css("backgroundColor", "pink");
  }
}