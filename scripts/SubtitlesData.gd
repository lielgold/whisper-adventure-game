extends Node

class_name SubtitlesData

enum thumbnails {GIRL_CALM, CAT, SUN, WOMAN_CONCERNED, MOUSE_FRIENDLY, WOMAN_FRIENDLY, RED_CAT, OLD_GIRL_CALM}

# typed dictionary hype...
const thumbails_filepath :={
	thumbnails.GIRL_CALM : 'res://assets/images/gui/character thumbnails/girl_calm.png',
	thumbnails.CAT : 'res://assets/maps/living room people/cat head 1.PNG',
	thumbnails.SUN : 'res://assets/maps/sun/sun face.PNG',
	thumbnails.WOMAN_CONCERNED : 'res://assets/images/gui/character thumbnails/woman_concerend_thumbnail.png',
	thumbnails.WOMAN_FRIENDLY : 'res://assets/images/gui/character thumbnails/woman_smiling_thumbnail.png',
}

const subtitles_data :={
	# example:
	"path to sound file" : {
		text_heb = "text of the subtitle",
		speaker = thumbnails.GIRL_CALM, # face that appears along with the text
	},
	
	####### tutorial
	
	#"res://assets/maps/house front tutorial/audio/open the flower.wav" : {
		#text_heb = "Short subtitle text!",
		#speaker = thumbnails.GIRL_CALM,
	#},
	"res://assets/maps/sun/first you need to open the sun and then you can talk to it.wav" : {
		text_heb = "צָרִיךְ קֹדֶם לִפְתֹּחַ אֶת הַשֶּׁמֶשׁ, וְרַק אָז אֶפְשָׁר לְדַבֵּר אִתָּה.",
		speaker = thumbnails.CAT,
	},
	"res://assets/maps/sun/hi.wav" : {
		text_heb = "הַי.",
		speaker = thumbnails.SUN,
	},
	
	#####  house after tutorial
	# living room
	"res://assets/maps/living room people/audio/wow how did you that.wav" : {
		text_heb = "אֵיךְ עָשִׂית אֶת זֶה?",
		speaker = thumbnails.WOMAN_FRIENDLY,
	},
	"res://assets/maps/living room people/audio/open the woman.wav" : {
		text_heb = "וּוָאו, אֵיזֶה יוֹפִי.",
		speaker = thumbnails.WOMAN_FRIENDLY,
	},
	"res://assets/maps/living room people/audio/play with the woman.wav" : {
		text_heb = "אֲנִי לֹא יְכוֹלָה לְשַׂחֵק אִתָּךְ. אֲנַחְנוּ צְרִיכוֹת לִמְצֹא אֶת הַהוֹרִים שֶׁלָּךְ.",
		speaker = thumbnails.WOMAN_CONCERNED,
	},
	# yard
	"res://assets/maps/outside window/audio/talk to the bird.wav" : {
		text_heb = "אַתָּה רוֹצֶה לְשַׂחֵק כַּדּוּרֶגֶל?",
		speaker = thumbnails.GIRL_CALM,
	},
	"res://assets/maps/outside window/audio/how did you do it.wav" : {
		text_heb = "אֵיךְ עָשִׂית אֶת זֶה?",
		speaker = thumbnails.WOMAN_FRIENDLY,
	},
	"res://assets/maps/outside window/audio/you're almost as pretty as me.wav" : {
		text_heb = "אַתָּה יָפֶה כִּמְעַט כָּמוֹנִי.",
		speaker = thumbnails.GIRL_CALM,
	},
	# house front
	"res://assets/maps/house front after tutorial/audio/talk to the bin.wav" : {
		text_heb = "אִיכְס.",
		speaker = thumbnails.GIRL_CALM,
	},
	"res://assets/maps/house front after tutorial/audio/open the ball2.wav" : {
		text_heb = "אִי אֶפְשָׁר לְשַׂחֵק עִם כַּדּוּר מְפֻנְצָ'ר.",
		speaker = thumbnails.GIRL_CALM,
	},
	# house yard
	"res://assets/maps/house yard/audio/want to play with me.wav" : {
		text_heb = "רוֹצֶה לְשַׂחֵק אִתִּי?",
		speaker = thumbnails.GIRL_CALM,
	},
	"res://assets/maps/house yard/audio/the sun is too far.wav" : {
		text_heb = "הַשֶּׁמֶשׁ רְחוֹקָה מִדַּי.",
		speaker = thumbnails.GIRL_CALM,
	},
	"res://assets/maps/house yard/audio/nice summer.wav" : {
		text_heb = "יֹפִי שֶׁל קַיִץ. 40 מַעֲלוֹת, נֶחְמָד.",
		speaker = thumbnails.GIRL_CALM,
	},	
	"res://assets/maps/house yard/audio/do the sun magic.wav" : {
		text_heb = "תַּעֲשִׂי אֶת הַקֶּסֶם עִם הַשֶּׁמֶשׁ.",
		speaker = thumbnails.WOMAN_FRIENDLY,
	},
	"res://assets/maps/house yard/audio/who is this girl.wav" : {
		text_heb = "מִי זֹאת? אַתְּ הַיַּלְדָּה הַזֹּאת?",
		speaker = thumbnails.WOMAN_FRIENDLY,
	},
	# area dialoug
	"res://assets/maps/first area/what is your parents name.wav" : {
		text_heb = "אֵיךְ קוֹרְאִים לַהוֹרִים שֶׁלָּךְ?",
		speaker = thumbnails.WOMAN_CONCERNED,
	},	
	"res://assets/maps/first area/whats your name.wav" : {
		text_heb = "אֵיךְ קוֹרְאִים לָךְ?",
		speaker = thumbnails.WOMAN_CONCERNED,
	},
	"res://assets/maps/first area/where do you live.wav" : {
		text_heb = "אֵיפֹה אַתְּ גָּרָה? אַתְּ רוֹצָה שֶׁאֲנִי אֶתְקַשֵּׁר לְמִישֶׁהוּ?",
		speaker = thumbnails.WOMAN_CONCERNED,
	},	
	
	
	# ending animation
	"res://assets/maps/forest sunset/audio/its late.wav" : {
		text_heb = "כְּבָר מְאֻחָר.",
		speaker = thumbnails.WOMAN_CONCERNED,
	},
	"res://assets/maps/forest sunset/audio/where are you going2.wav" : {
		text_heb = "לְאָן אַתְּ הוֹלֶכֶת?",
		speaker = thumbnails.WOMAN_CONCERNED,
	},
}


static func get_text(sound_file_path:String)->String:
	return subtitles_data[sound_file_path]['text_heb']

static func get_speaker(sound_file_path:String)->String:
	var speaker = ''
	var d = subtitles_data[sound_file_path]
	if d.has("speaker"):
		speaker = thumbails_filepath[d.speaker]
	return speaker
