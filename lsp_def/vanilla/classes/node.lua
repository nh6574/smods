---@meta

---@class Position
---@field x number x position
---@field y number y position

---@class Transform: Position
---@field w number Width
---@field h number Height
---@field r number Rotation
---@field scale number Scale

---@class Transform.InitArgs
---@field x? number x position. Defaults to `0`
---@field y? number y position. Defaults to `0`
---@field w? number Width. Defaults to `1`
---@field h? number Height. Defaults to `1`
---@field r? number Rotation. Defaults to `0`
---@field scale? number Scale. Defaults to `1`
---@field [1]? number x position. Defaults to `0`
---@field [2]? number y position. Defaults to `0`
---@field [3]? number Width. Defaults to `1`
---@field [4]? number Height. Defaults to `1`
---@field [5]? number Rotation. Defaults to `0`
---@field [6]? number Scale. Defaults to `1`

---@class Node.States
---@field visible boolean If the node is visible (and interactable) on screen
---@field collide {can: boolean, is: boolean} Keeps track of the collision state
---@field focus {can: boolean, is: boolean} Keeps track of the focus state
---@field hover {can: boolean, is: boolean} Keeps track of the hover state
---@field click {can: boolean, is: boolean} Keeps track of the click state
---@field drag {can: boolean, is: boolean} Keeps track of the dragged state
---@field release_on {can: boolean, is: boolean} Keeps track of the released state

--- Node represent any game object that needs to have some transform available in the game itself.
---@class Node: Object
---@field ARGS table Stores argument tables for reuse
---@field RET table Stores return tables for reuse
---@field config table Stores metadata
---@field T Transform Node's transform
---@field CT Transform Transform to use for collision detection
---@field click_offset Position Click offset table, used to determine things like drag offset
---@field hover_offset Position Hover offset table, used to determine things like 3d shader effects
---@field created_on_pause boolean? Keep track if the node was created on pause. If true, this node moves normally even when the G.TIMERS.TOTAL doesn't increment
---@field ID integer ID tracker, every Node has a unique ID
---@field FRAME {DRAW: number, MOVE: number} Frame tracker to aid in not doing too many extra calculations
---@field states Node.States The states for this Node and all derived nodes. This is how we control the visibility and interactibility of any object
---@field container Node The node is translated with this container as the reference frame. This allows control over things like screen shake, room positioning, rotation, padding, etc. without needing to modify every game object
---@field children table The list of children give Node a treelike structure. This can be used for things like drawing, deterministice movement and parallax calculations when child nodes rely on updated information from parents, and inherited attributes like button click functions
---@field DEBUG_VALUE? string Debug string to draw on the screen with `draw_boundingrect`
---@field REMOVED? boolean IF true the node has been marked for removal

---@class Node.InitArgs
---@field T? Transform.InitArgs Transform initializer
---@field container? Node The parent container. All nodes within that container are translated with that container as the reference frame. Defaults to `G.ROOM`

---@overload fun(args: Node.InitArgs): Node
Node = {}
Node.__index = Node
Node.super = Object

---@param args Node.InitArgs
---@return Node
--- Creates a new instance of the class.
function Node:__call(args) end

---@param args Node.InitArgs
--- Initializes the object.
function Node:init(args) end

--- Draw a bounding rectangle representing the transform of this node. Used in debugging.
function Node:draw_boundinrect() end

--- Draws self and its children.
function Node:draw() end

---@param point Position The coordinates of the cursor transformed into game units
---@return boolean?
--- Determines if this node collides with some point. Applies any container translations and rotations, then
--- applies translations and rotations specific to this node. This means the collision detection effectively
--- determines if some point intersects this node regardless of rotation.
function Node:collides_with_point(point) end

---@param point Position The coordinates of the cursor transformed into game units
---@param type 'Click'|'Hover' The type of offset to set for this Node
--- Sets the offset of passed point in terms of this node's T.x and T.y
function Node:set_offset(point, type) end

--- If the current container is being 'Dragged', usually by a cursor, determines if any drag popups need to be generated and does so
function Node:drag() end

---@return Node?
--- Determines if this Node can be dragged. This is a simple function but more complex objects may redefine this to return a parent\
--- if the parent needs to drag other children with it
function Node:can_drag() end

--- Called by the CONTROLLER when this node is no longer being dragged, removes any d_popups
function Node:stop_drag() end

--- If the current container is being 'Hovered', usually by a cursor, determines if any hover popups need to be generated and does so
function Node:hover() end

--- Called by the CONTROLLER when this node is no longer being hovered, removes any h_popups
function Node:stop_hover() end

---@return number x
---@return number y
--- Called by the CONTROLLER to determine the position the cursor should be set to for this node
function Node:put_focused_cursor() end

---@param container Node The new node that will behave as this nodes container
--- Sets the container of this node and all child nodes to be a new container node
function Node:set_container(container) end

--- Translation function used before any draw calls, translates this node according to the transform of the container node
function Node:translate_container() end

--- When this Node needs to be deleted, removes self from any tables it may have been added to to destroy any weak references\
--- Also calls the remove method of all children to have them do the same
function Node:remove() end

---@param other_node Node to measure the distance from
---@return number
--- returns the squared(fast) distance in game units from the center of this node to the center of another node
function Node:fast_mid_dist(other_node) end

---@param dragged table
--- Prototype for a click release function, when the cursor is released on this node
function Node:release(dragged) end

--- Prototype for a click function
function Node:click() end

--- Prototype animation function for any frame manipulation needed
function Node:animate() end

---@param dt number
--- Prototype update function for any object specific logic that needs to occur every frame
function Node:update(dt) end

--TODO: Document Node.ARGS
