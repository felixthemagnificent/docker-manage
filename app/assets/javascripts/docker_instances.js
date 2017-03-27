$(function() {
  $('table.table').on('click', '#showLog' ,function(){
    var id = $(this).parent().parent().data('id');
    $.get({
      url: '/docker_instances/' + id + '/log',
      success: function (data) {
        eval(data);
      }
    });
  });
});