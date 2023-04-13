import Mathlib.Data.Fin.Basic
import Mathlib.Init.Data.Int.Bitwise
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
| int : (w : Width) → Int → val
| pair : val → val → val
| triple : val → val → val → val
| error : val

class Pointed (α : Type) where
  point : α

def Pointed.morphism [Pointed α] [Pointed β] (f: α → β) : Prop :=
  f point = point

def val.binaryIntFunction (w : Width) (f : Int → Int → Int)
 (x : val) (y : val) : val :=
  match x with
  | .int w1 v1 =>
     match y with
     | .int w2 v2 =>
         if W1 : w1 = w then
           if W2 : w2 = w then
             .int w <| f v1 v2
           else error
         else error
     | _ => .error
  | _ => .error

@[simp, aesop norm simp]
theorem val.binaryIntFuction_l_w_neq (H : w1 ≠ w) :
  val.binaryIntFunction w f (.int w1 v1) y = .error := by {
    simp[binaryIntFunction, H]; cases y <;> simp;

}

@[simp, aesop norm simp]
theorem val.binaryIntFuction_r_w_neq (H : w2 ≠ w) :
  val.binaryIntFunction w f x (.int w2 v2)  = .error := by {
    simp[binaryIntFunction, H]; cases x <;> simp;
}

@[simp]
theorem val.binaryIntFunction_l_pair :
   val.binaryIntFunction w f (.pair x1 x2) y = .error := by {
  simp[binaryIntFunction];
}

@[simp]
theorem val.binaryIntFunction_l_triple :
   val.binaryIntFunction w f (.triple x1 x2 x3) y = .error := by {
  simp[binaryIntFunction];
}

@[simp]
theorem val.binaryIntFunction_l_error :
   val.binaryIntFunction w f .error y = .error := by {
  simp[binaryIntFunction];
}

@[simp]
theorem val.binaryIntFunction_r_pair :
   val.binaryIntFunction w f x (.pair y1 y2) = .error := by {
  simp[binaryIntFunction];
  cases x <;> simp;
}

@[simp]
theorem val.binaryIntFunction_r_triple :
   val.binaryIntFunction w f x (.triple y1 y2 y3) = .error := by {
  simp[binaryIntFunction];
  cases x <;> simp;
}

@[simp]
theorem val.binaryIntFunction_r_error :
   val.binaryIntFunction w f x .error = .error := by {
  simp[binaryIntFunction]; cases x <;> simp
}


def pow2 : Nat → Nat
| 0 => 1
| n+1 => 2 * pow2 n

@[simp]
def val.add (w : Width) (x y : val) : val :=
  val.binaryIntFunction w (fun x y => (x + y) % pow2 w) x y

@[simp]
def val.and (w : Width) (x y : val) : val :=
  val.binaryIntFunction w (fun x y => (Int.land x y) % pow2 w) x y

def val.negate (w : Width) (x : val) : val :=
  match x with
  | .int _w1 v1 => .int 0 <| (- v1) % w
  | _ => .error

@[simp]
theorem val.negate.pair : val.negate w (.pair x1 x2) = .error := by {
  simp[negate];
}

@[simp]
theorem val.negate.triple : val.negate w (.triple x1 x2 x3) = .error := by {
  simp[negate];
}


@[simp]
theorem val.negate.error : val.negate w (.error) = .error := by {
  simp[negate];
}

@[simp]
def val.or (w : Width) (x y : val) : val :=
  val.binaryIntFunction w (fun x y => (Int.lor x y) % pow2 w) x y


@[simp]
def val.sub (w : Width) (x y : val) : val :=
  val.binaryIntFunction w (fun x y => (x - y) % pow2 w) x y

@[simp]
def val.xor (w : Width) (x y : val) : val :=
  val.binaryIntFunction w (fun x y => (Int.lxor' x y) % pow2 w) x y

@[simp]
def op.eval (o : op) (v : val) (_rgn : val → val) : val :=
 match o with
 | .const w i => val.int w i
 | .add w => match v with | .pair x y => val.add w x y | _ => .error
 | .and w => match v with | .pair x y => val.and w x y | _ => .error
 | .negate w => val.negate w v
 | .or w => match v with | .pair x y => val.or w x y | _ => .error
 | .sub w => match v with | .pair x y => val.sub w x y | _ => .error
 | .xor w => match v with | .pair x y => val.xor w x y | _ => .error

@[simp]
instance S : UserSemantics op val where
  default := .error
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
