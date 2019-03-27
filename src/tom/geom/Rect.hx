package tom.geom;

import tom.util.Pool;

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

	/**
	 * Left x co-ordinate
	 */
	public var left(get, never): Float;

	/**
	 * Right x co-ordinate
	 */
	public var right(get, never): Float;

	/**
	 * Top co-ordinate
	 */
	public var top(get, never): Float;

	/**
	 * Bottom y co-ordinate
	 */
	public var bottom(get, never): Float;

	/**
	 * Area of this rectangle
	 */
	public var area(get, never): Float;

	public static inline function get(?x:Float, ?y:Float, ?width:Float, ?height:Float):Rect {
		var rect = POOL.get();
		rect.set(x, y, width, height);
		return rect;
	}

	public function new(?x:Float, ?y:Float, ?width:Float, ?height:Float) {
		set(x, y, width, height);
	}

	public inline function set(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0): Rect {
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		return this;
	}
	

	public inline function put():Void
		POOL.put(this);

	inline function get_area():Float
		return width * height;

	inline function get_left():Float
		return x;

	inline function get_right():Float
		return x + width;

	inline function get_top():Float
		return y;

	inline function get_bottom():Float
		return y + height;

	public inline function centreX():Float
		return x + width / 2;

	public inline function centreY():Float
		return y + height / 2;
	
	/**
	 * Restore the rectangle to its defaults.
	 */
	public inline function reset(): Void {
		x = y = width = height = 0;
	}

	/**
	 * Returns `true` when this rectangle overlaps / intersects with `other`
	 * @param other rectangle to check
	 * @return `true` when intersects
	 */
	public function intersects(other: Rect): Bool {
		return (right > other.left) &&
			(left < other.right) && 
			(bottom > other.top) &&
			(top < other.bottom);
	}

	/**
	 * Returns true when `other` is inside this rectangle
	 * @param other the other rectangle
	 * @return true when `other` inside
	 */
	public function contains(other: Rect): Bool {
		return (left <= other.left) && (other.right <= right)
			&& (top <= other.top) && (other.bottom <= bottom);
	}
	/**
	 * Returns `true` if this rectangle and `other` have the same co-ordinates
	 * and dimensions
	 * @param other the rectangle to compare
	 * @param maxDiff maximum difference between equal rect co-ordinates / dimensions
	 * @return true when same
	 */
	public inline function equals(other: Rect, maxDiff: Float = 0.01): Bool 
		return (Math.abs(x - other.x) < maxDiff) &&
			(Math.abs(y - other.y) < maxDiff) &&
			(Math.abs(width - other.width) < maxDiff) &&
			(Math.abs(height - other.height) < maxDiff);

	public inline function toString():String
		return '${x}, ${y} - ${width} x ${height}';
}
