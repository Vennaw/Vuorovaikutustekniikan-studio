
var spotifyUrl = "https://api.spotify.com/v1/";
var seedRelateds;

function changeMode(radio){

  var val = radio.value;
    console.log(val);
  pjs.setMode(val);
} 

function getSimilarityIndex(hexagon, id){
  getRelatedArtistData(id, function(data){
      var similarityIndex = 0;

      for (var i = 0; i<data.artists.length; i++) {
        for(var j = 0; j<seedRelateds.artists.length; j++){
          if(seedRelateds.artists[j].name == data.artists[i].name){
            similarityIndex += 5;
          }
        }
      }
      hexagon.setSimilarityIndex(1.5*similarityIndex/100);
  });
}

function getArtist(id){
  if(id){
    var url = spotifyUrl + "artists/" + id;
    var args = null;
  }else{
    var url = spotifyUrl + "search";
    var args = { 
            q:$("#searchField").val(), 
            type: "artist",
    }; 
  }
	
	$.getJSON(url, args,
            function(data) {
                var json = JSON.stringify(data,null,"\t");
                pjs.resetCanvas();
                if(args){
                  if(data.artists.items.length == 0){
                    alert("No results found!");
                  }else{
                    pjs.addNewArtist(0, data.artists.items[0]);
                    
                    getRelatedArtistData(data.artists.items[0].id, function(data){
                      seedRelateds = data;
                      pjs.setSeedArtist();
                    });
                  }
                }else{
                  
                  $("#result2").html('<strong> Artist: '+ data.name +'</strong>');

                  pjs.addNewArtist(0, data);
                 getRelatedArtistData(data.id, function(data){
                  seedRelateds = data;
                  pjs.setSeedArtist();
                 });
                }

            },
            function() {
                error("Trouble getting data");
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
  getRelatedArtistData(artistID, function(data){
    pjs.addRelatedArtists(i, j, oddRow, oddColumn, data.artists);
  });
}

function getRelatedArtistData(id, callback){
  var url = spotifyUrl + "artists/" + id + "/related-artists";
  $.getJSON(url,
    function(data){
      callback(data);
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
