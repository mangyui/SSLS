

$(function () {

    //var form = layui.form, layer = layui.layer;
    //form.on('submit(formDemo)', function (data) {
    //    //layer.msg(JSON.stringify(data.field));
    //    //alert("123");
    //    return false;
    //});

    $(".Modify .btn").click(function () {
        $(".Modify .btn").removeClass("bgtheme").addClass("btn-default");
        $(this).addClass("bgtheme");
        $(".Modify_form").hide();
        $(".Modify_form").eq($(this).index()).show();
    });
    $(".td_checkbox").click(function () {
        if ($(".td_checkbox").length == $(".td_checkbox:checked").length) {
            $("#Selecteds").prop("checked", true);
        }
        else {
            $("#Selecteds").prop("checked", false);
        }
    })
    $("#Selecteds").click(function () {
        $(".td_checkbox").prop("checked", this.checked);
    })
})

layer.ready(function () {
    if ($("#msg").text() != "")
        layer.msg($("#msg").text(), { anim: 6 });
    if ($("#msg1").text() != "")
        layer.alert($("#msg1").text(), { anim: 1 });
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
    layerRenew = function (mess, id, e) {            //续借
        layer.confirm(mess, {         //询问框
            title: '续借',
            btn: ['确定', '取消'], //按钮
            anim: 3
        }, function () {
            $.post("/Borrow/Renew", { id: id }, function (data) {
                //console.log(data);
                if (data.result == 0 || data.result == 1) {
                    layer.alert("续借成功", { icon: 1 });
                    $(e).text("已续借").addClass("disabled");
                    if (data.result == 0)
                        $(e).parents("tr").find("span.label").text(data.Timelimit).removeClass("bgred").addClass("bggreen");
                    else
                        $(e).parents("tr").find("span.label").text(data.Timelimit).removeClass("bggreen").addClass("bgred");
                }
                else {
                    layer.alert("续借失败", { icon: 2, });
                }
            })
        });
    };
    layerReturm = function (mess, id, e) {           //归还
        layer.confirm(mess, {         //询问框
            title: '归还',
            btn: ['确定', '取消'], //按钮
            anim: 3
        }, function () {
            $.post("/Borrow/ReturnBook", { id: id }, function (data) {
                if (data) {
                    layer.alert("归还成功", { icon: 1 });
                    $(e).text("已归还").addClass("disabled");
                    $(e).prev("table").find(".borrow_state").text("已归还")
                }
                else {
                    layer.alert("归还失败", { icon: 2 });
                }
            })
        });
    };
    layerPay = function (mess, id, e) {       //缴纳罚金
        layer.confirm(mess, {         //询问框
            title: '缴纳罚金',
            btn: ['确定', '取消'], //按钮
            anim: 3
        }, function () {
            $.post("/Fine/PayMoney", { id: id }, function (data) {
                if (data.result == 1) {
                    layer.alert("缴纳成功", { icon: 1 });
                    $(e).text("已缴纳").addClass("disabled");
                    $(e).prev("table").find(".fine_state").text("已缴纳")
                }
                else {
                    layer.alert(data.msg, { icon: 2 });
                }
            })
        });
    };
    $("#ModifyPwd_btn").click(function () {     //修改密码
        var oldpwd = $("#OldPwd").val();
        var newpwd = $("#NewPwd").val();
        if (oldpwd == "" || newpwd == "") {
            layer.msg("请填写密码！", { anim: 6 });
        }
        else {
            $.post("/Reader/ModifyPwd", { oldPwd: oldpwd, newPwd: newpwd }, function (data) {
                if (data == true) {
                    layer.alert("修改成功！请重新登录", { icon: 1, closeBtn: 0 }, function () {
                        window.location.href = "/Reader/Login";
                    });
                    //setTimeout(function () {
                    //    window.location.href = "/Reader/Login";
                    //},2000)
                }
                else {
                    layer.alert("密码错误！", { icon: 2 });
                }
            })
        }
    })
})