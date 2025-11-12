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

set_option linter.unusedSimpArgs false
set_option warn.sorry false
set_option linter.unusedVariables false 

def bw (w : Nat) (x : BitVec v) : BitVec w := x.signExtend w

def addMax (a : BitVec v) (b : BitVec w) : BitVec (max v w + 1) :=
   a.signExtend _ + b.signExtend _

def mulMax (a : BitVec v) (b : BitVec w) : BitVec (max v w * 2) :=
   a.signExtend _ * b.signExtend _

def subMax (a : BitVec v) (b : BitVec w) : BitVec (max v w + 1) :=
   a.signExtend _ - b.signExtend _

-- TODO: this is a lie anyway, so whatever.
def shlMax (a : BitVec v) (b : BitVec w) : BitVec (max v w) :=
   a.signExtend (max v w) <<< b.signExtend (max v w)

-- TODO: this is a lie anyway, so whatever.
def shrMax (a : BitVec v) (b : BitVec w) : BitVec (max v w) :=
    a.signExtend (max v w) >>> b.signExtend (max v w)



variable (w p q r s t u : Nat)
-- variable (a b c : BitVec w)
variable (a : BitVec p)
variable (b : BitVec r)
variable (c : BitVec s)

-- end preamble

-- PROBLEM
/-
  {
    "name": "add_assoc_1",
    "preconditions": ["(>= q t)", "(>= u t)"],
    "lhs": "(bw t ( + (bw u (+ (bw p a) (bw r b))) (bw s c)))",
    "rhs": "(bw t ( + (bw p a) (bw q (+ (bw r b) (bw s c)))))"
  },
-/


def bw' (wmask : BitVec o) (x : BitVec o) : BitVec o := x &&& (wmask)

def unaryMax (pmask qmask : BitVec o) : BitVec o := (pmask ||| qmask)

def unaryIncr (mask : BitVec o) : BitVec o := (mask <<< 1) ||| 1

-- | Add two unary numbers represented as bitmasks.
def unaryAdd (pmask : BitVec o) (qmask : BitVec o) : BitVec o := 
  -- 2^p
  let ppot := pmask + 1 -- power of two
  -- 2^q
  let qpot := qmask + 1 -- power of two
  -- 2^p * 2^q = 2^(p+q)
  let sumpot := ppot * qpot
  -- 2^(p+q) - 1 = mask of (p + q) ones
  sumpot - 1


def unaryDouble (mask : BitVec o) : BitVec o := unaryAdd mask mask

def unaryOne {o : Nat} : BitVec o := 1
def unaryTwo {o : Nat} : BitVec o := 3


def addMax'Mask (pmask : BitVec o) (qmask : BitVec o) : BitVec o :=
    unaryAdd pmask qmask |> unaryIncr

def addMax' (a : BitVec o) (wmask : BitVec o) (b : BitVec o) (vmask : BitVec o) : BitVec o :=
    let max := addMax'Mask wmask vmask
    (a + b) -- &&& max

def subMax'Mask (pmask : BitVec o) (qmask : BitVec o) : BitVec o :=
    let added := unaryAdd pmask qmask
    unaryDouble added |> unaryIncr

