
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
            area: ['780px', '60%'],
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
    toReturn = function (mess, id) {            //归还
        layer.confirm(mess, {         //询问框
            title: '强制归还',
            btn: ['确定', '取消'], //按钮
            anim: 3
        }, function () {
            $.post("/Admin/ToReturn", { readerId: id }, function (data) {
                if (data.result == true) {
                    layer.alert(data.mess, { icon: 1 }, function () {
                        window.location.reload();
                    });
                }
                else {
                    layer.alert(data.mess, { icon: 2, });
                }
            })
        });
    };
})

$(function () {
    $url = window.location.pathname;
    $("#ulNav a").each(function () {
        if ($(this).attr("href") == $url) {
            $(this).parent().addClass('active-li');
        }
    })
    $("#toggle-label").click(function () {
        if ($("#navLeft").css('left') == "0px") {
            $("#navLeft").css('left', '-250px');
            $("#toggle-label .glyphicon").addClass("glyphicon-menu-hamburger").removeClass("glyphicon-remove");
        }
        else if ($("#navLeft").css('left') == "-250px") {
            $("#navLeft").css('left', '0px');
            $("#toggle-label .glyphicon").addClass("glyphicon-remove").removeClass("glyphicon-menu-hamburger");
        }

    });
    if ($(window).width() < 767) {
        $("#toggle-label").click();
    }
    $("#file").change(function () {
        var file=$(this)[0].files[0];
        if ((file.type).indexOf("image/") == -1) {
            layer.alert("图片格式不正确，请重新上传！", {         //询问框
                icon: 2,
                title: '错误',
            });
            $(this).val("");
            $("#file_img").attr("src","").css("visibility", "hidden");
        }
        else {
           $("#file_img").attr("src", URL.createObjectURL(file)).css("visibility","visible");
        }

    })

    $(".two-ul a").click(function (event) {
        event.stopPropagation();
    })
    $('#ulNav>li').click(function () {
        $(this).toggleClass('active-liNav');
    });

    if (window.location.pathname == "/Admin/Index") {
        var BC_Chart = echarts.init(document.getElementById('BC_Chart'));

        var option ={
            title: {
                text: '数量占比',
                left: 'center',
                top: 20,
                textStyle: {
                    color: '#ccc'
                }
            },
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            series: [
                {
                    name: '详情',
                    type: 'pie',
                    radius: '55%',
                    center: ['50%', '50%'],
                    data: [
                        { value: 7, name: '测试1' },
                        { value: 7, name: '测试2' },
                        { value: 7, name: '测试3' },
                        { value: 7, name: '测试4' },
                        { value: 7, name: '测试5' },
                        { value: 7, name: '测试6' }
                    ].sort(function (a, b) { return a.value - b.value; }),
                    roseType: 'radius',

                    animationType: 'scale',
                    animationEasing: 'elasticOut',
                    animationDelay: function (idx) {
                        return Math.random() * 200;
                    }
                }
            ]
        };
        BC_Chart.setOption(option);
        BC_Chart.showLoading();
        $.post('/Admin/GetBCChart').done(function (data) {
            BC_Chart.hideLoading();
            // 填入数据
            BC_Chart.setOption({
                series: [{
                    // 根据名字对应到相应的系列
                    data: data
                }]
            });
        });
    };

    if (window.location.pathname == "/Admin/BorrowStatistics") {

        var Borrow_Chart = echarts.init(document.getElementById('Borrow_Chart'));
        var Borrow_Category = echarts.init(document.getElementById('Borrow_Category'));
        var all_Reader = echarts.init(document.getElementById('all_Reader'));

        var option2 = {
            title: {
                text: '近半个月借阅情况',
                subtext: '数据同步'
            },
            color: ['#337ab7'],
            tooltip: {
                trigger: 'axis'
            },
            toolbox: {
                show: true,
                feature: {
                    dataView: { show: true, readOnly: false },
                    magicType: { show: true, type: ['line', 'bar'] },
                    restore: { show: true },
                    saveAsImage: { show: true }
                }
            },
            xAxis: {
                name: '时间（t）',
                type: 'category',
                boundaryGap: false,
                data: ['2018-12-07', '2018-12-08', '2018-12-09', '2018-12-10', '2018-12-11', '2018-12-12', '2018-12-13']
            },
            yAxis: {
                name: '数量（n）',
                type: 'value',
                boundaryGap: [0, 1]
            },
            series: [{
                data: [0, 0, 0,0, 0, 0, 0],
                type: 'line',
                markPoint: {
                    data: [
                        { type: 'max', name: '最大值' },
                        { type: 'min', name: '最小值' }
                    ]
                },
                markLine: {
                    data: [
                        { type: 'average', name: '平均值' }
                    ]
                }
            }]
        };
        Borrow_Chart.setOption(option2);

        Borrow_Chart.showLoading();
        $.post('/Admin/GetBorrowChart').done(function (data) {
            // 填入数据
            Borrow_Chart.hideLoading();
            Borrow_Chart.setOption({
                xAxis: {
                    data: data[0]
                },
                series: [{
                    // 根据名字对应到相应的系列
                    data: data[1]
                }]
            });
        });

        var option6 = {
            title: {
                text: '图书类别借阅总量',
            },
            tooltip: {
                trigger: 'axis'
            },
            legend: {
                data: ['借阅量']
            },
            toolbox: {
                show: true,
                feature: {
                    dataView: { show: true, readOnly: false },
                    magicType: { show: true, type: ['line', 'bar'] },
                    restore: { show: true },
                    saveAsImage: { show: true }
                }
            },
            calculable: true,
            xAxis: [
                {
                    type: 'category',
                    data: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月']
                }
            ],
            yAxis: [
                {
                    type: 'value'
                }
            ],
            series: [
                {
                    name: '借阅量',
                    type: 'bar',
                    data: [2, 4, 7, 13, 14, 15, 6,6, 2, 0, 4, 3],
                    markPoint: {
                        data: [
                            { type: 'max', name: '最大值' },
                            { type: 'min', name: '最小值' }
                        ]
                    },
                    markLine: {
                        data: [
                            { type: 'average', name: '平均值' }
                        ]
                    }
                }
            ]
        };
        Borrow_Category.setOption(option6);

        Borrow_Category.showLoading();
        $.post('/Admin/GetBorrowCategory').done(function (data) {
            // 填入数据
            Borrow_Category.hideLoading();
            Borrow_Category.setOption({
                xAxis: {
                    data: data[0]
                },
                series: [{
                    // 根据名字对应到相应的系列
                    data: data[1]
                }]
            });
        });

        var all_Reader_option = {   //all读者在借
            title: {
                text: '读者在借',
            },
            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    type: 'shadow'
                }
            },
            toolbox: {
                show: true,
                feature: {
                    dataView: { show: true, readOnly: false },
                    magicType: { show: true, type: ['line', 'bar'] },
                    restore: { show: true },
                    saveAsImage: { show: true }
                }
            },
            legend: {
                data: ['在借数']
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: {
                name: '数量（n）',
                type: 'value',
                boundaryGap: [0, 1]
            },
            yAxis: {
                name: '读者名',
                type: 'category',
                data: ['读者1', '读者2', '读者3', '读者4', '读者5']
            },
            series: [
                {
                    name: '在借数',
                    type: 'bar',
                    data: [0, 0, 0, 0, 0]
                }
            ]
        };
        all_Reader.setOption(all_Reader_option);

        all_Reader.showLoading();
        $.post('/Admin/GetAllReader').done(function (data) {
            // 填入数据
            all_Reader.hideLoading();
            all_Reader.setOption({
                yAxis: {
                    data: data[0]
                },
                series: [
                {
                    name: '在借数',
                    type: 'bar',
                    data: data[1]
                }
                ]
            });
        });
    }

    if (window.location.pathname == "/Admin/Analyze") {

        var Book_Chart = echarts.init(document.getElementById('Book_Chart'));
        var Reader_Chart = echarts.init(document.getElementById('Reader_Chart'));

        var option3 = {
            title: {
                text: '读者借阅TOP5',
            },
            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    type: 'shadow'
                }
            },
            toolbox: {
                show: true,
                feature: {
                    dataView: { show: true, readOnly: false },
                    magicType: { show: true, type: ['line', 'bar'] },
                    restore: { show: true },
                    saveAsImage: { show: true }
                }
            },
            legend: {
                data: ['在借数', '已还数']
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: {
                name: '数量（n）',
                type: 'value',
                boundaryGap: [0,0.5]
            },
            yAxis: {
                name: '读者名',
                type: 'category',
                data: ['读者1', '读者2', '读者3', '读者4', '读者5']
            },
            series: [
                {
                    name: '在借数',
                    type: 'bar',
                    data: [0, 0, 0, 0, 0]
                },
                {
                    name: '已还数',
                    type: 'bar',
                    data: [0, 0, 2, 3, 10]
                }
            ]
        };
        Book_Chart.setOption(option3);

        Book_Chart.showLoading();
        $.post('/Admin/GetReaderTop').done(function (data) {
            // 填入数据
            Book_Chart.hideLoading();
            Book_Chart.setOption({
                yAxis: {
                    data: data[0]
                },
                series: [
                {
                    name: '在借数',
                    type: 'bar',
                    data: data[1]
                },
                {
                    name: '已还数',
                    type: 'bar',
                    data: data[2]
                }
                ]
            });
        });

        var option4 = {
            title: {
                text: '图书借阅TOP6',
            },
            color: ['#3398DB'],
            tooltip: {
                trigger: 'axis',
                axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                    type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                }
            },
            toolbox: {
                show: true,
                feature: {
                    dataView: { show: true, readOnly: false },
                    magicType: { show: true, type: ['line', 'bar'] },
                    restore: { show: true },
                    saveAsImage: { show: true }
                }
            },
            legend: {
                data: ['借阅量']
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: [
                {
                    name: '书名',
                    type: 'category',
                    data: ['图书1', '图书2', '图书3', '图书4', '图书5', '图书6'],
                    axisTick: {
                        alignWithLabel: true
                    }
                }
            ],
            yAxis: [
                {
                    name: '数量（n）',
                    type: 'value',
                    boundaryGap: [0, 0.6]
                }
            ],
            series: [
                {
                    name: '借阅量',
                    type: 'bar',
                    barWidth: '60%',
                    data: [10, 52, 200, 334, 390, 330, 220]
                }
            ]
       };
       Reader_Chart.setOption(option4);

       Reader_Chart.showLoading();
       $.post('/Admin/GetBookTop').done(function (data) {
           // 填入数据
           Reader_Chart.hideLoading();
           Reader_Chart.setOption({
               xAxis: {
                   data: data[0]
               },
               series: [{
                   // 根据名字对应到相应的系列
                   data: data[1]
               }]
           });
       });
    }
    if (window.location.pathname == "/Admin/FineStatistics") {

        var Fine_Chart = echarts.init(document.getElementById('Fine_Chart'));
        var option5 = {
            title: {
                text: '罚单缴纳情况',
                subtext: '暂取前五个读者'
            },
            tooltip: {
                trigger: 'axis',
                axisPointer: {
                    type: 'shadow'
                }
            },
            legend: {
                data: ['待缴纳', '已缴纳']
            },
            grid: {
                left: '3%',
                right: '4%',
                bottom: '3%',
                containLabel: true
            },
            xAxis: {
                name: '数量（n）',
                type: 'value',
                boundaryGap: [0, 0.5]
            },
            yAxis: {
                name: '读者名',
                type: 'category',
                data: ['读者1', '读者2', '读者3', '读者4', '读者5']
            },
            series: [
                {
                    name: '待缴纳',
                    type: 'bar',
                    data: [0, 0, 0, 0, 0]
                },
                {
                    name: '已缴纳',
                    type: 'bar',
                    data: [0, 0, 0, 0, 0]
                }
            ]
        };
        Fine_Chart.setOption(option5);

        Fine_Chart.showLoading();
        $.post('/Admin/GetFineChart').done(function (data) {
            // 填入数据
            Fine_Chart.hideLoading();
            Fine_Chart.setOption({
                yAxis: {
                    data: data[0]
                },
                series: [
                {
                    name: '待缴纳',
                    type: 'bar',
                    data: data[1]
                },
                {
                    name: '已缴纳',
                    type: 'bar',
                    data: data[2]
                }
                ]
            });
        });
    }
})