<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
	$(document).ready(function(){	
		// 点击头像
		$(".header_right_img").click(function(){
			$(".header_right_img_ul").fadeToggle(200);
		});
		
		// 打开科室信息
		$(".header_right_img_ul_set").click(function(){
			$(".user_set_card").fadeToggle(200);
			$(".system_set_card").css("display","none");
		});
	
		// 关闭科室信息
		$(".fa_close_user_set").click(function(){
			$(".user_set_card").fadeOut(200);
		})
	});
</script>

<div class="user_set_card">
	<i class="fa fa_close_user_set fa-close" title="关闭"></i>
	<div class="account_formbox">
		<jsp:include page="/WEB-INF/pages/admin/manager_account.jsp" />
	</div>
</div>
<script>
	// 关闭科室信息卡片
	$(".fa_close_user_set").click(function(){
		$(".user_set_card").fadeOut(200);
	})
</script>

<section class="container_d">
	<div class="content_d">
		<div class="content_box_d">
			<div>
				<div id="high_charts"></div>
			</div>
		</div>
	</div>
</section>
<script src="https://code.highcharts.com.cn/jquery/jquery-1.8.3.min.js"></script>
    <script src="https://code.highcharts.com.cn/highcharts/highcharts.js"></script>
    <script src="https://code.highcharts.com.cn/highcharts/modules/exporting.js"></script>
    <script src="https://code.highcharts.com.cn/highcharts/modules/oldie.js"></script>
    <script src="https://code.highcharts.com.cn/highcharts-plugins/highcharts-zh_CN.js"></script>
    <script>
    var chart = null; // 定义全局变量
    $(document).ready(function() {
      chart = Highcharts.chart('high_charts', {
        chart: {
          zoomType: 'x',//面积图
          //type: 'spline',
          events: {
            load: requestData // 图表加载完毕后执行的回调函数
          }
        },
        title: {
          text: '体温数据曲线图'
        },
        subtitle: {
            text: document.ontouchstart === undefined ?
            '(鼠标拖动可以进行缩放)' : '手势操作进行缩放'
        },
        xAxis: {
            title: {
                text: '时 间'
            },
            type: 'datetime',
                dateTimeLabelFormats:{
                    millisecond : '%Y-%m-%d %H:%M:%S'
                }
        },

        yAxis: {
            minPadding: 0.2,
            maxPadding: 0.2,
            title: {
                text: '温 度 ℃',
                margin: 80
            },
            plotLines:[{
                color:'red',           //线的颜色，定义为红色
                dashStyle:'longdashdot',     //默认值，这里定义为实线
                value:38.5,               //定义在那个值上显示标示线，这里是在x轴上刻度为3的值处垂直化一条线
                width:2,                //标示线的宽度，2px
            },{
                color:'yellow',           //线的颜色，定义为红色
                dashStyle:'longdashdot',     //默认值，这里定义为实线
                value:37.0,               //定义在那个值上显示标示线，这里是在x轴上刻度为3的值处垂直化一条线
                width:2,
            }]
        },
        tooltip: {
            dateTimeLabelFormats:{
                millisecond:"%Y-%m-%d %H:%M:%S"
                // second:"%Y-%m-%d %H:%M:%S",
                // minute:"%Y-%m-%d %H:%M",
                // hour:"%Y-%m-%d %H",
                // day:"%Y-%m-%d",
                // month:"%Y-%m",
                // year:"%Y"
            }
        },
        legend: {
            enabled: false
        },
         plotOptions: {//面积区域设置
             area: {
                 fillColor: {
                     linearGradient: {
                         x1: 0,
                         y1: 0,
                         x2: 0,
                         y2: 1
                     },
                     stops: [
                         [0, Highcharts.getOptions().colors[0]],
                         [1, Highcharts.Color(Highcharts.getOptions().colors[0]).setOpacity(0).get('rgba')]
                     ]
                 },
                 marker: {
                     radius: 2//点点
                 },
                 lineWidth: 1,//线条
                 states: {
                     hover: {
                         lineWidth: 1//线条hover
                     }
                 },
                 threshold: null//起始点
             }
         },
        series: [{
            type: 'area',//面积区域
            name: '温度',
            data: []
        }]





      });


    });

    /**
     * Ajax 请求数据接口，并通过 Highcharts 提供的函数进行动态更新
     * 接口调用完毕后间隔 1 s 继续调用本函数，以达到实时请求数据，实时更新的效果
     */
    function requestData() {
      $.ajax({
        url: '/Huarui/admin/devicejsonp',
        success: function(point) {
        	var point = $.parseJSON(point);
            console.log("point 数据："+point);
            console.log("point 长度："+point.length);
            console.log("point[0]："+point[0]);
            console.log("point[1]："+point[1]);
            console.log("point[2]："+point[2]);
            var series = chart.series[0],
            shift = series.data.length > 20; // 当数据点数量超过 20 个，则指定删除第一个点

          // 新增点操作
          //具体的参数详见：https://api.hcharts.cn/highcharts#Series.addPoint
          // chart.series[0].addPoint(point[0], true, shift);
          for (var i = 0; i < point.length; i++) {
              chart.series[0].addPoint(point[i], true, shift);
          }

          // 一秒后继续调用本函数
          // setTimeout(requestData, 1000);
        },
        cache: false
      });
    }
    </script>