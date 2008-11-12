$.ajax({
  type: 'GET',
  url: 'assets/prettify.js',
  cache: true,
  success: function() { prettyPrint() },
  dataType: 'script',
  data: null
});