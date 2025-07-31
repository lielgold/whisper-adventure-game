extends Node

@onready var half_sun := $"../half sun"
@onready var cat_head_1 := $"../sprites#cat head 1"
@onready var cat_head_2 := $"../sprites#cat head 2"
@onready var girl_back := $"../girl back"
@onready var girl_front := $"../girl front"

var initialize :=false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#for n in [half_sun, cat_head_1, cat_head_2, girl_back]:
		#n.visible = false
	#girl_front.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	#if !initialize:
		#initialize=true	
		#for n in [half_sun, cat_head_1, cat_head_2, girl_back]:
			#n.visible = true
		#girl_front.visible = false
		
func _on_animation_player_animation_finished(anim_name):
	if anim_name=="living_room/initial_animation":
		for n in [half_sun, cat_head_1, cat_head_2, girl_back]:
			n.visible = false
		girl_front.visible = true
