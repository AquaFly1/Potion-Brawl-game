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
				
	elif event is InputEventMouseMotion and is_grabbed:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "global_position", get_global_mouse_position()- drag_offset, 0.1)
		tween.set_ease(Tween.EASE_OUT)
		

func _process(delta: float) -> void:
	movement = global_position - previous_pos
	var distance = global_position.distance_to(previous_pos)
	speed = distance/delta
	previous_pos = global_position
	if not is_grabbed:
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", target, 1)
	if movement.x > 0:
		rotation_degrees = speed/100
	elif movement.x < 0:
		rotation_degrees = -speed/100

func play_card():
	pass
	
func load_card(resource):
	ingredient = resource
	sprite.texture = ingredient.sprite
