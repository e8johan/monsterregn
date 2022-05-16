extends Sprite

signal points_increase(points)
signal points_decrease

var no_of_clicks_left := 2
var speed := Vector2(0, 100)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position += speed*delta
	
	if self.position.y > 1000:
		emit_signal("points_decrease")
		self.queue_free()

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton && event.pressed:
		self.no_of_clicks_left -= 1
		if self.no_of_clicks_left <= 0:
			emit_signal("points_increase", 1)
			self.queue_free()
