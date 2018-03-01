document.addEventListener('turbolinks:load', function() {
    var control = document.querySelector('#timer');
    if (control) {
        var seconds = parseInt(control.dataset.time);
        drawTimer();
    }

    function drawTimer() {
        if (seconds < 1) {
            control.textContent = "00:00";
            return;
        }
        seconds--;
        control.textContent = secondsToTime(seconds);
        setTimeout(drawTimer, 1000);
    }

    function secondsToTime(secs) {
        var hours = Math.floor(secs / (60 * 60));
        hours = hours < 10 ? '0' + hours : hours;
        var divisorForMinutes = secs % (60 * 60);
        var minutes = Math.floor(divisorForMinutes / 60);
        minutes = minutes < 10 ? '0' + minutes : minutes;
        var divisorForSeconds = divisorForMinutes % 60;
        var seconds = Math.ceil(divisorForSeconds);
        seconds = seconds < 10 ? '0' + seconds : seconds;
        return  minutes + ':' + seconds;
    }
});