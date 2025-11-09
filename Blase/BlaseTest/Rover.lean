/- We take all the rewrites from ROVER and add them into blase.

### Actionable Insights
- Problems in ROVER than depend on constants have a fixed bitwidth followed
- by a zero-extension, which could benifit from case splitting.
- Abstraction of multiplication could benifit from normalization
  of ac_nf for e.g. `Nat.max` to allow unification.
-/
import Blase
namespace Test
namespace Rover

set_option warn.sorry false

/-
  {
    "name": "add_assoc_1",
    "preconditions": ["(>= q t)", "(>= u t)"],
    "lhs": "(bw t ( + (bw u (+ (bw p a) (bw r b))) (bw s c)))",
    "rhs": "(bw t ( + (bw p a) (bw q (+ (bw r b) (bw s c)))))"
  },
-/
def bw (w : Nat) (x : BitVec v) : BitVec w := x.zeroExtend w

def addMax (a : BitVec v) (b : BitVec w) : BitVec (max v w) :=
   a.zeroExtend _ + b.zeroExtend _

def mulMax (a : BitVec v) (b : BitVec w) : BitVec (max v w) :=
   a.zeroExtend _ * b.zeroExtend _

def subMax (a : BitVec v) (b : BitVec w) : BitVec (max v w) :=
   a.zeroExtend _ - b.zeroExtend _

def shlMax (a : BitVec v) (b : BitVec w) : BitVec (max v w) :=
   a.zeroExtend (max v w) <<< b.zeroExtend (max v w)

def shrMax (a : BitVec v) (b : BitVec w) : BitVec (max v w) :=
    a.zeroExtend (max v w) >>> b.zeroExtend (max v w)

variable (w p q r s t : Nat)
variable (a b c : BitVec w)




variable (w p q r s t : Nat)
variable (a b : BitVec w)
-- end preamble

/--
error: unsolved goals
w✝ : ℕ
c : BitVec w✝
w p q r s t : ℕ
a b : BitVec w
u : ℕ
hq : q ≥ t
hu : u ≥ t
⊢ BitVec.zeroExtend t
      (BitVec.zeroExtend (max u s)
          (BitVec.zeroExtend u
            (BitVec.zeroExtend (max p r) (BitVec.zeroExtend p a) +
              BitVec.zeroExtend (max p r) (BitVec.zeroExtend r b))) +
        BitVec.zeroExtend (max u s) (BitVec.zeroExtend s c)) =
    BitVec.zeroExtend t
      (BitVec.zeroExtend (max p q) (BitVec.zeroExtend p a) +
        BitVec.zeroExtend (max p q)
          (BitVec.zeroExtend q
            (BitVec.zeroExtend (max r s) (BitVec.zeroExtend r b) +
              BitVec.zeroExtend (max r s) (BitVec.zeroExtend s c))))
-/
#guard_msgs in 
theorem add_assoc_1 (hq : q >= t) (hu : u >= t) :
  (bw t (addMax (bw u (addMax (bw p a) (bw r b))) (bw s c)))  =
  (bw t (addMax (bw p a) (bw q (addMax (bw r b) (bw s c))))) := by
  simp only [bw, addMax]
  fail_if_success bv_multi_width
/-
{
  "name": "add_assoc_2",
  "preconditions": ["(< r q)", "(< s q)", "(>= u t)"],
  "lhs": "(bw t ( + (bw u (+ (bw p a) (bw r b))) (bw s c)))",
  "rhs": "(bw t ( + (bw p a) (bw q (+ (bw r b) (bw s c)))))"
},
-/

-- end preamble

/--
error: unsolved goals
w✝ : ℕ
c : BitVec w✝
w p q r s t : ℕ
a b : BitVec w
u : ℕ
hr : r < q
hs : s < q
hu : u ≥ t
⊢ BitVec.zeroExtend t
      (BitVec.zeroExtend (max u s)
          (BitVec.zeroExtend u
            (BitVec.zeroExtend (max p r) (BitVec.zeroExtend p a) +
              BitVec.zeroExtend (max p r) (BitVec.zeroExtend r b))) +
        BitVec.zeroExtend (max u s) (BitVec.zeroExtend s c)) =
    BitVec.zeroExtend t
      (BitVec.zeroExtend (max p q) (BitVec.zeroExtend p a) +
        BitVec.zeroExtend (max p q)
          (BitVec.zeroExtend q
            (BitVec.zeroExtend (max r s) (BitVec.zeroExtend r b) +
              BitVec.zeroExtend (max r s) (BitVec.zeroExtend s c))))
-/
#guard_msgs in
theorem add_assoc_2 (hr : r < q) (hs : s < q) (hu : u >= t) :
  (bw t (addMax (bw u (addMax (bw p a) (bw r b))) (bw s c)))  =
  (bw t (addMax (bw p a) (bw q (addMax (bw r b) (bw s c))))) := by
  simp only [bw, addMax]
  fail_if_success bv_multi_width
/-
  {
    "name": "add_assoc_3",
    "preconditions": ["(>= q t)", "(< p u)", "(< r u)"],
    "lhs": "(bw t ( + (bw u (+ (bw p a) (bw r b))) (bw s c)))",
    "rhs": "(bw t ( + (bw p a) (bw q (+ (bw r b) (bw s c)))))"
  },
-/

-- end preamble

/--
error: unsolved goals
w✝ : ℕ
c : BitVec w✝
w p q r s t : ℕ
a b : BitVec w
u : ℕ
hq : q ≥ t
hp : p < u
hr : r < u
⊢ BitVec.zeroExtend t
      (BitVec.zeroExtend (max u s)
          (BitVec.zeroExtend u
            (BitVec.zeroExtend (max p r) (BitVec.zeroExtend p a) +
              BitVec.zeroExtend (max p r) (BitVec.zeroExtend r b))) +
        BitVec.zeroExtend (max u s) (BitVec.zeroExtend s c)) =
    BitVec.zeroExtend t
      (BitVec.zeroExtend (max p q) (BitVec.zeroExtend p a) +
        BitVec.zeroExtend (max p q)
          (BitVec.zeroExtend q
            (BitVec.zeroExtend (max r s) (BitVec.zeroExtend r b) +
              BitVec.zeroExtend (max r s) (BitVec.zeroExtend s c))))
-/
#guard_msgs in
theorem add_assoc_3 (hq : q >= t) (hp : p < u) (hr : r < u) :
  (bw t (addMax (bw u (addMax (bw p a) (bw r b))) (bw s c)))  =
  (bw t (addMax (bw p a) (bw q (addMax (bw r b) (bw s c))))) := by
  simp only [bw, addMax]
  fail_if_success bv_multi_width
