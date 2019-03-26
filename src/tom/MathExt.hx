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
	
	
	public static inline function clampMag(n:Float, max:Float):Float {
		return Math.clamp(n, -max, max);
	}
}
