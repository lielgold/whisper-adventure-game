extends Control

const dict_button_resource = preload("res://scenes/dictionary_button.tscn")
@onready var words_container := $ScrollContainer/VBoxContainer

@onready var image_of_selected_word :TextureRect= $dict_image
@onready var text_at_bottom_of_image :RichTextLabel= $dict_image/RichTextLabel

var path_to_sound_of_selected_word := ''

# Called when the node enters the scene tree for the first time.
func _ready():
	# remove previous words (because it's easier to work this way in the editor)
	for child in words_container.get_children():
		words_container.remove_child(child)
		child.queue_free()
	for word in Global.known_dictionary_words:
		add_word_button(word)

func add_word_button(word:String):
	assert(Translate.dictionary_words.has(word))
	var new_button = dict_button_resource.instantiate()
	new_button.initialize(self, word, Translate.dictionary_words[word].word_heb, Translate.dictionary_words[word].definition_img_standard, Translate.dictionary_words[word].sound_eng)
	words_container.add_child(new_button)

func word_button_selected(word_button:DictButton):
	if word_button.definition_img_standard.is_empty()==false:
		var img :String= Translate.get_translated_image_definition(word_button.translation_key)
		image_of_selected_word.texture = load(img)

		# scale down the image if it's too big
		if image_of_selected_word.texture.get_height() > image_of_selected_word.size.y or \
			image_of_selected_word.texture.get_width() > image_of_selected_word.size.x:
				image_of_selected_word.stretch_mode = TextureRect.STRETCH_SCALE
		else:
			image_of_selected_word.stretch_mode = TextureRect.STRETCH_KEEP_CENTERED
		
	if word_button.sound_path.is_empty()==false:
		path_to_sound_of_selected_word = Translate.get_sound(word_button.translation_key)
		AudioStreamManager.play(path_to_sound_of_selected_word)
	
	text_at_bottom_of_image.text = "[center]" +  word_button.translated_word + "[/center]"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _input(_event):
	#close the menu if clicked outside of it
	if Input.is_action_just_pressed("interact_with_object") or Input.is_action_just_pressed("talk_to_object"):
		if !Rect2(position,size).has_point(get_global_mouse_position()):
			visible = false


func _on_say_the_word_button_pressed():
	if path_to_sound_of_selected_word.is_empty()==false:
		AudioStreamManager.play_varried(path_to_sound_of_selected_word)

func empty_dictionary():
	for c in words_container.get_children():
		words_container.remove_child(c)
		c.queue_free()
	#image_of_selected_word
	text_at_bottom_of_image.text=""

# update the visuals of the menu
# pinned_words - contains all the pinned words
func update_menu(pinned_words:Array[String]):
	for b:DictButton in words_container.get_children():
		b.is_pinned = false
	
	for w:String in pinned_words:
		for b:DictButton in words_container.get_children():
			if w==b.translation_key:
				b.is_pinned = true
				break
	for b:DictButton in words_container.get_children():
		b.update_pinned_visuals()
	
