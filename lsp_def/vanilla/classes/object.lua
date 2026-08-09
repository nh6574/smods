---@meta

---@class Object: table

---@overload fun(...?: any): Object
Object = {}
Object.__index = Object

--- Creates a new instance of the class.
---@param ...? any
---@return Object
function Object:__call(...) end

---@param T metatable
---@return boolean
--- Checks if the Object is a specific metatable type (i.e. belongs to the class or one that extends it).
function Object:is(T) end

---@return Object
--- Extends the object's class.
function Object:extend() end

---@param ...? any
--- Initializes the object.
function Object:init(...) end
