extends Control

const pinned_word_resource := preload("res://scenes/pinned_word_button.tscn")
@onready var pinned_buttons :Control= $"pinned words container"

const MIN_HEIGHT := 730
const MAX_HEIGHT := 598
const MAX_PINNED_WORDS:=5

# used for showing / hiding the words
var _show_words :=false

func add_pinned_word(word:String)->bool:
	if pinned_buttons.get_child_count()==MAX_PINNED_WORDS:
		return false
	for b:PinnedWordButton in pinned_buttons.get_children():
		if b.dictionary_word==word:
			return false
	var new_button = pinned_word_resource.instantiate()
	new_button.initialize(word)
	pinned_buttons.add_child(new_button)
	return true

func remove_pinned_word(word:String)->void:
	var remove_this :PinnedWordButton=null
	for b:PinnedWordButton in pinned_buttons.get_children():
		if b.dictionary_word==word:
			remove_this=b
	if remove_this!=null:
		pinned_buttons.remove_child(remove_this)
		remove_this.queue_free()

func remove_all_pinned_words()->void:
	var words :=get_pinned_words()
	words.reverse()
	for w in words:
		remove_pinned_word(w)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if _show_words:
		if MAX_HEIGHT <= position.y:
			position.y -=5
	else:
		if position.y <= MIN_HEIGHT:
			position.y +=5

func _on_mouse_entered():
	_show_words = true

func _on_mouse_exited():
	_show_words = false

func get_pinned_words()->Array[String]:
	var output :Array[String]=[]
	for b in pinned_buttons.get_children():
		output.append(b.dictionary_word)
	return output
