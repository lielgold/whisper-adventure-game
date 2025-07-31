extends RichTextLabel

# how long should subtitles stay on screen after the sound ended
const SUBTITLE_EXTRA_DURATION :float=1
const RIGHT_PADDING_FOR_THUMBNAIL_POSITION :int=50

@onready var character_thumbnail :TextureRect= $"character thumbnail"

var active_time:float=0
var subtitle_duration:float

func initialize(_subtitle_text:String, _subtitle_duration:float, char_thumbnail_path:String=''):
	character_thumbnail = $"character thumbnail"
	self.text = "[center][font size=40][color="+ str('ffffff') + "][outline_color=" + str('000000') + "][outline_size=9]"+ \
		_subtitle_text + \
		"[/outline_size][/outline_color][/color][/font][/center]"	
	
	subtitle_duration = get_subtitle_duration(_subtitle_text,_subtitle_duration)
	if char_thumbnail_path=='': 
		character_thumbnail.visible = false
	else:
		character_thumbnail.texture = load(char_thumbnail_path)
		

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
var placed_thumbnail :=false
func _process(delta):
	# place the thumbnail next to the text. This has to be done after _ready since the text size isn't fixed at that point. 
	active_time+=delta
	if !placed_thumbnail:
		placed_thumbnail=true
		character_thumbnail.position.x = float(size.x)/2 + float(get_content_width())/2 + RIGHT_PADDING_FOR_THUMBNAIL_POSITION
		character_thumbnail.visible = true
		
	if active_time>=subtitle_duration:
		get_parent().remove_child(self)
		queue_free()

func _count_words(input_string: String) -> int:
	var words = input_string.split(" ")
	var word_count = 0
	for word in words:
		if word != "":
			word_count += 1
	return word_count

	
func get_subtitle_duration(subtitle_text:String,sound_length:float)->float:
	var num_words :int= _count_words(subtitle_text)
	# appearntly children at the third grade read roughly one word a second, so this should serve as a rough estimate
	return max(sound_length, num_words) +SUBTITLE_EXTRA_DURATION
