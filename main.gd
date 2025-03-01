extends Node2D

var peer = ENetMultiplayerPeer.new()
const port = 4242

var players = []

@export var player_container_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_host_pressed():
	var error = peer.create_server(int(port))
	if error:
		return error
	multiplayer.multiplayer_peer = peer
	
	_on_connected()
	_add_player(1)

func _on_connected():
	_toggle_menu(false)

func _toggle_menu(state: bool):
	$MainMenu.visible=state

func _add_player(_id: int):
	var player = player_container_scene.instantiate() as Player
	player.position = Vector2(100,100)
	players.append(player)
	$EntityContainer.add_child(player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
