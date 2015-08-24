/* main.js
   root namespace 
*/

/*jslint
  browser : true,
  continue : true,
  devel : true,
  indent : 2,
  maxerr : 50,
  newcap : true,
  nomen: true,
  plusplus : true,
  regexp : true,
  sloppy : true,
  vars : true,
  white : true
*/
/*global $, main */

var main = (function () {
    var 
    jqueryMap = {},

    loadURL,
        
    initModule = function ($control, $content) {
        setJqueryMap($control, $content);
        
        jqueryMap.$search.click( loadURL );
    };

    loadURL = function () {
        console.log(jqueryMap.$input.val());
//        jqueryMap.$content.load(jqueryMap.$input.val());
        jqueryMap.$content.attr('src',jqueryMap.$input.val());
    };
    // DOM methods
    // _setJqueryMap_
    setJqueryMap = function ($control, $content) {
        jqueryMap = {
            $input: $control.find( '#query' ),
            $search: $control.find( '#search' ),
            $expand: $control.find( '#expand' ),
            $content: $content
        };
    };
    return { initModule: initModule };
}());
           
        
        
