// Get that hamburger menu cookin' //

document.addEventListener("DOMContentLoaded", function () {
    // Get all "navbar-burger" elements
    var $navbarBurgers = Array.prototype.slice.call(
        document.querySelectorAll(".navbar-burger"),
        0
    );
    // Check if there are any navbar burgers
    if ($navbarBurgers.length > 0) {
        // Add a click event on each of them
        $navbarBurgers.forEach(function ($el) {
            $el.addEventListener("click", function () {
                // Get the target from the "data-target" attribute
                var target = $el.dataset.target;
                var $target = document.getElementById(target);
                // Toggle the class on both the "navbar-burger" and the "navbar-menu"
                $el.classList.toggle("is-active");
                $target.classList.toggle("is-active");
            });
        });
    }
});

// Smooth Anchor Scrolling
$(document).on("click", 'a[href^="#"]', function (event) {
    event.preventDefault();
    $("html, body").animate(
        {
            scrollTop: $($.attr(this, "href")).offset().top
        },
        500
    );
});

// When the user scrolls down 20px from the top of the document, show the scroll up button
window.onscroll = function () {
    scrollFunction();
};

function scrollFunction() {
    if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
        document.getElementById("toTop").style.display = "block";
    } else {
        document.getElementById("toTop").style.display = "none";
    }
}

// Preloader
$(document).ready(function ($) {
    $(".preloader-wrapper").fadeOut();
    $("body").removeClass("preloader-site");

    registerChanges();
});

function registerChanges() {
    $('#ddlYear').on('change', GetMakes);
    $('#ddlMake').on('change', GetModels);
    $('#ddlModel').on('change', GetTrims);
}

function GetMakes(e) {
    let selectedYear = $('#ddlYear').val();
    $.ajax({
        method: "GET",
        dataType: "jsonp",
        type: "POST",
        jsonpCallback: 'GotMakes',
        url: `https://www.carqueryapi.com/api/0.3/?&cmd=getMakes&year=${selectedYear}`,
    })
        .done(GotMakes);
}

function GotMakes(result) {
    var ddlMakes = $('#ddlMake').empty();

    for (let i = 0; i < result.Makes.length; i++) {
        let item = result.Makes[i];
        ddlMakes.append($('<option>', {
            value: item.make_id,
            text: item.make_display
        }));
    }
}

function GetModels() {
    let selectedYear = $('#ddlYear').val();
    let selectedMake = $('#ddlMake').val();

    $.ajax({
        method: "GET",
        dataType: "jsonp",
        type: "POST",
        jsonpCallback: 'GotModels',
        url: `https://www.carqueryapi.com/api/0.3/?&cmd=getModels&year=${selectedYear}&make=${selectedMake}`,
    })
        .done(GotModels);
}

function GotModels(result) {
    var ddlModels = $('#ddlModel').empty();

    for (let i = 0; i < result.Models.length; i++) {
        let item = result.Models[i];
        ddlModels.append($('<option>', {
            value: item.model_name,
            text: item.model_name
        }));
    }
}

function GetTrims() {
//https://www.carqueryapi.com/api/0.3/?cmd=getTrims&make=brilliance&year=2010&model=BS4&sold_in_us=0&full_results=0
    let selectedYear = $('#ddlYear').val();
    let selectedMake = $('#ddlMake').val();
    let selectedModel = $('#ddlModel').val();

    $.ajax({
        method: "GET",
        dataType: "jsonp",
        type: "POST",
        jsonpCallback: 'GotTrims',
        url: `https://www.carqueryapi.com/api/0.3/?&cmd=getTrims&model=${selectedModel}&year=${selectedYear}&make=${selectedMake}&full_results=0`,
    })
        .done(GotTrims);
}

function GotTrims(result) {
    var ddlTrims = $('#ddlTrim').empty();

    for (let i = 0; i < result.Trims.length; i++) {
        let item = result.Trims[i];
        ddlTrims.append($('<option>', {
            value: item.model_id,
            text: item.model_trim
        }));
    }
}

function SendSubmission() {
    var subms = {
        "Seller": {
            "Name": $('#txtName').val(),
            "Email": $('#txtEmail').val(),
            "ContactNo": $('#txtContactNo').val(),
            "Province": $('#ddlProvince option:selected').text(),
            "Town": $('#txtTown').val(),
            "Suburb": $('#txtSuburb').val()
        },
        "Vehicle": {
            "Year": Number.parseInt($('#txtYear').val()),
            "Make": $('#ddlMake option:selected').text(),
            "Model": $('#ddlModel option:selected').text(),
            "Trim": $('#ddlTrim option:selected').text(),
            "Mileage": Number.parseInt($('#txtMileage').val()),
            "Price": Number.parseFloat($('#txtPrice').val()),
            "Condition": Number.parseInt($('#ddlCondition').val()),
            "Issues": $('#txtIssues').val()
        }
    };

    $.ajax({
        type: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        url: "https://leads.wheelo.co.za/submissions",
        data: JSON.stringify(subms)
    }).done(SubmitDone);
}

function SubmitDone() {
    alert("Thank you for your Submission.");
}

function SendMessage() {
    var msg = {
        "Body": $("#txtContactBody").val(),
        "Email": $("#txtContactEmail").val() || $("#txtEmail").val(),
        "Name": $("#txtContactName").val() || $("#txtName").val(),
        "Phone": $("#txtContactContactNo").val() || $("#txtContactNo").val(),
        "To": "kierrie@wheelo.co.za"
    };

    $.ajax({
        type: "POST",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        url: "https://comms.wheelo.co.za/message",
        data: JSON.stringify(msg)
    }).done(MessageDone);
}

function MessageDone() {
    alert("Thank you, we will be in touch.");
}