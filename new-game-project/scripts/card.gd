extends Control

class_name CardBase

@onready var sprite: TextureRect = $TextureRect

@export var ingredient: Resource
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.texture = ingredient.sprite

func play_card():
	pass
