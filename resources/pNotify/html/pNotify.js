$(function(){
    window.addEventListener('message', function(event){
        if(event.data.options){
          var options = event.data.options;
          if(options.clearall){
              $(".noty_bar").hide();
          }else{
            new Noty(options).show();
          }
        }else{
          var maxNotifications = event.data.maxNotifications;
          Noty.setMaxVisible(maxNotifications.max, maxNotifications.queue);
        };
    });
});