/-
  {
    "name": "add_assoc_4",
    "preconditions": ["(< r q)", "(< s q)", "(< p u)", "(< r u)"],
    "lhs": "(bw t ( + (bw u (+ (bw p a) (bw r b))) (bw s c)))",
    "rhs": "(bw t ( + (bw p a) (bw q (+ (bw r b) (bw s c)))))"
  },
-/

-- end preamble

/--
error: unsolved goals
w✝ : ℕ
c : BitVec w✝
w p q r s t : ℕ
a b : BitVec w
u : ℕ
hr : r < q
hs : s < q
hp : p < u
hu : r < u
⊢ BitVec.zeroExtend t
      (BitVec.zeroExtend (max u s)
          (BitVec.zeroExtend u
            (BitVec.zeroExtend (max p r) (BitVec.zeroExtend p a) +
              BitVec.zeroExtend (max p r) (BitVec.zeroExtend r b))) +
        BitVec.zeroExtend (max u s) (BitVec.zeroExtend s c)) =
    BitVec.zeroExtend t
      (BitVec.zeroExtend (max p q) (BitVec.zeroExtend p a) +
        BitVec.zeroExtend (max p q)
          (BitVec.zeroExtend q
            (BitVec.zeroExtend (max r s) (BitVec.zeroExtend r b) +
              BitVec.zeroExtend (max r s) (BitVec.zeroExtend s c))))
-/
#guard_msgs in 
theorem add_assoc_4 (hr : r < q) (hs : s < q) (hp : p < u) (hu : r < u) :
    (bw t (addMax (bw u (addMax (bw p a) (bw r b))) (bw s c)))  =
    (bw t (addMax (bw p a) (bw q (addMax (bw r b) (bw s c))))) := by
  simp only [bw, addMax]
  fail_if_success bv_multi_width
/-
  {
    "name": "add_right_shift",
    "preconditions": [
      "(>= q t)",
      "(>= s (+ p (- (^ 2 u) 1)))",
      "(> v s)",
      "(> v t)"
    ],
    "lhs": "(bw r (+ (bw p a) (bw q (>> (bw t b) (bw u c)))))",
    "rhs": "(bw r (>> (bw v (+ (bw s (<< (bw p a) (bw u c))) (bw t b))) (bw u c)))"
  },
-/

-- end preamble

/--
error: unsolved goals
w✝ : ℕ
c : BitVec w✝
w p q r s t : ℕ
a b : BitVec w
u v : ℕ
hq : q ≥ t
hs : s ≥ p + (2 ^ u - 1)
hv_s : v > s
hv_t : v > t
⊢ BitVec.zeroExtend r
      (BitVec.zeroExtend (max p q) (BitVec.zeroExtend p a) +
        BitVec.zeroExtend (max p q)
          (BitVec.zeroExtend q
            (BitVec.zeroExtend (max t u) (BitVec.zeroExtend t b) >>>
              BitVec.zeroExtend (max t u) (BitVec.zeroExtend u c)))) =
    BitVec.zeroExtend r
      (BitVec.zeroExtend (max v u)
          (BitVec.zeroExtend v
            (BitVec.zeroExtend (max s t)
                (BitVec.zeroExtend s
                  (BitVec.zeroExtend (max p u) (BitVec.zeroExtend p a) <<<
                    BitVec.zeroExtend (max p u) (BitVec.zeroExtend u c))) +
              BitVec.zeroExtend (max s t) (BitVec.zeroExtend t b))) >>>
        BitVec.zeroExtend (max v u) (BitVec.zeroExtend u c))
-/
#guard_msgs in 
theorem add_right_shift (hq : q >= t) (hs : s >= p + (2 ^ u - 1)) (hv_s : v > s) (hv_t : v > t) :
  (bw r (addMax (bw p a) (bw q (shrMax (bw t b) (bw u c)))))  =
  (bw r (shrMax (bw v (addMax (bw s (shlMax (bw p a) (bw u c))) (bw t b))) (bw u c))) := by
   simp only [bw, addMax, shrMax, shlMax]
   fail_if_success bv_multi_width
/-
  {
    "name": "add_zero",
    "preconditions": [],
    "lhs": "(bw p (+ (bw p a) (bw q 0)))",
    "rhs": "(bw p a)"
  },
-/

-- end preamble

/--
warning: abstracted non-variable bitvector: ⏎
  → 'BitVec.ofBool false'
---
error: MAYCEX: Found possible counter-example at iteration 0 for predicate MultiWidth.Nondep.Predicate.binRel
  (MultiWidth.BinaryRelationKind.eq)
  (MultiWidth.Nondep.WidthExpr.var 0)
  (MultiWidth.Nondep.Term.zext
    (MultiWidth.Nondep.Term.add
      (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.var 0) (MultiWidth.Nondep.WidthExpr.var 1))
      (MultiWidth.Nondep.Term.zext
        (MultiWidth.Nondep.Term.zext
          (MultiWidth.Nondep.Term.var 0 (MultiWidth.Nondep.WidthExpr.var 2))
          (MultiWidth.Nondep.WidthExpr.var 0))
        (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.var 0) (MultiWidth.Nondep.WidthExpr.var 1)))
      (MultiWidth.Nondep.Term.zext
        (MultiWidth.Nondep.Term.zext
          (MultiWidth.Nondep.Term.var 1 (MultiWidth.Nondep.WidthExpr.const 1))
          (MultiWidth.Nondep.WidthExpr.var 1))
        (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.var 0) (MultiWidth.Nondep.WidthExpr.var 1))))
    (MultiWidth.Nondep.WidthExpr.var 0))
  (MultiWidth.Nondep.Term.zext
    (MultiWidth.Nondep.Term.var 0 (MultiWidth.Nondep.WidthExpr.var 2))
    (MultiWidth.Nondep.WidthExpr.var 0))
