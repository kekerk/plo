<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@ include file="/WEB-INF/view/jspHandler.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="/team/chart/highcharts.js"></script>
<script src="/team/chart/modules/exporting.js"></script>
<script src="/team/chart/themes/grid-light.js"></script>
</head>
<body>
<h1>������Ʈ</h1>
   <div id="container" style="min-width: 400px; height: 400px; margin: 0 auto"></div>
   <div id="container2" style="float: left; width:50%; height: 400px; "></div>
   <div id="container3" style="float: left; width:50%; height: 400px;"></div>
   <div id="container4" style="float: left; width:50%; height: 400px; "></div>
   <div id="container5" style="float: left; width:50%; height: 400px;"></div>
   <script>
   $(document).ready(function() { 
     Highcharts.chart('container', {
          data: {
              table: 'datatable'
          },
          chart: {
              type: 'column'
          },
          title: {
              text: '�Ϻ� ���� '
          },
          xAxis : {
                   categories: [<c:forEach items="${cost}" var="c">'<fmt:formatDate value="${c.date}" pattern="MM-dd"/>',</c:forEach>],
                   crosshair: true
         },
          yAxis: {
              allowDecimals: false,
              title: {
                  text: '�ݾ�(��)'
              }
          },
          tooltip: {
              formatter: function () {
                  return '<b>' + this.series.name + '</b><br/>' +
                      this.point.y + ' ' + this.point.name.toLowerCase();
              }
          },
          series : [{
              name: '��ǰ ����',
                  data: [<c:forEach items="${cost}" var="c">${c.cost},</c:forEach>]
              }, {
                  name: '����',
                  data: [<c:forEach items="${amount}" var="a">${a.amount},</c:forEach>]
              },{
                  name: '���ͱ�',
                  data: [<c:forEach items="${amount}" var="a">${a.money},</c:forEach>]
              }
              ]   
        
      });
     Highcharts.chart('container2', {
          chart: {
              plotBackgroundColor: null,
              plotBorderWidth: 0,
              plotShadow: false
          },
          title: {
              text: '���� ���� ������ ���� <br> ${todaycnt.get(0)+todaycnt.get(1)}',
              align: 'center',
              verticalAlign: 'middle',
              y: 40
          },
          tooltip: {
              pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
          },
          plotOptions: {
              pie: {
                  dataLabels: {
                      enabled: true,
                      distance: -50,
                      style: {
                          fontWeight: 'bold',
                          color: 'white'
                      }
                  },
                  startAngle: -90,
                  endAngle: 90,
                  center: ['50%', '75%'],
                  size: '110%'
              }
          },
          series: [{
              type: 'pie',
              name: '���� ���� �����ں���',
              innerSize: '50%',
              data: [
                  ['�� <br>'+${todaycnt.get(0)},  ${todaycnt.get(0)}],
                  ['�� <br>'+${todaycnt.get(1)},  ${todaycnt.get(1)}]        
              ]
          }]
          
      });
     Highcharts.chart('container3', {
          chart: {
              plotBackgroundColor: null,
              plotBorderWidth: 0,
              plotShadow: false
          },
          title: {
              text: '�� ���� ������ ���� <br> ${tot.get(0)+tot.get(1)}',
              align: 'center',
              verticalAlign: 'middle',
              y: 40
          },
          tooltip: {
              pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
          },
          plotOptions: {
              pie: {
                  dataLabels: {
                      enabled: true,
                      distance: -50,
                      style: {
                          fontWeight: 'bold',
                          color: 'white'
                      }
                  },
                  startAngle: -90,
                  endAngle: 90,
                  center: ['50%', '75%'],
                  size: '110%'
              }
          },
          series: [{
              type: 'pie',
              name: '�� ���� �����ں���',
              innerSize: '50%',
              data: [
                  ['��<br>'+${tot.get(0)}, ${tot.get(0)}],
                  ['��<br>'+${tot.get(1)}, ${tot.get(1)}]        
              ]
          }]
          
      });
     Highcharts.chart('container4', {
          chart: {
              plotBackgroundColor: null,
              plotBorderWidth: null,
              plotShadow: false,
              type: 'pie'
          },
          title: {
              text: '���� ������ ���� ����'
          },
          tooltip: {
              pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
          },
          plotOptions: {
              pie: {
                  allowPointSelect: true,
                  cursor: 'pointer',
                  dataLabels: {
                      enabled: false
                  },
                  showInLegend: true
              }
          },
          series: [{
              name: '���̴뺰 ����',
              colorByPoint: true,
              data: [<c:forEach items="${men}" var="m">{ name: '${m.ag}',y: ${m.cnt} },</c:forEach>]
          }]
      });
     Highcharts.chart('container5', {
          chart: {
              plotBackgroundColor: null,
              plotBorderWidth: null,
              plotShadow: false,
              type: 'pie'
          },
          title: {
              text: '���� ������ ���� ����'
          },
          tooltip: {
              pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
          },
          plotOptions: {
              pie: {
                  allowPointSelect: true,
                  cursor: 'pointer',
                  dataLabels: {
                      enabled: false
                  },
                  showInLegend: true
              }
          },
          series: [{
              name: '���̴뺰 ����',
              colorByPoint: true,
              data: [<c:forEach items="${girl}" var="g">{ name: '${g.ag}',y: ${g.cnt} },</c:forEach>]
          }]
      });
});     
   
</script>
</body>
</html>