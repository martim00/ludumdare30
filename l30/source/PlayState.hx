package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxColor;
import flixel.FlxCamera;
import flixel.util.FlxPoint;
import flixel.addons.editors.ogmo.FlxOgmoLoader;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	private var loader: FlxOgmoLoader;
	private var level : FlxTilemap;
	
	private var player1 : Player;
	private var player2 : Player;
	
	private var ground : Ground;
	
	private var blocks : FlxTypedGroup<Block>;
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		FlxG.mouse.visible = false;
		
		FlxG.cameras.bgColor = FlxColor.WHITE;	
		
		
		
		player1 = new Player(16, FlxG.height - 32, FlxColor.BLUE, true);
		add(player1);
		
		player2 = new Player(FlxG.width - 32, FlxG.height - 32, FlxColor.RED, false);
		add(player2);
		
		createCamera(0, 0xFFFFCCCC, player1);
		createCamera(Std.int(FlxG.height / 2), 0xFFCCCCFF, player2);
		
		ground = new Ground(0, FlxG.height - 10);
		add(ground);
		
		//blocks = new FlxTypedGroup<Block>();
		//loader = new FlxOgmoLoader(AssetPaths.level1__oel);
		
		loadLevel();
		
		super.create();
	}
	
	private function loadLevel()
	{		
		//level = new FlxTilemap();
		blocks = new FlxTypedGroup<Block>();
		//var levelpath = "assets/data/level" + level + ".oel";	
		loader = new FlxOgmoLoader(AssetPaths.level1__oel);
		loader.loadEntities(placeEntities, "blocks");
	}
	
	private function placeEntities(entityName: String, entityData:Xml):Void
	{
		var x : Int = Std.parseInt(entityData.get("x"));
		var y : Int = Std.parseInt(entityData.get("y"));
		
		if (entityName == "block")
		{
			trace("block loaded");
			var block = new Block(x, y, FlxColor.GREEN);
			blocks.add(block);
			add(block);
		}
		
		
		
	}
	
	
	private function createCamera(Y:Int, Color:Int, Follow:FlxSprite):Void
	{
		var camera:FlxCamera = new FlxCamera(0, Y, Std.int(FlxG.width), Std.int(FlxG.height / 2));
		//var camera:FlxCamera = new FlxCamera(0, Y, FlxG.width, Std.int(FlxG.height / 2););
	//	camera.setBounds(0, Y, Std.int(FlxG.width), Std.int(FlxG.height / 2));
		camera.bgColor = Color;
		camera.follow(Follow, FlxCamera.STYLE_PLATFORMER, new FlxPoint(0, Std.int(FlxG.height / 2)));
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
	
	function handleKeys() : Void
	{
		if (FlxG.keys.anyJustPressed(["SPACE"]))
		{
			trace("space clicked");
			player1.toggleIdle();
			player2.toggleIdle();
		}
		
	}
	
	function collidePlayers(p1 : FlxObject, p2 : FlxObject) : Void
	{
		FlxG.resetState();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
		
		handleKeys();
		
		FlxG.collide(ground, player1);
		FlxG.collide(ground, player2);
		
		FlxG.collide(blocks, player1);
		FlxG.collide(blocks, player2);
		
		FlxG.collide(player1, player2, collidePlayers);
		
	}	
}