-/
#guard_msgs in theorem add_zero :
    (bw p (addMax (bw p a) (bw q (0#1))))  =
    (bw p a) := by
  simp only [bw, addMax]
  bv_multi_width

/-
{
  "name": "commutativity_add",
  "preconditions": [],
  "lhs": "(bw r ( + (bw p a) (bw q b)))",
  "rhs": "(bw r ( + (bw q b) (bw p a)))"
},
-/

-- end preamble

#guard_msgs in
theorem commutativity_add :
      bw r (addMax (bw p a) (bw q b))  = bw r (addMax (bw q b) (bw p a)) := by
  simp only [bw, addMax]
  bv_multi_width
/-
  {
    "name": "commutativity_mult",
    "preconditions": [],
    "lhs": "(bw r ( * (bw p a) (bw q b)))",
    "rhs": "(bw r ( * (bw q b) (bw p a)))"
  },
-/

-- end preamble

/--
warning: abstracted non-variable bitvector: ⏎
  → 'BitVec.zeroExtend (max p q) (BitVec.zeroExtend p a) * BitVec.zeroExtend (max p q) (BitVec.zeroExtend q b)'
---
warning: abstracted non-variable bitvector: ⏎
  → 'BitVec.zeroExtend (max q p) (BitVec.zeroExtend q b) * BitVec.zeroExtend (max q p) (BitVec.zeroExtend p a)'
---
error: MAYCEX: Found possible counter-example at iteration 0 for predicate MultiWidth.Nondep.Predicate.binRel
  (MultiWidth.BinaryRelationKind.eq)
  (MultiWidth.Nondep.WidthExpr.var 0)
  (MultiWidth.Nondep.Term.zext
    (MultiWidth.Nondep.Term.var
      0
      (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.var 1) (MultiWidth.Nondep.WidthExpr.var 2)))
    (MultiWidth.Nondep.WidthExpr.var 0))
  (MultiWidth.Nondep.Term.zext
    (MultiWidth.Nondep.Term.var
      1
      (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.var 2) (MultiWidth.Nondep.WidthExpr.var 1)))
    (MultiWidth.Nondep.WidthExpr.var 0))
-/
#guard_msgs in theorem commutativity_mult :
      bw r (mulMax (bw p a) (bw q b))  = bw r (mulMax (bw q b) (bw p a)) := by
  simp only [bw, mulMax]
  -- TODO: normalize 'max' by ac_nf.
  bv_multi_width
/-
  {
    "name": "dist_over_add",
    "preconditions": ["(>= q r)", "(>= u r)", "(>= v r)"],
    "lhs": "(bw r (* (bw p a) (+ (bw s b) (bw t c))))",
    "rhs": "(bw r (+ (bw u (* (bw p a) (bw s b))) (bw v (* (bw p a) (bw t c)) ) ))"
  },
-/

-- end preamble

/--
warning: abstracted non-variable bitvector: ⏎
  → 'BitVec.zeroExtend (max p (max s t)) (BitVec.zeroExtend p a) *
    BitVec.zeroExtend (max p (max s t))
      (BitVec.zeroExtend (max s t) (BitVec.zeroExtend s b) + BitVec.zeroExtend (max s t) (BitVec.zeroExtend t c))'
---
warning: abstracted non-variable bitvector: ⏎
  → 'BitVec.zeroExtend (max p s) (BitVec.zeroExtend p a) * BitVec.zeroExtend (max p s) (BitVec.zeroExtend s b)'
---
warning: abstracted non-variable bitvector: ⏎
  → 'BitVec.zeroExtend (max p t) (BitVec.zeroExtend p a) * BitVec.zeroExtend (max p t) (BitVec.zeroExtend t c)'
---
error: MAYCEX: Found possible counter-example at iteration 1 for predicate MultiWidth.Nondep.Predicate.or
  (MultiWidth.Nondep.Predicate.binWidthRel
    (MultiWidth.WidthBinaryRelationKind.le)
    (MultiWidth.Nondep.WidthExpr.addK (MultiWidth.Nondep.WidthExpr.var 0) 1)
    (MultiWidth.Nondep.WidthExpr.var 1))
  (MultiWidth.Nondep.Predicate.or
    (MultiWidth.Nondep.Predicate.binWidthRel
      (MultiWidth.WidthBinaryRelationKind.le)
      (MultiWidth.Nondep.WidthExpr.addK (MultiWidth.Nondep.WidthExpr.var 2) 1)
      (MultiWidth.Nondep.WidthExpr.var 1))
    (MultiWidth.Nondep.Predicate.or
      (MultiWidth.Nondep.Predicate.binWidthRel
        (MultiWidth.WidthBinaryRelationKind.le)
        (MultiWidth.Nondep.WidthExpr.addK (MultiWidth.Nondep.WidthExpr.var 3) 1)
        (MultiWidth.Nondep.WidthExpr.var 1))
      (MultiWidth.Nondep.Predicate.binRel
        (MultiWidth.BinaryRelationKind.eq)
        (MultiWidth.Nondep.WidthExpr.var 1)
        (MultiWidth.Nondep.Term.zext
          (MultiWidth.Nondep.Term.var
            0
            (MultiWidth.Nondep.WidthExpr.max
              (MultiWidth.Nondep.WidthExpr.var 4)
              (MultiWidth.Nondep.WidthExpr.max
                (MultiWidth.Nondep.WidthExpr.var 5)
                (MultiWidth.Nondep.WidthExpr.var 6))))
          (MultiWidth.Nondep.WidthExpr.var 1))
        (MultiWidth.Nondep.Term.zext
          (MultiWidth.Nondep.Term.add
            (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.var 2) (MultiWidth.Nondep.WidthExpr.var 3))
            (MultiWidth.Nondep.Term.zext
              (MultiWidth.Nondep.Term.zext
                (MultiWidth.Nondep.Term.var
                  1
                  (MultiWidth.Nondep.WidthExpr.max
                    (MultiWidth.Nondep.WidthExpr.var 4)
                    (MultiWidth.Nondep.WidthExpr.var 5)))
                (MultiWidth.Nondep.WidthExpr.var 2))
              (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.var 2) (MultiWidth.Nondep.WidthExpr.var 3)))
            (MultiWidth.Nondep.Term.zext
              (MultiWidth.Nondep.Term.zext
                (MultiWidth.Nondep.Term.var
                  2
                  (MultiWidth.Nondep.WidthExpr.max
                    (MultiWidth.Nondep.WidthExpr.var 4)
                    (MultiWidth.Nondep.WidthExpr.var 6)))
                (MultiWidth.Nondep.WidthExpr.var 3))
              (MultiWidth.Nondep.WidthExpr.max
                (MultiWidth.Nondep.WidthExpr.var 2)
                (MultiWidth.Nondep.WidthExpr.var 3))))
          (MultiWidth.Nondep.WidthExpr.var 1)))))
-/
#guard_msgs in theorem dist_over_add (hq : q >= r) (hu : u >= r) (hv : v >= r) :
  (bw r (mulMax (bw p a) (addMax (bw s b) (bw t c))))  =
  (bw r (addMax (bw u (mulMax (bw p a) (bw s b))) (bw v (mulMax (bw p a) (bw t c))))) := by
    simp only [bw, addMax, mulMax]
    -- TODO: push zext into add, distribute mul.
    bv_multi_width
