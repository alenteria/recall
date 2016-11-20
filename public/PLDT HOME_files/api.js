HOST = "http://localhost:3000";
// == LOAD LIBRARIES
var loadCss = function(src, location){
  var link = document.createElement( "link" );
  link.href = src;
  link.type = "text/css";
  link.rel = "stylesheet";
  link.media = "screen,print";
  location.appendChild(link);
}
var loadJS = function(url, implementationCode, location){
    var scriptTag = document.createElement('script');
    scriptTag.src = url;
    scriptTag.onload = implementationCode;
    scriptTag.onreadystatechange = implementationCode;
    location.appendChild(scriptTag);
};
// == LOAD LIBRARIES

// === MAIN FUNCTIONS
var MAIN = function(){
  var widget = "";
  $('body').append(widget);
  $("#habla_panel_div").remove();
  $("#msSurveySuperHolder").remove();
}
// === MAIN FUNCTIONS

window.onload= function(){
  loadCss(HOST+"/api/style.css", document.body);
  loadJS('http://cdn.sinch.com/latest/sinch.min.js', function(){}, document.body);
  if(typeof jQuery == 'undefined'){
    loadJS(HOST+"/api/jquery.min.js", function(){
      MAIN
    }, document.body);
  }else{
    MAIN
  }
}