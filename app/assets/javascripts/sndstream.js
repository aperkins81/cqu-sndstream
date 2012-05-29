$(document).ready(function(){
   $("#jplayer").jPlayer({
       ready: function (event) {
           $(this).jPlayer("setMedia", {
               m4a: "url goes here"
           });
       },
       swfPath: "/",
       supplied: "m4a",
       solution: "flash, html"
   });
});

