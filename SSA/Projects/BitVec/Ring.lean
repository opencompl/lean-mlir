import Std.Data.BitVec
import Mathlib.Data.Nat.Bitwise
import Mathlib.Data.ZMod.Defs

/-

    |            +                      |              *                |         ^
----------------------------------------------------------------------------------------------------
    |                                   |                               |
 +  | `(a + b) + c = a + (b + c)`       |             N/A               |         N/A
    |                                   |                               |
 *  | `(a + b) * c = (a * c) + (b * c)` | `(a * b) * c = a * (b * c)`   |         N/A
    | `a * (b + c) = (a * b) + (a * c)` |                               |
    |                                   |                               |
 ^  | `a^(b+c) = a^b * a^c`             | `(a * b)^c = a^c + b^c`       |  `(a^b)^c = a^(b*c)`
    |                                   |                               |


-/

variable (a b c : BitVec w)

example : (a &&& b) ||| c = (a ||| c) &&& (b ||| c) := by
  sorry --TODO

example : a ||| (b &&& c) = (a ||| b) &&& (a ||| c) := by
  sorry --TODO

example : (a ||| b) &&& c = (a &&& c) ||| (b &&& c) := by
  sorry --TODO

example : a &&& (b ||| c) = (a &&& b) ||| (a &&& c) := by
  sorry --TODO


-- example : a + b = ((a ^^^ b) + (a &&& b) &&& !1) ||| (a ^^^ b)
