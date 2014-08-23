package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.tile.FlxTilemap;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxColor;
import flixel.FlxCamera;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	private var level : FlxTilemap;
	
	private var player1 : Player;
	private var player2 : Player;
	
	private var ground : Ground;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		FlxG.mouse.visible = false;
		
		FlxG.cameras.bgColor = FlxColor.WHITE;
		
		level = new FlxTilemap();
		//add(level);
		
		player1 = new Player(10, FlxG.height - 20 - 100);
		add(player1);
		
		player2 = new Player(100, FlxG.height - 20);
		add(player2);
		
		createCamera(0, 0xFFFFCCCC, player1);
		createCamera(Std.int(FlxG.height / 2), 0xFFCCCCFF, player2);
		
		ground = new Ground(0, FlxG.height - 10);
		add(ground);
		
		super.create();
	}
	
	private function createCamera(Y:Int, Color:Int, Follow:FlxSprite):Void
	{
		var camera:FlxCamera = new FlxCamera(0, Y, Std.int(FlxG.width), Std.int(FlxG.height / 2));
		//var camera:FlxCamera = new FlxCamera(0, Y, FlxG.width, Std.int(FlxG.height / 2););
		//camera.setBounds(0, 0, Std.int(FlxG.width), Std.int(FlxG.height / 2));
		camera.bgColor = Color;
		camera.follow(Follow);
		FlxG.cameras.add(camera);
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}
	
	

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
		FlxG.collide(ground, player1);
		FlxG.collide(player2, ground);
		
	}	
}