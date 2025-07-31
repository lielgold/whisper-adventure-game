extends Node

signal sound_started_playing(sound_file_path:String, sound_length:float)

var num_players = 8
var bus = "master"

var available :Array[AudioStreamPlayer]= []  # The available players.
var queue_v2 := []  # The queue of sounds to play, each is a dictionary in the form of {"sound_path": sound_path, "volume":volume, "pitch":pitch}
var a_queued_sound_is_playing:=false

func _ready():
	# Create the pool of AudioStreamPlayer nodes.
	for i in num_players:
		var p = AudioStreamPlayer.new()
		add_child(p)
		available.append(p)
		p.finished.connect(_on_stream_finished.bind(p))
		p.bus = bus


func _on_stream_finished(stream):
	# When finished playing a stream, make the player available again.
	available.append(stream)
	a_queued_sound_is_playing=false


func play(sound_path, volume:float=1, pitch:float=1, enqueque_sound=false):
	queue_v2.append({"sound_path": sound_path, "volume":volume, "pitch":pitch, "queued_sound":enqueque_sound})

func play_varried(sound_path):
	play(sound_path, randf_range(0.8, 1), randf_range(0.9, 1.2))

func play_enqueued_sound(sound_path):
	play(sound_path, 1, 1, true)

func _process(_delta):
	# Play sound if any sound queue isn't empty, and if there isn't already a queued sound playing
	if not queue_v2.is_empty() and not available.is_empty() and !a_queued_sound_is_playing:
		var sound_dict = queue_v2.pop_front()
		# play queued sounds only after everything else is done playing
		if sound_dict["queued_sound"]:
			if available.size()!=num_players: # only play queue sound if none others are playing
				queue_v2.append(sound_dict)
				return
			else:
				a_queued_sound_is_playing = true
		available[0].stream = load(sound_dict["sound_path"])
		available[0].pitch_scale = sound_dict["pitch"]
		available[0].volume_db = sound_dict["volume"]
		
		if Global.mute_sound==true: 
			available[0].volume_db = -100
		available[0].play()
		# emit sound path and length
		emit_signal("sound_started_playing",sound_dict["sound_path"], available[0].stream.get_length())
		available.pop_front()
