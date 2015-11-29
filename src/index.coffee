$ = require 'jquery'

module.exports = (options, callback) ->
	[options, callback] = [{}, options] unless callback?

	type = options.type ? String
	accept = options.accept ? '*'
	multiple = options.multiple ? false

	inp = $("""<input type="file" accept="#{accept}"/>""")

	inp.attr('multiple', '') if multiple

	inp.bind('change', ((event) ->
		files = event.target.files

		return callback new Error 'no files' unless files.length > 0

		for file in files
			file_reader = new FileReader

			file_reader.onabort = (error=(new Error 'abort')) -> callback error
			file_reader.onerror = (error=(new Error 'error')) -> callback error

			file_reader.onload = -> callback null, file_reader.result, file.name

			method = switch
				when type is ArrayBuffer then 'readAsArrayBuffer'
				when type is String then 'readAsText'
				when type is Blob then 'readAsBlob'
				else 'readAsText'

			file_reader[method] file

	)).click()
