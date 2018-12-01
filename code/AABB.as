package code {
	import flash.geom.Point;

	/**
	 * The class for the AABB collider.
	 */
	public class AABB {

		/** Half of the width of the object. */
		private var halfWidth: Number;
		
		/** Half of the height of the object. */
		private var halfHeight: Number;

		/** The minimum x value of the object's width. */
		public var xMin: Number;
		
		/** The maximum x value of the object's width. */
		public var xMax: Number;
		
		/** The minimum y value of the object's width. */
		public var yMin: Number;
		
		/** The maximum y value of the object's width. */
		public var yMax: Number;

		/**
		 * The constructor for AABB.
		 * @param halfWidth Half the width of the object.
		 * @param halfHeight Half the height of the object.
		 */
		public function AABB(halfWidth: Number, halfHeight: Number) {
			setSize(halfWidth, halfHeight); // Sets the collider's size.
		} // ends AABB

		/**
		 * Sets the size of the collider according to the object's width and height.
		 * @param halfWidth Half the width of the object.
		 * @param halfHeight Half the height of the object.
		 */
		public function setSize(halfWidth: Number, halfHeight: Number): void {
			this.halfWidth = halfWidth;
			this.halfHeight = halfHeight;
			// recalculate edges!!!
			//calcEdges((xMin + xMax) / 2, (yMin + yMax) / 2); // Calculate the collider's edges.
		} // ends setSize

		/**
		 * Calculate the position of the 4 edges from the center (x, y) position.
		 * @param x The object's current x position.
		 * @param y The object's current y position.
		 */
		public function calcEdges(x: Number, y: Number): void {
			xMin = x - halfWidth;
			xMax = x + halfWidth;

			yMin = y - halfHeight;
			yMax = y + halfHeight;
		} // ends calcEdges

		/**
		 * This function checks to see if this AABB
		 * is overlapping another AABB.
		 * @param other The other AABB to check this AABB against.
		 * @return Whether or not they are overlapping. If true, they are overlapping.
		 */
		public function checkOverlap(other: AABB): Boolean {

			if (this.xMax < other.xMin) return false; // gap to the right
			if (this.xMin > other.xMax) return false; // gap to the left

			if (this.yMax < other.yMin) return false; // gap below
			if (this.yMin > other.yMax) return false; // gap above

			return true;
		} // ends checkOverlap

		/**
		 * This function calculates how long to move THIS box so that it no longer intersects another AABB.
		 * @param other The other AABB to check this AABB against.
		 * @return The "fix" vector - how far to move this box.
		 */
		public function findOverlapFix(other:AABB): Point {
			var moveL:Number = other.xMin - this.xMax;
			var moveR:Number = other.xMax - this.xMin;
			var moveU:Number = other.yMin - this.yMax;
			var moveD:Number = other.yMax - this.yMin;
			
			var fix:Point = new Point();
			
			fix.x = (Math.abs(moveL) < Math.abs(moveR)) ? moveL : moveR;
			fix.y = (Math.abs(moveU) < Math.abs(moveD)) ? moveU : moveD;
			
			if (Math.abs(fix.x) < Math.abs(fix.y)) fix.y = 0;
			else fix.x = 0;
			
			return fix;
		} // ends findOverlapFix
	} // ends class
} // ends package