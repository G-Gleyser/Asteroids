extends CanvasLayer

signal restart()
signal inicia()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		Pausa()
		
	pass
func Pausa():
	get_tree().paused = true
	$menuPause.visible = true
	pass

func AtualizaPlacar(placar):
	var label = $GridContainer/HFlowContainer/pts
	label.text = placar
	pass
	
func hideRestartPanel():
	$PanelRestart.visible = false
	pass
func showRestartPanel():
	$PanelRestart.visible = true
	pass

func _on_restart_pressed() -> void:
	hideRestartPanel()
	emit_signal("restart")
	pass # Replace with function body.


func _on_iniciar_pressed() -> void:
	$menu.visible = false
	$GridContainer.visible = true
	get_tree().paused = false
	emit_signal("inicia")
	pass # Replace with function body.


func _on_sair_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_continuar_pressed() -> void:
	get_tree().paused = false
	$menuPause.visible = false
	pass # Replace with function body.


func _on_menu_pressed() -> void:
	get_tree().paused = true
	get_tree().reload_current_scene()
	$menuPause.visible = false
	$menu.visible = true
	pass # Replace with function body.
