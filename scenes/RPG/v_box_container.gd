extends VBoxContainer

signal buttonpressed(button_name)
@export var button_array:Array[String]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for name in button_array:
		var button = Button.new()
		button.text = name
		button.pressed.connect("button_pressed", name)
		add_child(button)
