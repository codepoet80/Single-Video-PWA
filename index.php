<html>
  <head>
  <title>Latest Video</title>
  <!-- Single Video PWA. Plays the most recent video (updating every 12 hours) and nothing else 
    Copyright codepoet, 2023
  -->
  <style type="text/css">
    body, html
    {
      margin: 0; padding: 0; height: 100%; overflow: hidden;
      background-color: black;
    }
    #content
    {
      position:absolute; left: 0; right: 0; bottom: 0; top: 0px;
    }
  </style>
  <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1">
  <?php include "meta.php";?>
  <script>
  //Register service worker (stub)
  if ('serviceWorker' in navigator) {
    window.addEventListener('load', function() {
      navigator.serviceWorker.register('serviceworker.js').then(function(registration) {
        //console.log('ServiceWorker registration successful with scope: ', registration.scope);
      }, function(err) {
        console.log('ServiceWorker registration failed: ', err);
      });
    });
  }
  //Decide to refresh video or not every time we're made visible again
  var lastRefresh = new Date();
  window.addEventListener("visibilitychange", function () {
      if (document.visibilityState === "visible") {
      var now = new Date();
      //reload once an hour
      if (new Date() - lastRefresh > 1000 * 60 * 60 * 12) {
        //console.log("Refreshing to load the latest service");
        window.location.reload();
      } else {
        //console.log("Not refreshing because last load was too recent");
      }
    }
  });
  </script>
  </head>
  <body>
    <div id="content">
      <video height="100%" width="100%" controls autoplay preload="auto"/>
        <source src="video.mp4?<?php echo uniqid(); ?>" type="video/mp4">
      </video>
    </div>
  </body>
</html>
