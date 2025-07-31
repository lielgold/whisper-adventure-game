extends Button

class_name PinnedWordButton

@onready var button_text :=$RichTextLabel
var sound_to_play :String=''
var dictionary_word:String = ''
var word_translation:String = ''

func initialize(word:String):
	dictionary_word = word
	sound_to_play = Translate.get_sound(word)
	word_translation = Translate.get_hebrew_translation(word)

# Called when the node enters the scene tree for the first time.
func _ready():
	var color := "8B4513"
	button_text.text = "[right][font size=20][color=" + color + "]" + word_translation + "[/color][/font][/right]"

func _on_pressed():
	AudioStreamManager.play_varried(sound_to_play)
