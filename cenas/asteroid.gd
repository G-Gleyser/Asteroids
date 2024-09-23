class_name Asteroid extends Area2D

var vel = 10
signal explode(position, scale)
func _ready() -> void:
	vel /= (scale.x/2)
	rotation = randf_range(0, 2*PI)
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	global_position += Vector2(0,-1).rotated(rotation) * vel * delta
	pass

func _process(delta: float) -> void:
	Teleporta()
	pass

func Teleporta():
	var tamanho = $CollisionShape2D.shape.radius /2
	var tela = get_viewport_rect().size;
	if((position.x + tamanho) < 0):
		position.x = (tela.x + tamanho) 
	if((position.x -tamanho)> tela.x):
		position.x = -tamanho
		
	if(position.y + tamanho < 0):
		position.y = tela.y + tamanho
	if position.y -tamanho > tela.y:
		position.y = -tamanho
		
	pass
	
func atingido():
	emit_signal("explode", position, scale)
	queue_free()
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is Nave:
		$hit.play()
		body.morre()
	pass # Replace with function body.
