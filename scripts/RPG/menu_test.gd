extends VBoxContainer

@export var can_jump: bool = true # Should never be disabled
@export var can_sword: bool = true # False until unlocked
@export var can_magic: bool = true # False until atleast one magic is unlocked
@export var can_item: bool = true # Generally always on, unless theres a boss that denies items
@export var can_flee: bool = true # Always on, except during bosses

var Actions = [
	{"enabled": can_jump, "text": "Jump"},
	{"enabled": can_sword, "text": "Sword"},
	{"enabled": can_magic, "text": "Magic"},
	{"enabled": can_item, "text": "Item"},
	{"enabled": can_flee, "text": "Flee"}
]

func _ready() -> void:
	position.x -= 250
	display_action_buttons()

# Creates new instances of buttons, good if an action is removed during the fight
func display_action_buttons():
	clear_buttons()
	for action in Actions:
		if action["enabled"]:
			var button = Button.new()
			button.text = action["text"]
			add_child(button)
			button.connect("pressed", func(): _on_button_pressed(action["text"]))

# Deletes current buttons, helps memory management
func clear_buttons():
	for child in get_children():
		child.queue_free()

func _on_button_pressed(button_text):
	print("Button '%s' pressed!" % button_text)
	
	if button_text == "Jump":
		print("Should jump.")
		# Select enemy
		# Play jump action
