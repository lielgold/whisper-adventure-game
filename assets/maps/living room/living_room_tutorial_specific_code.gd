extends Node

@onready var animation_player :=$"../AnimationPlayer"
@export_file("*.tscn")  var path_to_new_screen_tscn :String= ""

@onready var sun_background := $"../sun background"
@onready var sun_inner_circle := $"../sun inner circle"

@onready var ceiling := $"../ceiling"
@onready var floor2 := $"../floor"
@onready var wall := $"../wall"
@onready var window := $"../window"


# Called when the node enters the scene tree for the first time.
func _ready():
	var english_open_the_something := $"../talk to something"
	english_open_the_something.visible = true

var initialized :=false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if !initialized:
		initialized=true
		sun_background.visible = true
		sun_inner_circle.visible = true
		ceiling.visible = true
		floor2.visible = true
		wall.visible = true
		window.visible = true

var vb_faded_away:=0
func _on_animation_player_animation_finished(anim_name):
	if anim_name=="fade_away": 
		vb_faded_away+=1
		if vb_faded_away==4:
			animation_player.play("living room/room fade away")
	
func _change_level_after_room_fades_away():
	Global.area_manager.change_game_screen(path_to_new_screen_tscn)
