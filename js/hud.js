$(document).ready(function () {
  window.addEventListener("message", function (event) {
    if (event.data.displayhud == true) {
      $(".speedometer").show();
      update(event.data.speed, 1);
    }

    if (event.data.displayhud == false) {
      $(".speedometer").hide();
      update(event.data.speed, 1);
    }

    if (event.data.body == "gpsbody") {
      $("#gpsbody").text(event.data.gpsbody);
    }
    switch (event.data.action) {
      case 'update_status':
        document.getElementById("idplayer").innerHTML = event.data.pid;
      break;
      case "showHud":
        $("#hud").show();
        break;
      case "hideHud":
        $("#hud").hide();
        break;
      case "setMoney":
        setAnzahl(event.data.money);
        $("money").show();
        $(".money").show();
        break;
      case "gpsheader":
        $("#gpsheader").text(event.data.gpsheader);
        break;
      case "savezone":
        $("#savezone").show();
        break;
      case "savezonenotshow":
        $("#savezone").hide();
      default:
        break;
    }
  });
  });



function setAnzahl(anzahl) {
  document.getElementById("playermoney").innerHTML =
    new Intl.NumberFormat("de-DE").format(anzahl) + " $";
}

// DIE ZEIT THADÄUS

function updateClock() {
  let monat = [
    "Januar",
    "Februar",
    "März",
    "April",
    "Mai",
    "Juni",
    "Juli",
    "August",
    "September",
    "Oktober",
    "November",
    "Dezember",
  ];
  let today = new Date();

  let monate = today.getMonth();
  let date = today.getDate();

  let hours = addZero(today.getHours());
  let minutes = addZero(today.getMinutes());
  // let seconds = addZero(today.getSeconds());

  let current_time = `${hours}:${minutes}`;
  let current_date = `${date} ${monat[monate]}`;
  $("#currentime").text(current_time);
  $("#currentdate").text(current_date);
  setTimeout(updateClock, 1000);
}

function addZero(num) {
  return num < 10 ? `0${num}` : num;
}

updateClock();

function update(speed, gas) {
  document.getElementsByClassName("kmh")[0].innerHTML = speed;
}
