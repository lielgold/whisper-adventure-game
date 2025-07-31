extends Node

var mic_player:AudioStreamPlayer
var audio_player:AudioStreamPlayer
var capture_stream_to_text: CaptureStreamToText
var game_root:Node
var area_manager:AreaManager

var mute_sound:= false
var always_transcribe:=false

## the words and pharses the player has encountered so far
var known_dictionary_words :Array[String]= []
