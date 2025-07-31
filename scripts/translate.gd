extends Node


## containts the dictionary definitions. VoiceButton translation_key is used as the key here to get information
## word_eng - conatins a list of spelling options for the translation word. 
## the first is correct ("cold"), and will appear in the GUI, the rest are there to cover for common pronounciation mistakes ("called")
const dictionary_words := {
	"door" : {
		"word_eng":["door"], 
		"word_heb": "דֶּלֶת",
		"definition_img_standard" : "res://assets/maps/house front/door.webp", 
		"sound_eng" : "res://assets/maps/house front/door.wav",
	},
	"cat" : {
		"word_eng":["cat"] , 
		"word_heb": "חָתוּל",
		"definition_img_standard" : "res://assets/maps/sun/cat 2.PNG", 
		"sound_eng" : "res://assets/maps/sun/cat.wav",
	},
	"flower" : {
		"word_eng":["flower"] , 
		"word_heb": "פֶּרַח", 
		"definition_img_standard" : "res://assets/maps/house front/open flower.PNG", 
		"sound_eng" : "res://assets/maps/house front/flower.wav",
	},
	"open the door" : {
		"word_eng":["open the door"], 
		"word_heb": "פְּתַח אֶת הַדֶּלֶת",
		"sound_eng" : "res://assets/maps/house front/open the door.wav",
		"definition_img_standard" : "res://assets/maps/house front/sign open the door.webp", 		
		"definition_img_eng" : "res://assets/images/gui/dictionary/open the door definition.webp",
		
	},
	"floor" : {
		"word_eng":["floor"], 
		"word_heb": "רִצְפָּה",
		"definition_img_standard" : "res://assets/images/dictionary definitions/floor def.PNG", 
		"sound_eng" : "res://assets/maps/living room/audio/floor.wav",
	},
	"wall" : {
		"word_eng":["wall"], 
		"word_heb": "קִיר",
		"definition_img_standard" : "res://assets/images/dictionary definitions/wall def.PNG", 
		"sound_eng" : "res://assets/maps/living room/audio/wall.wav",
	},
	"ceiling" : {
		"word_eng":["ceiling"] , 
		"word_heb": "תִּקְרָה",
		"definition_img_standard" : "res://assets/images/dictionary definitions/ceiling def.PNG", 
		"sound_eng" : "res://assets/maps/living room/audio/ceiling.wav",
	},
	"window" : {
		"word_eng":["window"], 
		"word_heb": "חַלּוֹן",
		"definition_img_standard" : "res://assets/images/dictionary definitions/window def.PNG", 
		"sound_eng" : "res://assets/maps/living room/audio/window.wav",
	},
	"sun" : {
		"word_eng":["sun"] , 
		"word_heb": "שֶׁמֶשׁ",
		"definition_img_standard" : "res://assets/maps/living room/small sun.png", 
		"sound_eng" : "res://assets/maps/sun/sun.wav",
	},
	"talk to the cat" : {
		"word_eng":["talk to the cat"], 
		"word_heb": "דַּבֵּר אֶל הֶחָתוּל",
		"sound_eng" : "res://assets/maps/sun/talk to the cat.wav",
		"definition_img_standard" : "res://assets/maps/sun/cat 1 .PNG",
		"definition_img_eng" : "res://assets/images/dictionary definitions/talk to the cat definition.webp",
	},
	"thought" : {
		"word_eng":["thought"], 
		"word_heb": "מַחְשָׁבָה",
		"sound_eng" : "res://assets/maps/living room people/audio/thought.wav",
		"definition_img_standard" : "res://assets/maps/living room people/thought bubble.PNG",
		"definition_img_eng" : "res://assets/maps/living room people/thought bubble.PNG",
	},
	"I" : {
		"word_eng":["I"] , 
		"word_heb": "אֲנִי",
		"sound_eng" : "res://assets/maps/living room people/audio/I.wav",
		"definition_img_standard" : "res://assets/maps/areas/two families/misc/i_definition.png",
	},
	"talk to me" : {
		"word_eng":["talk to me"] , 
		"word_heb": "דַּבֵּר אֵלַי",
		"sound_eng" : "res://assets/maps/sun/hi.wav",
	},
	"bird" : {
		"word_eng":["bird"] , 
		"word_heb": "צִפּוֹר",
		"sound_eng" : "res://assets/maps/outside window/audio/bird.wav",
		"definition_img_standard" : "res://assets/maps/outside window/bird, closed wings.PNG",
	},
	"lie to the bird" : {
		"word_eng":["lie to the bird"], 
		"word_heb": "שֶׁקֶר לַצִּפּוֹר",
		"sound_eng" : "res://assets/maps/outside window/audio/lie to the bird definition.wav",
		"definition_img_standard" : "res://assets/maps/outside window/sign lie to the .PNG",
		"definition_img_eng" : "res://assets/maps/outside window/sign lie to the .PNG",
	},
	"open the flower" : {
		"word_eng":["open the flower"], 
		"word_heb": "פְּתַח אֶת הַפֶּרַח",
		"sound_eng" : "res://assets/maps/house front tutorial/audio/open the flower.wav",
		"definition_img_standard" : "res://assets/maps/house front tutorial/open the flower sign translated.PNG", 		
		"definition_img_eng" : "res://assets/maps/house front tutorial/open the flower sign translated.PNG",
	},
	"open the ----" : {
		"word_eng":["open the ----"] , 
		"word_heb": "---פְּתַח אֶת הַ",
		"sound_eng" : "res://assets/maps/living room/audio/open the something.wav",
		"definition_img_standard" : "res://assets/maps/living room/open the something.PNG",
		"definition_img_eng" : "res://assets/maps/living room/open the something.PNG",
	},
	"bin" : {
		"word_eng":["bin"], 
		"word_heb": "פַּח",
		"sound_eng" : "res://assets/maps/house front after tutorial/audio/bin.wav",
		"definition_img_standard" : "res://assets/maps/house front after tutorial/open bin.PNG", 		
	},
	"ball" : {
		"word_eng":["ball"], 
		"word_heb": "כַּדּוּר",
		"sound_eng" : "res://assets/maps/house front after tutorial/audio/ball.wav",
		"definition_img_standard" : "res://assets/maps/house front after tutorial/ball.PNG",
	},
	"play with the ball" : {
		"word_eng":["play with the ball"] ,
		"word_heb": "שַׂחֵק עִם הַכַּדּוּר",
		"sound_eng" : "res://assets/maps/house front after tutorial/audio/play with the ball.wav",
		"definition_img_standard" : "res://assets/maps/house front after tutorial/Copy of sign play with the ball.PNG",
		"definition_img_eng" : "res://assets/maps/house front after tutorial/sign play with the ball translated.PNG",
	},	
	"open the ---- male spanish" : {
		"word_eng":["open the?"] ,
		"word_heb": "פְּתַח אֶת? (זָכָר)",
		"sound_eng" : "res://assets/translation/spanish/SP_abre el.wav",
		"definition_img_standard" : "res://assets/translation/spanish/images/abre el ----.PNG",
		"definition_img_eng" : "res://assets/translation/spanish/images/abre el ----.PNG",
	},
	"open the ---- female spanish" : {
		"word_eng":["open the?"] ,
		"word_heb": "פְּתַח אֶת? (נְקֵבָה)",
		"sound_eng" : "res://assets/translation/spanish/SP_open the something.wav",
		"definition_img_standard" : "res://assets/translation/spanish/images/SP open the something.PNG",
		"definition_img_eng" : "res://assets/translation/spanish/images/SP open the something.PNG",
	},
	"woman" : {
		"word_eng":["woman"] ,
		"word_heb": "אִשָּׁה",
		"sound_eng" : "res://assets/maps/living room people/audio/woman.wav",
		"definition_img_standard" : "res://assets/maps/living room people/woman_front_1_fixed.png",
	},
}


