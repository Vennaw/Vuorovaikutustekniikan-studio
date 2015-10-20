var apiKey = "3UK4X34LU88JB2Q5D";
var baseUrl = "https://api.spotify.com/v1/";


function getArtist(){
	var url = baseUrl + "search";
	// var args = { 
 //            format:'json', 
 //            api_key: apiKey,
 //            name: $("#searchField").val(),
 //    }; 
 	var args = { 
            q:$("#searchField").val(), 
            type: "artist",
    }; 
	$.getJSON(url, args,
            function(data) {
                var json = JSON.stringify(data,null,"\t");
                // $("#results").html(json);
                pjs.addNewArtist(0, data.artists.items[0]);

            },
            function() {
                error("Trouble getting data for " + artist);
            }
        );
}

function getArtistImage(id){
  var url;
  var artists = pjs.getArtists().toArray();
  for (var i = artists.length - 1; i >= 0; i--) {
    if(artists[i].data.id == id){
      url = artist[i].data.images[0].url;
      if(!url){
        console.log("can't find artist image!");
      }else{

      }
    }
  }
}

function getRelatedArtists(i, j, oddColumn, oddRow, artistID){
  var url = baseUrl + "artists/" + artistID + "/related-artists";
  $.getJSON(url,
    function(data){
      var json = JSON.stringify(data,null,"\t");
      pjs.addRelatedArtists(i, j, oddRow, oddColumn, data.artists);
    });
}

var pjs;

  $(document).ready(function() {
    getPjsInstance();
  });

  // obtain a reference to the processing sketch
  function getPjsInstance() {
    var bound = false;
    pjs = Processing.getInstanceById('mycanvas');
    if(pjs != null)
      bound = true;
    if(!bound)
      setTimeout(getPjsInstance, 250);
  }
