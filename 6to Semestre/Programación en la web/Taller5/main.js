function validateFieldLength(id, value, minLength, maxLength) {
    var field = document.getElementById(id);
    if (value.length > minLength && value.length <= maxLength) {
        var alert_1 = document.getElementById("alert" + id);
        if (alert_1 != null) {
            alert_1.remove();
        }
    }
    else {
        var alert_2 = document.getElementById("alert" + id);
        if (alert_2 == null) {
            var alertElement = document.createElement("div");
            alertElement.id = "alert" + id;
            alertElement.classList.add("alert");
            alertElement.innerHTML = "Length must be between " + minLength + " and " + maxLength;
            field.parentElement.insertBefore(alertElement, field.nextSibling);
        }
    }
}
function validateFieldDir(id, value) {
    var field = document.getElementById(id);
    var re = /(cll|cra|av|anv|trans){1}(.+)*/gm;
    if (value.match(re)) {
        var alert_3 = document.getElementById("alert" + id);
        if (alert_3 != null) {
            alert_3.remove();
        }
    }
    else {
        var alert_4 = document.getElementById("alert" + id);
        if (alert_4 == null) {
            var alertElement = document.createElement("div");
            alertElement.id = "alert" + id;
            alertElement.classList.add("alert");
            alertElement.innerHTML = "Addresses should start with \"cll\", \"cra\", \"av\", \"anv\" or \"trans\"";
            field.parentElement.insertBefore(alertElement, field.nextSibling);
        }
    }
}
function validatePassword(id, value) {
    var field = document.getElementById(id);
    var re = /[a-z|A-Z|#|%|\/|&].*/gm;
    if (value.match(re)) {
        var alert_5 = document.getElementById("alertC" + id);
        if (alert_5 != null) {
            alert_5.remove();
        }
    }
    else {
        var alert_6 = document.getElementById("alertC" + id);
        if (alert_6 == null) {
            var alertElement = document.createElement("div");
            alertElement.id = "alertC" + id;
            alertElement.classList.add("alert");
            alertElement.innerHTML = "Password must contain letters, numbers or #, %, /, &";
            field.parentElement.insertBefore(alertElement, field.nextSibling);
        }
    }
    validateFieldLength(id, value, 15, 20);
}
