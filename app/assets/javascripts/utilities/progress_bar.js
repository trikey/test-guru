document.addEventListener('turbolinks:load', function() {
    var progressBar = document.querySelector('.progress-bar');

    if (progressBar) {
        var currentNumber = progressBar.dataset.currentNumber - 1;
        var total = progressBar.dataset.total;
        var percent = currentNumber * 100 / total;

        progressBar.style.width = percent + "%";
    }
});

