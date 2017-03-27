App.status = App.cable.subscriptions.create("StatusChannel",
{
  connected: function ()
  {
  },
  disconnected: function ()
  {
  },
  received: function (data)
  {
    if (data.command == 'reload_row')
    {
      var id = data.id;
      $('tr[data-id=' + id + ']').html(data.html);
    }
    else if (data.command == 'send_logs')
    {
      $('#logModalText').append('<br>' + data.text);
    }
    else if (data.command == 'delete_row')
    {
      var id = data.id;
      $('tr[data-id=' + id +']').remove();
    }
  }
});
