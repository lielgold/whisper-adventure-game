extends TextureButton

@export_file("*.tscn")  var path_to_new_screen_tscn :String= ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func change_to_new_screen():
	assert(path_to_new_screen_tscn!="")
	Global.area_manager.change_game_screen(path_to_new_screen_tscn)