def subMax' (a : BitVec o) (wmask : BitVec o) (b : BitVec o) (vmask : BitVec o) : BitVec o :=
    (a - b)  -- &&& (subMax'Mask wmask vmask)

def negMax' (a : BitVec o) : BitVec o :=
    (-a) 

def mulMax'Mask (wmask : BitVec o) (vmask : BitVec o) : BitVec o :=
    let added := unaryAdd wmask vmask
    unaryDouble added |> unaryIncr

def mulMax' (a : BitVec o) (wmask : BitVec o) (b : BitVec o) (vmask : BitVec o) : BitVec o :=
    let max := mulMax'Mask wmask vmask
    (a * b) &&& max

-- large ≥ small
def UnaryGe (largemask smallmask : BitVec o) : Prop :=
  ~~~ largemask &&& smallmask = 0#o

def UnaryLe (smallmask largemask : BitVec o) : Prop :=
  UnaryGe largemask smallmask

def UnaryLt (smallmask largemask : BitVec o) : Prop :=
   -- a < b iff b > a
   -- b > a iff b ≥ a &&& b ≠ a
    UnaryGe largemask smallmask ∧ largemask ≠ smallmask

def UnaryGt (largemask smallmask : BitVec o) : Prop :=
   UnaryLt smallmask largemask

/-
An axiom that allows us to do bounded model checking up to bitwidth 64.
-/
@[elab_as_elim]
axiom AxBoundedModelCheck {P : Nat → Prop} (bound : Nat) : (P bound) → ∀ i, P i

variable {o : Nat}
  (ppot : BitVec o)  
  (qpot : BitVec o)  
  (rpot : BitVec o)  
  (spot : BitVec o)  
  (tpot : BitVec o)  
  (upot : BitVec o)  
  (pmask : BitVec o) 
  (qmask : BitVec o) 
  (rmask : BitVec o) 
  (smask : BitVec o) 
  (tmask : BitVec o) 
  (umask : BitVec o) 
  (a' : BitVec o) (b' : BitVec o) (c' : BitVec o)

-- BMC
theorem add_assoc_1' 
  (hppot : ppot &&& (ppot - 1) = 0)
  (hqpot : qpot &&& (qpot - 1) = 0)
  (hrpot : rpot &&& (rpot - 1) = 0)
  (hspot : spot &&& (spot - 1) = 0)
  (htpot : tpot &&& (tpot - 1) = 0)
  (hupot : upot &&& (upot - 1) = 0)
  (hpmask : pmask = ppot - 1)
  (hqmask : qmask = qpot - 1)
  (hrmask : rmask = rpot - 1)
  (hsmask : smask = spot - 1)
  (htmask : tmask = tpot - 1)
  (humask : umask = upot - 1)
  -- default assumptions ↑ 
  (hqt : UnaryGe qmask tmask)
  (hut : UnaryGe umask tmask) :
  (bw' tmask
    (addMax' 
      (bw' umask 
        (addMax' ((bw' pmask a')) pmask (bw' rmask b') rmask))
      umask
      (bw' smask c')
      smask)) =
  (bw' tmask
    (addMax'
      (bw' pmask a') pmask
      (bw' qmask 
        (addMax' (bw' rmask b') rmask (bw' smask c') smask))
      qmask)) := by
  simp only [bw', addMax', UnaryGe, addMax'Mask, unaryAdd, unaryIncr, unaryMax] at *
  induction o using AxBoundedModelCheck 8
  bv_decide
  -- bv_automata_gen (config := {backend := .circuit_cadical_verified 100 })
  -- bv_multi_width +verbose? (niter := 1)
  -- bv_automata_classic
  -- bv_multi_width -check? (niter := 30)
  -- sorry

/--
info: 'Test.Rover.add_assoc_1'' depends on axioms: [propext,
 Classical.choice,
 Lean.ofReduceBool,
 Lean.trustCompiler,
 Quot.sound,
 Test.Rover.AxBoundedModelCheck]
-/
#guard_msgs in #print axioms add_assoc_1'

theorem add_assoc_1 (hq : q >= t) (hu : u >= t) :
  (bw t (addMax (bw u (addMax (bw p a) (bw r b))) (bw s c))) =
  (bw t (addMax (bw p a) (bw q (addMax (bw r b) (bw s c))))) := by
  simp only [bw, addMax] at *
  -- bv_multi_width -check?
  sorry

-- PROBLEM
/-
{
  "name": "add_assoc_2",
  "preconditions": ["(< r q)", "(< s q)", "(>= u t)"],
  "lhs": "(bw t ( + (bw u (+ (bw p a) (bw r b))) (bw s c)))",
  "rhs": "(bw t ( + (bw p a) (bw q (+ (bw r b) (bw s c)))))"
},
-/

-- end preamble

theorem add_assoc_2 (hr : r < q) (hs : s < q) (hu : u >= t) :
  (bw t (addMax (bw u (addMax (bw p a) (bw r b))) (bw s c)))  =
  (bw t (addMax (bw p a) (bw q (addMax (bw r b) (bw s c))))) := by
  simp only [bw, addMax]
  -- fail_if_success bv_multi_width
  sorry 

-- BMC
theorem add_assoc_2' 
  (hppot : ppot &&& (ppot - 1) = 0)
  (hqpot : qpot &&& (qpot - 1) = 0)
  (hrpot : rpot &&& (rpot - 1) = 0)
  (hspot : spot &&& (spot - 1) = 0)
  (htpot : tpot &&& (tpot - 1) = 0)
  (hupot : upot &&& (upot - 1) = 0)
  (hpmask : pmask = ppot - 1)
  (hqmask : qmask = qpot - 1)
  (hrmask : rmask = rpot - 1)
  (hsmask : smask = spot - 1)
  (htmask : tmask = tpot - 1)
  (humask : umask = upot - 1)
  (hr : UnaryLt rmask qmask) (hs : UnaryLt smask qmask) (hu : UnaryGe umask  tmask)
  :
  --
  (bw' tmask 
    (addMax' (bw' umask (addMax' (bw' pmask a') pmask (bw' rmask b') rmask)) umask (bw' smask c') smask))  =
  (bw' tmask (addMax' (bw' pmask a') pmask (bw' qmask (addMax' (bw' rmask b') rmask (bw' smask c') smask)) qmask)) := by
  simp only [bw', addMax', UnaryGe, addMax'Mask, unaryAdd, unaryIncr, unaryMax, UnaryLe, UnaryLt] at *
  induction o using AxBoundedModelCheck 8
  bv_decide

-- PROBLEM
/-
  {
    "name": "add_assoc_3",
    "preconditions": ["(>= q t)", "(< p u)", "(< r u)"],
    "lhs": "(bw t ( + (bw u (+ (bw p a) (bw r b))) (bw s c)))",
    "rhs": "(bw t ( + (bw p a) (bw q (+ (bw r b) (bw s c)))))"
  },
-/

-- end preamble

theorem add_assoc_3 (hq : q >= t) (hp : p < u) (hr : r < u) :
  (bw t (addMax (bw u (addMax (bw p a) (bw r b))) (bw s c)))  =
  (bw t (addMax (bw p a) (bw q (addMax (bw r b) (bw s c))))) := by
  simp only [bw, addMax]
  -- fail_if_success bv_multi_width
  sorry

-- BMC
theorem add_assoc_3' 
  (hppot : ppot &&& (ppot - 1) = 0)
  (hqpot : qpot &&& (qpot - 1) = 0)
  (hrpot : rpot &&& (rpot - 1) = 0)
  (hspot : spot &&& (spot - 1) = 0)
  (htpot : tpot &&& (tpot - 1) = 0)
  (hupot : upot &&& (upot - 1) = 0)
  (hpmask : pmask = ppot - 1)
  (hqmask : qmask = qpot - 1)
  (hrmask : rmask = rpot - 1)
  (hsmask : smask = spot - 1)
  (htmask : tmask = tpot - 1)
  (humask : umask = upot - 1)
  (hr : UnaryGe qmask tmask) (hs : UnaryLt pmask umask) (hu : UnaryLt rmask umask) :
  (bw' tmask 
    (addMax' (bw' umask (addMax' (bw' pmask a') pmask (bw' rmask b') rmask)) umask (bw' smask c') smask))  =
  (bw' tmask (addMax' (bw' pmask a') pmask (bw' qmask (addMax' (bw' rmask b') rmask (bw' smask c') smask)) qmask)) := by
  simp only [bw', addMax', UnaryGe, addMax'Mask, unaryAdd, unaryIncr, unaryMax, UnaryLt] at *
  induction o using AxBoundedModelCheck 8
  bv_decide

-- PROBLEM
/-
  {
    "name": "add_assoc_4",
    "preconditions": ["(< r q)", "(< s q)", "(< p u)", "(< r u)"],
    "lhs": "(bw t ( + (bw u (+ (bw p a) (bw r b))) (bw s c)))",
    "rhs": "(bw t ( + (bw p a) (bw q (+ (bw r b) (bw s c)))))"
  },
-/

-- end preamble

theorem add_assoc_4 (hr : r < q) (hs : s < q) (hp : p < u) (hu : r < u) :
    (bw t (addMax (bw u (addMax (bw p a) (bw r b))) (bw s c)))  =
    (bw t (addMax (bw p a) (bw q (addMax (bw r b) (bw s c))))) := by
  simp only [bw, addMax]
  -- fail_if_success bv_multi_width
  sorry 

-- BMC
theorem add_assoc_4' 
  (hppot : ppot &&& (ppot - 1) = 0)
  (hqpot : qpot &&& (qpot - 1) = 0)
  (hrpot : rpot &&& (rpot - 1) = 0)
  (hspot : spot &&& (spot - 1) = 0)
  (htpot : tpot &&& (tpot - 1) = 0)
  (hupot : upot &&& (upot - 1) = 0)
  (hpmask : pmask = ppot - 1)
  (hqmask : qmask = qpot - 1)
  (hrmask : rmask = rpot - 1)
  (hsmask : smask = spot - 1)
  (htmask : tmask = tpot - 1)
  (humask : umask = upot - 1)
  (hr : UnaryLt rmask qmask) (hs : UnaryLt smask qmask) (hp : UnaryLt pmask umask) (hu : UnaryLt rmask umask) :
  (bw' tmask 
    (addMax' (bw' umask (addMax' (bw' pmask a') pmask (bw' rmask b') rmask)) umask (bw' smask c') smask))  =
  (bw' tmask (addMax' (bw' pmask a') pmask (bw' qmask (addMax' (bw' rmask b') rmask (bw' smask c') smask)) qmask)) := by
  simp only [bw', addMax', UnaryGe, addMax'Mask, unaryAdd, unaryIncr, unaryMax, UnaryLt] at *
  induction o using AxBoundedModelCheck 8
  bv_decide

-- PROBLEM
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

-- INEXPRESSIBLE
theorem add_right_shift (hq : q >= t) (hs : s >= p + (2 ^ u - 1)) (hv_s : v > s) (hv_t : v > t) :
  (bw r (addMax (bw p a) (bw q (shrMax (bw t b) (bw u c)))))  =
  (bw r (shrMax (bw v (addMax (bw s (shlMax (bw p a) (bw u c))) (bw t b))) (bw u c))) := by
   simp only [bw, addMax, shrMax, shlMax]
   -- fail_if_success bv_multi_width
   sorry 

-- PROBLEM
/-
  {
    "name": "add_zero",
    "preconditions": [],
    "lhs": "(bw p (+ (bw p a) (bw q 0)))",
    "rhs": "(bw p a)"
  },
-/

-- end preamble

-- MULTIWIDTH
theorem add_zero :
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

-- MULTIWIDTH
set_option maxHeartbeats 9999999 in
theorem commutativity_add :
      bw r (addMax (bw p a) (bw q b))  = bw r (addMax (bw q b) (bw p a)) := by
  simp only [bw, addMax]
  bv_multi_width

-- PROBLEM
/-
  {
    "name": "commutativity_mult",
    "preconditions": [],
    "lhs": "(bw r ( * (bw p a) (bw q b)))",
    "rhs": "(bw r ( * (bw q b) (bw p a)))"
  },
-/

-- end preamble

theorem commutativity_mult :
      bw r (mulMax (bw p a) (bw q b))  = bw r (mulMax (bw q b) (bw p a)) := by
  simp only [bw, mulMax]
  -- TODO: normalize 'max' by ac_nf.
  -- | TODO: 'max p q' should be rewritten to the same normal form ':('
  fail_if_success bv_multi_width
  sorry

-- BMC
theorem commutativity_mult' 
  (hppot : ppot &&& (ppot - 1) = 0)
  (hqpot : qpot &&& (qpot - 1) = 0)
  (hrpot : rpot &&& (rpot - 1) = 0)
  (hspot : spot &&& (spot - 1) = 0)
  (htpot : tpot &&& (tpot - 1) = 0)
  (hupot : upot &&& (upot - 1) = 0)
  (hpmask : pmask = ppot - 1)
  (hqmask : qmask = qpot - 1)
  (hrmask : rmask = rpot - 1)
  (hsmask : smask = spot - 1)
  (htmask : tmask = tpot - 1)
  (humask : umask = upot - 1) :
  (bw' rmask (mulMax' (bw' pmask a') pmask (bw' qmask b') qmask)) =
  (bw' rmask (mulMax' (bw' qmask b') qmask (bw' pmask a') pmask)) := by
  simp only [bw', addMax', mulMax', UnaryGe, unaryIncr, unaryMax, unaryAdd, mulMax'Mask, unaryDouble, addMax'Mask] at *
  induction o using AxBoundedModelCheck 3
  bv_decide

-- PROBLEM
/-
  {
    "name": "dist_over_add",
    "preconditions": ["(>= q r)", "(>= u r)", "(>= v r)"],
    "lhs": "(bw r (* (bw p a) (+ (bw s b) (bw t c))))",
    "rhs": "(bw r (+ (bw u (* (bw p a) (bw s b))) (bw v (* (bw p a) (bw t c)) ) ))"
  },
-/

-- end preamble

theorem dist_over_add (hq : q >= r) (hu : u >= r) (hv : v >= r) :
  (bw r (mulMax (bw p a) (addMax (bw s b) (bw t c))))  =
  (bw r (addMax (bw u (mulMax (bw p a) (bw s b))) (bw v (mulMax (bw p a) (bw t c))))) := by
    simp only [bw, addMax, mulMax]
    -- TODO: push zext into add, distribute mul.
    -- fail_if_success bv_multi_width
    sorry

-- BMC
theorem dist_over_add' 
  (hppot : ppot &&& (ppot - 1) = 0)
  (hqpot : qpot &&& (qpot - 1) = 0)
  (hrpot : rpot &&& (rpot - 1) = 0)
  (hspot : spot &&& (spot - 1) = 0)
  (htpot : tpot &&& (tpot - 1) = 0)
  (hupot : upot &&& (upot - 1) = 0)
  (hpmask : pmask = ppot - 1)
  (hqmask : qmask = qpot - 1)
  (hrmask : rmask = rpot - 1)
  (hsmask : smask = spot - 1)
  (htmask : tmask = tpot - 1)
  (humask : umask = upot - 1)
  (hq : UnaryGe qmask rmask) (hu : UnaryGe umask rmask) (hv : UnaryGe vmask rmask) :
  (bw' rmask 
    (mulMax'
      (bw' pmask a')
      pmask
      (addMax' (bw' smask b') smask (bw' tmask c') tmask)
      (addMax'Mask smask tmask)))  =
  (bw' rmask
    (addMax' 
      (bw' umask (mulMax' (bw' pmask a') pmask (bw' smask b') smask)) umask
      (bw' vmask (mulMax' (bw' pmask a') pmask (bw' tmask c') tmask)) vmask)) := by
  simp only [bw', addMax', mulMax', UnaryGe, unaryIncr, unaryMax, unaryAdd, mulMax'Mask, unaryDouble, addMax'Mask] at *
  induction o using AxBoundedModelCheck 3
  bv_decide

  
-- PROBLEM
/-
  {
    "name": "left_shift_add_1",
    "preconditions": ["(>= u r)", "(>= s r)"],
    "lhs": "(bw r (<< (bw s (+ (bw p a) (bw q b))) (bw t c)))",
    "rhs": "(bw r (+ (bw u (<< (bw p a) (bw t c))) (bw u (<< (bw q b) (bw t c)))))"
  },
-/

-- end preamble

-- INEXPRESSIBLE
theorem left_shift_add_1 (hu : u >= r) (hs : s >= r) :
  (bw r (shlMax (bw s (addMax (bw p a) (bw q b))) (bw t c)))  =
  (bw r (addMax (bw u (shlMax (bw p a) (bw t c))) (bw u (shlMax (bw q b) (bw t c))))) := by
   simp only [bw, addMax, shlMax]
   -- fail_if_success bv_multi_width
   sorry

-- PROBLEM
/-
  {
    "name": "left_shift_add_2",
    "preconditions": ["(>= u r)", "(> s p)", "(> s q)"],
    "lhs": "(bw r (<< (bw s (+ (bw p a) (bw q b))) (bw t c)))",
    "rhs": "(bw r (+ (bw u (<< (bw p a) (bw t c))) (bw u (<< (bw q b) (bw t c)))))"
  },
-/
-- end preamble

-- INEXPRESSIBLE
theorem left_shift_add_2 (hu : u >= r) (hs : s > p) (hsq : s > q) :
  (bw r (shlMax (bw s (addMax (bw p a) (bw q b))) (bw t c)))  =
  (bw r (addMax (bw u (shlMax (bw p a) (bw t c))) (bw u (shlMax (bw q b) (bw t c))))) := by
   simp only [bw, addMax, shlMax]
   -- fail_if_success bv_multi_width
   sorry

-- PROBLEM
/-
  {
    "name": "left_shift_mult",
    "preconditions": ["(>= t r)", "(>= v r)"],
    "lhs": "(bw r (<< (bw t (* (bw p a) (bw q b))) (bw u c)))",
    "rhs": "(bw r (* (bw v (<< (bw p a) (bw u c))) (bw q b)))"
  },
-/

-- end preamble

-- INEXPRESSIBLE
theorem left_shift_mult (ht : t >= r) (hv : v >= r) :
  (bw r (shlMax (bw t (mulMax (bw p a) (bw q b))) (bw u c)))  =
  (bw r (mulMax (bw v (shlMax (bw p a) (bw u c))) (bw q b))) := by
   simp only [bw, mulMax, shlMax]
   -- fail_if_success bv_multi_width
   sorry

-- PROBLEM
/-
  {
    "name": "merge_left_shift",
    "preconditions": ["(>= u r)", "(> t s)", "(> t q)"],
    "lhs": "(bw r (<< (bw u (<< (bw p a) (bw q b))) (bw s c)))",
    "rhs": "(bw r (<< (bw p a) (bw t (+ (bw q b) (bw s c)))))"
  },
-/


-- end preamble

-- INEXPRESSIBLE
theorem merge_left_shift (hu : u >= r) (hts : t > s) (htq : t > q) :
  (bw r (shlMax (bw u (shlMax (bw p a) (bw q b))) (bw s c)))  =
  (bw r (shlMax (bw p a) (bw t (addMax (bw q b) (bw s c))))) := by
   simp only [bw, addMax, shlMax]
   -- fail_if_success bv_multi_width
   sorry

-- PROBLEM
/-
  {
    "name": "merge_right_shift",
    "preconditions": ["(>= u p)", "(> t s)", "(> t q)"],
    "lhs": "(bw r (>> (bw u (>> (bw p a) (bw q b))) (bw s c)))",
    "rhs": "(bw r (>> (bw p a) (bw t (+ (bw q b) (bw s c)))))"
  },
-/

-- end preamble

-- INEXPRESSIBLE
theorem merge_right_shift (hu : u >= p) (hts : t > s) (htq : t > q) :
  (bw r (shrMax (bw u (shrMax (bw p a) (bw q b))) (bw s c)))  =
  (bw r (shrMax (bw p a) (bw t (addMax (bw q b) (bw s c))))) := by
   simp only [bw, addMax, shrMax]
   -- fail_if_success bv_multi_width
   sorry

-- PROBLEM
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
   fail_if_success bv_multi_width
   sorry

-- BMC
theorem mul_one'
  (hppot : ppot &&& (ppot - 1) = 0)
  (hqpot : qpot &&& (qpot - 1) = 0)
  (hrpot : rpot &&& (rpot - 1) = 0)
  (hspot : spot &&& (spot - 1) = 0)
  (htpot : tpot &&& (tpot - 1) = 0)
  (hupot : upot &&& (upot - 1) = 0)
  (hpmask : pmask = ppot - 1)
  (hqmask : qmask = qpot - 1)
  (hrmask : rmask = rpot - 1)
  (hsmask : smask = spot - 1)
  (htmask : tmask = tpot - 1)
  (humask : umask = upot - 1) 
  (hq : qmask ≠ 0#o) : -- q > 0
  (bw' pmask (mulMax' (bw' pmask a') pmask (bw' qmask (1#o)) qmask)) =
  (bw' pmask a') := by
  simp only [bw', addMax', mulMax', UnaryGe, unaryIncr, unaryMax, unaryAdd, mulMax'Mask, unaryDouble, addMax'Mask] at *
  induction o using AxBoundedModelCheck 3
  bv_decide


-- PROBLEM
/-
  {
    "name": "mul_two",
    "preconditions": [],
    "lhs": "(bw r (* (bw p a) 2))",
    "rhs": "(bw r (<< (bw p a) 1))"
  },
-/

-- end preamble

theorem mul_two :
  (bw r (mulMax (bw p a) (bw 2 (2#2))))  =
  (bw r ((bw p a) <<< 1)) := by
   simp only [bw, mulMax]
   -- | TODO: can be solved by further preprocessing: we have (max p 2), so we
   -- can case split until we remove the '2'.
   -- fail_if_success bv_multi_width
   sorry

-- BMC
theorem mul_two' 
  (hppot : ppot &&& (ppot - 1) = 0)
  (hqpot : qpot &&& (qpot - 1) = 0)
  (hrpot : rpot &&& (rpot - 1) = 0)
  (hspot : spot &&& (spot - 1) = 0)
  (htpot : tpot &&& (tpot - 1) = 0)
  (hupot : upot &&& (upot - 1) = 0)
  (hpmask : pmask = ppot - 1)
  (hqmask : qmask = qpot - 1)
  (hrmask : rmask = rpot - 1)
  (hsmask : smask = spot - 1)
  (htmask : tmask = tpot - 1)
  (humask : umask = upot - 1) :
  (bw' rmask (mulMax' (bw' pmask a') pmask (bw' (2#o) (2#o)) (2#o))) =
  (bw' rmask ((bw' pmask a') <<< 1)) := by
  simp only [bw', addMax', mulMax', UnaryGe, unaryIncr, unaryMax, unaryAdd, mulMax'Mask, unaryDouble, addMax'Mask] at *
  induction o using AxBoundedModelCheck 3
  bv_decide

-- PROBLEM
/-
{
  "name": "mult_assoc_1",
  "preconditions": ["(>= q t)", "(>= u t)"],
  "lhs": "(bw t ( * (bw u (* (bw p a) (bw r b))) (bw s c)))",
  "rhs": "(bw t ( * (bw p a) (bw q (* (bw r b) (bw s c)))))"
},
-/


theorem mult_assoc_1 (hq : q >= t) (hu : u >= t) :
  (bw t (mulMax (bw u (mulMax (bw p a) (bw r b))) (bw s c))) =
  (bw t (mulMax (bw p a) (bw q (mulMax (bw r b) (bw s c))))) := by
   simp only [bw, mulMax]
   fail_if_success bv_multi_width
   sorry

-- BMC
theorem mult_assoc_1' 
  (hppot : ppot &&& (ppot - 1) = 0)
  (hqpot : qpot &&& (qpot - 1) = 0)
  (hrpot : rpot &&& (rpot - 1) = 0)
  (hspot : spot &&& (spot - 1) = 0)
  (htpot : tpot &&& (tpot - 1) = 0)
  (hupot : upot &&& (upot - 1) = 0)
  (hpmask : pmask = ppot - 1)
  (hqmask : qmask = qpot - 1)
  (hrmask : rmask = rpot - 1)
  (hsmask : smask = spot - 1)
  (htmask : tmask = tpot - 1)
  (humask : umask = upot - 1)
  (hq : UnaryGe qmask tmask) (hu : UnaryGe umask tmask) :
  (bw' tmask 
    (mulMax' 
      (bw' umask 
        (mulMax' (bw' pmask a') pmask (bw' rmask b') rmask))
      umask
      (bw' smask c')
      smask)) =
  (bw' tmask
    (mulMax'
      (bw' pmask a') pmask
      (bw' qmask 
        (mulMax' (bw' rmask b') rmask (bw' smask c') smask))
      qmask)) := by
  simp only [bw', addMax', mulMax', UnaryGe, unaryIncr, unaryMax, unaryAdd, mulMax'Mask, unaryDouble, addMax'Mask] at *
  induction o using AxBoundedModelCheck 3
  bv_decide

-- PROBLEM
/-
  {
    "name": "mult_assoc_2",
    "preconditions": ["(>= q t)", "(<= (+ p r) u)"],
    "lhs": "(bw t ( * (bw u (* (bw p a) (bw r b))) (bw s c)))",
    "rhs": "(bw t ( * (bw p a) (bw q (* (bw r b) (bw s c)))))"
  },
-/

-- end preamble

theorem mult_assoc_2 (hq : q >= t) (hu : (p + r) <= u) :
  (bw t (mulMax (bw u (mulMax (bw p a) (bw r b))) (bw s c)))  =
  (bw t (mulMax (bw p a) (bw q (mulMax (bw r b) (bw s c))))) := by
  simp only [bw, mulMax]
  -- fail_if_success bv_multi_width
  sorry

-- BMC
theorem mult_assoc_2' 
  (hppot : ppot &&& (ppot - 1) = 0)
  (hqpot : qpot &&& (qpot - 1) = 0)
  (hrpot : rpot &&& (rpot - 1) = 0)
  (hspot : spot &&& (spot - 1) = 0)
  (htpot : tpot &&& (tpot - 1) = 0)
  (hupot : upot &&& (upot - 1) = 0)
  (hpmask : pmask = ppot - 1)
  (hqmask : qmask = qpot - 1)
  (hrmask : rmask = rpot - 1)
  (hsmask : smask = spot - 1)
  (htmask : tmask = tpot - 1)
  (humask : umask = upot - 1)
  (hq : UnaryGe qmask tmask) (hu : UnaryLe (unaryAdd pmask rmask) umask) :
  (bw' tmask 
    (mulMax' 
      (bw' umask 
        (mulMax' (bw' pmask a') pmask (bw' rmask b') rmask))
      umask
      (bw' smask c')
      smask)) =
  (bw' tmask
    (mulMax'
      (bw' pmask a') pmask
      (bw' qmask 
        (mulMax' (bw' rmask b') rmask (bw' smask c') smask))
      qmask)) := by
  simp only [bw', addMax', mulMax', UnaryGe, unaryIncr, unaryMax, unaryAdd, mulMax'Mask, unaryDouble, addMax'Mask, UnaryLe] at *
  induction o using AxBoundedModelCheck 3
  bv_decide

-- PROBLEM
/-
  {
    "name": "mult_assoc_3",
    "preconditions": ["(<= (+ r s) q)", "(>= u t)"],
    "lhs": "(bw t ( * (bw u (* (bw p a) (bw r b))) (bw s c)))",
    "rhs": "(bw t ( * (bw p a) (bw q (* (bw r b) (bw s c)))))"
  },
-/

-- end preamble

theorem mult_assoc_3 (hq : (r + s) <= q) (hu : u >= t) :
  (bw t (mulMax (bw u (mulMax (bw p a) (bw r b))) (bw s c)))  =
  (bw t (mulMax (bw p a) (bw q (mulMax (bw r b) (bw s c))))) := by
  simp only [bw, mulMax]
  -- fail_if_success bv_multi_width
  sorry

-- BMC
theorem mult_assoc_3' 
  (hppot : ppot &&& (ppot - 1) = 0)
  (hqpot : qpot &&& (qpot - 1) = 0)
  (hrpot : rpot &&& (rpot - 1) = 0)
  (hspot : spot &&& (spot - 1) = 0)
  (htpot : tpot &&& (tpot - 1) = 0)
  (hupot : upot &&& (upot - 1) = 0)
  (hpmask : pmask = ppot - 1)
  (hqmask : qmask = qpot - 1)
  (hrmask : rmask = rpot - 1)
  (hsmask : smask = spot - 1)
  (htmask : tmask = tpot - 1)
  (humask : umask = upot - 1)
  (hq : UnaryLe (unaryAdd rmask smask) qmask) (hu : UnaryGe umask tmask) :
  (bw' tmask 
    (mulMax' 
      (bw' umask 
        (mulMax' (bw' pmask a') pmask (bw' rmask b') rmask))
      umask
      (bw' smask c')
      smask)) =
  (bw' tmask
    (mulMax'
      (bw' pmask a') pmask
      (bw' qmask 
        (mulMax' (bw' rmask b') rmask (bw' smask c') smask))
      qmask)) := by
  simp only [bw', addMax', mulMax', UnaryGe, unaryIncr, unaryMax, unaryAdd, mulMax'Mask, unaryDouble, addMax'Mask, UnaryLe] at *
  induction o using AxBoundedModelCheck 3
  bv_decide

-- PROBLEM
/-
  {
    "name": "mult_assoc_4",
    "preconditions": ["(<= (+ r s) q)", "(<= (+ p r) u)"],
    "lhs": "(bw t ( * (bw u (* (bw p a) (bw r b))) (bw s c)))",
    "rhs": "(bw t ( * (bw p a) (bw q (* (bw r b) (bw s c)))))"
  },
-/


-- end preamble

theorem mult_assoc_4 (hq : (r + s) <= q) (hu : (p + r) <= u) :
  (bw t (mulMax (bw u (mulMax (bw p a) (bw r b))) (bw s c))) =
  (bw t (mulMax (bw p a) (bw q (mulMax (bw r b) (bw s c))))) := by
  simp only [bw, mulMax]
  -- fail_if_success bv_multi_width
  sorry

-- BMC
theorem mult_assoc_4' 
  (hppot : ppot &&& (ppot - 1) = 0)
  (hqpot : qpot &&& (qpot - 1) = 0)
  (hrpot : rpot &&& (rpot - 1) = 0)
  (hspot : spot &&& (spot - 1) = 0)
  (htpot : tpot &&& (tpot - 1) = 0)
  (hupot : upot &&& (upot - 1) = 0)
  (hpmask : pmask = ppot - 1)
  (hqmask : qmask = qpot - 1)
  (hrmask : rmask = rpot - 1)
  (hsmask : smask = spot - 1)
  (htmask : tmask = tpot - 1)
  (humask : umask = upot - 1)
  (hq : UnaryLe (unaryAdd rmask smask) qmask) (hu : UnaryLe (unaryAdd pmask rmask) umask) :
  (bw' tmask 
    (mulMax' 
      (bw' umask 
        (mulMax' (bw' pmask a') pmask (bw' rmask b') rmask))
      umask
      (bw' smask c')
      smask)) =
  (bw' tmask
    (mulMax'
      (bw' pmask a') pmask
      (bw' qmask 
        (mulMax' (bw' rmask b') rmask (bw' smask c') smask))
      qmask)) := by
  simp only [bw', addMax', mulMax', UnaryGe, unaryIncr, unaryMax, unaryAdd, mulMax'Mask, unaryDouble, addMax'Mask, UnaryLe] at *
  induction o using AxBoundedModelCheck 3
  bv_decide

-- PROBLEM
/-
  {
    "name": "mult_sum_same",
    "preconditions": ["(> t p)", "(> t 1)", "(>= s (+ p q))"],
    "lhs": "(bw r (+ (bw s (* (bw p a) (bw q b))) (bw q b)))",
    "rhs": "(bw r (* (bw t (+ (bw p a) (bw 1 1))) (bw q b)))"
  },
-/

-- end preamble

-- TODO
theorem mult_sum_same (htp : t > p) (ht1 : t > 1) (hs : s >= (p + q)) :
  (bw r (addMax (bw s (mulMax (bw p a) (bw q b))) (bw q b)))  =
  (bw r (mulMax (bw t (addMax (bw p a) (bw 1 (1#1)))) (bw q b))) := by
  simp only [bw, mulMax, addMax]
  -- fail_if_success bv_multi_width
  sorry

-- BMC
theorem mult_same_same'
  (hppot : ppot &&& (ppot - 1) = 0)
  (hqpot : qpot &&& (qpot - 1) = 0)
  (hrpot : rpot &&& (rpot - 1) = 0)
  (hspot : spot &&& (spot - 1) = 0)
  (htpot : tpot &&& (tpot - 1) = 0)
  (hupot : upot &&& (upot - 1) = 0)
  (hpmask : pmask = ppot - 1)
  (hqmask : qmask = qpot - 1)
  (hrmask : rmask = rpot - 1)
  (hsmask : smask = spot - 1)
  (htmask : tmask = tpot - 1)
  (humask : umask = upot - 1)
  (htp : UnaryGt tmask pmask) (ht1 : UnaryGt tmask (1#o)) (hs : UnaryGe smask (unaryAdd pmask qmask)) :
  (bw' rmask 
    (addMax' 
      (bw' smask 
        (mulMax' (bw' pmask a') pmask (bw' qmask b') qmask)) 
      smask 
      (bw' qmask b') 
      qmask)) =
  (bw' rmask 
    (mulMax' 
      (bw' tmask 
        (addMax' (bw' pmask a') pmask (bw' (1#o) (1#o)) (1#o))) 
      tmask 
      (bw' qmask b') 
      qmask)) := by
  simp only [UnaryLt, bw', addMax', mulMax', UnaryGe, unaryIncr, unaryMax, unaryAdd, mulMax'Mask, unaryDouble, addMax'Mask, UnaryGt] at *
  induction o using AxBoundedModelCheck 3
  bv_decide



-- PROBLEM
/-
  {
    "name": "one_to_two_mult",
    "preconditions": ["(> q (+ p 2))", "(> q p)"],
    "lhs": "(bw p (* (bw 1 1) (bw p x)))",
    "rhs": "(bw p (- (bw q (* (bw 2 2) (bw p x))) (bw p x)))"
  }
-/


-- end preamble

theorem one_to_two_mult (hq : q > (p + 2)) (hpq : q > p) :
  (bw p (mulMax (bw 1 (1#1)) (bw p a)))  =
  (bw p (subMax (bw q (mulMax (bw 2 (2#2)) (bw p a))) (bw p a))) := by
  simp only [bw, mulMax, subMax]
  -- | TODO: this is solvable once again by width-case-splitting.
  -- fail_if_success bv_multi_width
  sorry

-- BMC
theorem one_to_two_mult' 
  (hppot : ppot &&& (ppot - 1) = 0)
  (hqpot : qpot &&& (qpot - 1) = 0)
  (hrpot : rpot &&& (rpot - 1) = 0)
  (hspot : spot &&& (spot - 1) = 0)
  (htpot : tpot &&& (tpot - 1) = 0)
  (hupot : upot &&& (upot - 1) = 0)
  (hpmask : pmask = ppot - 1)
  (hqmask : qmask = qpot - 1)
  (hrmask : rmask = rpot - 1)
  (hsmask : smask = spot - 1)
  (htmask : tmask = tpot - 1)
  (humask : umask = upot - 1)
  (hq : UnaryGt qmask (unaryAdd pmask (2#o))) (hpq : UnaryGt qmask pmask) :
  (bw' pmask (mulMax' (bw' (1#o) (1#o)) (1#o) (bw' pmask a') pmask)) =
  (bw' pmask 
    (subMax' 
      (bw' qmask 
        (mulMax' (bw' (2#o) (2#o)) (2#o) (bw' pmask a') pmask)) 
      qmask 
      (bw' pmask a') 
      pmask)) := by
  simp only [subMax', subMax'Mask, bw', addMax', mulMax', UnaryGe, unaryIncr, unaryMax, unaryAdd, mulMax'Mask, unaryDouble, addMax'Mask, UnaryGt, subMax'Mask, UnaryLt] at *
  induction o using AxBoundedModelCheck 3
  bv_decide


-- PROBLEM
/-
  {
    "name": "sub_to_neg",
    "preconditions": [],
    "lhs": "(bw r (- (bw p a) (bw q b)))",
    "rhs": "(bw r (+ (bw p a) (- (bw q b))))"
  },
-/

-- end preamble

theorem sub_to_neg :
  (bw r (subMax (bw p a) (bw q b))) =
  (bw r (addMax (bw p a) (- (bw q b)))) := by
  simp only [bw, subMax, addMax]
  simp
  fail_if_success bv_multi_width
  -- should not fail.
  sorry

-- BMC
theorem sub_to_neg'
  (hppot : ppot &&& (ppot - 1) = 0)
  (hqpot : qpot &&& (qpot - 1) = 0)
  (hrpot : rpot &&& (rpot - 1) = 0)
  (hspot : spot &&& (spot - 1) = 0)
  (htpot : tpot &&& (tpot - 1) = 0)
  (hupot : upot &&& (upot - 1) = 0)
  (hpmask : pmask = ppot - 1)
  (hqmask : qmask = qpot - 1)
  (hrmask : rmask = rpot - 1)
  (hsmask : smask = spot - 1)
  (htmask : tmask = tpot - 1)
  (humask : umask = upot - 1) :
  (bw' rmask 
    (subMax' (bw' pmask a') pmask (bw' qmask b') qmask)) =
  (bw' rmask 
    (addMax' 
      (bw' pmask a') pmask 
      (negMax' (bw' qmask b')) qmask)) := by
  simp only [subMax', subMax'Mask, negMax',  bw', addMax', UnaryGe, unaryIncr, unaryMax, unaryAdd, mulMax'Mask, unaryDouble, addMax'Mask] at *
  induction o using AxBoundedModelCheck 3
  -- pmask = 0#3
  -- qmask = 1#3
  -- rmask = 7#3
  -- a' = 7#3
  -- b' = 7#3
  bv_decide

-- PROBLEM
/-
  {
    "name": "sum_same",
    "preconditions": [],
    "lhs": "(bw q (+ (bw p a) (bw p a)))",
    "rhs": "(bw q (* (bw 2 2) (bw p a)))"
  },
-/

-- end preamble

theorem sum_same :
  (bw q (addMax (bw p a) (bw p a)))  =
  (bw q (mulMax (bw 2 (2#2)) (bw p a))) := by
  simp only [bw, addMax, mulMax]
  sorry

-- BMC
theorem sum_same'
  (hppot : ppot &&& (ppot - 1) = 0)
  (hqpot : qpot &&& (qpot - 1) = 0)
  (hrpot : rpot &&& (rpot - 1) = 0)
  (hspot : spot &&& (spot - 1) = 0)
  (htpot : tpot &&& (tpot - 1) = 0)
  (hupot : upot &&& (upot - 1) = 0)
  (hpmask : pmask = ppot - 1)
  (hqmask : qmask = qpot - 1)
  (hrmask : rmask = rpot - 1)
  (hsmask : smask = spot - 1)
  (htmask : tmask = tpot - 1)
  (humask : umask = upot - 1) :
  (bw' qmask (addMax' (bw' pmask a') pmask (bw' pmask a') pmask)) =
  (bw' qmask (mulMax' (bw' (2#o) (2#o)) (2#o) (bw' pmask a') pmask)) := by
  simp only [bw', addMax', mulMax', UnaryGe, unaryIncr, unaryMax, unaryAdd, mulMax'Mask, unaryDouble, addMax'Mask] at *
  induction o using AxBoundedModelCheck 3
  bv_decide

end Rover
end Test