/-
  {
    "name": "left_shift_add_1",
    "preconditions": ["(>= u r)", "(>= s r)"],
    "lhs": "(bw r (<< (bw s (+ (bw p a) (bw q b))) (bw t c)))",
    "rhs": "(bw r (+ (bw u (<< (bw p a) (bw t c))) (bw u (<< (bw q b) (bw t c)))))"
  },
-/

-- end preamble

theorem left_shift_add_1 (hu : u >= r) (hs : s >= r) :
  (bw r (shlMax (bw s (addMax (bw p a) (bw q b))) (bw t c)))  =
  (bw r (addMax (bw u (shlMax (bw p a) (bw t c))) (bw u (shlMax (bw q b) (bw t c))))) := by
   simp only [bw, addMax, shlMax]
   fail_if_success bv_multi_width
   sorry
/-
  {
    "name": "left_shift_add_2",
    "preconditions": ["(>= u r)", "(> s p)", "(> s q)"],
    "lhs": "(bw r (<< (bw s (+ (bw p a) (bw q b))) (bw t c)))",
    "rhs": "(bw r (+ (bw u (<< (bw p a) (bw t c))) (bw u (<< (bw q b) (bw t c)))))"
  },
-/
-- end preamble

theorem left_shift_add_2 (hu : u >= r) (hs : s > p) (hsq : s > q) :
  (bw r (shlMax (bw s (addMax (bw p a) (bw q b))) (bw t c)))  =
  (bw r (addMax (bw u (shlMax (bw p a) (bw t c))) (bw u (shlMax (bw q b) (bw t c))))) := by
   simp only [bw, addMax, shlMax]
   fail_if_success bv_multi_width
   sorry
/-
  {
    "name": "left_shift_mult",
    "preconditions": ["(>= t r)", "(>= v r)"],
    "lhs": "(bw r (<< (bw t (* (bw p a) (bw q b))) (bw u c)))",
    "rhs": "(bw r (* (bw v (<< (bw p a) (bw u c))) (bw q b)))"
  },
-/

-- end preamble

theorem left_shift_mult (ht : t >= r) (hv : v >= r) :
  (bw r (shlMax (bw t (mulMax (bw p a) (bw q b))) (bw u c)))  =
  (bw r (mulMax (bw v (shlMax (bw p a) (bw u c))) (bw q b))) := by
   simp only [bw, mulMax, shlMax]
   fail_if_success bv_multi_width
   sorry
/-
  {
    "name": "merge_left_shift",
    "preconditions": ["(>= u r)", "(> t s)", "(> t q)"],
    "lhs": "(bw r (<< (bw u (<< (bw p a) (bw q b))) (bw s c)))",
    "rhs": "(bw r (<< (bw p a) (bw t (+ (bw q b) (bw s c)))))"
  },
-/


-- end preamble

theorem merge_left_shift (hu : u >= r) (hts : t > s) (htq : t > q) :
  (bw r (shlMax (bw u (shlMax (bw p a) (bw q b))) (bw s c)))  =
  (bw r (shlMax (bw p a) (bw t (addMax (bw q b) (bw s c))))) := by
   simp only [bw, addMax, shlMax]
   fail_if_success bv_multi_width
   sorry
/-
  {
    "name": "merge_right_shift",
    "preconditions": ["(>= u p)", "(> t s)", "(> t q)"],
    "lhs": "(bw r (>> (bw u (>> (bw p a) (bw q b))) (bw s c)))",
    "rhs": "(bw r (>> (bw p a) (bw t (+ (bw q b) (bw s c)))))"
  },
-/

-- end preamble

theorem merge_right_shift (hu : u >= p) (hts : t > s) (htq : t > q) :
  (bw r (shrMax (bw u (shrMax (bw p a) (bw q b))) (bw s c)))  =
  (bw r (shrMax (bw p a) (bw t (addMax (bw q b) (bw s c))))) := by
   simp only [bw, addMax, shrMax]
   fail_if_success bv_multi_width
   sorry
/-
  {
    "name": "mul_one",
    "preconditions": [],
    "lhs": "(bw p (* (bw p a) (bw q 1)))",
    "rhs": "(bw p a)"
  },
-/

-- end preamble

