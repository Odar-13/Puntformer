extends VBoxContainer

@export var has_button_2: bool

var new_button
var newer_button
var newest_button

func _ready() -> void:
	var new_button = Button.new()
	new_button.text = "Button created!"
	add_child(new_button)
	
	if (has_button_2):
		var newer_button = Button.new()
		newer_button.text = "The COOLER button."
		add_child(newer_button)
		
	var newest_button = Button.new()
	newest_button.text = "Cringe"
	add_child(newest_button)
