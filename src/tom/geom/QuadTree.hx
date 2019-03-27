package tom.geom;

import tom.util.Pool;
import tom.geom.Rect;

interface IQuadTreeMember {
	var bounds(get, null): Rect;
}

class QuadTree<T: IQuadTreeMember> implements IPoolable {
    public static inline var MAX_LEVEL = 50;
    public static inline var MAX_OBJECTS = 5;

    static final pool: Pool<QuadTree<T>> = new Pool<QuadTree<T>>(() -> new QuadTree(null, 0));
    /**
     * List of objects in this node.
     */
    public final objects: Array<T> = new Array<T>();
    /**
     * The boundaries of the rect.
     */
    public var bounds(default, null): Rect;

    public var level(default, null): Int;

    // Children

    var topLeft: QuadTree<T> = null;
    var topRight: QuadTree<T> = null;
    var bottomLeft: QuadTree<T> = null;
    var bottomRight: QuadTree<T> = null;

    /**
     * Creates a new Quad Tree.
     * @param bounds The bounds of the tree.
     * @param level The level / depth of the tree.
     */
    public function new(bounds: Rect, level: Int = 0) {
        set(bounds, level);
    }

    /**
     * Set up this Quad Tree
     * @param bounds The bounds of the tree.
     * @param level The level / depth of the tree.
     */
    public inline function set(bounds: Rect, level: Int = 0): QuadTree<T> {
        this.bounds = bounds;
        this.level = level;
        return this;
    }

    public static inline function get<T: IQuadTreeMember>(bounds: Rect, ?level: Int): QuadTree<T> {
        return cast pool.get().set(bounds, level);
    }

    public function add(object: T): Bool {
        if(!bounds.contains(object.bounds)) {
            return false;
        }
        if(level < MAX_LEVEL && (topLeft != null || objects.length >= MAX_OBJECTS)) {
            if(topLeft == null)
                split();
            
            if(topLeft.add(object))
                return true;
            if(topRight.add(object))
                return true;
            if(bottomLeft.add(object))
                return true;
            if(bottomRight.add(object))
                return true;
        }

        objects.push(object);
        return true;
    }

    public function getContents(?list: Array<T>): Array<T> {
        if(list == null)
            list = new Array<T>();
        
        for(obj in objects)
            list.push(obj);
        
        if(topLeft == null)
            return list;
        
        topLeft.getContents(list);
        topRight.getContents(list);
        bottomLeft.getContents(list);
        bottomRight.getContents(list);

        return list;
    }

    public function getColliding(rect: Rect, ?list: Array<T>): Array<T> {
        if(list == null)
            list = new Array<T>();
        
        if(!bounds.intersects(rect))
            return list;
        
        for(obj in objects)
            if(rect.intersects(obj.bounds))
                list.push(obj);
        
        if(topLeft == null)
            return list;

        topLeft.getColliding(rect, list);
        topRight.getColliding(rect, list);
        bottomLeft.getColliding(rect, list);
        bottomRight.getColliding(rect, list);

        return list;
    }
    function split(): Void {
        var halfW = bounds.width / 2;
        var halfH = bounds.height / 2;

        topLeft = QuadTree.get(Rect.get(bounds.x, bounds.y, halfW, halfH), level + 1);
        topRight = QuadTree.get(Rect.get(bounds.x + halfW, bounds.y, halfW, halfH), level + 1);
        bottomLeft = QuadTree.get(Rect.get(bounds.x, bounds.y + halfH, halfW, halfH), level + 1);
        bottomRight = QuadTree.get(Rect.get(bounds.x + halfW, bounds.y + halfH, halfW, halfH), level + 1);
    }
	/**
	 * Move entities who can fit in a lower node.
	 */
	function balance(): Void {
		for (obj in objects) {
			if (topLeft.add(obj) || topRight.add(obj) || bottomRight.add(obj) || bottomLeft.add(obj))
				objects.remove(obj);
		}
	}

    public function remove(obj: T): Bool {
        if(topLeft == null)
            return objects.remove(obj);
        	
		return objects.remove(obj) || topLeft.remove(obj)||
			topRight.remove(obj) || bottomRight.remove(obj)||
			bottomLeft.remove(obj);
    }

    public function clear(): Void {
        // put inner quads in pool
        if(topLeft == null)
            return;
        
        topLeft.put();
        topRight.put();
        bottomLeft.put();
        bottomRight.put();


        topLeft = topRight = bottomLeft = bottomRight = null;
    }

    public function reset(): Void {
        level = 0;
        if(bounds != null)
            bounds.put();
        bounds = null;
        clear();
    }

    public inline function put(): Void {
        pool.put(this);
    }

    public function toString() {
        return '${level}: ${bounds}';
    }
}