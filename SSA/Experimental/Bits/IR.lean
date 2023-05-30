import SSA.Core.WellTypedFramework
import SSA.Experimental.Bits.Decide

inductive BaseType
  | bitvec : BaseType
  deriving DecidableEq

instance : Inhabited BaseType := ⟨BaseType.bitvec⟩

instance : Goedel BaseType where
toType := fun
  | .bitvec => Term

abbrev UserType := SSA.UserType BaseType

inductive Op : Type
| zero
| negOne
| one
| and
| or
| xor
| not
| ls
| add
| sub
| neg
| incr
| decr

@[simp, reducible]
def argUserType : Op → UserType
| Op.zero  | Op.negOne | Op.one => .unit
| Op.and | Op.or | Op.xor | Op.add | Op.sub => 
  .pair (.base (BaseType.bitvec)) (.base (BaseType.bitvec))
| Op.not | Op.ls | Op.neg | Op.incr | Op.decr => .base (BaseType.bitvec)

@[simp, reducible]
def outUserType : Op → UserType := fun _ => .base BaseType.bitvec

@[simp]
def rgnDom : Op → UserType := fun _ => .unit
@[simp]
def rgnCod : Op → UserType := fun _ => .unit


@[simp]
def eval (o : Op)
  (arg: Goedel.toType (argUserType o))
  (_rgn : (Goedel.toType (rgnDom o) → Goedel.toType (rgnCod o))) :
  Goedel.toType (outUserType o) :=
    match o with
     | Op.zero => Term.zero
     | Op.negOne => Term.negOne
     | Op.one => Term.one
     | Op.and => Term.and arg.1 arg.2
     | Op.or => Term.or arg.1 arg.2
     | Op.xor => Term.xor arg.1 arg.2
     | Op.not => Term.not arg
     | Op.ls => Term.ls arg
     | Op.add => Term.add arg.1 arg.2
     | Op.sub => Term.sub arg.1 arg.2
     | Op.neg => Term.neg arg
     | Op.incr => Term.incr arg
     | Op.decr => Term.decr arg

instance TUS : SSA.TypedUserSemantics Op BaseType where
  argUserType := argUserType
  rgnDom := rgnDom
  rgnCod := rgnCod
  outUserType := outUserType
  eval := eval


open EDSL
syntax "zero" term : dsl_op
syntax "negOne" term : dsl_op
syntax "one" term : dsl_op
syntax "and" term : dsl_op
syntax "or" term : dsl_op
syntax "xor" term : dsl_op
syntax "not" term : dsl_op
syntax "ls" term : dsl_op
syntax "add" term : dsl_op
syntax "sub" term : dsl_op
syntax "neg" term : dsl_op
syntax "incr" term : dsl_op
syntax "decr" term : dsl_op

macro_rules
  | `([dsl_op| add $w ]) => `(Op.add $w)
  | `([dsl_op| and $w ]) => `(Op.and $w)
  | `([dsl_op| decr $w ]) => `(Op.decr $w)
  | `([dsl_op| incr $w ]) => `(Op.incr $w)
  | `([dsl_op| ls $w ]) => `(Op.ls $w)
  | `([dsl_op| neg $w ]) => `(Op.neg $w)
  | `([dsl_op| negOne $w ]) => `(Op.negOne $w)
  | `([dsl_op| not $w ]) => `(Op.not $w)
  | `([dsl_op| one $w ]) => `(Op.one $w)
  | `([dsl_op| or $w ]) => `(Op.or $w)
  | `([dsl_op| sub $w ]) => `(Op.sub $w)
  | `([dsl_op| xor $w ]) => `(Op.xor $w)
  | `([dsl_op| zero $w ]) => `(Op.zero $w)

