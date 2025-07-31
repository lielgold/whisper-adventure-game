extends Control

class_name GameScreen

var total_text :String=''
var total_inputs_num :=0
@onready var animation_player:AnimationPlayer = $AnimationPlayer

## the voice buttons in the sceen that need voice transcription.
# when the list isn't empty, voice transcription should be activated
var vb_that_need_voice_transcription:Array[VoiceButton] = []


var played_initial_sound :=false
## sound to play when the screen starts
@export_file("*.wav", "*.mp3", "*.ogg") var initial_sound_file :String= ''

var area_manager:AreaManager

func initialize(_area_manager:AreaManager):
	area_manager = _area_manager

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(Global.capture_stream_to_text!=null)
	Global.capture_stream_to_text.transcribed_msg.connect(_handle_transcribed_text)
	
	for vb in get_children():
		if vb is VoiceButton:
			vb.initialize(self)
	
	# no sound to play, so flag it as played to remove future checks inside _process.
	if initial_sound_file=='': 
		played_initial_sound=true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if !played_initial_sound and self.visible and initial_sound_file !='':
		played_initial_sound = true
		AudioStreamManager.play(initial_sound_file)


func _handle_transcribed_text(_is_partial_text, new_text):
	total_text += new_text
	total_inputs_num+=1
	
	var txt:String = new_text.to_lower()
	if txt.is_empty()==false: 
		txt = TextServerManager.get_primary_interface().strip_diacritics(txt)
	
	txt = expand_contractions(txt)
	txt = remove_punctuation(txt)
	
	if txt.is_empty():
		return
	
	for vb in get_children():
		if vb is VoiceButton:
			vb.handle_voice_input(txt)

# TODO remove this and use AreaManager function change_game_screen
func change_to_new_screen(path_to_new_screen_tscn:String):
	area_manager.change_game_screen(path_to_new_screen_tscn)

func change_to_new_area(path_to_new_area_tscn:String):
	Global.game_root.change_area_manager(path_to_new_area_tscn)

func play_audio(sound_file_path:String, add_variation:=true):
	if add_variation:
		AudioStreamManager.play_varried(sound_file_path)
	else:
		AudioStreamManager.play(sound_file_path)



func remove_punctuation(text: String) -> String:
	var regex = RegEx.new()
	regex.compile("[.,:;!?\"'()-\\[\\]{}<>/\\\\|@#%^&*_+=~`]")
	return regex.sub(text, "", true)

## add the button to the list of VB that need audio transcription. turns audio transcription on and off
## if no voice buttons need this service.
## transcription_needed - true when recording starts, false when it ends
## when the list is empty, turn off transcription service to reduce CPU load
func voice_button_needs_transcription(vb:VoiceButton, transcription_needed:bool):
	if Global.always_transcribe: 
		set_deferred("Global.capture_stream_to_text.recording", true)
		#Global.capture_stream_to_text.recording = true
		return
	
	if transcription_needed and vb_that_need_voice_transcription.has(vb)==false:
		vb_that_need_voice_transcription.append(vb)
	if !transcription_needed and vb_that_need_voice_transcription.has(vb):
		vb_that_need_voice_transcription.erase(vb)
		
	if vb_that_need_voice_transcription.is_empty(): 
		if Global.capture_stream_to_text.recording:
			Global.capture_stream_to_text.recording = false
	else:
		if !Global.capture_stream_to_text.recording:
			Global.capture_stream_to_text.recording = true
		Global.game_root.open_speech_bubble()
		Global.game_root.start_speech_bubble_close_timer()
		#set_deferred("Global.capture_stream_to_text.recording", true)

## return true if the trigger text should be ignored
# this is a bug fixing function that ignores trigger texts if they repeat themselves in the same voice button in a row
# this fixes all sort of weird behaviour (can't input new triggers because the old ones get included in the input and trigger first)
# not in use, to be removed if the bugs don't prop back up
var last_succesful_trigger_text :=''
var last_triggered_voice_button :VoiceButton=null
func should_ignore_vb_trigger(vb:VoiceButton, new_trigger_text)->bool:
	if last_triggered_voice_button==null or last_succesful_trigger_text=='': 
		return false
	if new_trigger_text==last_succesful_trigger_text and vb==last_triggered_voice_button:
		return true
	return false
	
## register the last succesful trigger text
# bug fix function, see description in should_ignore_vb_trigger
# not in use, to be removed if the bugs don't prop back up
func got_succesful_vb_trigger(vb:VoiceButton, trigger_text)->void:	
	last_triggered_voice_button = vb
	last_succesful_trigger_text = trigger_text
	
func expand_contractions(text: String) -> String:
	# Dictionary of contractions and their full forms
	const contractions = {
		"i'm": "i am",
		"you're": "you are",
		"he's": "he is",
		"she's": "she is",
		"it's": "it is",
		"we're": "we are",
		"they're": "they are",
		"i've": "i have",
		"you've": "you have",
		"we've": "we have",
		"they've": "they have",
		"i'd": "i would",
		"you'd": "you would",
		"he'd": "he would",
		"she'd": "she would",
		"we'd": "we would",
		"they'd": "they would",
		"i'll": "i will",
		"you'll": "you will",
		"he'll": "he will",
		"she'll": "she will",
		"we'll": "we will",
		"they'll": "they will",
		"can't": "cannot",
		"won't": "will not",
		"don't": "do not",
		"isn't": "is not",
		"aren't": "are not",
		"wasn't": "was not",
		"weren't": "were not",
		"hasn't": "has not",
		"haven't": "have not",
		"hadn't": "had not",
		"doesn't": "does not",
		"didn't": "did not",
		"wouldn't": "would not",
		"shouldn't": "should not",
		"couldn't": "could not",
		"mustn't": "must not",
		"let's": "let us"
	}
	
	# Convert the text to lowercase for matching
	var lower_text = text.to_lower()
	
	# Replace contractions with their full forms
	for contraction in contractions.keys():
		lower_text = lower_text.replace(contraction, contractions[contraction])
	
	return lower_text

