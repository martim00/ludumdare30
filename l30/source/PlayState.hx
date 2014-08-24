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
import flixel.addons.ui.FlxUIPopup;
import flixel.util.FlxRect;
import flixel.util.FlxTimer;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	private var loader: FlxOgmoLoader;
	private var level : FlxTilemap;
	
	private var player1 : Player;
	private var player2 : Player;
	
	private var player1Inventory : InventoryView;
	private var player2Inventory : InventoryView;
	
	private var ground : Ground;
	private var blocks : FlxTypedGroup<Block>;	
	private var giftBlock : GiftBlock;		
	private var middleScreen = Std.int(FlxG.height / 2);

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		#if flash //flash only works with mp3 files
		FlxG.sound.playMusic(AssetPaths.play_state_song__mp3, 1, true);
		#else //for martim that compiles for neko
		FlxG.sound.playMusic(AssetPaths.play_state_song__ogg, 1, true);
		#end
		
		FlxG.mouse.visible = false;
		
		FlxG.cameras.bgColor = FlxColor.WHITE;
		
		player1 = new Player(16, FlxG.height - 32, FlxColor.BLUE, true);
		add(player1);
		
		//player2 = new Player(FlxG.width - 32, FlxG.height - 32, FlxColor.RED, false);
		player2 = new Player(Constants.LEVEL_WIDTH - 32, FlxG.height - 32, FlxColor.RED, false);
		add(player2);
		
		ground = new Ground(Constants.LEVEL_BEGIN_X, FlxG.height - 16);
		add(ground);
		
		/*player1Inventory = new InventoryView(0, 0, player1.getInventory());
		add(player1Inventory);
		player2Inventory = new InventoryView(0, middleScreen, player2.getInventory());
		add(player2Inventory);*/
		
		createCamera(0, 0xFFFFCCCC, player1);
		createCamera(Std.int(FlxG.height / 2), 0xFFCCCCFF, player2);
		
		loadLevel();
		
		super.create();
	}
		
	private function loadLevel()
	{	
		blocks = new FlxTypedGroup<Block>();		
		loader = new FlxOgmoLoader(AssetPaths.level2__oel);
		loader.loadEntities(placeEntities, "blocks");
	}
	
	private function placeEntities(entityName: String, entityData:Xml):Void
	{
		var x : Int = Std.parseInt(entityData.get("x"));
		var y : Int = Std.parseInt(entityData.get("y"));
		
		if (entityName == "block")
		{		
			var block = new Block(x, y, FlxColor.GREEN);
			blocks.add(block);
			add(block);
		}
		
		if (entityName == "giftBlock")
		{		
			var gift = new GiftBlock(x, y);
			//blocks.add(block);
			add(gift);
		}		
	}
	
	
	private function createCamera(Y:Int, Color:Int, Follow:FlxSprite):Void
	{
		//var camera:FlxCamera = new FlxCamera(0, Y, Std.int(FlxG.width), Std.int(FlxG.height / 2));
		var camera:FlxCamera = new FlxCamera(Constants.LEVEL_BEGIN_X, Y, Std.int(FlxG.width), Std.int(FlxG.height / 2));
		//var camera:FlxCamera = new FlxCamera(0, Y, FlxG.width, Std.int(FlxG.height / 2););
		
		// isso funciona
		//camera.setBounds(16, Std.int(FlxG.height / 2), Std.int(FlxG.width), Std.int(FlxG.height / 2));
		
		camera.setBounds(Constants.LEVEL_BEGIN_X, Std.int(FlxG.height / 2), Constants.LEVEL_WIDTH, Std.int(FlxG.height / 2));
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
		FlxG.camera.fade(FlxColor.WHITE,.33, false, function() {
				FlxG.switchState(new EndState());
			});	
	}
	
	function collideWithGift(gift : FlxObject, player : FlxObject) : Void
	{		
		gift.x = player1.x - 10;
		gift.y = player1.y;
		//player1.receiveGift(gift);
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
		
		FlxG.collide(giftBlock, player2, collideWithGift);
		
		FlxG.collide(player1, player2, collidePlayers);		
	}	
}