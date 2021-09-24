function validateFieldLength(id: string, value: string | any[], minLength: number, maxLength: number) {
    let field = document.getElementById(id);
    if (value.length > minLength && value.length <= maxLength) {
        let alert = document.getElementById("alert" + id);
        if (alert != null) {
            alert.remove();
        }
    } else {
        let alert = document.getElementById("alert" + id);
        if (alert == null) {
            let alertElement = document.createElement("div");
            alertElement.id = "alert" + id;
            alertElement.classList.add("alert");
            alertElement.innerHTML = `Length must be between ${minLength} and ${maxLength}`;

            field.parentElement.insertBefore(alertElement, field.nextSibling);
        }
    }
}

function validateFieldDir(id: string, value: string) {
    let field: Element = document.getElementById(id);
    let re = /(cll|cra|av|anv|trans){1}(.+)*/gm;

    if (value.match(re)) {
        let alert = document.getElementById("alert" + id);
        if (alert != null) {
            alert.remove();
        }
    } else {
        let alert = document.getElementById("alert" + id);
        if (alert == null) {
            let alertElement = document.createElement("div");
            alertElement.id = "alert" + id;
            alertElement.classList.add("alert");
            alertElement.innerHTML = `Addresses should start with "cll", "cra", "av", "anv" or "trans"`;

            field.parentElement.insertBefore(alertElement, field.nextSibling);
        }
    }
}

function validatePassword(id: string, value: string) {
    let field: Element = document.getElementById(id);
    let re = /[a-z|A-Z|#|%|\/|&].*/gm;

    if (value.match(re)) {
        let alert = document.getElementById("alertC" + id);
        if (alert != null) {
            alert.remove();
        }
    } else {
        let alert = document.getElementById("alertC" + id);
        if (alert == null) {
            let alertElement = document.createElement("div");
            alertElement.id = "alertC" + id;
            alertElement.classList.add("alert");
            alertElement.innerHTML = `Password must contain letters, numbers or #, %, /, &`;

            field.parentElement.insertBefore(alertElement, field.nextSibling);
        }
    }
    validateFieldLength(id, value, 15, 20);
}

