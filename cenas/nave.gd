extends CharacterBody2D
class_name Nave

signal atira(bala)
signal morreu(vida)
@export var rate_fire := .2
@export var vidasIniciais = 3

var acc = 100.0
var vidas 
var vivo = true
var bala = preload("res://cenas/bala.tscn")
var shot_delay = false
var spawn_protection_delay = false
var morteDelay = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	vidas = vidasIniciais
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_action_pressed("shot")):
		if !shot_delay:
			shot_delay = true
			shot()
			await get_tree().create_timer(rate_fire).timeout
			shot_delay = false
	pass

func _physics_process(delta: float) -> void:
	var max_speed = 250
	var vel = Vector2.ZERO
	var rVel = .1
	acc = 100.0
	var v = Vector2( 0, Input.get_axis("ui_up", "ui_down"))
	velocity += v.rotated(rotation) * acc * delta
	velocity = velocity.limit_length(max_speed)
	
	if( Input.is_action_pressed("move_dir") ):
		
		rotate(rad_to_deg(rVel* delta))
		
	if( Input.is_action_pressed("move_esq") ):
		rotate(rad_to_deg(-rVel* delta))		
	

	Teleporta()
	move_and_slide()
	pass

func Teleporta():
	var tela = get_viewport_rect().size;
	if(position.x < 0):
		position.x = tela.x
	if position.x > tela.x:
		position.x = 0
		
	if(position.y < 0):
		position.y = tela.y
	if position.y > tela.y:
		position.y = 0
		
	pass

func shot():
	$shot.play()
	var b = bala.instantiate()
	b.position = $spawnBala.global_position
	b.rotation = rotation
	emit_signal("atira", b)
	pass
	
func morre():
	if !morteDelay:
		morteDelay = true
		vidas -= 1
		emit_signal("morreu", vidas)
		
		if vidas >= 0:
			await get_tree().create_timer(1).timeout
			morteDelay = false
		else:
			visible = false
			process_mode = Node.PROCESS_MODE_DISABLED
			velocity = Vector2.ZERO
	pass

func respawn(pos):
	morteDelay = false
	vidas = vidasIniciais 
	rotation = 0
	position = pos
	visible = true
	process_mode = Node.PROCESS_MODE_INHERIT
	spawnProtection()
	pass
	
func spawnProtection():
	$shield.play()
	var col = $CollisionPolygon2D
	if !spawn_protection_delay:
		col.visible = true
		col.disabled = true
		spawn_protection_delay = true
		await get_tree().create_timer(3).timeout
		spawn_protection_delay = false
		col.disabled = false
		col.visible = false
	pass
