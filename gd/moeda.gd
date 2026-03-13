extends RigidBody3D

signal coletado

func _ready() -> void:
	var area3Dhere = $moeda_area
	area3Dhere.area_entered.connect(_coletar)
	pass # Replace with function body.
func _coletar(entroNode: Area3D)->void:
	if!entroNode.owner.is_in_group("player"):
		return
	
	coletado.emit()
	queue_free()
