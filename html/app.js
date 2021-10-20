const closeKey = [27];

window.addEventListener("message", function(event) {
    $('body').hide();
    let action = event.data.action
    if (action == "show") {
        $('body').show();
        $('.number-text').text(event.data.number)

    } else if (action == "close") {
        $('body').hide();
    }
});

$('.card-outer').tilt({
    scale: 1.05,
    perspective: 500
})

$('.card-outer').tilt({
    glare: false,
    maxGlare: .5
})

$("body").on("keyup", function (key) {
    if (closeKey.includes(key.which)) {
        $('body').hide();
        $.post("http://qy-squidcard/close", JSON.stringify({}))
    }
  });

function flip(event) {
	var element = event.currentTarget;
	if (element.className === "card") {
    if(element.style.transform == "rotateY(180deg)") {
        element.style.transform = "rotateY(0deg)";

        setTimeout(function() { 
            $('.card-back').hide();
            $('.card-front').show();
        }, 300);
    }
    else {
        element.style.transform = "rotateY(180deg)";
        setTimeout(function() { 
            $('.card-front').hide();
            $('.card-back').show();
        }, 300);
    }
  }
};