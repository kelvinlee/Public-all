# pugls.coffee

class Giccoo
	constructor : (@name)->
		# this.checkOrientation()
		# this.BindShare()
	# 增加微信事件.
	weixin : (callback)->
		document.addEventListener 'WeixinJSBridgeReady', callback
	# 增加旋转判断.
	checkOrientation : ()->
		orientationChange = ->
			switch window.orientation
				when 0 then reloadmeta 640,0
				when 90 then reloadmeta 641,"no"
				when -90 then reloadmeta 641,"no"
		reloadmeta = (px,us)-> 
			setTimeout ->
				viewport = document.getElementsByName("viewport")[0]
				viewport.content = "width="+px+", user-scalable="+us+", target-densitydpi=device-dpi"
			,100
		window.addEventListener 'load', ->
			orientationChange()
			window.onorientationchange = orientationChange
		window.addEventListener "load", ->
			setTimeout -> 
					window.scrollTo 0,1
	BindShare: (content,url = window.location.href,pic)->
		$ep = this
		list = 
			"qweibo":"http://v.t.qq.com/share/share.php?title={title}&url={url}&pic={pic}"
			"renren":"http://share.renren.com/share/buttonshare.do?title={title}&link={url}&pic={pic}"
			"weibo":"http://v.t.sina.com.cn/share/share.php?title={title}&url={url}&pic={pic}"
			"qzone":"http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url={url}&title={title}&pic={pic}"
			"facebook":"http://www.facebook.com/sharer/sharer.php?s=100&p[url]={url}}&p[title]={title}&p[summary]={title}&pic={pic}"
			"twitter":"https://twitter.com/intent/tweet?text={title}&pic={pic}"
			"kaixin":"http://www.kaixin001.com/rest/records.php?content={title}&url={url}&pic={pic}"
		$("a[data-share]").unbind('click').bind 'click', ->
			$ep.fShare list[$(this).data('share')],content,url,pic
	fShare: (url,content,sendUrl,pic = "")->
		# 分享内容
		content = content
		shareContent = encodeURIComponent content
		pic = encodeURIComponent pic
		url = url.replace "{title}",shareContent
		url = url.replace "{pic}",pic
		# 分享地址
		backUrl = encodeURIComponent sendUrl
		url = url.replace "{url}",backUrl
		# console.log url
		window.open url,'_blank'
	fBindRadio: (e)->
		$e = this
		e.each (i)->
			$div = $('<div>').addClass 'radio-parent '+$(this).attr 'class'
			$i = $ '<i>'
			$(this).before $div
			$div.addClass($(this).attr('class')).append $ this
			$div.append $i 
			$(this).change ->
				$o = $(this)
				$('[name='+$o.attr('name')+']').parent().removeClass 'on'
				console.log $('[name='+$o.attr('name')+']')
				setTimeout ->
					if $o.is ':checked'
						$o.parent().addClass 'on'
					else
						$o.parent().removeClass 'on'
				,10
	fBindCheckBox:(e)->
		$e = this
		e.each (i)->
			$div = $('<div>').addClass 'checkbox-parent '+$(this).attr 'class'
			$i = $ '<i>'
			$(this).before $div
			$div.addClass($(this).attr('class')).append $ this
			$div.append $i 
			$(this).change ->
				$o = $(this)
				setTimeout ->
					if $o.is ':checked'
						$o.parent().addClass 'on'
					else
						$o.parent().removeClass 'on'
				,10
	fBindSelect : (e)->
		$e = this
		e.each (i)-> 
			$div = $('<div>').addClass 'select-parent'
			$span = $ '<span>'
			$i = $ '<i>'
			$(this).before $div
			$div.addClass($(this).attr('class')).append $ this
			$div.append $span.append $(this).find('option:checked').html()
			$div.append $i 
			$(this).change ->
				$o = $(this)
				setTimeout ->
					$e.fChangeSelectVal($o)
				,10
			
	fChangeSelectVal : (o)->
		$(o).next().html $(o).find('option:checked').html()
	# 重力感应
	fBindOrientation : ()->
		window.addEventListener 'deviceorientation', this.orientationListener, false
		window.addEventListener 'MozOrientation', this.orientationListener, false
		window.addEventListener 'devicemotion', this.orientationListener, false
	orientationListener: (evt)->
		if not evt.gamma && not evt.beta
			# angle=radian*180.0/PI 在firefox中x和y是弧度值,
			evt.gamma = (evt.x * (180 / Math.PI)); # 转换成角度值,
			evt.beta = (evt.y * (180 / Math.PI)); # 转换成角度值
			evt.alpha = (evt.z * (180 / Math.PI)); # 转换成角度值
		gamma = evt.gamma
		beta = evt.beta
		alpha = evt.alpha
		if evt.accelerationIncludingGravity
			gamma = event.accelerationIncludingGravity.x*10
			beta = -event.accelerationIncludingGravity.y*10
			alpha = event.accelerationIncludingGravity.z*10
		if this._lastGamma != gamma || this._lastBeta != beta
			oriencallback beta.toFixed(2),gamma.toFixed(2),(alpha != if null then alpha.toFixed(2) else 0),gamma,beta
			this._lastGamma = gamma;
			this._lastBeta = beta;






gico = new Giccoo 'normal'