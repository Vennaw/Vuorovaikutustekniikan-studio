$(document).ready(function(){
    var onFail = function(e) {
    	        console.log('Rejected!', e);
    	    };
    		 	
    var onSuccess = function(s) {
    	var context = new AudioContext();
        var mediaStreamSource = context.createMediaStreamSource(s);
        
        rec = new Recorder(mediaStreamSource);
        hasPri = true;
    }
    	
    var onFail = function(s){
    	document.getElementById('result2').innerHTML = "<strong>The request to record is rejected.</strong";
    }

    function startRecording() {
        if (navigator.getUserMedia) {
            navigator.getUserMedia({audio: true}, onSuccess, onFail);
            
        } else {
            console.log('navigator.getUserMedia not present');
            document.getElementById('result2').innerHTML = 
            	"<mark><strong>Your browser doesn't support audio recording.</mark><div>" +
            	"Please use <em><a href=\"http://www.google.cn/chrome\">Chrome</a></em>, " +
            	"<em><a href=\"http://www.firefox.com\">Firefox</a></em> or " + 
            	"<em><a href=\"http://www.opera.com\">Opera</a></em> instead.</strong>";
            safari = true;
        }
    }

    var socket = io();

    function sendRequest( data ){
    		socket.emit('identify', data);
    }

    socket.on('response', function(data){
        var json = JSON.parse(data);
        if(json.status.msg == "Success"){
            if(recording){
                stopRecording();
                console.log(json);
                getArtist(json.metadata.music[0].external_metadata.spotify.artists[0].id);
            }
        }else{
            console.log(json);
        }
    })
      
    navigator.getUserMedia  = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia;

    var rec;
    var audio = document.querySelector('#audio');
    var recording = false;
    var hasPri = false;
    var safari = false;
    var hasres = false;
    startRecording();

    var intervalKey;
    var timeoutKey;
    var trying = false;






    $("#record").click(function() {
    	if( safari ){
    		return;
    	}
       if( !hasPri ){
    	   document.getElementById('result2').innerHTML = "<strong><em>Has no authority to use your microphone.</em><strong>";
    	   return;
       }
       if( !recording ){
    	   document.getElementById('result2').innerHTML ='<strong>Searching...</strong>';
    	   $('#record').addClass("active");
    	   rec.record();
    	   recording = true;
    	   trying = true;
    	// export a wav every three seconds, so we can send it
           intervalKey = setInterval(function() {
                rec.exportWAV(function(blob) {
           			sendRequest( blob );
                });
            }, 3000);
           
            timeoutKey = setTimeout(function(){
            	console.log('timeout');
            	if( !hasRes ){
            		document.getElementById('result2').innerHTML ='<strong>No result, try again...</strong>';
            	}
            	stopRecording();
            }, 15000);
            
       }else{
    	   stopRecording();
       }
    });

    function stopRecording(){
    	console.log('stopRecording');
        document.getElementById('result2').innerHTML ='';
    	$('#record').removeClass("active");
        clearInterval(intervalKey);
    	clearTimeout(timeoutKey);
    	rec.stop();
    	recording = false;
    	trying = false;
    	hasRes = false;
    }
});