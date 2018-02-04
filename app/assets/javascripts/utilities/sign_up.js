document.addEventListener('turbolinks:load', function() {
    var password1 = document.querySelector('#user_password');
    var password2 = document.querySelector('#user_password_confirmation');

    if (password1 && password2) {
        password1.addEventListener('input', checkPasswords);
        password2.addEventListener('blur', checkPasswords);
    }
});

function checkPasswords() {
    var password1 = document.querySelector('#user_password');
    var password2 = document.querySelector('#user_password_confirmation');

    if (password2.value.length == 0) {
        password1.classList.remove('border-error');
        password1.classList.remove('border-success');
        password2.classList.remove('border-error');
        password2.classList.remove('border-success');
        return;
    }

    if (password1.value == password2.value) {
        password1.classList.remove('border-error');
        password2.classList.remove('border-error');
        password1.classList.add('border-success');
        password2.classList.add('border-success');
    }
    else {
        password1.classList.remove('border-success');
        password2.classList.remove('border-success');
        password1.classList.add('border-error');
        password2.classList.add('border-error');
    }
}