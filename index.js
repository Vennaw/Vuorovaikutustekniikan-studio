var apiKey = "insert_echonest_apikey_here";
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
                $("#results").html(json);
                console.log(data);
            },
            function() {
                error("Trouble getting data for " + artist);
            }
        );
}