extends Node3D
var vida = 1
var speed = 2
@onready var anim: AnimationPlayer = $Path3D/follow/SpringArm3D/pivot/lobaoo/AnimationPlayer
@onready var follow: PathFollow3D = $Path3D/follow
var cooldown = true
enum estado{ANDANDO, ATAQUE, MORTO}
var state = estado.ANDANDO
@onready var cooldown_attack: Timer = $CooldownAttack
var alvo
var dano = 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Label.text = str("vida =", GameManager.player["vida"])
	match state:
		estado.ANDANDO:
			anim.play("Walk")
			anim.speed_scale = 1
			follow.progress += speed * delta
			pass
		estado.ATAQUE:
			anim.speed_scale = 0.4
			anim.play("Attack")
			pass
		estado.MORTO:
			
			pass
		
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("player") and vida >= 1:
		state = estado.ATAQUE
		GameManager.player["vida"] == dano
	pass 
func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.is_in_group("player"):
		state = estado.ANDANDO
	pass # Replace with function body.
func attack():
	if cooldown:
		GameManager.player["vida"] -= 1
		alvo.tremercontrole(0.2, 0.3, 0.3)
		state = estado.ANDANDO
		cooldown = false
		cooldown_attack.start()


func _on_cooldown_attack_timeout() -> void:
	cooldown = true
	pass # Replace with function body.
