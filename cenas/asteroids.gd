extends Node
#
#@export var spawnRate = 4
#
#var poits = 0
#var asteroid = preload("res://cenas/asteroid.tscn")
#var spawn = Vector2(200,200) #-100,-100)
#var spawnDelay = false
## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#func novoAsteroid():
	#var ast = asteroid.instantiate()
	#ast.position = spawn
	#ast.connect("explode", _on_asteroid_explode)
	#add_child(ast)
	#pass
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#if!spawnDelay:
		#spawnDelay = true
		#await get_tree().create_timer(spawnRate).timeout
		#novoAsteroid()
		#spawnDelay = false
	#pass
	#
#func _on_asteroid_explode(position, scale):
	#if (scale.x >= .25):
		#novosAsteroid(position, scale)
		#novosAsteroid(position, scale)
	#pass
	#
#func novosAsteroid(position, scale):
	#var pontos= int(1 / scale.x*10)
	#var ast = asteroid.instantiate()
	#ast.position = position
	#ast.scale = scale/1.5
	#ast.connect("explode", _on_asteroid_explode)
	#call_deferred("add_child", ast)
	#poits += pontos
	#print(poits)
	#pass