theorem mul_one :
  (bw p (mulMax (bw p a) (bw q (1#1))))  =
  (bw p a) := by
   simp only [bw, mulMax]
   exact sorry
/-
  {
    "name": "mul_two",
    "preconditions": [],
    "lhs": "(bw r (* (bw p a) 2))",
    "rhs": "(bw r (<< (bw p a) 1))"
  },
-/

-- end preamble

/--
warning: abstracted non-variable bitvector: ⏎
  → 'BitVec.zeroExtend (max p 2) (BitVec.zeroExtend p a) * BitVec.zeroExtend (max p 2) 2#2'
---
error: MAYCEX: Found possible counter-example at iteration 0 for predicate MultiWidth.Nondep.Predicate.binRel
  (MultiWidth.BinaryRelationKind.eq)
  (MultiWidth.Nondep.WidthExpr.var 0)
  (MultiWidth.Nondep.Term.zext
    (MultiWidth.Nondep.Term.var
      0
      (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.var 1) (MultiWidth.Nondep.WidthExpr.const 2)))
    (MultiWidth.Nondep.WidthExpr.var 0))
  (MultiWidth.Nondep.Term.zext
    (MultiWidth.Nondep.Term.shiftl
      (MultiWidth.Nondep.WidthExpr.var 1)
      (MultiWidth.Nondep.Term.zext
        (MultiWidth.Nondep.Term.var 1 (MultiWidth.Nondep.WidthExpr.var 2))
        (MultiWidth.Nondep.WidthExpr.var 1))
      1)
    (MultiWidth.Nondep.WidthExpr.var 0))
-/
#guard_msgs in
theorem mul_two :
  (bw r (mulMax (bw p a) (bw 2 (2#2))))  =
  (bw r ((bw p a) <<< 1)) := by
   simp only [bw, mulMax]
   -- | TODO: can be solved by further preprocessing: we have (max p 2), so we
   -- can case split until we remove the '2'.
   bv_multi_width
/-
{
  "name": "mult_assoc_1",
  "preconditions": ["(>= q t)", "(>= u t)"],
  "lhs": "(bw t ( * (bw u (* (bw p a) (bw r b))) (bw s c)))",
  "rhs": "(bw t ( * (bw p a) (bw q (* (bw r b) (bw s c)))))"
},
-/



-- end preamble

/--
warning: abstracted non-variable bitvector: ⏎
  → 'BitVec.zeroExtend (max u s)
      (BitVec.zeroExtend u
        (BitVec.zeroExtend (max p r) (BitVec.zeroExtend p a) * BitVec.zeroExtend (max p r) (BitVec.zeroExtend r b))) *
    BitVec.zeroExtend (max u s) (BitVec.zeroExtend s c)'
---
warning: abstracted non-variable bitvector: ⏎
  → 'BitVec.zeroExtend (max p q) (BitVec.zeroExtend p a) *
    BitVec.zeroExtend (max p q)
      (BitVec.zeroExtend q
        (BitVec.zeroExtend (max r s) (BitVec.zeroExtend r b) * BitVec.zeroExtend (max r s) (BitVec.zeroExtend s c)))'
---
error: MAYCEX: Found possible counter-example at iteration 1 for predicate MultiWidth.Nondep.Predicate.or
  (MultiWidth.Nondep.Predicate.binWidthRel
    (MultiWidth.WidthBinaryRelationKind.le)
    (MultiWidth.Nondep.WidthExpr.addK (MultiWidth.Nondep.WidthExpr.var 0) 1)
    (MultiWidth.Nondep.WidthExpr.var 1))
  (MultiWidth.Nondep.Predicate.or
    (MultiWidth.Nondep.Predicate.binWidthRel
      (MultiWidth.WidthBinaryRelationKind.le)
      (MultiWidth.Nondep.WidthExpr.addK (MultiWidth.Nondep.WidthExpr.var 2) 1)
      (MultiWidth.Nondep.WidthExpr.var 1))
    (MultiWidth.Nondep.Predicate.binRel
      (MultiWidth.BinaryRelationKind.eq)
      (MultiWidth.Nondep.WidthExpr.var 1)
      (MultiWidth.Nondep.Term.zext
        (MultiWidth.Nondep.Term.var
          0
          (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.var 2) (MultiWidth.Nondep.WidthExpr.var 3)))
        (MultiWidth.Nondep.WidthExpr.var 1))
      (MultiWidth.Nondep.Term.zext
        (MultiWidth.Nondep.Term.var
          1
          (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.var 4) (MultiWidth.Nondep.WidthExpr.var 0)))
        (MultiWidth.Nondep.WidthExpr.var 1))))
-/
#guard_msgs in 
theorem mult_assoc_1 (hq : q >= t) (hu : u >= t) :
  (bw t (mulMax (bw u (mulMax (bw p a) (bw r b))) (bw s c))) =
  (bw t (mulMax (bw p a) (bw q (mulMax (bw r b) (bw s c))))) := by
   simp only [bw, mulMax]
   bv_multi_width
/-
  {
    "name": "mult_assoc_2",
    "preconditions": ["(>= q t)", "(<= (+ p r) u)"],
    "lhs": "(bw t ( * (bw u (* (bw p a) (bw r b))) (bw s c)))",
    "rhs": "(bw t ( * (bw p a) (bw q (* (bw r b) (bw s c)))))"
  },
-/

-- end preamble

/--
warning: abstracted non-variable bitvector: ⏎
  → 'BitVec.zeroExtend (max u s)
      (BitVec.zeroExtend u
        (BitVec.zeroExtend (max p r) (BitVec.zeroExtend p a) * BitVec.zeroExtend (max p r) (BitVec.zeroExtend r b))) *
    BitVec.zeroExtend (max u s) (BitVec.zeroExtend s c)'
---
warning: abstracted non-variable bitvector: ⏎
  → 'BitVec.zeroExtend (max p q) (BitVec.zeroExtend p a) *
    BitVec.zeroExtend (max p q)
      (BitVec.zeroExtend q
        (BitVec.zeroExtend (max r s) (BitVec.zeroExtend r b) * BitVec.zeroExtend (max r s) (BitVec.zeroExtend s c)))'
---
warning: abstracted non-variable width: ⏎
  → 'p + r'
---
error: MAYCEX: Found possible counter-example at iteration 1 for predicate MultiWidth.Nondep.Predicate.or
  (MultiWidth.Nondep.Predicate.binWidthRel
    (MultiWidth.WidthBinaryRelationKind.le)
    (MultiWidth.Nondep.WidthExpr.addK (MultiWidth.Nondep.WidthExpr.var 0) 1)
    (MultiWidth.Nondep.WidthExpr.var 1))
  (MultiWidth.Nondep.Predicate.or
    (MultiWidth.Nondep.Predicate.binWidthRel
      (MultiWidth.WidthBinaryRelationKind.le)
      (MultiWidth.Nondep.WidthExpr.addK (MultiWidth.Nondep.WidthExpr.var 2) 1)
      (MultiWidth.Nondep.WidthExpr.var 3))
    (MultiWidth.Nondep.Predicate.binRel
      (MultiWidth.BinaryRelationKind.eq)
      (MultiWidth.Nondep.WidthExpr.var 1)
      (MultiWidth.Nondep.Term.zext
        (MultiWidth.Nondep.Term.var
          0
          (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.var 2) (MultiWidth.Nondep.WidthExpr.var 4)))
        (MultiWidth.Nondep.WidthExpr.var 1))
      (MultiWidth.Nondep.Term.zext
        (MultiWidth.Nondep.Term.var
          1
          (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.var 5) (MultiWidth.Nondep.WidthExpr.var 0)))
        (MultiWidth.Nondep.WidthExpr.var 1))))
-/
#guard_msgs in 
theorem mult_assoc_2 (hq : q >= t) (hu : (p + r) <= u) :
  (bw t (mulMax (bw u (mulMax (bw p a) (bw r b))) (bw s c)))  =
  (bw t (mulMax (bw p a) (bw q (mulMax (bw r b) (bw s c))))) := by
  simp only [bw, mulMax]
  bv_multi_width

/-
  {
    "name": "mult_assoc_3",
    "preconditions": ["(<= (+ r s) q)", "(>= u t)"],
    "lhs": "(bw t ( * (bw u (* (bw p a) (bw r b))) (bw s c)))",
    "rhs": "(bw t ( * (bw p a) (bw q (* (bw r b) (bw s c)))))"
  },
-/

-- end preamble

/--
warning: abstracted non-variable bitvector: ⏎
  → 'BitVec.zeroExtend (max u s)
      (BitVec.zeroExtend u
        (BitVec.zeroExtend (max p r) (BitVec.zeroExtend p a) * BitVec.zeroExtend (max p r) (BitVec.zeroExtend r b))) *
    BitVec.zeroExtend (max u s) (BitVec.zeroExtend s c)'
---
warning: abstracted non-variable bitvector: ⏎
  → 'BitVec.zeroExtend (max p q) (BitVec.zeroExtend p a) *
    BitVec.zeroExtend (max p q)
      (BitVec.zeroExtend q
        (BitVec.zeroExtend (max r s) (BitVec.zeroExtend r b) * BitVec.zeroExtend (max r s) (BitVec.zeroExtend s c)))'
---
warning: abstracted non-variable width: ⏎
  → 'r + s'
---
error: MAYCEX: Found possible counter-example at iteration 1 for predicate MultiWidth.Nondep.Predicate.or
  (MultiWidth.Nondep.Predicate.binWidthRel
    (MultiWidth.WidthBinaryRelationKind.le)
    (MultiWidth.Nondep.WidthExpr.addK (MultiWidth.Nondep.WidthExpr.var 0) 1)
    (MultiWidth.Nondep.WidthExpr.var 1))
  (MultiWidth.Nondep.Predicate.or
    (MultiWidth.Nondep.Predicate.binWidthRel
      (MultiWidth.WidthBinaryRelationKind.le)
      (MultiWidth.Nondep.WidthExpr.addK (MultiWidth.Nondep.WidthExpr.var 2) 1)
      (MultiWidth.Nondep.WidthExpr.var 3))
    (MultiWidth.Nondep.Predicate.binRel
      (MultiWidth.BinaryRelationKind.eq)
      (MultiWidth.Nondep.WidthExpr.var 3)
      (MultiWidth.Nondep.Term.zext
        (MultiWidth.Nondep.Term.var
          0
          (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.var 2) (MultiWidth.Nondep.WidthExpr.var 4)))
        (MultiWidth.Nondep.WidthExpr.var 3))
      (MultiWidth.Nondep.Term.zext
        (MultiWidth.Nondep.Term.var
          1
          (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.var 5) (MultiWidth.Nondep.WidthExpr.var 0)))
        (MultiWidth.Nondep.WidthExpr.var 3))))
-/
#guard_msgs in 
theorem mult_assoc_3 (hq : (r + s) <= q) (hu : u >= t) :
  (bw t (mulMax (bw u (mulMax (bw p a) (bw r b))) (bw s c)))  =
  (bw t (mulMax (bw p a) (bw q (mulMax (bw r b) (bw s c))))) := by
  simp only [bw, mulMax]
  bv_multi_width
/-
  {
    "name": "mult_assoc_4",
    "preconditions": ["(<= (+ r s) q)", "(<= (+ p r) u)"],
    "lhs": "(bw t ( * (bw u (* (bw p a) (bw r b))) (bw s c)))",
    "rhs": "(bw t ( * (bw p a) (bw q (* (bw r b) (bw s c)))))"
  },
-/


-- end preamble

/--
warning: abstracted non-variable bitvector: ⏎
  → 'BitVec.zeroExtend (max u s)
      (BitVec.zeroExtend u
        (BitVec.zeroExtend (max p r) (BitVec.zeroExtend p a) * BitVec.zeroExtend (max p r) (BitVec.zeroExtend r b))) *
    BitVec.zeroExtend (max u s) (BitVec.zeroExtend s c)'
---
warning: abstracted non-variable bitvector: ⏎
  → 'BitVec.zeroExtend (max p q) (BitVec.zeroExtend p a) *
    BitVec.zeroExtend (max p q)
      (BitVec.zeroExtend q
        (BitVec.zeroExtend (max r s) (BitVec.zeroExtend r b) * BitVec.zeroExtend (max r s) (BitVec.zeroExtend s c)))'
---
warning: abstracted non-variable width: ⏎
  → 'r + s'
---
warning: abstracted non-variable width: ⏎
  → 'p + r'
---
error: MAYCEX: Found possible counter-example at iteration 0 for predicate MultiWidth.Nondep.Predicate.or
  (MultiWidth.Nondep.Predicate.binWidthRel
    (MultiWidth.WidthBinaryRelationKind.le)
    (MultiWidth.Nondep.WidthExpr.addK (MultiWidth.Nondep.WidthExpr.var 0) 1)
    (MultiWidth.Nondep.WidthExpr.var 1))
  (MultiWidth.Nondep.Predicate.or
    (MultiWidth.Nondep.Predicate.binWidthRel
      (MultiWidth.WidthBinaryRelationKind.le)
      (MultiWidth.Nondep.WidthExpr.addK (MultiWidth.Nondep.WidthExpr.var 2) 1)
      (MultiWidth.Nondep.WidthExpr.var 3))
    (MultiWidth.Nondep.Predicate.binRel
      (MultiWidth.BinaryRelationKind.eq)
      (MultiWidth.Nondep.WidthExpr.var 4)
      (MultiWidth.Nondep.Term.zext
        (MultiWidth.Nondep.Term.var
          0
          (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.var 2) (MultiWidth.Nondep.WidthExpr.var 5)))
        (MultiWidth.Nondep.WidthExpr.var 4))
      (MultiWidth.Nondep.Term.zext
        (MultiWidth.Nondep.Term.var
          1
          (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.var 6) (MultiWidth.Nondep.WidthExpr.var 0)))
        (MultiWidth.Nondep.WidthExpr.var 4))))
