---@meta

--- Determines how an event is triggered.
--- @alias Event.TriggerType
--- | 'immediate' Executes handler immediately
--- | 'before' Executes handler immediately, but only after some delay the event is fully marked as completed
--- | 'after' Executes handler after specified delay
--- | 'condition' Same as immediate, but only used when default handler is used
--- | 'ease' Eases value and modifies value in table. Function is called back with eased value during that time. Handler return value determines the value to set on the table

--- @alias Event.EaseType
--- | 'lerp'
--- | 'linear'
--- | 'insine'
--- | 'outsine'
--- | 'inoutsine'
--- | 'quad'
--- | 'inquad'
--- | 'outquad'
--- | 'inoutquad'
--- | 'inexpo'
--- | 'outexpo'
--- | 'inoutexpo'
--- | 'incirc'
--- | 'outcirc'
--- | 'inoutcirc'
--- | 'elastic'
--- | 'inelastic'
--- | 'outelastic'
--- | 'inoutelastic'
--- | 'inback'
--- | 'outback'
--- | 'inoutback'

---@class Event.InitArgs
---@field trigger? Event.TriggerType
---@field blocking? boolean Prevents subsequent events in the queue from being handled. Defaults to `true`
---@field blockable? boolean Allows this event to be blocked from being handled. Defaults to `true`
---@field start_timer? boolean If false, sets `time` to current timer value when handle is called.
---@field func? fun(n: number?): boolean|number? Should return `true` when the event is completed. `n` is passed as an argument for the `'ease'` type. Defaults to a dummy function based on the event type.
---@field delay? number Use depends on trigger type. `ease`: Easing duration `after`: Delay before handler is executed. `before`: Delay before event is fully marked as completed. Defaults to `0`
---@field no_delete? boolean Prevents the event from being removed from queue when `EventManager:clear_queue` is called.
---@field pause_force? boolean If `true`, treats the Event as being created on pause
---@field timer? Game.TimerType Timer type in G.TIMERS to use. Defaults to `TOTAL` if unpaused, `REAL` if paused
---@field ease? Event.EaseType For trigger type `'ease'`. Defaults to `'lerp'`
---@field type? Event.EaseType For trigger type `'ease'`. Defaults to `'lerp'`
---@field ref_table? table For trigger type `'ease'` or `'condition'`
---@field ref_value? any For trigger type `'ease'` or `'condition'`
---@field ease_to? number For trigger type `'ease'`
---@field stop_val? any For trigger type `'condition'`

---@class Event: Object
---@field trigger Event.TriggerType
---@field blocking boolean Prevents subsequent events in the queue from being handled
---@field blockable boolean Allows this event to be blocked from being handled
---@field complete boolean Determines if this event is completed
---@field start_timer boolean If false, sets `time` to current timer value when handle is called
---@field func fun(n: number?): boolean|number? Should return `true` when the event is completed. `n` is passed as an argument for the `'ease'` type.
---@field delay number Use depends on trigger type. `ease`: Easing duration `after`: Delay before handler is executed. `before`: Delay before event is fully marked as completed
---@field no_delete boolean Prevents the event from being removed from queue when `EventManager:clear_queue` is called.
---@field created_on_pause boolean Determines if the event was created on pause
---@field timer Game.TimerType Timer type in G.TIMERS to use
---@field ease {type: Event.EaseType, ref_table: table, ref_value: any, start_val: number, end_val: number, start_time: number?, end_time: number?} Config values for the `'ease'` event type
---@field condition {ref_table: table, ref_value: any, stop_val: any} Config values for the `'condition'` event type

---@overload fun(config: Event.InitArgs): Event
Event = {}
Event.__index = Event
Event.super = Object

---@param config Event.InitArgs
---@return Event
--- Creates a new instance of the class.
function Event:__call(config) end

---@param config Event.InitArgs
--- Initializes the object.
function Event:init(config) end

--- @class Event.Result
---@field pause_skip? boolean Skips current event queue, allowing other events to execute. This behaves the same as having everything set to `false`.
--- @field blocking? boolean Blocks rest of the events, preventing them from being handled, unless `blockable` is false.
--- @field completed? boolean Marks this event as completed and removed this event from list. Requires `time_done` to be also true.
--- @field time_done? boolean Marks this event as done and removed this event from list. Requires `completed` to be also true.

---@param _results Event.Result Result object to return to
--- Handles the Event.
function Event:handle(_results) end

---@alias Event.Queue table<integer, Event>

---@class EventManager: Object
---@field queues {base: Event.Queue, unlock: Event.Queue, tutorial: Event.Queue, achievement: Event.Queue, other: Event.Queue} List of event queues
---@field queue_timer number Current event time
---@field queue_dt number Update frequency. Defaults to `1/60`
---@field queue_last_processed number Last time when the queue is processed
---@field append_count? integer Counter for events added to a queue b other events while that queue is being handled
---@field append_queue? integer Queue that is being handled

---@overload fun(): EventManager
EventManager = {}
EventManager.__index = EventManager
EventManager.super = Object

---@return EventManager
--- Creates a new instance of the class.
function EventManager:__call() end

--- Initializes the object.
function EventManager:init() end

---@param event Event
---@param queue? string Queue to use. Defaults to `'base'`
---@param front? boolean Puts even at the front of the queue.
--- Adds Event to the EventManager's queue.
function EventManager:add_event(event, queue, front) end

---@param queue? string Queue to clear. Clears all queues if falsy
---@param exception? string Clears all other queues except provided. Only works if `queue` is truthy
function EventManager:clear_queue(queue, exception) end

---@param dt number
---@param forced? boolean Forces update disregarding the timer
--- Updates the EventManager.
function EventManager:update(dt, forced) end
