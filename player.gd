class_name Player extends CharacterBody2D

const SPEED = 300.0


func _physics_process(_delta: float) -> void:
	if is_multiplayer_authority() and get_viewport().get_window().has_focus():
		velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * SPEED
		move_and_slide()
