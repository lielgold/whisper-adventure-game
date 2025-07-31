extends GameScreen

@export_file("*.tscn")  var path_to_new_screen_tscn :String= ""
var animation_finished:=false

func _on_animation_player_animation_finished(_anim_name):
	animation_finished=true
	area_manager.change_game_screen(path_to_new_screen_tscn)

func _on_visibility_changed():
	if visible==true and animation_finished:
		area_manager.change_game_screen(path_to_new_screen_tscn)