-/
#guard_msgs in 
theorem mult_assoc_4 (hq : (r + s) <= q) (hu : (p + r) <= u) :
  (bw t (mulMax (bw u (mulMax (bw p a) (bw r b))) (bw s c))) =
  (bw t (mulMax (bw p a) (bw q (mulMax (bw r b) (bw s c))))) := by
  simp only [bw, mulMax]
  bv_multi_width

/-
  {
    "name": "mult_sum_same",
    "preconditions": ["(> t p)", "(> t 1)", "(>= s (+ p q))"],
    "lhs": "(bw r (+ (bw s (* (bw p a) (bw q b))) (bw q b)))",
    "rhs": "(bw r (* (bw t (+ (bw p a) (bw 1 1))) (bw q b)))"
  },
-/

-- end preamble

/--
warning: abstracted non-variable bitvector: ⏎
  → 'BitVec.zeroExtend (max p q) (BitVec.zeroExtend p a) * BitVec.zeroExtend (max p q) (BitVec.zeroExtend q b)'
---
warning: abstracted non-variable bitvector: ⏎
  → 'BitVec.zeroExtend (max t q)
      (BitVec.zeroExtend t
        (BitVec.zeroExtend (max p 1) (BitVec.zeroExtend p a) +
          BitVec.zeroExtend (max p 1) (BitVec.zeroExtend 1 (BitVec.ofBool true)))) *
    BitVec.zeroExtend (max t q) (BitVec.zeroExtend q b)'
