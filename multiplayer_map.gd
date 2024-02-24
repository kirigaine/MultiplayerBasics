extends Node2D

# Create network object 
var peer = ENetMultiplayerPeer.new()
@export var player_scene: PackedScene
var multi_port : int = 25565
var multi_ip : String = "localhost"

func _process(delta: float) -> void:
	pass

func _on_btn_host_pressed():
	# Start server and connect host
	peer.create_server(multi_port)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_add_player)
	_add_player()
	
func _add_player(id = 1):
	# Instantiate player object and add as child node
	var player = player_scene.instantiate()
	player.name = str(id)
	call_deferred("add_child",player)


func _on_btn_join_pressed():
	# Create a client conection to peer
	peer.create_client(multi_ip,multi_port)
	multiplayer.multiplayer_peer = peer


func _on_tb_text_changed():
	# Update variables to join ip:port
	multi_port = int($tb_port.get_text())
	multi_ip = $tb_ip.get_text()
