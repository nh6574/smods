---@meta

--TODO: Move
---@class StateSprite: AnimatedSprite
---@overload fun(...: any): StateSprite|table
StateSprite = {}
function StateSprite:__call(...) return self end

--- Place for misc. LSP additions related to vanilla.
--- Vanilla Pools

---@alias Enhancements
---| 'm_bonus'
---| 'm_mult'
---| 'm_wild'
---| 'm_glass'
---| 'm_steel'
---| 'm_stone'
---| 'm_gold'
---| 'm_lucky'

---@alias Editions
---| 'e_foil'
---| 'e_holo'
---| 'e_polychrome'
---| 'e_negative'

---@alias Seals
---| 'Red'
---| 'Blue'
---| 'Gold'
---| 'Purple'

---@alias Stickers
---| 'perishable'
---| 'eternal'
---| 'rental'
---| 'pinned'

---@alias PokerHands
---| 'Flush Five'
---| 'Flush House'
---| 'Five of a Kind'
---| 'Straight Flush'
---| 'Four of a Kind'
---| 'Full House'
---| 'Flush'
---| 'Straight'
---| 'Three of a Kind'
---| 'Two Pair'
---| 'Pair'
---| 'High Card'

---@alias Ranks
---| '2'
---| '3'
---| '4'
---| '5'
---| '6'
---| '7'
---| '8'
---| '9'
---| '10'
---| 'Jack'
---| 'Queen'
---| 'King'
---| 'Ace'

---@alias Suits
---| 'Hearts'
---| 'Diamonds'
---| 'Clubs'
---| 'Spades'

---@alias Rarities
---| 'Legendary'
---| 'Rare'
---| 'Uncommon'
---| 'Common'

---@alias PlayAreas
---| `G.play` # Area for cards played (check during scoring for cards scored)
---| 'unscored' # Check for unscored cards during scoring
---| `G.hand` # Area for cards held in hand
---| `G.jokers` # Joker area
---| `G.consumeables` # Consumable area
---| `G.discard` # Discard area
---| `G.deck` # Deck
