fs        = require 'fs'
express   = require 'express'
highlight = require("highlight").Highlight
jqtpl     = require 'jqtpl'

app = express.createServer()

app.configure ->
	app.set 'root', __dirname
	app.set 'view engine', 'html'
	app.register '.html', jqtpl.express
	
	app.use express.static "#{__dirname}/../public"
	app.use app.router

app.get '*', (req, res) ->
	fs.readFile './lib/sample.json', 'utf-8', (err, file) ->
		res.render 'debug',
			layout: false,
			locals:
				body: highlight file
		
		
app.listen 3777