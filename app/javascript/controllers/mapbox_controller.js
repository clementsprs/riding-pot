import { Controller } from "@hotwired/stimulus"
import mapboxgl from "mapbox-gl"

export default class extends Controller {
  static values = {
    apiKey: String,
    page: String,
    markers: Array,
    markersIndex: Array
  }

  connect() {
    console.log(this.pageValue)
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })
    if (this.pageValue === "index") {
    this.#addMarkersToIndexMap()
    this.#fitMapToIndexMarkers()
    this.#staticImage(this.markersValue)}
    else {
    this.#displayJourneyReshaped(this.map, this.markersValue)
    this.#fitMapToJourney()}
  }

  #addMarkersToIndexMap() {
    this.markersIndexValue.forEach((marker) => {
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(this.map)
    });
  }

  #fitMapToJourney() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(markers => bounds.extend([ markers[0], markers[1] ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }

  #fitMapToIndexMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersIndexValue.forEach(markersIndex => bounds.extend([ markersIndex.lng, markersIndex.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }

  #displayJourneyReshaped(map, coords) {
    //on transforme nos coordonées en string pour l'appel de l'API
    var newCoords = [];
    var maxVal = 97;
    var delta = Math.floor( coords.length / maxVal );
    for (var i = 0; i < coords.length; i=i+delta) {
      newCoords.push(coords[i]);
    }
    var coordsString = newCoords.join(';');
    //choix du type d'itinéraire que l'on souhaite calculer (par exemple avec "walking" on ne fera pas le tour d'un rond point, avec "driving" si.
    var typeRoute = 'cycling'; //cycling, walking, driving-traffic
    var directionsRequest = 'https://api.mapbox.com/matching/v5/mapbox/'+typeRoute+'/' + coordsString + '?geometries=geojson&access_token=' + this.apiKeyValue;
    var xhr = new XMLHttpRequest();
    xhr.open('GET', directionsRequest);
    xhr.onload = function () {
        if (xhr.status === 200) {
            var response = JSON.parse(xhr.responseText);
            //on récupère la données calculé qui nous permettra d'afficher l'itinéraire
            var route = response.matchings[0].geometry;
            //add layer
            map.addLayer({
                id: 'journeyReshaped', //identifiant unique de l'objet
                type: 'line',
                source: {
                    type: 'geojson',
                    data: {
                        type: 'Feature',
                        geometry: route //utilisation de l'itinéraire
                    }
                },
                paint: {
                    'line-color': "#14453D", //couleur de la ligne
                    'line-width': 3, //epaisseur de la ligne
                    'line-opacity': 0.8 //opacité de la ligne
                }
            });
        } else {
            //en cas d'erreur ajax
            console.log('Request failed.  Returned status of ' + xhr.status);
        }
    };
    xhr.send();
}


#staticImage(coords) {
var polyline = require('@mapbox/polyline');
console.log(polyline);
console.log(coords.length)
var newCoords = [];
var maxVal = 97;
var delta = Math.floor( coords.length / maxVal );
console.log(delta);
for (var j = 0; j < coords.length; j=j+delta) {
  newCoords.push(coords[j]);
}
console.log(newCoords);
var path = polyline.encode(newCoords);
console.log(path);
console.log(polyline.decode(path))
var directionsRequest = 'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/path-5+f44-0.5(%7DrpeFxbnjVsFwdAvr@cHgFor@jEmAlFmEMwM_FuItCkOi@wc@bg@wBSgM)/auto/500x500?access_token=' + this.apiKeyValue;
var xhr = new XMLHttpRequest();
xhr.open('GET', directionsRequest);
xhr.onload = function () {
    if (xhr.status === 200) {
        var response = JSON.parse(xhr.responseText);
        console.log(response)
        //on récupère la données calculé qui nous permettra d'afficher l'itinéraire
        var route = response.matchings[0].geometry;
        //add layer
        map.addLayer({
            id: 'journeyReshaped', //identifiant unique de l'objet
            type: 'line',
            source: {
                type: 'geojson',
                data: {
                    type: 'Feature',
                    geometry: route //utilisation de l'itinéraire
                }
            },
            paint: {
                'line-color': "#14453D", //couleur de la ligne
                'line-width': 3, //epaisseur de la ligne
                'line-opacity': 0.8 //opacité de la ligne
            }
        });
    } else {
        //en cas d'erreur ajax
        console.log('Request failed.  Returned status of ' + xhr.status);
    }
};
xhr.send();

}


}
