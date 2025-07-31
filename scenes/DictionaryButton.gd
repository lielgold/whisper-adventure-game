extends Button

class_name DictButton

const pin1 = preload("res://assets/images/gui/dictionary/pin 1.PNG")
const pin2 = preload("res://assets/images/gui/dictionary/pin 2.PNG")
const pin3 = preload("res://assets/images/gui/dictionary/pin 3.PNG")
const pin4 = preload("res://assets/images/gui/dictionary/pin 4.PNG")
const pin5 = preload("res://assets/images/gui/dictionary/pin 5.PNG")

## The length of the dictionary string. This makes sure the string fits nicely on the page
const STRING_LENGTH = 30

@onready var button_text := $RichTextLabel
@onready var pin_texture := $pin_TextureRect

var dictionary_menu:Control
var translation_key :String
var translated_word:String
var translated_to_student:String
var definition_img_standard:String
var sound_path:String
var is_pinned:bool=false

func initialize(_dictionary_menu, _translation_key:String, _translation:String, _definition_img_standard:String='', _sound_path=''):
	dictionary_menu = _dictionary_menu
	translation_key = _translation_key	
	translated_word = Translate.get_translated_word(_translation_key)
	#word = _word
	translated_to_student = _translation
	definition_img_standard = _definition_img_standard
	sound_path = _sound_path
	
	var txt := translated_word.capitalize()
	for i in range(0,STRING_LENGTH-len(translation_key)-len(translated_to_student)):
		txt += " "
	txt += translated_to_student
	
	button_text = $RichTextLabel
	button_text.text = "[center]" + txt + "[/center]"
	
	pin_texture = $pin_TextureRect
	var n = randi_range(1,5)
	if n ==1: pin_texture.texture_normal = pin1
	elif n==2: pin_texture.texture_normal = pin2
	elif n==3: pin_texture.texture_normal = pin3
	elif n==4: pin_texture.texture_normal = pin4
	elif n==5: pin_texture.texture_normal = pin5
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_pressed():
	dictionary_menu.word_button_selected(self)
	
func update_pinned_visuals():
	if is_pinned:
		pin_texture.self_modulate.a = 1
	else:
		pin_texture.self_modulate.a = 0


func _on_pin_texture_rect_pressed():
	if is_pinned: 
		Global.game_root.pinned_words.remove_pinned_word(translation_key)
		is_pinned=false
	else: 
		var added_word:bool = Global.game_root.pinned_words.add_pinned_word(translation_key)
		if added_word: # false if player maxed the number of words they can pin
			is_pinned=true
	update_pinned_visuals()
	

func _on_pin_texture_rect_mouse_entered():
	if !is_pinned:
		pin_texture.self_modulate.a = 0.2

func _on_pin_texture_rect_mouse_exited():
	update_pinned_visuals()
