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

// http://docs.phonegap.com/en/1.7.0/cordova_media_capture_capture.md.html#capture.captureAudio

// Called when capture operation is finished
//
function captureSuccess(mediaFiles) {
    var i, len;
    for (i = 0, len = mediaFiles.length; i < len; i += 1) {
        uploadFile(mediaFiles[i]);
    }       
}

// Called if something bad happens.
// 
function captureError(error) {
    var msg = 'An error occurred during capture: ' + error.code;
    navigator.notification.alert(msg, null, 'Uh oh!');
}

// A button will call this function
//
function captureAudio() {
    // Launch device audio recording application, 
    // allowing user to capture up to 1 audio clip
    navigator.device.capture.captureAudio(captureSuccess, captureError, {limit: 1, duration: 7});
}

// Upload files to server
function uploadFile(mediaFile) {
    var ft = new FileTransfer(),
        path = mediaFile.fullPath,
        name = mediaFile.name;

    ft.upload(path,
        "http://my.domain.com/upload.php",
        function(result) {
            console.log('Upload success: ' + result.responseCode);
            console.log(result.bytesSent + ' bytes sent');
        },
        function(error) {
            console.log('Error uploading file ' + path + ': ' + error.code);
        },
        { fileName: name });   
}

