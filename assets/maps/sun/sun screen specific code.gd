extends Node

@onready var sun_face:= $"../sun face"
@export_file("*.tscn")  var path_to_new_area :String= ""
var changed_area :=false

var end_timer_duration :float= 3
var end_timer_elapsed :float= 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if sun_face.visible==false:
		end_timer_elapsed +=delta
		if end_timer_elapsed>end_timer_duration and !changed_area:
			Global.game_root.change_area_manager(path_to_new_area)
			changed_area = true


