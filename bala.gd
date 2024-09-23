extends Area2D

@export var vel = 700

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var mVect = Vector2(0,-1)
	global_position += mVect.rotated(rotation) * delta * vel
	pass


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	pass # Replace with function body.


func _on_area_entered(area: Area2D) -> void:
	if (area is Asteroid):
		$hit.play()
		area.atingido()
		queue_free()
	pass # Replace with function body.
