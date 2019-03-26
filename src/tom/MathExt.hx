package tom;

/**
 * Extensions to the standard Math class
 */
class MathExt {
	/**
	 * Returns the sign of the number
	 * @param n The number
	 * @return The sign of the number: -1 if negative, 1 if positive, 0 if zero
	 */
	public static function sign(n:Float):Int {
		return (n > 0) ? 1 : (n == 0 ? 0 : -1);
	}
	
	/**
	 * Clamps the number between a minumum and maximum
	 * @param n the number
	 * @param min the minimum
	 * @param max the maximum
	 * @return the clamped number
		return n < min ? min : (n > max ? max : n)
	 */
	public static function clamp(n: Float, min: Float, max: Float): Float
		return n < min ? min : (n > max ? max : n);

	
	public static inline function clampMag(n:Float, max:Float):Float {
		return clamp(n, -max, max);
	}
}