---
warning: abstracted non-variable width: ⏎
  → 'p + q'
---
error: MAYCEX: Found possible counter-example at iteration 1 for predicate MultiWidth.Nondep.Predicate.or
  (MultiWidth.Nondep.Predicate.binWidthRel
    (MultiWidth.WidthBinaryRelationKind.le)
    (MultiWidth.Nondep.WidthExpr.var 0)
    (MultiWidth.Nondep.WidthExpr.var 1))
  (MultiWidth.Nondep.Predicate.or
    (MultiWidth.Nondep.Predicate.binWidthRel
      (MultiWidth.WidthBinaryRelationKind.le)
      (MultiWidth.Nondep.WidthExpr.var 0)
      (MultiWidth.Nondep.WidthExpr.const 1))
    (MultiWidth.Nondep.Predicate.or
      (MultiWidth.Nondep.Predicate.binWidthRel
        (MultiWidth.WidthBinaryRelationKind.le)
        (MultiWidth.Nondep.WidthExpr.addK (MultiWidth.Nondep.WidthExpr.var 2) 1)
        (MultiWidth.Nondep.WidthExpr.var 3))
      (MultiWidth.Nondep.Predicate.binRel
        (MultiWidth.BinaryRelationKind.eq)
        (MultiWidth.Nondep.WidthExpr.var 4)
        (MultiWidth.Nondep.Term.zext
          (MultiWidth.Nondep.Term.add
            (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.var 2) (MultiWidth.Nondep.WidthExpr.var 5))
            (MultiWidth.Nondep.Term.zext
              (MultiWidth.Nondep.Term.zext
                (MultiWidth.Nondep.Term.var
                  0
                  (MultiWidth.Nondep.WidthExpr.max
                    (MultiWidth.Nondep.WidthExpr.var 1)
                    (MultiWidth.Nondep.WidthExpr.var 5)))
                (MultiWidth.Nondep.WidthExpr.var 2))
              (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.var 2) (MultiWidth.Nondep.WidthExpr.var 5)))
            (MultiWidth.Nondep.Term.zext
              (MultiWidth.Nondep.Term.zext
                (MultiWidth.Nondep.Term.var 1 (MultiWidth.Nondep.WidthExpr.var 6))
                (MultiWidth.Nondep.WidthExpr.var 5))
              (MultiWidth.Nondep.WidthExpr.max
                (MultiWidth.Nondep.WidthExpr.var 2)
                (MultiWidth.Nondep.WidthExpr.var 5))))
          (MultiWidth.Nondep.WidthExpr.var 4))
        (MultiWidth.Nondep.Term.zext
          (MultiWidth.Nondep.Term.var
            2
            (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.var 0) (MultiWidth.Nondep.WidthExpr.var 5)))
          (MultiWidth.Nondep.WidthExpr.var 4)))))
-/
#guard_msgs in 
theorem mult_sum_same (htp : t > p) (ht1 : t > 1) (hs : s >= (p + q)) :
  (bw r (addMax (bw s (mulMax (bw p a) (bw q b))) (bw q b)))  =
  (bw r (mulMax (bw t (addMax (bw p a) (bw 1 (1#1)))) (bw q b))) := by
  simp only [bw, mulMax, addMax]
  bv_multi_width
/-
  {
    "name": "one_to_two_mult",
    "preconditions": ["(> q (+ p 2))", "(> q p)"],
    "lhs": "(bw p (* (bw 1 1) (bw p x)))",
    "rhs": "(bw p (- (bw q (* (bw 2 2) (bw p x))) (bw p x)))"
  }
-/


-- end preamble

/--
warning: abstracted non-variable bitvector: ⏎
  → 'BitVec.zeroExtend (max 1 p) (BitVec.zeroExtend 1 (BitVec.ofBool true)) *
    BitVec.zeroExtend (max 1 p) (BitVec.zeroExtend p a)'
---
warning: abstracted non-variable bitvector: ⏎
  → 'BitVec.zeroExtend (max 2 p) 2#2 * BitVec.zeroExtend (max 2 p) (BitVec.zeroExtend p a)'
---
error: MAYCEX: Found possible counter-example at iteration 3 for predicate MultiWidth.Nondep.Predicate.or
  (MultiWidth.Nondep.Predicate.binWidthRel
    (MultiWidth.WidthBinaryRelationKind.le)
    (MultiWidth.Nondep.WidthExpr.var 0)
    (MultiWidth.Nondep.WidthExpr.addK (MultiWidth.Nondep.WidthExpr.var 1) 2))
  (MultiWidth.Nondep.Predicate.or
    (MultiWidth.Nondep.Predicate.binWidthRel
      (MultiWidth.WidthBinaryRelationKind.le)
      (MultiWidth.Nondep.WidthExpr.var 0)
      (MultiWidth.Nondep.WidthExpr.var 1))
    (MultiWidth.Nondep.Predicate.binRel
      (MultiWidth.BinaryRelationKind.eq)
      (MultiWidth.Nondep.WidthExpr.var 1)
      (MultiWidth.Nondep.Term.zext
        (MultiWidth.Nondep.Term.var
          0
          (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.const 1) (MultiWidth.Nondep.WidthExpr.var 1)))
        (MultiWidth.Nondep.WidthExpr.var 1))
      (MultiWidth.Nondep.Term.zext
        (MultiWidth.Nondep.Term.add
          (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.var 0) (MultiWidth.Nondep.WidthExpr.var 1))
          (MultiWidth.Nondep.Term.zext
            (MultiWidth.Nondep.Term.zext
              (MultiWidth.Nondep.Term.var
                1
                (MultiWidth.Nondep.WidthExpr.max
                  (MultiWidth.Nondep.WidthExpr.const 2)
                  (MultiWidth.Nondep.WidthExpr.var 1)))
              (MultiWidth.Nondep.WidthExpr.var 0))
            (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.var 0) (MultiWidth.Nondep.WidthExpr.var 1)))
          (MultiWidth.Nondep.Term.add
            (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.var 0) (MultiWidth.Nondep.WidthExpr.var 1))
            (MultiWidth.Nondep.Term.bnot
              (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.var 0) (MultiWidth.Nondep.WidthExpr.var 1))
              (MultiWidth.Nondep.Term.zext
                (MultiWidth.Nondep.Term.zext
                  (MultiWidth.Nondep.Term.var 2 (MultiWidth.Nondep.WidthExpr.var 2))
                  (MultiWidth.Nondep.WidthExpr.var 1))
                (MultiWidth.Nondep.WidthExpr.max
                  (MultiWidth.Nondep.WidthExpr.var 0)
                  (MultiWidth.Nondep.WidthExpr.var 1))))
            (MultiWidth.Nondep.Term.ofNat
              (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.var 0) (MultiWidth.Nondep.WidthExpr.var 1))
              1)))
        (MultiWidth.Nondep.WidthExpr.var 1))))
