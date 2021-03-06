"use strict";
var page = require('webpage').create();
phantom.onError = function(msg, trace) {
	var msgStack = ['PHANTOM ERROR: ' + msg];
	if (trace && trace.length) {
		msgStack.push('TRACE:');
		trace.forEach(function(t) {
			msgStack.push(' -> ' + (t.file || t.sourceURL) + ': ' + t.line + (t.function ? ' (in function ' + t.function +')' : ''));
		});
	}
	console.log(msgStack.join('\n'));
	phantom.exit(1);
};
<% if ${useUrl} == "true" %>var url = '<%= url %>';<% end %>
<% if ${useUrl} == "false" %>
var content = <% for cp in contentStrings %><% if ${__for_first} == "false" %>+
<% end %>'<%= cp %>'<% end %>;
var url = '';
page.setContent(content, url);<% end %>
page.paperSize = {
	width : '<%= paperWidth %>',
	height : '<%= paperHeight %>',
	orientation : '<%= paperOrientation %>'
};
page.open(url);
page.onLoadFinished = function() {
	page.render('<%= destination %>');
	phantom.exit();
}
