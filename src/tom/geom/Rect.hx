package tom.geom;

import tom.Pool;

/**
 * A 2D rectangle.
 */
class Rect implements IPoolable {
	static var POOL:Pool<Rect> = new Pool(() -> new Rect());

	/**
	 * X-coordinate
	 */
	public var x:Float;
	/**
	 * Y-coordinate
	 */
	public var y:Float;
	/**
	 * Width of rectangle
	 */
	public var width:Float;
	/**
	 * Height of rectangle
	 */
	public var height:Float;

	public static inline function get(?x:Float, ?y:Float, ?width:Float, ?height:Float):Rect {
		var rect = POOL.get();
		rect.set(x, y, width, height);
		return rect;
	}

	function new(?x:Float, ?y:Float, ?width:Float, ?height:Float) {
		set(x, y, width, height);
	}

	public inline function set(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0) {
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
	}

	public inline function getBounds():Rect
		return get(x, y, width, height);

	public inline function put():Void
		POOL.put(this);

	public inline function area():Float
		return x * y * width * height;

	public inline function left():Float
		return x;

	public inline function right():Float
		return x + width;

	public inline function top():Float
		return y;

	public inline function bottom():Float
		return y + height;

	public inline function centreX():Float
		return x + width / 2;

	public inline function centreY():Float
		return y + height / 2;
	
	public inline function reset(): Void {}

	public function intersects(other: Rect): Bool {
		return (other.x < right()) && (x < other.right()) &&
			(other.y < bottom()) && (y < other.bottom());
	}

	public function contains(other: Rect): Bool {
		return (x <= other.x) && (other.right() <= right())
			&& (y <= other.y) && (other.bottom() <= bottom());
	}

	public inline function toString():String
		return '${x}, ${y} ${width} x ${height}';
}
