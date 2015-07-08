// LOAD PAGE
var framedepth = 0;
$(document).ready(function(){
	// HIDE BODY
	$("body").hide();
	// CREATE TABS AND FRAMES
	framedepth=sites.length+1;
	$("body").append("<div id='tabs'></div>");
	$.each(sites, function(index,site){
		$("#tabs").append("<a href='#"+site.id+"' tabindex='"+(index+1)+"' class='tab'><img src='img/"+site.icon+"' id='"+site.id+"' name='"+site.name+"' title='"+site.desc+"' class='tabicon'></a>");
		$("body").append("<iframe id='"+site.id+"frame' name='"+site.id+"' src='"+site.link+"' tabindex='-1' class='tabdata' seamless></iframe>");
	});
	// SET SELECTED TAB AND FRAME
	startid=(!window.location.hash)?"#"+sites[0].id:window.location.hash;
	$(startid).trigger("click");
	// SHOW BODY
	$("body").show();
});
// CHANGE TABS
$(document).on("click", "a", function(e){
	frameid = "#"+e.target.id+"frame";
	$("iframe").hide();
	$("iframe").attr('tabindex',-1);
	$(frameid).show();
	$(frameid).attr('tabindex',framedepth);
});
