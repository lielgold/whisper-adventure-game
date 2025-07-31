extends Node

const subtitle_resource := preload("res://scenes/gui/subtitle.tscn")

@onready var gui :Control= $"gui"
@onready var dictionary_menu :Control= $gui/dictionary_menu
@onready var open_dictionary_menu_animation_player :AnimationPlayer= $gui/open_dictionary_menu/AnimationPlayer
@onready var speech_bubble :Control= $gui/speech_bubble
@onready var open_speech_bubble_button :Control= $gui/open_speech_bubble
@onready var pinned_words :Control= $"gui/pinned words"
@onready var progress_bar :TextureProgressBar= $gui/progression_bar
@onready var progress_bar_particles :CPUParticles2D= $gui/progression_bar/InteractivityParticles2D
@onready var progress_bar_button :Button= $gui/progression_bar/Button
@onready var progress_bar_text :RichTextLabel= $gui/progression_bar/RichTextLabel
@onready var progress_bar_animation_player :AnimationPlayer= $gui/progression_bar/AnimationPlayer
@onready var subtitles_container :VBoxContainer = $gui/subtitles/VBoxContainer


@onready var gui_animation :AnimationPlayer= $gui/AnimationPlayer

# gui animations
const gui_anim_fade_in_progress_bar :String= "fade_in_progress_bar"
const gui_anim_win_animation :String= "win_animation"
const PROGRESS_BAR_SPIN_ANIMATION :String= "spin_progress_bar"

## timer to close the speech bubble. when it reaches zero, close the speech bubble. this way it will automatically close and open.
const SPEECH_BUBBLE_LINGER_DURATION :float = 3 # how long to keep the bubble open after transcription ended
var close_speech_bubble_elapsed:float = 0
var close_speech_timer_started :=false

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.game_root = self
	for c in get_children():
		if c is AreaManager:
			c.initialize(self)
			Global.area_manager = c
	
	# fixes a bug that's not worth chasing
	Global.mic_player.play()
	Global.audio_player.stop()
		
	if OS.get_name() == "Android":
		OS.request_permission("android.permission.RECORD_AUDIO")
	
	# handle subtitles
	AudioStreamManager.connect("sound_started_playing", add_subtitle)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if close_speech_timer_started:
		close_speech_bubble_elapsed+=_delta
		if close_speech_bubble_elapsed > VoiceButton.activation_timer_duration + SPEECH_BUBBLE_LINGER_DURATION:
			close_speech_bubble()
			close_speech_timer_started = false
			close_speech_bubble_elapsed = 0


func change_area_manager(path_to_new_area_tscn:String):
	for c in get_children():
		if c is AreaManager:
			remove_child(c)
			c.queue_free()
			
	var new_area :AreaManager= load(path_to_new_area_tscn).instantiate()
	new_area.initialize(self)
	Global.area_manager = new_area
	add_child(new_area)
	move_child(new_area,0) # this ensures the gui is drawn above the game	
	
		

func toggle_text_to_speech()->void:
	if Global.capture_stream_to_text.recording:
		Global.capture_stream_to_text.recording = false
	else: Global.capture_stream_to_text.recording = true

# add a word to the dictionary of known words
func add_word_to_dictionary(word:String, automatically_pin_word:bool)->void:
		var word_data = Translate.dictionary_words.get(word)
		assert(word_data!=null, "tried to find a word in the dictionary and couldn't find it")
		if Global.known_dictionary_words.has(word):
			return
		else:
			Global.known_dictionary_words.append(word)
			dictionary_menu.add_word_button(word)
			if automatically_pin_word:
				pinned_words.add_pinned_word(word)
			open_dictionary_menu_animation_player.play("new_word_added")
			

func _on_open_dictionary_menu_button_pressed():
	dictionary_menu.update_menu(pinned_words.get_pinned_words())
	dictionary_menu.visible = true

func _on_open_speech_bubble_pressed():
	speech_bubble.visible = true
	open_speech_bubble_button.visible = false
	
func open_speech_bubble():
	speech_bubble.visible = true
	open_speech_bubble_button.visible = false

func close_speech_bubble():
	speech_bubble.visible = false
	open_speech_bubble_button.visible = true

func start_speech_bubble_close_timer()->void:
	close_speech_timer_started = true
	close_speech_bubble_elapsed = 0


func enable_progress_bar_button(object_with_function_to_call:Object, function_to_call_when_pressing_the_button:String)->void:
	progress_bar_particles.emitting = true
	progress_bar_button.disabled = false
	progress_bar_animation_player.play(PROGRESS_BAR_SPIN_ANIMATION)
	progress_bar_button.connect("pressed", Callable(object_with_function_to_call, function_to_call_when_pressing_the_button))

func reset_progress_bar()->void:
	progress_bar.rotation = 0
	progress_bar.value = 0
	progress_bar_particles.emitting=false
	progress_bar_button.disabled = true
	progress_bar_animation_player.stop()
	

func set_progress_bar_points(num_points:int)->void:
	progress_bar.value = num_points
	

func set_progress_bar_max_points(num_points:int)->void:
	progress_bar.max_value = num_points
	
func do_gui_animation(anim_name:String)->void:
	gui_animation.play(anim_name)
	
func play_sound(sound_name:String)->void:
	AudioStreamManager.play(sound_name)
	

func _on_progress_bar_button_pressed():
	do_gui_animation(gui_anim_win_animation)


func _on_progression_bar_mouse_entered():
	if progress_bar.value<progress_bar.max_value:
		progress_bar_text.visible = true
		progress_bar_text.text = "[color=black]" + str(progress_bar.value) + "/" + str(progress_bar.max_value) + "[/color]"
	else:
		progress_bar_text.visible = false
	
func _on_progression_bar_mouse_exited():
	progress_bar_text.visible = false

func gui_cinematic_started():
	gui.visible=false
	
func gui_cinematic_ended():
	gui.visible=true
	
func erase_pinned_words()->void:
	var a :Array[String]=[] 
	dictionary_menu.update_menu(a) # empty array -> no pinned words
	pinned_words.remove_all_pinned_words()

func add_subtitle(sound_file_path:String, sound_length:float):
	var new_subtitle := subtitle_resource.instantiate()
	if SubtitlesData.subtitles_data.has(sound_file_path)==false:
		return
	var text = SubtitlesData.get_text(sound_file_path)
	var speaker = SubtitlesData.get_speaker(sound_file_path)
	new_subtitle.initialize(text,sound_length, speaker)
	subtitles_container.add_child(new_subtitle)
	
	# limit subtitles to two at most
	if subtitles_container.get_child_count()>2:
		var n := subtitles_container.get_child(0)
		subtitles_container.remove_child(n)
		n.queue_free()
