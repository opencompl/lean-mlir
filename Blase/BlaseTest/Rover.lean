/- We take all the rewrites from ROVER and add them into blase.

### Actionable Insights
- Problems in ROVER than depend on constants have a fixed bitwidth followed
- by a zero-extension, which could benifit from case splitting.
- Abstraction of multiplication could benifit from normalization
  of ac_nf for e.g. `Nat.max` to allow unification.
-/
import Blase
import Blase.SingleWidth.Tactic
namespace Test
namespace Rover

set_option warn.sorry false

def bw (w : Nat) (x : BitVec v) : BitVec w := x.zeroExtend w

def addMax (a : BitVec v) (b : BitVec w) : BitVec (max v w + 1) :=
   a.zeroExtend _ + b.zeroExtend _

def mulMax (a : BitVec v) (b : BitVec w) : BitVec (max v w * 2) :=
   a.zeroExtend _ * b.zeroExtend _

def subMax (a : BitVec v) (b : BitVec w) : BitVec (max v w + 1) :=
   a.zeroExtend _ - b.zeroExtend _

-- TODO: this is a lie anyway, so whatever.
def shlMax (a : BitVec v) (b : BitVec w) : BitVec (max v w) :=
   a.zeroExtend (max v w) <<< b.zeroExtend (max v w)

-- TODO: this is a lie anyway, so whatever.
def shrMax (a : BitVec v) (b : BitVec w) : BitVec (max v w) :=
    a.zeroExtend (max v w) >>> b.zeroExtend (max v w)



variable (w p q r s t u : Nat)
-- variable (a b c : BitVec w)
variable (a : BitVec p)
variable (b : BitVec r)
variable (c : BitVec s)

-- end preamble

