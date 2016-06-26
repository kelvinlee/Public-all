Array::clean = (deleteValue) ->
	i = 0
	while i < @length
		if @[i] == deleteValue
			@splice i, 1
			i--
		i++
	this

HTMLElement::getStyle = (className)->
	if @.currentStyle
		return @.currentStyle className
	else
		return document.defaultView.getComputedStyle(@,false)[className]