@icon("res://assets/images/gui/Sound-Icon.svg")
extends TextureButton

class_name VoiceButton

signal vb_triggered(text:String)
signal vb_clicked()

## this is the word that will be added to the dictionary (if found).
@export var dictionary_word :String= ""

## search for sound in dictionary and play it on click
@export var use_sound_from_dictionary :bool=true

## sound to play when clicked on, not used if use_sound_from_dictionary is true
@export_file("*.wav", "*.mp3", "*.ogg") var sound_to_play_on_click :String= "res://assets/beep.wav"

## screen animation to play when clicked on
@export var screen_animation_clicked_on :String= ""
## play the animation on each click or only once
@export var play_sceen_animation_once :bool= true
var screen_animation_played :=false

## local animation to play when clicked on
@export var local_animation_clicked_on :String= ""
@export var play_local_animation_once :bool= true
var _played_local_animation_once :bool= false

## whether to automatically pin this word
@export var pin_this_word :bool= false

## change to this texture on click
@export_file("*.png", "*.webp", "*.jpg") var change_to_this_texture_on_click :String= ''

## basic animations that work on this button
const ANIM_FADE_AWAY := "fade_away"
const ANIM_FADE_IN := "fade_in"


var started_activation_timer :=false
## the time to speak to the mic
const activation_timer_duration :float= 5
## extra time for the engine to transcribe the audio and check if it matches the text in the dictionary. it shouldn't take new input.
const activation_timer_duration_extra_time :float= 2 
var activation_timer_elapsed :float= 0

@onready var progress_bar_timer := $recording_timer
@onready var trigger_counter := $trigger_count_progress_bar

@onready var animation_player :AnimationPlayer= $AnimationPlayer

## show particles that show the object can be interacted with
@export var show_usable_animation :=true
@onready var usable_particles :CPUParticles2D= $InteractivityParticles2D
const star_particles_blue = preload("res://assets/particles/star_blue.png")
const star_particles_pink = preload("res://assets/particles/star_pink.png")

var mouse_is_inside:=false

# a timer for the particles
var usable_timer_elapsed :float= 0
var usable_timer_active_duration :float= randf_range(2.5, 3.5)
var usable_timer_wait_duration :float= randf_range(2.5, 3.5)

# texts and the events they trigger
var has_translation_key :=false
## if change_to_new_screen isn't empty, change to this game_screen when the button is clicked on
@export_file("*.tscn") var change_to_new_screen :=''

var game_screen :GameScreen

func initialize(_game_screen:GameScreen):
	game_screen = _game_screen

# Called when the node enters the scene tree for the first time.
func _ready():
	for c in get_children():
		if c is TriggerText:
			if c.translation_key.is_empty()==false:
				has_translation_key =true
	
	if dictionary_word=='':
		push_warning("you forgot to fill a dictionary_word for: " + name)
	
	# get translated image if there is one
	var path_to_image :String= Translate.get_translated_image(dictionary_word)
	if path_to_image.is_empty()==false:
		texture_normal = load(path_to_image)
	
	# put particles in the middle of the sprite if the user hasn't moved it on their own
	if usable_particles.position == Vector2.ZERO:
		usable_particles.position.x += size.x/2
		usable_particles.position.y += size.y/2
	usable_particles.emitting = false
	
	# setup the trigger counter
	# find how many possible triggers are there
	var max_triggers :int=0
	var triggered_count :int=0
	for c in get_children():
		if c is TriggerText:
			if c.points_gained_for_success>0 and c.translation_key.is_empty()==false and c.disable_trigger==false:
				max_triggers+=1
				if c.triggered_before:
					triggered_count+=1
	trigger_counter.max_value = max_triggers
	trigger_counter.value = triggered_count
	
	progress_bar_timer.visible = false
	trigger_counter.visible = false
	
	# sanity checks, only for the editor
	if OS.is_debug_build():
		for c in get_children():
			if c is TriggerText:
				if c.translation_key.is_empty()==false:
					if !does_string_contain_translated_trigger_text(c.translation_key, c.translation_key):
						push_warning(c.translation_key + " could not be found in the transation dictionary")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if started_activation_timer:
		activation_timer_elapsed +=delta
		if activation_timer_elapsed>activation_timer_duration:
			progress_bar_timer.visible = false
		if activation_timer_elapsed > activation_timer_duration + activation_timer_duration_extra_time: 
			started_activation_timer=false
			game_screen.voice_button_needs_transcription(self, false)

		progress_bar_timer.value = (activation_timer_elapsed / activation_timer_duration)*100		
		
	
	# active usable particles by timer
	if show_usable_animation:
		if !mouse_is_inside:
			usable_timer_elapsed +=delta
			if usable_timer_elapsed < usable_timer_wait_duration:
				usable_particles.emitting = false
			elif usable_timer_elapsed < usable_timer_wait_duration + usable_timer_active_duration:
				usable_particles.emitting = true
			else:
				usable_particles.emitting = false
				usable_timer_elapsed = 0
			

## does the given input_text contains the translation of a word from the dictionary
## Example: 
## input_text 'talk to woman and do other things'
## translation_key is 'woman house talk to woman'
## translation_dictionary['woman happy talk to woman'][english translations] returns 'talk to woman'
func does_string_contain_translated_trigger_text(input_text:String,translation_key:String)->bool:
	if translation_key.is_empty(): return false
	var dict_entry :Dictionary={}
	if Translate.trigger_texts_translation.has(translation_key):
		dict_entry = Translate.trigger_texts_translation.get(translation_key)
	else:
		# tgus uses the trigger node name as the translation of the trigger
		# the key is set by default to game_screen_name***trigger_text_node_name
		var spl = translation_key.split("***")
		spl = spl[1]
		dict_entry = {"word_eng" : [spl]}

	
	# check if the translated pharse appears in the input_text
	var word_lang :String= 'word_eng'
	assert(word_lang.is_empty()==false)
	
	## check if the input contains one of the accpeted spelling options:
	## "I am called" is an acceptable substitue for "I am cold"
	for spelling in dict_entry[word_lang]:
		spelling = spelling.to_lower().strip_edges()
		if input_text.to_lower().contains(spelling):
			return true
	return false

