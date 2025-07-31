@icon("res://assets/images/pencil-icon.svg")
extends Node

class_name TriggerText

## This string serves as the key in the translation dictionary. It can be used to find the possible texts that, when spoken,
## will trigger responses from this voice button (animations, sounds and so on).
## If empty, the node name will be used as the translation key
## example: translation_key == 'cool scene talk to the dog'
## translation_dictionary['cool scene talk to the dog']['english translation'] -> "talk to the dog"
@export var translation_key :String= ''

## how many points to get for a succesful trigger
@export var points_gained_for_success: int = 1

## did the played already triggered this
var triggered_before: bool = false
## can this trigger happen only once
@export var can_only_be_triggered_once :bool=false

## the name of the animation to play from the game_screen object
@export var animation_to_play: String= ""

## the name of the animation to play from the game_screen object
@export var local_animation_to_play: String= ""

## make this local animation play when the button is cliked on
@export var animation_to_play_when_clicked_on: String= ""

## play this sound when the text triggers
@export_file("*.wav", "*.mp3", "*.ogg")  var sound_to_play :String= "res://assets/success.wav"
## whether to play the sound with a variation
@export var play_varied_sound: bool= true

@export var do_fade_away_animation := false
@export var do_fade_in_animation := false
## change to this texture, leave empty to not do anything
@export_file("*.png", "*.jpg", "*.webp") var change_to_texture := ""
## change to a new screen. when the button is pressed it will change to the specified screen. Leave empty to do nothing.
@export_file("*.tscn") var change_to_new_screen := ""

## make this node visible
@export var make_node_visible: Node = null

## disable trigger so it won't do anything
@export var disable_trigger := false

## prevent the same trigger to happen multiple times in a row. Should be true by default.
## there is a bug with godot-whisper where it sends the same text over and over again, so unless
## this is an edge case, you should prevent the same trigger from happening multiple times in a row (that is, keep this true)
@export var prevent_repeated_triggers := true

## This will be the new sound that will be played when the voice button is clicked on. It will not play when this text triggers.
## Leave empty to play nothing.
@export_file("*.wav", "*.mp3", "*.ogg") var new_sound_to_play_on_click: String= "select sound to play"


# Called when the node enters the scene tree for the first time.
func _ready():
	## by default if the translation key is left empty it will be set to [game screen name][trigger text name]
	## this way it's easier to see what trigger texts are available in the editor
	## ignore trigger_animations because I can't change its name due to Godot inheritence
	if translation_key.is_empty() and name!="trigger_animations": 
		translation_key = get_parent().get_parent().name +"***"+ name


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
