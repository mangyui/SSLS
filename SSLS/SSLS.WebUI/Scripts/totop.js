$(function(){
    $(window).scroll(function (event) {
       totop();
    }); 
    function totop(){
        if ($(this).scrollTop() >= 200) { $(".itop").fadeIn(400);; }
        if ($(this).scrollTop() < 200) { $(".itop").fadeOut(400); }
    }
    totop();
    $(".itop").click(function (event) { $("html,body").animate({ scrollTop: "0px" }, 400) });
})