func handle_voice_input(voice_input:String):
	if voice_input.is_empty():
		return
	if started_activation_timer:
		for c in get_children():
			if c is TriggerText:
				# ignore disabled triggers
				if c.disable_trigger or (c.triggered_before and c.can_only_be_triggered_once):
					continue
				# prevent the same TriggerText from happening mutiple times in a row
				# This is a bug fix due to the way godot-whisper works, which sends the same transcription over and over again, with no reset mechanism.
				# so the same trigger happens instantly over and over again				
				if c.prevent_repeated_triggers and game_screen.should_ignore_vb_trigger(self,c.translation_key):
					continue
				# finally, does the voice input contains the trigger text
				if does_string_contain_translated_trigger_text(voice_input, c.translation_key):
					# play animations
					if c.do_fade_away_animation:
						play_local_animation(ANIM_FADE_AWAY)
					if c.do_fade_in_animation: 
						play_local_animation(ANIM_FADE_IN)
					if c.animation_to_play.to_lower().strip_edges().is_empty()==false:
						game_screen.animation_player.play(c.animation_to_play.to_lower())
					if c.change_to_texture !="": 
						texture_normal= load(c.change_to_texture)
					if c.change_to_new_screen !="": 
						change_to_new_screen = c.change_to_new_screen
					if c.local_animation_to_play.to_lower().strip_edges().is_empty()==false:
						play_local_animation(c.local_animation_to_play.to_lower())
					if c.animation_to_play_when_clicked_on !="":
						local_animation_clicked_on = c.animation_to_play_when_clicked_on
					if c.new_sound_to_play_on_click !="select sound to play":
						sound_to_play_on_click = c.new_sound_to_play_on_click
						use_sound_from_dictionary=false						
						
					if c.make_node_visible != null:
						c.make_node_visible.visible = true
					
					# play sounds
					if c.sound_to_play.is_empty()==false:
						if c.play_varied_sound:
							AudioStreamManager.play_varried(c.sound_to_play)
						else:
							AudioStreamManager.play(c.sound_to_play)
					
					progress_bar_timer.visible=false
					started_activation_timer = false
					game_screen.voice_button_needs_transcription(self, false)
					game_screen.got_succesful_vb_trigger(self,c.translation_key)
					if !c.triggered_before:
						c.triggered_before= true
						trigger_counter.value+=1
						Global.area_manager.add_area_points(c.points_gained_for_success)
					emit_signal("vb_triggered",c.translation_key)
					break

					
	

func start_timer():
	started_activation_timer = true
	activation_timer_elapsed =0
	progress_bar_timer.visible = true
	
	# start voice transcription
	game_screen.voice_button_needs_transcription(self, true)
	

func _on_button_up():
	if Input.is_action_just_released("interact_with_object"):
		emit_signal("vb_clicked")
		# if change_to_level isn't empty, than change level when clicking on this button
		if change_to_new_screen.is_empty()==false:
			Global.area_manager.change_game_screen(change_to_new_screen)
		else:
			# normal clicked on object, play sound ("door!") or animation (show "open the door" sign)		
			var sound_to_play := sound_to_play_on_click
			# if this is a dictionary word, get data from there and add it to the player's known words if they don't know it yet
			if dictionary_word.is_empty() ==false:
				# add word to dictionary
				assert(Translate.dictionary_words.has(dictionary_word), "voice button tried to find a word in the dictionary and couldn't find it")
				Global.game_root.add_word_to_dictionary(dictionary_word,pin_this_word)
				# get soudn from dictionary
				if use_sound_from_dictionary and Translate.dictionary_words[dictionary_word].sound_eng.is_empty()==false:
					sound_to_play = Translate.get_sound(dictionary_word)
			
			if sound_to_play.is_empty()==false:
				AudioStreamManager.play(sound_to_play)
			
			## change texture
			if change_to_this_texture_on_click.is_empty()==false:
				texture_normal = load(change_to_this_texture_on_click)
			
			# play clicked on animation
			if screen_animation_clicked_on.is_empty() ==false:
				if !play_sceen_animation_once or (play_sceen_animation_once and screen_animation_played==false):
					game_screen.animation_player.play(screen_animation_clicked_on)
					screen_animation_played=true
			
			# play local clicked on animation
			if local_animation_clicked_on!='':
				# do animation if it should be played every click, or if it should be played only once and hasn't been played
				if !play_local_animation_once or (play_local_animation_once and !_played_local_animation_once):
					play_local_animation(local_animation_clicked_on)
					_played_local_animation_once=true
			
		
	elif Input.is_action_just_released("talk_to_object") and has_translation_key:
		start_timer()

func play_local_animation(animation_name):
	if animation_player.is_playing():
		animation_player.queue(animation_name)
	else:
		animation_player.play(animation_name)	
	

func _on_mouse_entered():
	mouse_is_inside = true
	if show_usable_animation:
		usable_particles.emitting = true
		if trigger_counter.max_value!=0:
			trigger_counter.visible=true

func _on_mouse_exited():
	mouse_is_inside = false
	usable_particles.emitting = false
	trigger_counter.visible=false
