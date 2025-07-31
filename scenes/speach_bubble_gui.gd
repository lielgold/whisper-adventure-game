extends Control

@onready var speach_bubble_text2 := $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(Global.capture_stream_to_text!=null)	
	Global.capture_stream_to_text.transcribed_msg.connect(speach_bubble_text2._on_capture_stream_to_text_transcribed_msg)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass	
