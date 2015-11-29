html5_file_load = require 'html5-file-load'

button.onclick = -> html5_file_load (err, file) ->
	console.log file