#### this contains the translation of the trigger texts
# 
const trigger_texts_translation := {		
	#"translation_key" :
	#{
		#"word_eng": ["english translation option number one", "another acceptable translation"], 
		#"word_heb": "hebrew translation", # not needed!
		#"word_sp": ["spanish translation"], # not needed!
	#}
	"open the door" : {
		"word_eng":["open the door"], 
		"word_heb": "פְּתַח אֶת הַדֶּלֶת",
	},
	"open the flower" : {
		"word_eng":["open the flower"], 
		"word_heb": "פְּתַח אֶת הַפֶּרַח",
	},	
	"open the ceiling" : {
		"word_eng": ["open the ceiling"], 
		"word_heb": "פתח את התקרה",
	},
	"open the floor" : {
		"word_eng": ["open the floor"], 
		"word_heb": "פתח את הרצפה",
	},
	"open the wall" : {
		"word_eng": ["open the wall"], 
		"word_heb": "פתח את הקיר",
	},
	"open the window" : {
		"word_eng": ["open the window"] , 
		"word_heb": "פתח את החלון",
	},
	"talk to the cat" : {
		"word_eng":["talk to the cat"], 
		"word_heb": "דַּבֵּר אֶל הֶחָתוּל",
	},
	"talk to the sun" : {
		"word_eng": ["talk to the sun"], 
		"word_heb": "דבר אל השמש",
	},
	"open the sun" : {
		"word_eng": ["open the sun"], 
		"word_heb": "פתח את השמש",
	},	
	"open the cat" : {
		"word_eng": ["open the cat"] , 
		"word_heb": "פתח את החתול",
	},
	"talk to the me" : {
		"word_eng":["talk to the me"], 
		"word_heb": "דַּבֵּר אֶל הַאֵלַי",
	},
	"talk to the parents" : {
		"word_eng": ["talk to the parents"], 
		"word_heb": "דבר אל ההורים",
	},
	"open the parents" : {
		"word_eng": ["open the parents"] ,
		"word_heb": "פתח את ההורים",
	},
	"lie to the parents" : {
		"word_eng": ["lie to the parents"] ,
		"word_heb": "שקר להורים",
	},
	"play with the parents" : {
		"word_eng": ["play with the parents"] ,
		"word_heb": "שחק עם ההורים",
	},
	"open the bird" : {
		"word_eng": ["open the bird"],
		"word_heb": "פתח את הציפור",
	},
	"lie to the bird" : {
		"word_eng":["lie to the bird"], 
		"word_heb": "שֶׁקֶר לַצִּפּוֹר",
	},
	"talk to the bird" : {
		"word_eng": ["talk to the bird"] ,
		"word_heb": "דבר אל הציפור",
	},
	"play with the bird" : {
		"word_eng": ["play with the bird"] ,
		"word_heb": "שחק עם הציפור",
	},	
	"talk to the flower" : {
		"word_eng": ["talk to the flower"] ,
		"word_heb": "דבר אל הפרח",
	},
	"lie to the flower" : {
		"word_eng": ["lie to the flower"] ,
		"word_heb": "שקר לפרח",
	},
	"play with the flower" : {
		"word_eng": ["play with the flower"] ,
		"word_heb": "שחק עם הפרח",
	},	
	"lie to the cat" : {
		"word_eng": ["lie to the cat"],
		"word_heb": "שקר לחתול",
	},
	"play with the cat" : {
		"word_eng": ["play with the cat"] ,
		"word_heb": "שחק עם החתול",
	},	
	"lie to the sun" : {
		"word_eng": ["lie to the sun"] ,
		"word_heb": "שקר לשמש",
	},	
	"play with the sun" : {
		"word_eng": ["play with the sun"] ,
		"word_heb": "שחק עם השמש",
	},
	"play with the ball" : {
		"word_eng":["play with the ball"] ,
		"word_heb": "שַׂחֵק עִם הַכַּדּוּר",
	},
	"talk to the ball" : {
		"word_eng": ["talk to the ball"] ,
		"word_heb": "דבר עם הכדור",
	},
	"lie to the ball" : {
		"word_eng": ["lie to the ball"] ,
		"word_heb": "שקר לכדור",
	},
	"open the ball" : {
		"word_eng": ["open the ball"] ,
		"word_heb": "פתח את הכדור",
	},
	"open the bin" : {
		"word_eng": ["open the bin"],
		"word_heb": "פתח את הפח",
	},
	"play with the bin" : {
		"word_eng": ["play with the bin"],
		"word_heb": "שחק עם הפח",
	},
	"talk to the bin" : {
		"word_eng": ["talk to the bin"],
		"word_heb": "דבר עם הפח",
	},
	"play with the me" : {
		"word_eng": ["play with the me"] ,
		"word_heb": "שחק עם האיתי",
	},
	"play with me" : {
		"word_eng": ["play with me"],
		"word_heb": "שחק איתי",
	},
	"lie to the me" : {
		"word_eng": ["lie to the me"],
		"word_heb": "דבר עם האיתי",
	},
	"lie to me" : {
		"word_eng": ["lie to me"],
		"word_heb": "דבר איתי",
	},
	"open the me" : {
		"word_eng": ["open the me"],
		"word_heb": "פתח האותי",
	},
	"open me" : {
		"word_eng": ["open me"],
		"word_heb": "פתח אותי",
	},
	"talk to the woman" : {
		"word_eng": ["talk to the woman"],
		"word_heb": "דבר עם האישה",
	},	
	"lie to the woman" : {
		"word_eng": ["lie to the woman"] ,
		"word_heb": "שקר לאישה",
	},
	"play with the woman" : {
		"word_eng": ["play with the woman"],
		"word_heb": "שחק עם האישה",
	},
	"open the woman" : {
		"word_eng": ["open the woman"],
		"word_heb": "פתח את האישה",
	},
}

func get_sound(word:String)->String:
	var sound_lang := 'sound_eng'
	var sound :String = dictionary_words[word][sound_lang]
	return sound

func get_translated_word(word:String)->String:
	var word_language = 'word_eng'
	if dictionary_words.has(word): 
		return dictionary_words[word][word_language][0]
	return ''
	
func get_hebrew_translation(word:String)->String:
	return dictionary_words[word]['word_heb']

## get the translated image from the dictionary, or an empty string if there is no translation (most images don't need one)
func get_translated_image(word:String):
	if dictionary_words.has(word)==false:
		push_warning("you forgot to add the word to the translation dictionary")
	
	var image_language = 'img_eng'
	if dictionary_words[word].has(image_language):
		return dictionary_words[word][image_language]
	return ''
	
## get a dictionary image. In order of availability:
# 1. translated image definition
# 3. regular image (most images don't need translation)
func get_translated_image_definition(word:String):
	var img_def_language = 'definition_img_eng'
	if dictionary_words[word].has(img_def_language):
		return dictionary_words[word][img_def_language]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

