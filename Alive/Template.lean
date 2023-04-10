

import SSA.Framework

abbrev Width := Nat -- bit width
abbrev MachineInt := Nat -- machine integers.

inductive op
| add (width : Width)
| and (width : Width)
| negate (width : Width)
| or (width : Width)
| sub (width : Width)
| xor (width : Width)
| const (width : Width) (i : MachineInt)

inductive val
| int : Width → MachineInt → val
| pair : val → val → val
| triple : val → val → val → val
deriving Inhabited

@[simp] def val.add (w : Width) (x y : val) : val := x
@[simp] def val.and (w : Width) (x y : val) : val := x
@[simp] def val.negate (w : Width) (x : val) : val := x
@[simp] def val.or (w : Width) (x y : val) : val := x
@[simp] def val.sub (w : Width) (x y : val) : val := x
@[simp] def val.xor (w : Width) (x y : val) : val := x

@[simp]
def op.eval (o : op) (v : val) (_rgn : val → val) : val :=
 match o with
 | .const w i => val.int w i
 | .add w => match v with | .pair x y => val.add w x y | _ => default
 | .and w => match v with | .pair x y => val.and w x y | _ => default
 | .negate w => val.negate w v
 | .or w => match v with | .pair x y => val.or w x y | _ => default
 | .sub w => match v with | .pair x y => val.sub w x y | _ => default
 | .xor w => match v with | .pair x y => val.xor w x y | _ => default

@[simp]
instance S : UserSemantics op val where
  eval := op.eval
  valPair := val.pair
  valTriple := val.triple


syntax "add(" term ")" : dsl_op
syntax "and(" term ")" : dsl_op
syntax "or(" term ")" : dsl_op
syntax "negate(" term ")" : dsl_op
syntax "sub(" term ")" : dsl_op
syntax "xor(" term ")" : dsl_op
syntax "const(" term "," term ")" : dsl_op

macro_rules
| `([dsl_op| add($w)]) => `(op.add $w)
| `([dsl_op| and($w)]) => `(op.and $w)
| `([dsl_op| negate($w)]) => `(op.negate $w)
| `([dsl_op| or($w)]) => `(op.or $w)
| `([dsl_op| sub($w)]) => `(op.sub $w)
| `([dsl_op| xor($w)]) => `(op.xor $w)
| `([dsl_op| const($w, $i)]) => `(op.const $w $i)


namespace Example
-- Name: AddSub:1043
-- Pre: None
/-
%Y = and %Z, C1
%X = xor %Y, C1
%LHS = add %X, 1
%r = add %LHS, %RHS
  =>
%or = or %Z, ~C1
%r = sub %RHS, %or
-/
def thm1  :
  SSA.eval (Op := op) (Val := val) e re [dsl_bb|
    %v3 := op:const(w,C1) %v42;
    %v4 := pair:%v1 %v3; -- (%Z, C1)
    %v5 := op:and(w) %v4; -- %Y = and %z, C1
    %v6 := pair: %v5 %v3 -- %X = xor %Y, C1
    dsl_ret %v6
  ] = SSA.eval (Op := op) (Val := val) e re [dsl_bb|
    dsl_ret %v6
  ] := by {
    simp[SSA.eval]
    sorry
  }


-- Name: AddSub:1152
-- Pre : None
-- Name: AddSub:1152
-- %r = add i1 %x, %y
--   =>
-- %r = xor %x, %y
--  def thm2 (w : Width) :
--   SSA.eval (Op := op) (Val := val) e re [dsl_bb|
--     %v1 = op:add
--   ]
end Example
