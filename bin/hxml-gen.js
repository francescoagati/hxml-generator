(function (console) { "use strict";
var Main = function() { };
Main.main = function() {
	var hxml = { name : "base"};
	var tmp;
	var tmp1;
	var this3 = hxml.libs;
	this3.push("s");
	tmp1 = this3;
	var this2 = tmp1;
	this2.push("b");
	tmp = this2;
	var this1 = tmp;
	var lst = ["a","b","c","d"];
	var _g = 0;
	while(_g < lst.length) {
		var el = lst[_g];
		++_g;
		this1.push(el);
	}
	var tmp2;
	var this5 = hxml.flags;
	this5.push("analyzer");
	tmp2 = this5;
	var this4 = tmp2;
	this4.push("" + "target" + "=" + "ios");
	var project = JSON.parse(JSON.stringify(hxml));
	project;
};
Main.main();
})(typeof console != "undefined" ? console : {log:function(){}});
