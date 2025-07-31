extends Node

# flower
@onready var flower := $"../flower"
@onready var flower_left_click := $"../flower/mouse left click"
@onready var flower_right_click := $"../flower/mouse right click"
@onready var flower_girl_on_mic := $"../flower/girl talking microphone2"
@onready var flower_plus_sign :=$"../flower/plus sign"
@onready var flower_speech_bubble_hint :=$"../flower/speech bubble hint"

# open the door sign
@onready var open_the_flower_sign := $"../open the flower sign"
@onready var open_the_flower_sign_left_click := $"../open the flower sign/computer mouse2"
@onready var open_the_flower_sign_animation := $"../open the flower sign/AnimationPlayer"

# door
@onready var door := $"../VB_door"
@onready var door_left_click := $"../VB_door/mouse left click"
@onready var door_right_click := $"../VB_door/mouse right click"
@onready var door_girl_on_mic := $"../VB_door/girl talking microphone3"
@onready var door_plus_sign := $"../VB_door/plus sign2"
@onready var door_speech_bubble := $"../VB_door/speech bubble"

# door sign
@onready var door_sign := $"../VB_door_sign2"
@onready var door_sign_animation := $"../VB_door_sign2/AnimationPlayer"

# Called when the node enters the scene tree for the first time.
func _ready():	
	door.disabled = true
	door.show_usable_animation = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

var clicked_on_show_open_flower :=false
var clicked_on_sign :=false
var did_open_the_flower :=false
var did_click_on_door :=false
var did_left_click_on_door_sign:=false
var did_open_the_door :=false

func _on_animation_player_animation_finished(anim_name):
	if anim_name=="local/show open flower sign" and !clicked_on_show_open_flower:
		open_the_flower_sign_animation.play("fade_in")
		open_the_flower_sign_left_click.visible = true
		flower_left_click.visible = false
		
		clicked_on_show_open_flower = true
	
	if anim_name=="local/clicked on sign" and !clicked_on_sign:
		open_the_flower_sign_left_click.visible = false
		flower_right_click.visible = true
		flower_girl_on_mic.visible = true
		flower_plus_sign.visible = true
		flower_speech_bubble_hint.visible = true
		
		clicked_on_sign = true
	
	if anim_name=="local/open the flower" and !did_open_the_flower:
		flower_right_click.visible = false
		flower_girl_on_mic.visible = false
		flower_plus_sign.visible = false
		flower_speech_bubble_hint.visible = false		
		if !did_click_on_door:
			door_left_click.visible = true
			
		door.disabled = false
		door.show_usable_animation = true
		
		did_open_the_flower = true
		
	if anim_name=="local/click on door" and !did_click_on_door:
		door_left_click.visible = false
		if !did_click_on_door:
			door_sign_animation.play("fade_in")
		
		did_click_on_door = true
	
	if anim_name=="local/left click on sign" and !did_left_click_on_door_sign:
		door_right_click.visible = true
		door_girl_on_mic.visible = true
		door_plus_sign.visible = true
		door_speech_bubble.visible = true
		
		did_left_click_on_door_sign=true
		
	if anim_name=="local/open the door" and !did_open_the_door:
		door_right_click.visible = false
		door_girl_on_mic.visible = false
		door_plus_sign.visible = false
		door_speech_bubble.visible = false
		
		did_open_the_door = true
