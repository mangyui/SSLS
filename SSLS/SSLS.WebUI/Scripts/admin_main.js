function layerwaring(mess, url) {
    layer.confirm(mess, {         //询问框
        btn: ['确定', '取消'] //按钮
    }, function () {
        window.location.href = url;
    }, function () {
        layer.msg('取消成功', { icon: 1 });
    });
}
$(function () {
    $url = window.location.pathname;
    $(".two-ul a").each(function () {
        if ($(this).attr("href") == $url) {
            $(this).parent().addClass('active-two-li');
            $(this).parent().parent().parent().addClass('active-liNav');
        }
    })
    $('#ulNav>li').click(function () {
        $(this).toggleClass('active-liNav');
    });
    /*   $("#pic").change(function () {
       $("#picimg").attr("src",$(this).val());
   })*/

})