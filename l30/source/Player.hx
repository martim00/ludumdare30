package ;

import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.util.FlxSpriteUtil;
import flixel.FlxG;
import flixel.system.FlxSound;
import flixel.util.FlxColor;


/**
 * ...
 * @author ...
 */
class Player extends FlxSprite
{
	private var idle : Bool = false;
	private var jumpSound : FlxSound;
	public var id : Int;	
	
	private var bounds : FlxSprite;
	
	private var levelWidth : Int;

	public function new(X:Float=0, Y:Float=0, color : Int, idle : Bool, id : Int, levelWidth : Int) 
	{
		super(X, Y);
		if (id == 1) {
			bounds = new FlxSprite(X, Y).makeGraphic(25, 39);
		} else {
			bounds = new FlxSprite(X, Y).makeGraphic(25, 33);
		}
		bounds.set_alpha(0);
		
		this.levelWidth = levelWidth;
				
		maxVelocity.set(100, 200);
		acceleration.y = Constants.GRAVITY;
		drag.x = maxVelocity.x * 4;
		jumpSound = FlxG.sound.load(AssetPaths.jump__wav);
		
		this.collisonXDrag = false;
		bounds.collisonXDrag = false;
		
		this.id = id;		
		this.idle = idle;
		
		loadAnimation();
	}
	
	private function loadAnimation()
	{
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		
		if (id == 1) {
			loadGraphic(AssetPaths.husband_run__png, true, 23, 37);
		} else {
			loadGraphic(AssetPaths.wife_run__png, true, 23, 31);
			facing = FlxObject.LEFT;
		}		
		
		animation.add("run", [0, 1, 2], 10);
		animation.add("stopped", [1], 10);
		animation.play("run");
	}
	
	public function toggleIdle()
	{
		this.idle = !this.idle;
	}
	
	public function isIdle() : Bool
	{
		return this.idle;
	}
	
	override function update() 
	{
		if (!idle) 
		{	
			// Player 1 controls
			acceleration.x = 0;
			
			if (FlxG.keys.pressed.LEFT)
			{
				facing = FlxObject.LEFT;
				acceleration.x = -maxVelocity.x * 4;
			}
			
			if (FlxG.keys.pressed.RIGHT)
			{
				facing = FlxObject.RIGHT;
				acceleration.x = maxVelocity.x * 4;
			}	
			
			if (FlxG.keys.justPressed.UP && isTouchingFloor())
			{
				jumpSound.play();
				velocity.y -= maxVelocity.y / 1.5;
			}
				
			// clamp...
			if (x >= levelWidth - this.width)
			{
				x = levelWidth - this.width;
			}
			
			if (x < Constants.LEVEL_BEGIN_X )
			{
				x = Constants.LEVEL_BEGIN_X ;
			}
			
			
		} else {
			velocity.x = 0;
			acceleration.x = 0;
		}
		
		setAnimationType();
		
		this.bounds.x = x - 1;
		this.bounds.y = y - 1;
				
		super.update();
	}
		
	private function setAnimationType()
	{
		if (velocity.x != 0 && velocity.y == 0) {
			animation.play("run");
		} else {
			animation.play("stopped");
		}
	}
	
	public function getBounds() : FlxSprite
	{
		return this.bounds;
	}
	
	function isTouchingFloor() : Bool
	{	
		//trace("is touching floor: " + isTouching(FlxObject.FLOOR));
		//trace("is touching right: " + isTouching(FlxObject.RIGHT));
		
		return isTouching(FlxObject.FLOOR) 
		// pelo menos evitamos a escalada com isso
			&& !isTouching(FlxObject.RIGHT) 
			&& !isTouching(FlxObject.LEFT); 
		//return velocity.y == 0;
	}
	
	
	
}