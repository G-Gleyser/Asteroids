extends Node2D

@onready var asteroids = $asteroids
@onready var balas = $balas
@onready var player = $Nave
@onready var hud = $hud
@onready var hudPontos = $hud/GridContainer/pontos/pts 
@onready var hudVidas = $hud/GridContainer/HFlowContainer2/vida/vidas

@export var spawnRate = 4
@export var maxAsteroids = 10
#@export var vidas = 3

var points = 0
var asteroid = preload("res://cenas/asteroid.tscn")
var nave = preload("res://cenas/nave.tscn")
var spaw
var spawnDelay = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#SpawnaPlayer()
	hud.connect("restart", _on_restart)
	hud.connect("inicia", _on_init)
	player.connect("atira", _on_player_shot)
	player.connect("morreu", _morreu)
	
	

func _respawn():
	points = 0
	SpawnaPlayer()
	pass

func SpawnaPlayer():
	var spawn = $spawnPlayer.position
	player.respawn(spawn)
	hudVidas.text = str(player.vidas) 
	hudPontos.text = str(0)
	pass


func _on_player_shot(bala):
	balas.add_child(bala)
	pass
	
func novoAsteroid():
	var random_float = randf() * 100
	$asteroids/spawnerAst.progress_ratio = random_float
	var spawn = $asteroids/spawnerAst.position
	var ast = asteroid.instantiate()
	ast.position = spawn
	ast.connect("explode", _on_asteroid_explode)
	asteroids.add_child(ast)
	pass

## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var astCount = asteroids.get_child_count()
	if astCount < maxAsteroids:
		if!spawnDelay:
			spawnDelay = true
			await get_tree().create_timer(spawnRate).timeout
			novoAsteroid()
			spawnDelay = false
	pass
	
func _on_asteroid_explode(position, scale):
	if (scale.x >= .25):
		novosAsteroid(position, scale)
		novosAsteroid(position, scale)
	pass


func _morreu(vidas):
	if(vidas < 0):
		hud.showRestartPanel()
	else:
		hudVidas.text = str(vidas)
	pass

func novosAsteroid(position, scale):
	var pontos= int(1 / scale.x*10)
	var ast = asteroid.instantiate()
	ast.position = position
	ast.scale = scale/1.5
	ast.connect("explode", _on_asteroid_explode)
	asteroids.call_deferred("add_child", ast)
	points += pontos
	hudPontos.text = str(points)
	pass

func _on_restart():
	SpawnaPlayer()
	pass

func _on_init():
	print("init")
	SpawnaPlayer()
	pass
