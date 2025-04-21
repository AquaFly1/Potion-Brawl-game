extends Control

@onready var sprite: TextureRect = $TextureRect

@export var ingredient: Resource
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.texture = ingredient.sprite


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
