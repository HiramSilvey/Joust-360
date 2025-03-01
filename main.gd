extends Node2D

const IP_ADDRESS = "127.0.0.1"
const PORT = 4242

var peer = ENetMultiplayerPeer.new()
var players = []

@export var player_container_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	multiplayer.peer_connected.connect(_on_peer_connected)
	# multiplayer.peer_disconnected.connect(_on_player_disconnected)
	multiplayer.connected_to_server.connect(_on_connected)
	# multiplayer.connection_failed.connect(_on_connect_fail)
	# multiplayer.server_disconnected.connect(_on_server_dicsonnected)
	$MultiplayerSpawner.spawned.connect(_on_spawned)


# Called when a new node has been created by the MultiplayerSpawner. This will probably
# only be called on the clients, I don't think the `spawned` signal is emitted
# on the server when it adds a node to the local tree.
func _on_spawned(node: Node):
	if node is PlayerContainer:
		players.append(node.player)

func _on_peer_connected(id: int):
	if multiplayer.is_server():
		_add_player(id)

func _on_host_pressed():
	var error = peer.create_server(PORT)
	if error:
		return error
	multiplayer.multiplayer_peer = peer
	
	_on_connected()
	_add_player(1)

func _on_connect_pressed():
	var error = peer.create_client(IP_ADDRESS, PORT)
	if error:
		return error
	multiplayer.multiplayer_peer = peer

func _on_connected():
	_toggle_menu(false)

func _toggle_menu(state: bool):
	$MainMenu.visible=state

func _add_player(id: int):
	var player = player_container_scene.instantiate() as PlayerContainer
	player.name = str(id)
	player.position = Vector2(100,100)
	players.append(player)
	$EntityContainer.add_child(player)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
