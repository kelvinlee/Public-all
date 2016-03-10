my = {}
my.getid = (id)->
	document.getElementById id
my.getclass = (cls)->
	document.getElementsByClassName cls
my.getbyname = (name)->
	document.getElementsByName name
my.createObjectURL = (file)->
	if window.navigator.userAgent.indexOf("Chrome") >= 1 or window.navigator.userAgent.indexOf("Safari") >= 1
		return window.webkitURL.createObjectURL file
	else
		return window.URL.createObjectURL file