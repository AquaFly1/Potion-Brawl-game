extends Control

class_name CardBase

@onready var sprite: TextureRect = $TextureRect
var is_grabbed = false
var drag_offset = Vector2(0,0)
var target = Vector2(0,0)
@export var ingredient: Resource
var movement = 0
var previous_pos = Vector2.ZERO
var speed = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	previous_pos = global_position

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				is_grabbed = true
				drag_offset = get_global_mouse_position() - global_position
			else:
				is_grabbed = false
				#pivot_offset = Vector2(0,0)
	elif event is InputEventMouseMotion and is_grabbed:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "global_position", get_global_mouse_position()- drag_offset, 0.1)
		#pivot_offset = get_global_mouse_position()
		

func _process(delta: float) -> void:
	movement = global_position - previous_pos
	speed = movement.x/delta
	previous_pos = global_position
	var tween = get_tree().create_tween()
	if not is_grabbed:
		tween.tween_property(self, "position", target, 0.5)
	rotation_degrees = speed/100

func play_card():
	pass
	
func load_card(resource):
	ingredient = resource
	sprite.texture = ingredient.sprite
