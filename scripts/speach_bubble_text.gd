extends RichTextLabel


func update_text():
	text = "[color=black]"+completed_text+"[/color]" + "[color=green]" + partial_text + "[/color]"

func _process(_delta):
	update_text()

var completed_text := ""
var partial_text := ""


func _on_capture_stream_to_text_transcribed_msg(is_partial, new_text):
	if text.length()>=140:
		completed_text = "" 
		clear()
		
	if is_partial == true:
		completed_text += new_text
		partial_text = ""
	else:
		if new_text!="":
			partial_text = new_text
