package ;

import flixel.FlxSprite;
import flixel.group.FlxTypedGroup;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

/**
 * ...
 * @author ...
 */
class InventoryView extends FlxTypedGroup<FlxSprite>
{
	private var model : Inventory;
	
	 private var sprBack:FlxSprite;

	public function new(X:Float, Y:Float, inventory : Inventory) 
	{
		//super(X, Y);
		super();
		this.model = inventory;
		
		//this.makeGraphic(16, Std.int(FlxG.height / 2), FlxColor.GRAY);
		
		sprBack = new FlxSprite().makeGraphic(16, Std.int(FlxG.height / 2), FlxColor.GRAY);
        FlxSpriteUtil.drawRect(sprBack, 3, 3, 10, Std.int(FlxG.height / 2) - 3, FlxColor.BLACK);
		add(sprBack);
		sprBack.x = X;
		sprBack.y = Y;
		
        /*_txtHealth = new FlxText(16, 2, 0, "3 / 3", 8);
        _txtHealth.setBorderStyle(FlxText.BORDER_SHADOW, FlxColor.GRAY, 1, 1);
        _txtMoney = new FlxText(0, 2, 0, "0", 8);
        _txtMoney.setBorderStyle(FlxText.BORDER_SHADOW, FlxColor.GRAY, 1, 1);
        _sprHealth = new FlxSprite(4, _txtHealth.y + (_txtHealth.height/2)  - 4, AssetPaths.health<strong>png);
        _sprMoney = new FlxSprite(FlxG.width - 12, _txtMoney.y + (_txtMoney.height/2)  - 4, AssetPaths.coin</strong>png);
        _txtMoney.alignment = "right";
        _txtMoney.x = _sprMoney.x - _txtMoney.width - 4;
        
        add(_sprHealth);
        add(_sprMoney);
        add(_txtHealth);
        add(_txtMoney);
        forEach(function(spr:FlxSprite) {
            spr.scrollFactor.set();
        });*/
		
		
	}
	
	override function update() : Void
	{
		super.update();
	}
	
}