@[simp]
theorem signExtend_zero : (0#w).signExtend v = 0#v := by
  apply BitVec.eq_of_toInt_eq
  simp [BitVec.toInt_signExtend]

@[simp]
theorem max_zero (a : Nat) : max a 0 = a := by
  omega

@[simp]
theorem zero_max (a : Nat) : max 0 a = a := by
  omega

-- Note that we need a '+1' in the implement of 'addMax',
-- to ensure that the addition does not overflow.
/-
  {
    "name": "add_assoc_1",
    "preconditions": ["(>= q t)", "(>= u t)"],
    "lhs": "(bw t ( + (bw u (+ (bw p a) (bw r b))) (bw s c)))",
    "rhs": "(bw t ( + (bw p a) (bw q (+ (bw r b) (bw s c)))))"
  },
-/

def bw' (w : BitVec o) (x : BitVec o) : BitVec o := x &&& w

def addMax' (a : BitVec o) (wa : BitVec o) (b : BitVec o) (wb : BitVec o) : BitVec o :=
    (a + b) &&& ((wa ||| wb) <<< 1)

theorem add_assoc_1 (hq : q >= t) (hu : u >= t) :
  (bw t (addMax (bw u (addMax (bw p a) (bw r b))) (bw s c))) =
  (bw t (addMax (bw p a) (bw q (addMax (bw r b) (bw s c))))) := by
  simp only [bw, addMax] at *
  -- bv_multi_width -check? (niter := 30)
  sorry

theorem add_assoc_1' (o : Nat)
  (pmask : BitVec o)
  (qmask : BitVec o)
  (rmask : BitVec o)
  (smask : BitVec o)
  (tmask : BitVec o)
  (umask : BitVec o)
  (wmask : BitVec o)
  (hwmask : wmask &&& (wmask - 1) = 0) 
  (hpmask : pmask &&& (pmask - 1) = 0)
  (hqmask : qmask &&& (qmask - 1) = 0)
  (hrmask : rmask &&& (rmask - 1) = 0)
  (hsmask : smask &&& (smask - 1) = 0)
  (htmask : tmask &&& (tmask - 1) = 0)
  (humask : umask &&& (umask - 1) = 0)
  (a' : BitVec o) (b' : BitVec o) (c' : BitVec o) :
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
  simp only [bw', addMax'] at *
  bv_automata_classic
  -- bv_multi_width -check? (niter := 30)
  -- sorry
#print axioms add_assoc_1'

#exit

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
  -- bv_multi_width -check? (niter := 30)
  sorry 

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
  -- bv_multi_width -check? (niter := 30)
  sorry

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
  -- bv_multi_width -check? (niter := 30)
  sorry 

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

theorem add_right_shift (hq : q >= t) (hs : s >= p + (2 ^ u - 1)) (hv_s : v > s) (hv_t : v > t) :
  (bw r (addMax (bw p a) (bw q (shrMax (bw t b) (bw u c)))))  =
  (bw r (shrMax (bw v (addMax (bw s (shlMax (bw p a) (bw u c))) (bw t b))) (bw u c))) := by
   simp only [bw, addMax, shrMax, shlMax]
   -- fail_if_success bv_multi_width
   sorry 

/-
  {
    "name": "add_zero",
    "preconditions": [],
    "lhs": "(bw p (+ (bw p a) (bw q 0)))",
    "rhs": "(bw p a)"
  },
-/

-- end preamble

-- SHOULDPASS, ADD
theorem add_zero :
    (bw p (addMax (bw p a) (bw q (0#1))))  =
    (bw p a) := by
  simp only [bw, addMax]
  fail_if_success bv_multi_width -check? (niter := 1) -- ofBool crap
  sorry

/-
{
  "name": "commutativity_add",
  "preconditions": [],
  "lhs": "(bw r ( + (bw p a) (bw q b)))",
  "rhs": "(bw r ( + (bw q b) (bw p a)))"
},
-/

-- end preamble

-- SHOULDPASS, ADD
theorem commutativity_add :
      bw r (addMax (bw p a) (bw q b))  = bw r (addMax (bw q b) (bw p a)) := by
  simp only [bw, addMax]
  bv_multi_width -check? (niter := 30)

/-
  {
    "name": "commutativity_mult",
    "preconditions": [],
    "lhs": "(bw r ( * (bw p a) (bw q b)))",
    "rhs": "(bw r ( * (bw q b) (bw p a)))"
  },
-/

-- end preamble

-- MAYPASS, MULT, CANONICALIZE
theorem commutativity_mult :
      bw r (mulMax (bw p a) (bw q b))  = bw r (mulMax (bw q b) (bw p a)) := by
  simp only [bw, mulMax]
  -- TODO: normalize 'max' by ac_nf.
  fail_if_success bv_multi_width -check? (niter := 5)
  sorry

/-
  {
    "name": "dist_over_add",
    "preconditions": ["(>= q r)", "(>= u r)", "(>= v r)"],
    "lhs": "(bw r (* (bw p a) (+ (bw s b) (bw t c))))",
    "rhs": "(bw r (+ (bw u (* (bw p a) (bw s b))) (bw v (* (bw p a) (bw t c)) ) ))"
  },
-/

-- end preamble

-- MAYPASS, MULT, ADD
theorem dist_over_add (hq : q >= r) (hu : u >= r) (hv : v >= r) :
  (bw r (mulMax (bw p a) (addMax (bw s b) (bw t c))))  =
  (bw r (addMax (bw u (mulMax (bw p a) (bw s b))) (bw v (mulMax (bw p a) (bw t c))))) := by
    simp only [bw, addMax, mulMax]
    -- TODO: push zext into add, distribute mul.
    -- fail_if_success bv_multi_width
    sorry

/-
  {
    "name": "left_shift_add_1",
    "preconditions": ["(>= u r)", "(>= s r)"],
    "lhs": "(bw r (<< (bw s (+ (bw p a) (bw q b))) (bw t c)))",
    "rhs": "(bw r (+ (bw u (<< (bw p a) (bw t c))) (bw u (<< (bw q b) (bw t c)))))"
  },
-/

-- end preamble

-- NOPASS
theorem left_shift_add_1 (hu : u >= r) (hs : s >= r) :
  (bw r (shlMax (bw s (addMax (bw p a) (bw q b))) (bw t c)))  =
  (bw r (addMax (bw u (shlMax (bw p a) (bw t c))) (bw u (shlMax (bw q b) (bw t c))))) := by
   simp only [bw, addMax, shlMax]
   -- fail_if_success bv_multi_width
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

-- NOPASS
theorem left_shift_add_2 (hu : u >= r) (hs : s > p) (hsq : s > q) :
  (bw r (shlMax (bw s (addMax (bw p a) (bw q b))) (bw t c)))  =
  (bw r (addMax (bw u (shlMax (bw p a) (bw t c))) (bw u (shlMax (bw q b) (bw t c))))) := by
   simp only [bw, addMax, shlMax]
   -- fail_if_success bv_multi_width
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

-- NOPASS
theorem left_shift_mult (ht : t >= r) (hv : v >= r) :
  (bw r (shlMax (bw t (mulMax (bw p a) (bw q b))) (bw u c)))  =
  (bw r (mulMax (bw v (shlMax (bw p a) (bw u c))) (bw q b))) := by
   simp only [bw, mulMax, shlMax]
   -- fail_if_success bv_multi_width
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

-- NOPASS
theorem merge_left_shift (hu : u >= r) (hts : t > s) (htq : t > q) :
  (bw r (shlMax (bw u (shlMax (bw p a) (bw q b))) (bw s c)))  =
  (bw r (shlMax (bw p a) (bw t (addMax (bw q b) (bw s c))))) := by
   simp only [bw, addMax, shlMax]
   -- fail_if_success bv_multi_width
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

-- NOPASS
theorem merge_right_shift (hu : u >= p) (hts : t > s) (htq : t > q) :
  (bw r (shrMax (bw u (shrMax (bw p a) (bw q b))) (bw s c)))  =
  (bw r (shrMax (bw p a) (bw t (addMax (bw q b) (bw s c))))) := by
   simp only [bw, addMax, shrMax]
   -- fail_if_success bv_multi_width
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

-- SHOULDPASS, MULT
theorem mul_one :
  (bw p (mulMax (bw p a) (bw q (1#1))))  =
  (bw p a) := by
   simp only [bw, mulMax]
   -- fail_if_success bv_multi_width
   sorry

/-
  {
    "name": "mul_two",
    "preconditions": [],
    "lhs": "(bw r (* (bw p a) 2))",
    "rhs": "(bw r (<< (bw p a) 1))"
  },
-/

-- end preamble

-- SHOULDPASS, MULT
theorem mul_two :
  (bw r (mulMax (bw p a) (bw 2 (2#2))))  =
  (bw r ((bw p a) <<< 1)) := by
   simp only [bw, mulMax]
   -- | TODO: can be solved by further preprocessing: we have (max p 2), so we
   -- can case split until we remove the '2'.
   -- fail_if_success bv_multi_width
   sorry

/-
{
  "name": "mult_assoc_1",
  "preconditions": ["(>= q t)", "(>= u t)"],
  "lhs": "(bw t ( * (bw u (* (bw p a) (bw r b))) (bw s c)))",
  "rhs": "(bw t ( * (bw p a) (bw q (* (bw r b) (bw s c)))))"
},
-/


-- NOPASS
theorem mult_assoc_1 (hq : q >= t) (hu : u >= t) :
  (bw t (mulMax (bw u (mulMax (bw p a) (bw r b))) (bw s c))) =
  (bw t (mulMax (bw p a) (bw q (mulMax (bw r b) (bw s c))))) := by
   simp only [bw, mulMax]
   fail_if_success bv_multi_width
   sorry

/-
  {
    "name": "mult_assoc_2",
    "preconditions": ["(>= q t)", "(<= (+ p r) u)"],
    "lhs": "(bw t ( * (bw u (* (bw p a) (bw r b))) (bw s c)))",
    "rhs": "(bw t ( * (bw p a) (bw q (* (bw r b) (bw s c)))))"
  },
-/

-- end preamble

-- NOPASS
theorem mult_assoc_2 (hq : q >= t) (hu : (p + r) <= u) :
  (bw t (mulMax (bw u (mulMax (bw p a) (bw r b))) (bw s c)))  =
  (bw t (mulMax (bw p a) (bw q (mulMax (bw r b) (bw s c))))) := by
  simp only [bw, mulMax]
  -- fail_if_success bv_multi_width
  sorry
/-
  {
    "name": "mult_assoc_3",
    "preconditions": ["(<= (+ r s) q)", "(>= u t)"],
    "lhs": "(bw t ( * (bw u (* (bw p a) (bw r b))) (bw s c)))",
    "rhs": "(bw t ( * (bw p a) (bw q (* (bw r b) (bw s c)))))"
  },
-/

-- end preamble

-- NOPASS
theorem mult_assoc_3 (hq : (r + s) <= q) (hu : u >= t) :
  (bw t (mulMax (bw u (mulMax (bw p a) (bw r b))) (bw s c)))  =
  (bw t (mulMax (bw p a) (bw q (mulMax (bw r b) (bw s c))))) := by
  simp only [bw, mulMax]
  -- fail_if_success bv_multi_width
  sorry

/-
  {
    "name": "mult_assoc_4",
    "preconditions": ["(<= (+ r s) q)", "(<= (+ p r) u)"],
    "lhs": "(bw t ( * (bw u (* (bw p a) (bw r b))) (bw s c)))",
    "rhs": "(bw t ( * (bw p a) (bw q (* (bw r b) (bw s c)))))"
  },
-/


-- end preamble

-- NOPASS
theorem mult_assoc_4 (hq : (r + s) <= q) (hu : (p + r) <= u) :
  (bw t (mulMax (bw u (mulMax (bw p a) (bw r b))) (bw s c))) =
  (bw t (mulMax (bw p a) (bw q (mulMax (bw r b) (bw s c))))) := by
  simp only [bw, mulMax]
  -- fail_if_success bv_multi_width
  sorry

/-
  {
    "name": "mult_sum_same",
    "preconditions": ["(> t p)", "(> t 1)", "(>= s (+ p q))"],
    "lhs": "(bw r (+ (bw s (* (bw p a) (bw q b))) (bw q b)))",
    "rhs": "(bw r (* (bw t (+ (bw p a) (bw 1 1))) (bw q b)))"
  },
-/

-- end preamble

-- NOPASS
theorem mult_sum_same (htp : t > p) (ht1 : t > 1) (hs : s >= (p + q)) :
  (bw r (addMax (bw s (mulMax (bw p a) (bw q b))) (bw q b)))  =
  (bw r (mulMax (bw t (addMax (bw p a) (bw 1 (1#1)))) (bw q b))) := by
  simp only [bw, mulMax, addMax]
  -- fail_if_success bv_multi_width
  sorry

/-
  {
    "name": "one_to_two_mult",
    "preconditions": ["(> q (+ p 2))", "(> q p)"],
    "lhs": "(bw p (* (bw 1 1) (bw p x)))",
    "rhs": "(bw p (- (bw q (* (bw 2 2) (bw p x))) (bw p x)))"
  }
-/


-- end preamble

-- MAYPASS
theorem one_to_two_mult (hq : q > (p + 2)) (hpq : q > p) :
  (bw p (mulMax (bw 1 (1#1)) (bw p a)))  =
  (bw p (subMax (bw q (mulMax (bw 2 (2#2)) (bw p a))) (bw p a))) := by
  simp only [bw, mulMax, subMax]
  -- | TODO: this is solvable once again by width-case-splitting.
  -- fail_if_success bv_multi_width
  sorry

/-
  {
    "name": "sub_to_neg",
    "preconditions": [],
    "lhs": "(bw r (- (bw p a) (bw q b)))",
    "rhs": "(bw r (+ (bw p a) (- (bw q b))))"
  },
-/

-- end preamble
-- SHOULDPASS
theorem sub_to_neg :
  (bw r (subMax (bw p a) (bw q b)))  =
  (bw r (addMax (bw p a) (- (bw q b)))) := by
  simp only [bw, subMax, addMax]
  -- TODO: should not fail.
  fail_if_success bv_multi_width +verbose? (niter := 2)
  sorry

/-
  {
    "name": "sum_same",
    "preconditions": [],
    "lhs": "(bw q (+ (bw p a) (bw p a)))",
    "rhs": "(bw q (* (bw 2 2) (bw p a)))"
  },
-/

-- end preamble

-- SHOULDPASS: CONSTMUL, ADD
theorem sum_same :
  (bw q (addMax (bw p a) (bw p a)))  =
  (bw q (mulMax (bw 2 (2#2)) (bw p a))) := by
  simp only [bw, addMax, mulMax]
  -- fail_if_success bv_multi_width
  sorry

end Rover
end Test
