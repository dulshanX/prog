var dformat = { dateFormat: "dd-mm-yy" }

$(function () {

  // $('#chart').hide;

  $('select').addClass('form-control');

  $('.dates').datepicker(dformat);

  $('#data_table').bootstrapTable({
    columns: [
      { field: 'username', title: 'User' },
      { field: 'date', title: 'Date' },
      { field: 'name', title: 'Name' },
      { field: 'category', title: 'Category' },
      { field: 'value', title: 'Hours' }
    ]
  });
  $('#data_table').bootstrapTable('getOptions').formatNoMatches = function () { return 'no data' };
  $('#data_table').bootstrapTable('toggleView');
  $('#data_table').bootstrapTable('toggleView');


  $('#form_filter').on('ajax:success', function (e) {
    [rawdata, status, xhr] = e.detail;
    // console.log(rawdata);
    // let data = JSON.parse(JSON.stringify(rawdata));

    data = rawdata;
    $('#data_table').bootstrapTable('load', data);

    if (rawdata.length == 0) { 
      $('#chart').fadeOut();
      return; 
    }
    else {
      $('#chart').fadeIn();
    }

    let dates = data.reverse().map(val => {
      let res = {};
      res.x = new Date(val.date);
      res.y = val.value;
      return res;
    });
    createChart(dates);
    // if (!chart) { createChart(dates) }
    // else { updateChart(dates); }
  });


  var ctx = document.getElementById("chart").getContext('2d');
  var chart;

  function createChart(data) {
    // console.log(data);
    chart = new Chart(ctx, {
      type: 'line',
      data: {
        datasets: [{
          data: data,
          backgroundColor: 'rgba(247,70,74,0.2)'
          // backgroundColor: 'rgba(70,191,189,0.2)'
          // backgroundColor: 'rgba(151,187,205,0.2)'
        }]
      },
      options: {
        legend: {
          display: false
        },
        scales: {
            xAxes: [{
                type: 'time',
                time: {
                    unit: 'month',
                    displayFormats: {
                        quarter: 'MMM YYYY'
                    }
                },
                distribution: 'linear',
                bounds: 'data'
            }]
        }
      }
    });
  }

  function updateChart(data) {
    chart.data.datasets.forEach((dataset) => {
        dataset.data.pop();
    });
    chart.update();

    chart.data.datasets.forEach((dataset) => {
        dataset.data.push(data);
    });
    chart.update();
  }

});
