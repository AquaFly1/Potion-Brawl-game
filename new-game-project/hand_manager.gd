extends Control


@export var hand = [CardBase]


func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_discard_pressed() -> void:
	print("discard")
