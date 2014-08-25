package ;
import flixel.FlxSprite;
import flixel.util.FlxPoint;

/**
 * ...
 * @author ...
 */
class Background extends FlxSprite
{

	public function new(X: Float = 0, Y : Float = 0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.background__png, false);
		
		solid = immovable = true;
	}
	
	override function update() : Void
	{
		super.update();
	}
	
}