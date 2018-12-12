
$(function () {
    $url = window.location.pathname;
    $("#ulNav a").each(function () {
        if ($(this).attr("href") == $url) {
            $(this).parent().addClass('active-li');
        }
    })
    $(".two-ul a").click(function (event) {
        event.stopPropagation();
    })
    $('#ulNav>li').click(function () {
        $(this).toggleClass('active-liNav');
    });

})
layer.ready(function () {
    layernot = function (mess) {
        layer.alert(mess, {         //询问框
            icon: 5,
            title: '提示',
        });
    };     
    layerwaring = function (mess, url) {
        layer.confirm(mess, {         //询问框
            icon: 7,
            title: '确认操作',
            btn: ['确定', '取消'], //按钮
            anim: 3
        }, function () {
            window.location.href = url;
        });
    };
    layerReader = function (url) {
        layer.open({
            type: 2,
            title: '读者信息',
            shade: 0.5,
            area: ['60%', '60%'],
            content: url //iframe的url
        });
    }
    Layerdelete = function (mess, url, id) {           //图书、类别删除
        layer.confirm(mess, {         //询问框
            title: '删除',
            btn: ['确定', '取消'], //按钮
            icon:0
        }, function () {
            $.post(url, { id: id }, function (data) {
                if (data.result) {
                    layer.alert(data.msg, { icon: 1 }, function () {
                        window.location.reload();
                    });                  
                }
                else {
                    layer.alert(data.msg, { icon: 2 });
                }
            })
        });
    };
})