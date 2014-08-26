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
import flixel.util.FlxTimer;
import flixel.util.FlxPoint;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	private var loader: FlxOgmoLoader;
	private var level : FlxTilemap;
	
	private var player1 : Player;
	private var player2 : Player;
	
	private var background : Background;
	private var ground : Ground;
	private var blocks : FlxTypedGroup<Block>;	
	private var giftBlocks : FlxTypedGroup<GiftBlock>;
	
	private var middleScreen = Std.int(FlxG.height / 2);

	private var textSize : Int = 100;
	
	private var levelWidth : Int = 800;

	var pressXText : FlxText;
	
	var isOnTransition : Bool = false;
	
	var levelCount : Int = 5;
	var actualLevel : Int = 1;
	
	

	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		FlxG.mouse.visible = false;
		
		FlxG.cameras.bgColor = FlxColor.WHITE;
			
		background = new Background(Constants.LEVEL_BEGIN_X, 240);
		add(background);				
		
		loadLevel(actualLevel);
		
		buildTexts();
		
		super.create();
	}
		
	private function buildTexts() : Void
	{	
		pressXText = new FlxText(0, 0, textSize, "Press X to send to your couple!");
	}
	
	private function loadLevel(level : Int)
	{	
		clearLevel();
		
		blocks = new FlxTypedGroup<Block>();		
		giftBlocks = new FlxTypedGroup<GiftBlock>();
		
		var levelpath = "assets/data/level" + level + ".oel";	
		
		//loader = new FlxOgmoLoader(AssetPaths.level4__oel);
		loader = new FlxOgmoLoader(levelpath);
		
		levelWidth = loader.width;
		
		ground = new Ground(Constants.LEVEL_BEGIN_X, FlxG.height - 16, levelWidth);
		add(ground);
		
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
			var gift = new GiftBlock(x, y, levelWidth);
			giftBlocks.add(gift);
			add(gift);
		}		
		
		if (entityName == "player1")
		{				
			player1 = new Player(x, y, FlxColor.BLUE, false, 1, levelWidth);
			add(player1.getBounds());
			add(player1);
			createCamera(0, 0xFFFFCCCC, player1);
		}
		
		
		if (entityName == "player2")
		{				
			player2 = new Player(x, y, FlxColor.RED, true, 2, levelWidth);
			add(player2.getBounds());
			add(player2);		
			createCamera(Std.int(FlxG.height / 2), 0xFFCCCCFF, player2);
		}	

	}
	
	
	private function createCamera(Y:Int, Color:Int, Follow:FlxSprite):Void
	{
		var camera:FlxCamera = new FlxCamera(Constants.LEVEL_BEGIN_X, Y, Std.int(FlxG.width), Std.int(FlxG.height / 2));
		//var camera:FlxCamera = new FlxCamera(Constants.LEVEL_BEGIN_X, Y, Std.int(FlxG.width), Std.int(FlxG.height / 2) - 32);
		
		
		// isso funciona
		//camera.setBounds(16, Std.int(FlxG.height / 2), Std.int(FlxG.width), Std.int(FlxG.height / 2));
		
		camera.setBounds(Constants.LEVEL_BEGIN_X, Std.int(FlxG.height / 2), levelWidth, Std.int(FlxG.height / 2));
	//	camera.setBounds(Constants.LEVEL_BEGIN_X, Std.int(FlxG.height / 2), Constants.LEVEL_WIDTH, FlxG.height - Constants.LEVEL_END_Y - 32);
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
			player1.toggleIdle();
			player2.toggleIdle();
		}		
		
		if (FlxG.keys.anyJustPressed(["R"]))
		{
			this.loadLevel(actualLevel);			
		}		
	}
	
	function collidePlayers(p1 : FlxObject, p2 : FlxObject) : Void
	{
		if (actualLevel == this.levelCount)
		{
		FlxG.camera.fade(FlxColor.WHITE,.33, false, function() {
				FlxG.switchState(new EndState());
			});	
		} else 
		{
			actualLevel += 1;
			loadLevel(actualLevel);
		}
	}

	
	function overlapsGiftBlocks(gift : GiftBlock, player : Player, targetPlayer : Player)
	{
		if (isOnTransition || player.isIdle())
			return;
			
		new FlxTimer(3, function(Timer : FlxTimer) : Void {
			remove(pressXText);	
		});			
		
		pressXText.x = player.x - textSize / 2;
		pressXText.y = player.y - 50;
		pressXText.color = FlxColor.YELLOW;
		add(pressXText);				
		
		//trace("OVERLAPPING");
		if (FlxG.keys.anyJustPressed(["x"]))
		{
			isOnTransition = true;	
			
			
			var xbkup = targetPlayer.x;
			var ybkup = targetPlayer.y;
			
			targetPlayer.y = targetPlayer.y - gift.height - 20;
			
			gift.x = xbkup;
			gift.y = ybkup;
			
			new FlxTimer(1, function(obj: FlxTimer) : Void {
				isOnTransition = false;				
			});
	}
	}

	function overlapsGiftBlocksP1(gift : GiftBlock, p1Bounds : FlxObject)
	{
		//trace("OVERLAPPING p1");
		overlapsGiftBlocks(gift, player1, player2);
	}
	
	function overlapsGiftBlocksP2(gift : GiftBlock, p2Bounds : FlxObject)
	{
		//trace("OVERLAPPING p2");
		overlapsGiftBlocks(gift, player2, player1);
	}
	
	function clearLevel():Void 
	{
		if (blocks != null)
		{
			blocks.forEach(function(obj : FlxSprite) : Void {
				remove(obj);
			});
		}
		
		if (giftBlocks != null)
		{
			giftBlocks.forEach(function(obj : FlxSprite) : Void {
				remove(obj);
			});
		}
		
		if (player1 != null)
		{
			remove(player1.getBounds());
			remove(player1);
		}
			
		if (player2 != null)
		{	
			remove(player2.getBounds());
			remove(player2);
		}
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
				
		FlxG.collide(ground, player1);
		FlxG.collide(ground, player2);
		
		FlxG.collide(blocks, player1);
		FlxG.collide(blocks, player2);	
		
		
		//FlxG.collide(player2, blocks);
		
		//FlxG.collide(blocks, player1);
		//FlxG.collide(blocks, player2);
		
		FlxG.collide(giftBlocks, blocks);
		
		FlxG.collide(giftBlocks, ground);
		
		FlxG.collide(giftBlocks, player1);
		FlxG.collide(giftBlocks, player2);
		
		
		FlxG.collide(player1, player2, collidePlayers);		
		FlxG.collide(giftBlocks, giftBlocks);
		
		
		FlxG.overlap(giftBlocks, player1.getBounds(), overlapsGiftBlocksP1);
		FlxG.overlap(giftBlocks, player2.getBounds(), overlapsGiftBlocksP2);		
		
		
		
		handleKeys();
		
	}	
}