@tool
class_name E_Downloader
extends HTTPRequest

func download_script(url: String, save_path: String) -> void:
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.request_completed.connect(self._on_request_completed.bind([save_path]))
	http_request.request(url)


func _on_request_completed(result, response_code, headers, body, save_path):
	if response_code == 200:
		save_path = save_path[0]
		var file = FileAccess.open(save_path, FileAccess.WRITE)
		file.store_buffer(body)
		file.close()
		print("Element download completed: ", save_path.get_file().split(".")[0])
		preload("res://addons/Elementum/ElementManager.gd").new().on()
	else:
		printerr("Failed to download \"{Element}\": {ERR}".format({"Element": save_path.get_file().split(".")[0],"ERR": response_code}))
	queue_free()
