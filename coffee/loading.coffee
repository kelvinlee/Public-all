class loading
	constructor : (@data)->
		# this.init data
	_count:0
	_now:0
	init: (data)->
		this._count = data.length
		for i in data
			img = new Image()
			img.onload = this.loadimg
			img.pe = this
			img.src = i.src
	loadimg: (e)->
		this.pe._now++
		this.pe._progress this.pe._now
	_progress: (n)->
		# console.log n,this._count,n/this._count
		this.progress n,this._count
		this.finished() if n is this._count
	finished: ->
		console.log 'finished'
	progress: (now,count)->
