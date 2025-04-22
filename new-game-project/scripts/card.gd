extends Control

class_name CardBase

@onready var sprite: TextureRect = $TextureRect

@export var ingredient: Resource
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func play_card():
	pass
	
func load_card(resource):
	ingredient = resource
	sprite.texture = ingredient.sprite
