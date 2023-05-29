-- https://en.wikipedia.org/wiki/Straightedge_and_compass_construction#The_basic_constructions
import SSA.Core.WellTypedFramework
import SSA.Core.Util


inductive Op
| line -- make line from two points
| circle -- make circle from center and radius
| intersect_ll -- intersect two lines
| intersect_cl -- intersect circle and line
| intersect_cc -- intersect two circles
deriving DecidableEq, Inhabited

inductive BaseType
| point
| line
| circle
| length
deriving DecidableEq, Inhabited

abbrev Point : Type := Unit
abbrev Line : Type := Unit
abbrev Length : Type := Unit

instance : Goedel BaseType where
  toType
  | .point => Point
  | .line => Line
  | .length => Length




-- instance TUS : SSA.TypedUserSemantics Op BaseType where
--   argUserType := argUserType
--   rgnDom := rgnDom
--   rgnCod := rgnCod
--   outUserType := outUserType
--   eval := eval

-- syntax "map1d" : dsl_op
-- syntax "extract1d" : dsl_op
-- syntax "const" "(" term ")" : dsl_op

-- open EDSL in
-- macro_rules
-- | `([dsl_op| map1d]) => `(Op.map1d)
-- | `([dsl_op| extract1d]) => `(Op.extract1d)
-- | `([dsl_op| const ($x)]) => `(Op.const $x) -- note that we use the syntax extension to enrich the base DSL



abbrev UserType := SSA.UserType BaseType