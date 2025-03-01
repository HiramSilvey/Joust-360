class_name PlayerContainer extends Node2D

var player: Player:
	get:
		return $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())
