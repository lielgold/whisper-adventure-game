extends AreaManager

@onready var animation_player :AnimationPlayer=$AnimationPlayer

const WIN_ANIMATION_NAME := "win_animation"

func add_area_points(num_points:int)->void:
	super(num_points)
	print(num_points)
	if area_points == int(max_area_points*0.25):
		AudioStreamManager.play_enqueued_sound("res://assets/maps/first area/whats your name.wav")
	elif area_points == int(max_area_points*0.5):
		AudioStreamManager.play_enqueued_sound("res://assets/maps/first area/where do you live.wav")
	elif area_points == int(max_area_points*0.75):
		AudioStreamManager.play_enqueued_sound("res://assets/maps/first area/what is your parents name.wav")
	if got_max_points:
		game_root.enable_progress_bar_button(self, "play_win_animation")

func play_win_animation():
	game_root.gui_cinematic_started()
	animation_player.play(WIN_ANIMATION_NAME)

func _on_animation_player_animation_finished(anim_name):
	if anim_name==WIN_ANIMATION_NAME: 
		game_root.gui_cinematic_ended()
		# you can move to the next area by using: 
		#game_root.change_area_manager(path_to_next_area)
