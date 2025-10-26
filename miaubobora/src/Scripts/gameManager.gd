class_name GameManager
extends Node2D


# Variáveis do jogo
@onready var current_state: GameState = GameState.PREPARATION
var cats

@onready var slingshot = $Slingshot

#são as abóbras, desculpe clean code
@onready var halloween := $aboboras
var level_cleared: bool = false
var canAim: bool
@onready var timer = $Timer

# Chamado a cada frame para verificar estabilidade física
func _process(delta):
	if current_state == GameState.ACTION:
		check_physics_stability()

# Estados do jogo
enum GameState {
	PREPARATION,  # Jogador está mirando/posicionando
	ACTION        # Ação está acontecendo (projétil voando)
}

func _ready():
	cats = $Gatos.get_children()


# Chamado para verificar se a física estabilizou
func check_physics_stability():
	if current_state != GameState.ACTION:
		return
	
	# Verificar se todos os objetos pararam de se mover
	var all_objects_stopped = are_all_physics_objects_stopped()

func are_all_physics_objects_stopped() -> bool:
	var physics_bodies = cats
	
	for body in physics_bodies:
		if body is RigidBody2D:
			if body.linear_velocity.length() > 5.0:  # Threshold de velocidade
				return false
			if body.angular_velocity > 0.1:  # Threshold de rotação
				return false
	
	return true

# Quando a ação termina
func on_action_completed():
	check_level_conditions()
	
# Verificar condições do nível
func check_level_conditions():
	var enemies = halloween
	
	if enemies.size() == 0:
		level_cleared = true
		victory()

# Game Over
func game_over():
	print("GAME OVER")
	Engine.time_scale = 0.5
	timer.start()
	
func _on_timer_timeout():
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()

# Vitória
func victory():
	print("VITÓRIA!")
	#vai pro próximo nivel
	
func shot_cat():
	var selected_cat = cats.pop_front()
	print(selected_cat)
	print(cats)
	
	if selected_cat == null:
		return
	selected_cat.freeze = true
	selected_cat.global_transform.origin = Vector2(slingshot.position.x,
	slingshot.position.y-10)
	selected_cat.enable_input_processing()
	
	
func _on_button_button_up() -> void:
	print("botao acionado")
	shot_cat()