-/
#guard_msgs in 
theorem one_to_two_mult (hq : q > (p + 2)) (hpq : q > p) :
  (bw p (mulMax (bw 1 (1#1)) (bw p a)))  =
  (bw p (subMax (bw q (mulMax (bw 2 (2#2)) (bw p a))) (bw p a))) := by
  simp only [bw, mulMax, subMax]
  -- | TODO: this is solvable once again by width-case-splitting.
  bv_multi_width
/-
  {
    "name": "sub_to_neg",
    "preconditions": [],
    "lhs": "(bw r (- (bw p a) (bw q b)))",
    "rhs": "(bw r (+ (bw p a) (- (bw q b))))"
  },
-/

-- end preamble

/--
error: CEX: Found exact counter-example at iteration 1 for predicate MultiWidth.Nondep.Predicate.binRel
  (MultiWidth.BinaryRelationKind.eq)
  (MultiWidth.Nondep.WidthExpr.var 0)
  (MultiWidth.Nondep.Term.zext
    (MultiWidth.Nondep.Term.add
      (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.var 1) (MultiWidth.Nondep.WidthExpr.var 2))
      (MultiWidth.Nondep.Term.zext
        (MultiWidth.Nondep.Term.zext
          (MultiWidth.Nondep.Term.var 0 (MultiWidth.Nondep.WidthExpr.var 3))
          (MultiWidth.Nondep.WidthExpr.var 1))
        (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.var 1) (MultiWidth.Nondep.WidthExpr.var 2)))
      (MultiWidth.Nondep.Term.add
        (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.var 1) (MultiWidth.Nondep.WidthExpr.var 2))
        (MultiWidth.Nondep.Term.bnot
          (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.var 1) (MultiWidth.Nondep.WidthExpr.var 2))
          (MultiWidth.Nondep.Term.zext
            (MultiWidth.Nondep.Term.zext
              (MultiWidth.Nondep.Term.var 1 (MultiWidth.Nondep.WidthExpr.var 3))
              (MultiWidth.Nondep.WidthExpr.var 2))
            (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.var 1) (MultiWidth.Nondep.WidthExpr.var 2))))
        (MultiWidth.Nondep.Term.ofNat
          (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.var 1) (MultiWidth.Nondep.WidthExpr.var 2))
          1)))
    (MultiWidth.Nondep.WidthExpr.var 0))
  (MultiWidth.Nondep.Term.zext
    (MultiWidth.Nondep.Term.add
      (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.var 1) (MultiWidth.Nondep.WidthExpr.var 2))
      (MultiWidth.Nondep.Term.zext
        (MultiWidth.Nondep.Term.zext
          (MultiWidth.Nondep.Term.var 0 (MultiWidth.Nondep.WidthExpr.var 3))
          (MultiWidth.Nondep.WidthExpr.var 1))
        (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.var 1) (MultiWidth.Nondep.WidthExpr.var 2)))
      (MultiWidth.Nondep.Term.zext
        (MultiWidth.Nondep.Term.add
          (MultiWidth.Nondep.WidthExpr.var 2)
          (MultiWidth.Nondep.Term.bnot
            (MultiWidth.Nondep.WidthExpr.var 2)
            (MultiWidth.Nondep.Term.zext
              (MultiWidth.Nondep.Term.var 1 (MultiWidth.Nondep.WidthExpr.var 3))
              (MultiWidth.Nondep.WidthExpr.var 2)))
          (MultiWidth.Nondep.Term.ofNat (MultiWidth.Nondep.WidthExpr.var 2) 1))
        (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.var 1) (MultiWidth.Nondep.WidthExpr.var 2))))
    (MultiWidth.Nondep.WidthExpr.var 0))
-/
#guard_msgs in theorem sub_to_neg :
  (bw r (subMax (bw p a) (bw q b)))  =
  (bw r (addMax (bw p a) (- (bw q b)))) := by
  simp only [bw, subMax, addMax]
  -- TODO: should not fail.
  bv_multi_width

/-
  {
    "name": "sum_same",
    "preconditions": [],
    "lhs": "(bw q (+ (bw p a) (bw p a)))",
    "rhs": "(bw q (* (bw 2 2) (bw p a)))"
  },
-/

-- end preamble

/--
warning: abstracted non-variable bitvector: ⏎
  → 'BitVec.zeroExtend (max 2 p) 2#2 * BitVec.zeroExtend (max 2 p) (BitVec.zeroExtend p a)'
---
error: MAYCEX: Found possible counter-example at iteration 0 for predicate MultiWidth.Nondep.Predicate.binRel
  (MultiWidth.BinaryRelationKind.eq)
  (MultiWidth.Nondep.WidthExpr.var 0)
  (MultiWidth.Nondep.Term.zext
    (MultiWidth.Nondep.Term.add
      (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.var 1) (MultiWidth.Nondep.WidthExpr.var 1))
      (MultiWidth.Nondep.Term.zext
        (MultiWidth.Nondep.Term.zext
          (MultiWidth.Nondep.Term.var 0 (MultiWidth.Nondep.WidthExpr.var 2))
          (MultiWidth.Nondep.WidthExpr.var 1))
        (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.var 1) (MultiWidth.Nondep.WidthExpr.var 1)))
      (MultiWidth.Nondep.Term.zext
        (MultiWidth.Nondep.Term.zext
          (MultiWidth.Nondep.Term.var 0 (MultiWidth.Nondep.WidthExpr.var 2))
          (MultiWidth.Nondep.WidthExpr.var 1))
        (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.var 1) (MultiWidth.Nondep.WidthExpr.var 1))))
    (MultiWidth.Nondep.WidthExpr.var 0))
  (MultiWidth.Nondep.Term.zext
    (MultiWidth.Nondep.Term.var
      1
      (MultiWidth.Nondep.WidthExpr.max (MultiWidth.Nondep.WidthExpr.const 2) (MultiWidth.Nondep.WidthExpr.var 1)))
    (MultiWidth.Nondep.WidthExpr.var 0))
-/
#guard_msgs in theorem sum_same :
  (bw q (addMax (bw p a) (bw p a)))  =
  (bw q (mulMax (bw 2 (2#2)) (bw p a))) := by
  simp only [bw, addMax, mulMax]
  bv_multi_width

end Rover
end Test
