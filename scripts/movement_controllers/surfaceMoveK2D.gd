extends KinematicBody2D

#Surface move is intended to be 2d platformer controller that is direction/gravity agnostic
#movement direction is detirmind by the colion normal of the KInematic body (ie the direction of the floor)
#and moevemnt speed is determined by the friction on that surface and the force acting on the body towards that surface
#implemnted properly it should provide an elegant mathematical solution for walking, sliding wallrunning, walljumping, etc.

const FORCES = Vector2(0,98.1) #this should be inherited or read from utility in future iterations

export (float) var topSpeed = 50 #maximum speed (decimeters?)
export (float) var damping = 1 #time (seconds) to reach top speed

const CUTOFF = 0.1 #acceptable threshold to target speed
var velocity = Vector2()
var walk = 0.0

func _physics_process(delta):
	velocity += FORCES * delta
	
	#the following has been adapted from simpleMove2D.gd
	var walkTarg = inMap.move.x * topSpeed
	if 0 < damping:
		var dWalk = walkTarg - velocity.x
		if CUTOFF < abs(dWalk): 
			velocity.x += sign(dWalk) * topSpeed * delta / damping
		else:
			velocity.x = walkTarg
	else:
		velocity.x = walkTarg
	#not that movement is implemented directly rather than with forces. This allows for more direct control and responsiveness but may need to be changed if compaitibility issues mount
	velocity =  move_and_slide(velocity)
	pass

#TODO figure out why fall and move feel so sluggish
#TODO add jump
#TODO add multidirectionality to walk and jump
#TODO built curved map to test multidirectionality
