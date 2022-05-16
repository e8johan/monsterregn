extends Node2D

var points := 0
var rng := RandomNumberGenerator.new()

export (PackedScene) var star_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	_updatePoints()
	_createStar()

func _process(delta):
	pass
	
func _updatePoints():
	$UI/PointsLabel.text = "\t" + str(self.points)

func _createStar():
	var star = star_scene.instance()
	var star_position = Vector2(rng.randi_range(64, 720-64), -60)
	star.position = star_position
	star.connect("points_increase", self, "_on_points_increase")
	star.connect("points_decrease", self, "_on_points_decrease")
	self.add_child(star)


func _on_points_increase(pts):
	self.points += pts
	self._updatePoints()

func _on_points_decrease():
	self.points -= 1
	if self.points < 0:
		self.points = 0
	self._updatePoints()

func _on_Timer_timeout():
	if rng.randi_range(0, 100) < 5:
		self._createStar()
