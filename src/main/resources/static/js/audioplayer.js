var player1,
onplayhead,
playerId,
timeline,
playhead,
timelineWidth;

jQuery(window).on("load", function () {
    audioPlay();
    ballSeek();
});

/* play */
function audioPlay() {
    /*var player = document.getElementById("player2");*/
  var player = $("#player2")[0]; //player2가 실질적인 오디오
  //alert(player);
    player.play();
    initProgressBar();
    isPlaying = true;
}
function initProgressBar() {
  jQuery(".play-pause").empty().val("PAUSE");
    player1 = document.getElementById("player2");
    player1.addEventListener("timeupdate", timeCal);
    var playBtn = jQuery(".play-pause");
          playBtn.click(function() {
            if (player1.paused == false) {
                player1.pause();
                isPlaying = false;
              jQuery(".play-pause").empty().val("PLAY");

            } else {
                player1.play();
                isPlaying = true;
              jQuery(".play-pause").empty().val("PAUSE");
            }
          });

}

/* 음악 시간 계산 */
function timeCal() {
    var width = jQuery("#timeline1").width();
    var length = player1.duration;
    var current_time = player1.currentTime;

    // calculate total length of value
    var totalLength = calculateTotalValue(length);
  //console.info(totalLength);
    jQuery(".end-time").html(totalLength);

    // calculate current value time
    var currentTime = calculateCurrentValue(current_time);
    jQuery(".start-time").html(currentTime);

    var progressbar = document.getElementById("seekObj1");
    progressbar.style.width = width * (player1.currentTime / player1.duration) + "px";

}

/* progress bar 길이 계산 */
function calculateTotalValue(length) {
    var minutes = Math.floor(length / 60);
      var  seconds_int = length - minutes * 60;
  if(seconds_int < 10){
    //console.info("here");
    seconds_int = "0"+seconds_int;
    //console.info(seconds_int);
  }
      var seconds_str = seconds_int.toString();
       var  seconds = seconds_str.substr(0, 2);
        var time = minutes + ':' + seconds;
//console.info(seconds_int)
    return time;
}

/* 현재 진행중인 시간 계산 */
function calculateCurrentValue(currentTime) {
    var current_hour = parseInt(currentTime / 3600) % 24,
        current_minute = parseInt(currentTime / 60) % 60,
        current_seconds_long = currentTime % 60,
        current_seconds = current_seconds_long.toFixed(),
        current_time = (current_minute < 10 ? "0" + current_minute : current_minute) + ":" + (current_seconds < 10 ? "0" + current_seconds : current_seconds);
    return current_time;
}

function ballSeek() {
     onplayhead = null;
     playerId = null;
     timeline = document.getElementById("timeline1");
     playhead = document.getElementById("seekObj1");
     timelineWidth = timeline.offsetWidth - playhead.offsetWidth;

    timeline.addEventListener("click", seek);
    playhead.addEventListener('mousedown', drag);
    window.addEventListener('mouseup', mouseUp);

}


function seek(event) {
    var player = document.getElementById("player2");
    player.currentTime = player.duration * clickPercent(event, timeline, timelineWidth);
}

function clickPercent(e, timeline, timelineWidth) {
    return (event.clientX - getPosition(timeline)) / timelineWidth;
}

function getPosition(el) {
    return el.getBoundingClientRect().left;
}

function drag(e) {
    player2.removeEventListener("timeupdate", timeCal);
    onplayhead = jQuery(this).attr("id");
    playerId = jQuery(this).parents("li").find("audio").attr("id");
    var player = document.getElementById(playerId);
    window.addEventListener('mousemove', dragFunc);
    player.removeEventListener('timeupdate', timeUpdate);
}


function dragFunc(e) {
    var player = document.getElementById(onplayhead);
    var newMargLeft = e.clientX - getPosition(timeline);

    if (newMargLeft >= 0 && newMargLeft <= timelineWidth) {
        playhead.style.width = newMargLeft + "px";
    }
    if (newMargLeft < 0) {
        playhead.style.width = "0px";
    }
    if (newMargLeft > timelineWidth) {
        playhead.style.width = timelineWidth + "px";
    }
}

function mouseUp(e) {
    if (onplayhead != null) {
        var player = document.getElementById(playerId);
        window.removeEventListener('mousemove', dragFunc);
        player.currentTime = player.duration * clickPercent(e, timeline, timelineWidth);
        player1.addEventListener("timeupdate", timeCal);
        player.addEventListener('timeupdate', timeUpdate);
    }
    onplayhead = null;
}

function timeUpdate() {
    var player2 = document.getElementById(onplayhead);
    var player = document.getElementById(playerId);
    var playPercent = timelineWidth * (player.currentTime / player.duration);
    player1.style.width = playPercent + "px";
    // If song is over
    if (player.currentTime == player.duration) {
        player.pause();
    }

}


/* 볼륨조절 */
function updateVolume() {
    player2.volume = volumecontrol.value;
  } 

/* 음소거 */
function mute(){
    player2.muted = !player2.muted;
}

/* 정지 - ing*/
function stop(){
   player1.pause();
   player2.pause();
   player1.currentTime = 0;
   player1.currentTime = 0;  
} 
