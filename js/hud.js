$(document).ready(function () {
  window.addEventListener("message", function (event) {
    if (event.data.action == "update_status") {
      document.getElementById("idplayer").innerHTML = event.data.pid;
    }
    if (event.data.action == "showHud") {
      $("#hud").show();
    }
    if (event.data.action == "hideHud") {
      $("#hud").hide();
    }
    if (event.data.action == "setMoney") {
      setAnzahl(event.data.money);
      $(".money").show();
      $("money").show();
    };
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


