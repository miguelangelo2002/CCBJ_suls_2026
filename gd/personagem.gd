extends CharacterBody3D

#
#const SPEED = 5.0
#const JUMP_VELOCITY = 4.5
#@onready var model: =$pivot/buddybuddy
#@onready var animation_player: AnimationPlayer = $pivot/buddybuddy/AnimationPlayer
#
#
#func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
		#print("qualquer coisa ")
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var input_dir := Input.get_vector("ui_right", "ui_left", "ui_down", "ui_up")
	#var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#if direction:
		#velocity.x = direction.x * SPEED
		#velocity.z = direction.z * SPEED
			#
			#
		#if Input.is_action_pressed("cima"):
			#model.rotation.y = deg_to_rad(0)
			#animation_player.play("Walk")
		#if Input.is_action_pressed("baixo"):
			#model.rotation.y = deg_to_rad(180)
			#animation_player.play("Walk")
		#if Input.is_action_pressed("esquerda"):
			#model.rotation.y = deg_to_rad(90)
			#animation_player.play("Walk")
		#if Input.is_action_pressed("direita"):
			#model.rotation.y = deg_to_rad(-90)
			#animation_player.play("Walk")
			#
		#if Input.is_action_just_pressed("pulo"):
			#animation_player.play("Jump")
			#
	#else: 
		#velocity.x = move_toward(velocity.x, 0, SPEED)
		#velocity.z = move_toward(velocity.z, 0, SPEED)
#
	#move_and_slide()
	#
#func animation(delta):
	#
	#if Input.is_action_pressed("cima"):
			#model.rotation.y = deg_to_rad(0)
			#animation_player.play("Walk")
		#if Input.is_action_pressed("baixo"):
			#model.rotation.y = deg_to_rad(180)
			#animation_player.play("Walk")
		#if Input.is_action_pressed("esquerda"):
			#model.rotation.y = deg_to_rad(90)
			#animation_player.play("Walk")
		#if Input.is_action_pressed("direita"):
			#model.rotation.y = deg_to_rad(-90)
			#animation_player.play("Walk")
			#
		#if Input.is_action_just_pressed("pulo"):
			#animation_player.play("Jump")
			#
	#pass
@onready var pivot = $pivot
@onready var animation_player: AnimationPlayer = $pivot/buddybuddy/AnimationPlayer
const SPEED = 5.0
const JUMP_VELOCITY = 7.0
@export var dir_vel = 7.5
var num_rotacao = deg_to_rad(0)

func _process(delta):

	animation(delta)


 
func _physics_process(delta: float) -> void:
	if GameManager.player["vida"] <= 0:
		animation_player.play("Death1")
		return 
		#global_position.x = 0
		#GameManager.player["vida"] == 3
		
	if not is_on_floor():

		velocity += get_gravity() * delta
	# Handle jump.
	if Input.is_action_just_pressed("pulo") and is_on_floor():
		animation_player.play("Jump")
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector( "direita", "esquerda","baixo" , "cima")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		
	if direction:
		
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		animation_player.play("Walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide()
	
func animation(delta):
	if is_on_floor():
		var andando = false
		if Input.is_action_pressed("cima"):
			andando = true
			
			num_rotacao = deg_to_rad(0)
			rotacionar(delta)
			if Input.is_action_pressed("esquerda"):
				num_rotacao = deg_to_rad(45)
				rotacionar(delta)
			if Input.is_action_pressed("direita"):
				num_rotacao = deg_to_rad(-45)
				rotacionar(delta)
			

		if  Input.is_action_pressed("baixo"):
			andando = true
			
			num_rotacao = deg_to_rad(180)
			rotacionar(delta)
			if Input.is_action_pressed("esquerda"):
				
				num_rotacao = deg_to_rad(135)
				rotacionar(delta)
			if Input.is_action_pressed("direita"):
				num_rotacao = deg_to_rad(-135)
				rotacionar(delta)
		if  Input.is_action_pressed("esquerda"):
			andando = true
			num_rotacao  = deg_to_rad(90)
			rotacionar(delta)
		if Input.is_action_pressed("direita"):
			andando = true
			num_rotacao  = deg_to_rad(-90)
			rotacionar(delta)
		#else:

			#andando = false

			#anim.play("Idle")

func rotacionar(delta):

	pivot.rotation.y = lerp_angle(pivot.rotation.y, num_rotacao, dir_vel * delta)


	pass # Replace with function body.
