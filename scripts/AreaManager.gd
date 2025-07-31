extends Control

# collection of game screens. its initial game screen child serves as the entry point
# to the area
class_name AreaManager

var game_root

## if false, the area doesn't use and show a progress bar
@export var use_progress_bar:bool=false
## the maximal numbers of points one can get in this area
@export var max_area_points:int=0 
var area_points:int=0
var got_max_points :=false #got to the maximal number of points

## whether to erase the pinned words on entry to this area
@export var erase_pinned_words_on_entry:bool=false

## path to tscn of the next area
@export_file("*.tscn") var path_to_next_area :=''

func initialize(_game_root):
	game_root = _game_root
	
	for c in get_children():
		if c is GameScreen:
			c.initialize(self)
			
	# progress bar
	game_root.reset_progress_bar()
	game_root.set_progress_bar_max_points(max_area_points)
	game_root.set_progress_bar_points(area_points)
	if use_progress_bar:
		game_root.progress_bar.visible = true	
	else:
		game_root.progress_bar.visible = false
	
	if erase_pinned_words_on_entry:
		game_root.erase_pinned_words()

func add_area_points(num_points:int)->void:
	if !use_progress_bar:
		return
	area_points+=num_points
	game_root.set_progress_bar_points(area_points)	
	if area_points>=max_area_points: 
		got_max_points = true


func change_game_screen(path_to_new_screen_tscn:String, debug_cmd:=false)->void:
	assert(path_to_new_screen_tscn!="")

	# stop transcribing
	# this is a bug fix:
	# this causes a thread error: Global.capture_stream_to_text.recording = false    
	# set_deferred avoids it by making the change after the old screen and its threads are removed
	set_deferred("Global.capture_stream_to_text.recording", false)
	
	var found_screen:=false
	for c in get_children():
		if c is GameScreen:
			if c.scene_file_path == path_to_new_screen_tscn:
				found_screen = true
				c.visible = true
			else:
				c.visible = false
				if debug_cmd: # this causes bugs because the animation changes the state of the scene and the scene gets stuck on the first frame. It's a bug that happens only in debug mode so not worth the hassle.
					c.animation_player.stop()
				
	
	# screen isn't found -> need to create it
	if found_screen==false:
		var new_screen = load(path_to_new_screen_tscn).instantiate()
		new_screen.initialize(self)
		add_child(new_screen)
		move_child(new_screen,0) # this ensures the gui is drawn above the game

func play_sound(sound_name:String)->void:
	AudioStreamManager.play(sound_name)

func _change_to_next_area():
	Global.game_root.change_area_manager(path_to_next_area)

func _process(_delta):
	pass
