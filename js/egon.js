let chart = {};

function renderChart (index) {
  chart['chart' + index] = new Highcharts.Chart({
    chart: {
      type: 'spline',
      renderTo: 'chart0'
    },
    title: {
      text: 'Live Data (CSV)'
    },

    subtitle: {
      text: 'Data input from a remote CSV file'
    },

    series: [ {
      name: 'P_suction',
      yAxis: 0,
      data: [],
      tooltip: {
        valueDecimals: 3,
        valueSuffix: ' bar abs'
      }
    }],

    data: {
      // data: 'https://demo-live-data.highcharts.com/time-data.csv',
      // csvURL: '/timedata',
      // itemDelimiter: ',',
      // lineDelimiter: '\n',
      // decimalPoint: '.'

      // enablePolling: false
    }
  });
}

function connectChart (index) {
  let sock = new WebSocket(getBaseURL() + '/chart/' + index);

  sock.onmessage = function (msg) {
    console.log(msg.data);
    var msgJson = JSON.parse(msg.data);
    setSeries('chart' + index, msgJson);
  };
  sock.onopen = function () {
    window.setInterval(function () {
      sock.send(JSON.stringify({action: 'rqs', time_span: 0, offset: 0}));
    }, 2000);
  };
  sock.onclose = function () {
    sock.send(JSON.stringify({action: 'close'}));
  };
}

function setSeries (id, res) {
  let c = chart[id];

  if (c && res !== null) {
    console.log(res);

    var seriesSize = Math.min(res.length, c.series.length);
    for (let i = 0; i < seriesSize; i++) {
      c.series[i].setData(res[i], true, false);
    }

    // c.data.csv = res;
    // c.update({
    // data: {
    // csv: res
    // }
    // });
    // chart.hideLoading();
    // chart.redraw(true);
  } else {
    console.log('setSeries: series is null');
  }
}

function getBaseURL () {
  var href = window.location.href.substring(7); // strip "http://"
  var idx = href.indexOf('/');
  return 'ws://' + href.substring(0, idx);
}
