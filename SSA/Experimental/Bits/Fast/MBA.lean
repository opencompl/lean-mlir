import SSA.Experimental.Bits.Fast.Attr
import Lean
import Lean.ToExpr

@[simp]
theorem BitVec.zero_concat (b : Bool) : (0#0).concat b = BitVec.ofBool b := by
  apply BitVec.eq_of_getLsbD_eq
  simp

@[simp]
theorem BitVec.intCast_eq_ofInt : ((i : Int) : BitVec w) = BitVec.ofInt w i := rfl

@[simp]
theorem BitVec.intCast_zero : ((0 : Int) : BitVec w) = 0#w := by simp

namespace MBA

inductive Factor
| var (n : Nat)
| and (x y : Factor)
| or (x y : Factor)
| xor (x y : Factor)
| not (x : Factor)
deriving Repr

def Factor.numVars : Factor → Nat
| .var n => n+1
| .and x y | .or x y | xor x y => max (x.numVars) (y.numVars)
| .not x => x.numVars

open Lean Elab Meta in
def Factor.toExpr (f : Factor) : Expr :=
  match f with
  | .var i => mkApp (mkConst ``Factor.var) (mkNatLit i)
  | .xor i j => mkApp2 (mkConst ``Factor.xor) i.toExpr j.toExpr
  | .and i j => mkApp2 (mkConst ``Factor.and) i.toExpr j.toExpr
  | .or i j => mkApp2 (mkConst ``Factor.or) i.toExpr j.toExpr
  | .not x => mkApp (mkConst ``Factor.not) x.toExpr

open Lean in
instance : ToExpr Factor where
  toExpr := Factor.toExpr
  toTypeExpr := mkConst ``Factor


@[simp]
theorem Factor.numVars_term : (Factor.var n).numVars = n + 1 := rfl

abbrev Env (w : Nat) := List (BitVec w)
def Env.getLsb {w : Nat} (env : Env (w + 1)) : Env 1 := env.map <| fun x => BitVec.ofBool <| x.getLsbD 0
def Env.getNonLsbs {w : Nat} (env : Env (w + 1)) : Env w := env.map <| fun x => x.extractLsb' 1 w

@[simp]
theorem Env.getLsb_getElem {env : Env (w + 1)} (n : Nat) :
    (Env.getLsb env)[n]? = (env[n]?).map (fun (x : BitVec (w + 1)) => BitVec.ofBool (x.getLsbD 0)) := by
  simp [Env.getLsb]

def Factor.reflect {w : Nat} (xs : Env w) : Factor → BitVec w
| .var n => xs[n]?.getD (0#w)
| .and x y => x.reflect xs &&& y.reflect xs
| .or x y => x.reflect xs ||| y.reflect xs
| .xor x y => x.reflect xs ^^^ y.reflect xs
| .not x => ~~~ (x.reflect xs)

def Factor.denote {w : Nat} (xs : Env w) (f : Factor) : Nat := f.reflect xs |>.toNat


theorem Factor.denote_eq_toNat_reflect {w : Nat} (xs : Env w) (f : Factor) :
  f.denote xs = (f.reflect xs |>.toNat) := rfl

/--
Environment of *finite* size, which can agree with the `Factor.reflect`.
We need `Factor.reflectFin` to show that our brute-force evaluation for length 1 has a finite environment size for exhaustive enumeration,
We need `Factor.reflect` to def-eq-unify with the user's given goal state.
We show their equivalence to allow us to decide on `denoteFin`, and to use this when proving facts about `denote`.
-/
def EnvFin (w : Nat) (n : Nat) := Fin n → (BitVec w)
def EnvFin.getLsb {w : Nat} (env : EnvFin (w + 1) n) : EnvFin 1 n := fun n => BitVec.ofBool <| (env n).getLsbD 0
def EnvFin.getNonLsbs {w : Nat} (env : EnvFin (w + 1) n) : EnvFin w n := fun n => (env n).extractLsb' 1 w

/-- Using 'env.getLsb' shortens all bitvectors to be one-bit, and so calling 'getLsbD' on this environment will only return the lowest bit if available -/
@[simp]
theorem EnvFin.getLsbD_getLsb {w : Nat} (env : EnvFin (w + 1) n) (bit : Nat) : (env.getLsb i).getLsbD bit =
    if bit = 0 then (env i).getLsbD 0 else false := by
  rcases bit with rfl | bit
  · simp [EnvFin.getLsb]
  · simp

def EnvFin.castLe {w n n' : Nat} (env : EnvFin w n) (h : n' ≤ n) : EnvFin w n' :=
  fun i' => env ⟨i', by omega⟩

@[simp]
def EnvFin.get_castLe {w n n' : Nat} (env : EnvFin w n) (h : n' ≤ n) (i : Fin n') :
  (env.castLe h) i = env ⟨i, by omega⟩ := rfl

/-- Map a function from `Fin n'` to `Fin n` on the index set of `EnvFin`. -/
def EnvFin.comap {w n n' : Nat} (env : EnvFin w n) (f : Fin n' → Fin n) : EnvFin w n' :=
  fun i' => env (f i')

@[simp]
theorem EnvFin.get_comap (env : EnvFin w n) (f : Fin n' → Fin n) (i : Fin n') :
  (env.comap f) i = env (f i) := rfl

/--
Cons a value 'b' onto the env, which obeys the equations:
- `(cons env b) 0 = b`,
- `(cons env b) i.succ = env i`
-/
def EnvFin.cons (env : EnvFin w n) (b : BitVec w) : EnvFin w (n + 1) :=
  fun i => i.cases b env

@[simp]
theorem EnvFin.cons_zero (env : EnvFin w n) (b : BitVec w) :
  (env.cons b) 0 = b := rfl

-- TODO: write theorems about `cons`.
@[simp]
theorem EnvFin.cons_succ (env : EnvFin w n) (b : BitVec w) (i : Fin n) :
  (env.cons b) i.succ = env i := rfl

/--
Using 'env.getNonLsbs' peels off the bits from index 'i+1' to 'w'.
-/
@[simp]
theorem EnvFin.getLsbD_getNonLsbs {w : Nat} (env : EnvFin (w + 1) n) (bit : Nat) :
    (env.getNonLsbs i).getLsbD bit = (decide (bit < w) && (env i).getLsbD (bit + 1)) := by
  simp [EnvFin.getNonLsbs]
  by_cases h : bit < w
  · simp [h, show 1 + bit = bit + 1 by omega]
  · simp [h]

def Factor.reflectFin {w : Nat} (f : Factor) (xs : EnvFin w f.numVars) : BitVec w :=
  match f with
  | .var n => xs ⟨n, by simp⟩
  | .and x y =>
    x.reflectFin (fun n => xs ⟨n, by simp [numVars]; omega⟩) &&& y.reflectFin (fun n => xs ⟨n, by simp [numVars]; omega⟩)
  | .or x y =>
     x.reflectFin (fun n => xs ⟨n, by simp [numVars]; omega⟩) ||| y.reflectFin (fun n => xs ⟨n, by simp [numVars]; omega⟩)
  | .xor x y =>
     x.reflectFin (fun n => xs ⟨n, by simp [numVars]; omega⟩) ^^^ y.reflectFin (fun n => xs ⟨n, by simp [numVars]; omega⟩)
  | .not x =>
     ~~~ x.reflectFin (fun n => xs ⟨n, by simp [numVars]⟩)


/-- Show that reflect and reflectFin agree in their values -/
theorem Factor.reflect_eq_reflectFin {f : Factor} {xs : List (BitVec w)} {xsFin : EnvFin w f.numVars}
    (h : ∀ (i : Fin f.numVars), xs[i]?.getD 0#w = xsFin i) :
    f.reflect xs = f.reflectFin xsFin := by
  induction f
  case var n => simp [reflect, reflectFin] at h ⊢; rw[← h]
  case and x y hx hy =>
    simp [reflect, reflectFin] at h ⊢
    rw[← hx, ← hy]
    · intros i
      simp [← h]
    · intros i
      simp [← h]
  case or x y hx hy =>
    simp [reflect, reflectFin] at h ⊢
    rw[← hx, ← hy]
    · intros i
      simp [← h]
    · intros i
      simp [← h]
  case xor x y hx hy =>
    simp [reflect, reflectFin] at h ⊢
    rw[← hx, ← hy]
    · intros i
      simp [← h]
    · intros i
      simp [← h]
  case not x hx =>
    simp [reflect, reflectFin] at h ⊢
    rw[← hx]
    · intros i
      simp [← h]

def Factor.denoteFin {w : Nat} (f : Factor) (xs : EnvFin w f.numVars) : Nat := f.reflectFin xs |>.toNat

theorem Factor.denoteFin_eq_toNat_reflectFin (f : Factor) (xs : EnvFin w f.numVars) :
  f.denoteFin xs = (f.reflectFin xs).toNat := rfl

/-- Show that 'denote'  agrees with 'denoteFin' -/
theorem Factor.denoteFin_eq_denote {f : Factor} {xs : List (BitVec w)} {xsFin : EnvFin w f.numVars}
    (h : ∀ (i : Fin f.numVars), xs[i]?.getD 0#w = xsFin i) :
    f.denoteFin xsFin = f.denote xs := by
  rw [Factor.denote, Factor.denoteFin, Factor.reflect_eq_reflectFin h]

theorem Factor.reflect_eq_ofInt_denote {w : Nat} (xs : Env w) (f : Factor) :
    f.reflect xs = (BitVec.ofInt w <| f.denote xs) := by
  simp [reflect, denote]

@[simp]
theorem Factor.reflect_zero_of_denote_zero {w : Nat} {f : Factor} {xs : Env w} (h : f.denote xs = 0) :
    f.reflect xs = 0#w := by
  simp [reflect_eq_ofInt_denote, h]

@[simp]
theorem Factor.reflect_width_zero  (f : Factor) (env : Env 0) : f.reflect env = 0#0 := by
  apply Subsingleton.elim

@[simp]
theorem Factor.denote_width_zero  (f : Factor) (env : Env 0) : f.denote env = 0 := by
  simp [denote]

@[simp]
theorem Factor.reflectFin_width_zero  (f : Factor) (env : EnvFin 0 f.numVars) : f.reflectFin env = 0#0 := by
  apply Subsingleton.elim

/--
The value of 'x.reflectFin env' can be computed from using
'(x.reflectFin env.getlsb)' and '(x.reflectFin env.getNonLsbs)'.
-/
theorem Factor.getLsb_reflectFin_eq_or_reflectFin_getLsb_reflectFin_getNonLsbs
    {w : Nat} {x : Factor} {env : EnvFin (w +1) x.numVars} :
    (x.reflectFin env).getLsbD i = if i = 0 then ((x.reflectFin env.getLsb).getLsbD 0) else (x.reflectFin env.getNonLsbs).getLsbD (i - 1) := by
  rcases i with rfl | i
  · simp
    induction x
    case var n =>
      simp [reflectFin]
    case and x y hx hy =>
      simp [reflectFin]
      simp [hx, hy]
      rfl
    case or x y hx hy =>
      simp [reflectFin]
      simp [hx, hy]
      rfl
    case xor x y hx hy =>
      simp only [reflectFin, BitVec.getLsbD_xor]
      simp only [hx, hy]
      rfl
    case not x hx  =>
      simp only [reflectFin, BitVec.getLsbD_not]
      simp [hx]
  · simp
    induction x
    case var n =>
      simp [reflectFin]
      intros h
      apply Classical.byContradiction
      intros hcontra
      simp at hcontra
      have := BitVec.getLsbD_ge (env ⟨n, by simp⟩) (i + 1) (by omega)
      simp [this] at h
    case and x y hx hy =>
      simp [reflectFin]
      simp [hx, hy]
      rfl
    case or x y hx hy =>
      simp [reflectFin]
      simp [hx, hy]
      rfl
    case xor x y hx hy =>
      simp only [reflectFin, BitVec.getLsbD_xor]
      simp only [hx, hy]
      rfl
    case not x hx  =>
      simp only [reflectFin, BitVec.getLsbD_not]
      simp [hx]

theorem Factor.reflectFin_eq_reflectFin_getLsb_reflectFin_getNonLsbs
    {w : Nat} {x : Factor} {env : EnvFin (w +1) x.numVars} :
    (x.reflectFin env) = (x.reflectFin env.getNonLsbs).concat ((x.reflectFin env.getLsb).getLsbD 0) := by
  apply BitVec.eq_of_getLsbD_eq
  intros i hi
  conv =>
    lhs
    rw [getLsb_reflectFin_eq_or_reflectFin_getLsb_reflectFin_getNonLsbs]
  rw [BitVec.getLsbD_concat]


/-- Build an 'EnvFin' from 'Env' -/
def EnvFin.ofEnv (env : Env w) (n : Nat) : EnvFin w n :=
  fun i => env.getD i 0#w

/-- Build an Env from an 'EnvFin' -/
def Env.ofEnvFin (envFin : EnvFin w n) : Env w := (List.finRange n).map envFin

@[simp]
theorem Env.length_ofEnvFin (envFin : EnvFin w n) :
  List.length (Env.ofEnvFin envFin) = n := by simp [ofEnvFin]

@[simp]
def EnvFin.get_ofEnv (env : Env w) (n : Nat) (i : Fin n) : (EnvFin.ofEnv env n) i = env.getD i 0#w := rfl

@[simp]
def Env.get_ofEnvFin (envFin : EnvFin w n) (i : Fin n) :
    (Env.ofEnvFin envFin)[i] = envFin i := by simp [ofEnvFin]

@[simp]
def Env.getElem_ofEnvFin (envFin : EnvFin w n) (i : Nat) (h : i < n) :
    (Env.ofEnvFin envFin)[i]'(by simp [Env.length_ofEnvFin, h]) = envFin ⟨i, by omega⟩ :=
  by simp [ofEnvFin]


@[simp]
def Env.getD_getElem?_ofEnvFin (envFin : EnvFin w n) (i : Nat) :
    (Env.ofEnvFin envFin)[i]?.getD (0#w) = if h : i < n then envFin ⟨i, h⟩ else 0#w := by
  rw [List.getD_getElem?]
  by_cases h : i < n  <;> simp [h]

theorem Factor.denote_eq_toNat_reflectFin {w : Nat} (xs : Env w) (f : Factor) :
    f.denote xs = (f.reflectFin (EnvFin.ofEnv xs _)).toNat := by
  rw [Factor.denote_eq_toNat_reflect]
  rw [reflect_eq_reflectFin]
  simp

theorem Factor.reflectFin_toNat_eq_add
    {w : Nat} {x : Factor} {env : EnvFin (w +1) x.numVars} :
    (x.reflectFin env).toNat = 2 * (x.reflectFin env.getNonLsbs).toNat + ((x.reflectFin env.getLsb).getLsbD 0).toNat := by
  rw [Factor.reflectFin_eq_reflectFin_getLsb_reflectFin_getNonLsbs]
  simp
  rw [Nat.mul_comm]


/-- Split a denote at an env intoa denote at the LSB and the denote at the non-Lsbs -/
theorem Factor.denoteFin_eq_add {w : Nat} (x : Factor) (env : EnvFin (w + 1) x.numVars) :
    x.denoteFin env = 2 * x.denoteFin env.getNonLsbs + x.denoteFin env.getLsb := by
  rw [Factor.denoteFin_eq_toNat_reflectFin]
  rw [Factor.denoteFin_eq_toNat_reflectFin]
  rw [Factor.denoteFin_eq_toNat_reflectFin]
  rw [Factor.reflectFin_toNat_eq_add]
  simp
  generalize (x.reflectFin env.getLsb) = bv
  revert bv
  decide


structure Term where
  c : Int
  f : Factor
deriving Repr

open Lean Elab Meta in
def Term.toExpr (t : Term) : Expr :=
  mkApp2 (mkConst ``Term.mk) (ToExpr.toExpr t.c) (t.f.toExpr)

open Lean in
instance : ToExpr Term where
  toExpr := Term.toExpr
  toTypeExpr := mkConst ``Term

def Term.numVars (t : Term) : Nat := t.f.numVars

/-- Reflect is what we use for reflection -/
def Term.reflect {w : Nat}  (t : Term) (xs: Env w) : BitVec w :=
  (BitVec.ofInt w t.c) * t.f.reflect xs

def Term.denote {w : Nat} (t : Term) (xs : Env w) : Int :=
  t.c * t.f.denote xs

def Term.denoteFin {w : Nat} (t : Term) (xs : EnvFin w t.numVars) : Int :=
  t.c * t.f.denoteFin xs

/-- Split a denote at an env intoa denote at the LSB and the denote at the non-Lsbs -/
theorem Term.denoteFin_eq_add {w : Nat} (t : Term) (env : EnvFin (w + 1) t.numVars) :
    t.denoteFin env = 2 * t.denoteFin env.getNonLsbs + t.denoteFin env.getLsb := by
  rw [Term.denoteFin]
  rw [Factor.denoteFin_eq_add]
  rw [Term.denoteFin]
  rw [Term.denoteFin]
  simp only [Int.natCast_add, Int.natCast_mul, Int.Nat.cast_ofNat_Int]
  rw [Int.mul_add]
  ac_nf

theorem Term.denoteFin_eq_denote {t : Term} {xs : List (BitVec w)} {xsFin : EnvFin w t.numVars} (h : ∀ (i : Fin t.numVars), xs[i]?.getD 0#w = xsFin i) :
    t.denoteFin xsFin = t.denote xs := by
  simp [Term.denoteFin, Term.denote, Factor.denoteFin_eq_denote h]

@[simp]
theorem Term.reflect_eq_ofInt_denote {w : Nat} {t : Term} {xs : Env w} :
    t.reflect xs = (BitVec.ofInt w <| t.denote xs) := by
  obtain ⟨c, f⟩ := t
  simp [Term.reflect, Term.denote]
  rw [BitVec.ofInt_mul]
  rw [Factor.reflect_eq_ofInt_denote]

@[simp]
theorem Term.reflect_zero_of_denote_zero {w : Nat} {t : Term} {xs : Env w} (h : t.denote xs = 0) :
    t.reflect xs = 0#w := by
  simp [Term.reflect_eq_ofInt_denote, h]

@[simp]
theorem Term.reflect_width_zero  (t : Term) (env : Env 0) :
    t.reflect env = 0 := by simp [Term.reflect]

@[simp]
theorem Term.denote_width_zero  (t : Term) (env : Env 0) :
    t.denote env = 0 := by simp [Term.denote]

@[simp]
theorem Term.denoteFin_width_zero  (t : Term) (env : EnvFin 0 t.numVars) :
    t.denoteFin env = 0 := by simp [Term.denoteFin, Factor.denoteFin]

def Eqn := List Term

instance : Repr Eqn := inferInstanceAs (Repr (List Term))

open Lean in
def Eqn.toExpr (e : Eqn) : Expr := ToExpr.toExpr (α := List Term) e

open Lean in
instance : ToExpr Eqn where
  toExpr := Eqn.toExpr
  toTypeExpr := mkConst ``Eqn

open Lean in
instance : ToExpr Term where
  toExpr := Term.toExpr
  toTypeExpr := mkConst ``Term

def Eqn.numVars (e : Eqn) : Nat :=
  match e with
  | [] => 0
  | e :: es => max e.numVars (Eqn.numVars es)

@[simp]
theorem Eqn.numVars_nil : Eqn.numVars [] = 0 := rfl

@[simp]
theorem Eqn.numVars_cons : Eqn.numVars (t :: es) = max t.numVars (Eqn.numVars es) := rfl

def Eqn.reflect {w : Nat} (e : Eqn) (env : Env w) : BitVec w :=
  match e with
  | [] => 0
  | t :: [] => t.reflect env
  | t :: ts => t.reflect env + Eqn.reflect ts env


@[simp]
theorem Eqn.reflect_nil  {w : Nat} (env : Env w) :
    Eqn.reflect [] env = 0 := rfl

@[simp]
theorem Eqn.reflect_cons {w : Nat}
    (t : Term) (ts : List Term) (env : Env w) :
    Eqn.reflect (t :: ts) env = t.reflect env + Eqn.reflect ts env := by
  rcases ts with t | ts
  simp [reflect]
  simp [reflect]


def Eqn.denote {w : Nat} (e : Eqn) (env : Env w) : Int :=
  match e with
  | [] => 0
  | t :: ts => t.denote env + Eqn.denote ts env

@[simp]
theorem Eqn.denote_nil  {w : Nat} (env : Env w) :
    Eqn.denote [] env = 0 := rfl

@[simp]
theorem Eqn.denote_cons {w : Nat}
    (t : Term) (ts : List Term) (env : Env w) :
    Eqn.denote (t :: ts) env = t.denote env + Eqn.denote ts env := rfl

def Eqn.denoteFin {w : Nat} (e : Eqn) (envFin : EnvFin w e.numVars) : Int :=
  match e with
  | [] => 0
  | t :: ts =>
    t.denoteFin (envFin.castLe (by simp; omega)) +
    Eqn.denoteFin ts (envFin.castLe (by simp; omega))

@[simp]
theorem Eqn.denoteFin_nil {w : Nat} (envFin : EnvFin w 0) :
  Eqn.denoteFin [] envFin = 0 := rfl

@[simp]
theorem Eqn.denoteFin_cons {w : Nat} (t : Term) (eqn : Eqn)
    (envFin : EnvFin w (max t.numVars  eqn.numVars)) :
  Eqn.denoteFin (t :: eqn) envFin =
  t.denoteFin (envFin.castLe (by omega)) +
  Eqn.denoteFin eqn (envFin.castLe (by omega)) := rfl

theorem Eqn.denoteFin_eq_add {w : Nat} (eqn : Eqn) (env : EnvFin (w + 1) eqn.numVars) :
    eqn.denoteFin env = 2 * eqn.denoteFin env.getNonLsbs + eqn.denoteFin env.getLsb := by
  induction eqn
  case nil => simp [denoteFin]
  case cons x xs ih =>
    simp only [denoteFin]
    simp only [ih]
    rw [Term.denoteFin_eq_add x]
    rw [Int.mul_add]
    ac_nf

/-- To evaluate `e.denote`, one can equally well evaluate `e.denoteFin` -/
theorem Eqn.denoteFin_eq_denote {e : Eqn} {xs : List (BitVec w)} {xsFin : EnvFin w e.numVars}
    (h : ∀ (i : Fin e.numVars), xs[i]?.getD 0#w = xsFin i) :
    e.denoteFin xsFin = e.denote xs := by
  induction e
  case nil => simp [Eqn.denoteFin]
  case cons t es ih =>
    simp
    rw [ih]
    · congr
      apply Term.denoteFin_eq_denote
      intros i
      specialize h ⟨i, by simp; omega⟩
      assumption
    · intros i
      specialize h ⟨i, by simp; omega⟩
      assumption

@[simp]
theorem Eqn.reflect_width_zero  (es : Eqn) (env : Env 0) :
    Eqn.reflect es env = 0 := by
  induction es
  case nil => simp [Eqn.reflect]
  case cons e es ih =>
    simp [ih, Eqn.reflect]


@[simp]
theorem Eqn.denote_width_zero  (es : Eqn) (env : Env 0) :
    Eqn.denote es env = 0 := by
  induction es
  case nil => simp [Eqn.denote]
  case cons e es ih =>
    simp [ih, Eqn.denote]

@[simp]
theorem Eqn.denoteFin_width_zero  (es : Eqn) (env : EnvFin 0 es.numVars) :
    Eqn.denoteFin es env = 0 := by
  induction es
  case nil => simp [Eqn.denoteFin]
  case cons e es ih =>
    simp [ih, Eqn.denoteFin]

@[simp]
theorem Eqn.reflect_eq_ofInt_denote {w : Nat} (xs : Env w) (e : Eqn) :
    e.reflect xs = BitVec.ofInt w (e.denote xs) := by
  induction e
  case nil => simp
  case cons t ts ih =>
    simp
    simp [BitVec.ofInt_add, ih]
@[simp]
theorem Eqn.reflect_zero_of_denote_zero {w : Nat} (xs : Env w) (e : Eqn) (h : e.denote xs = 0) :
    e.reflect xs = 0 := by simp [h]

@[simp]
def Env.getLsb_eq_of_width_one (env : List (BitVec 1)) : Env.getLsb env = env := by
  simp [getLsb]
  suffices heq : (fun x => BitVec.ofBool (x.getLsbD 0)) = id by simp [heq]
  ext x i hi
  have : i = 0 := by omega
  simp [this]


theorem Eqn.denote_hard_case_aux {eqn : Eqn}
    (h1 : ∀ (env1 : EnvFin 1 eqn.numVars), Eqn.denoteFin eqn env1 = 0) :
    ∀ {w : Nat} (env : EnvFin w eqn.numVars), eqn.denoteFin env = 0 := by
  intros w
  induction w
  case zero => simp
  case succ w ih =>
    intros env
    rw [Eqn.denoteFin_eq_add]
    rw [h1]
    simp
    rw [ih]
    simp


theorem Eqn.denote_hard_case_of_denote (e : Eqn) (h : ∀ (env1 : EnvFin 1 e.numVars), e.denoteFin env1 = 0) :
    ∀ {w : Nat} (env : List (BitVec w)), e.reflect env = 0 := by
  intros w env
  rw [Eqn.reflect_eq_ofInt_denote]
  rw [← Eqn.denoteFin_eq_denote (xsFin := EnvFin.ofEnv env e.numVars) (h := by simp)]
  rw [Eqn.denote_hard_case_aux]
  · simp
  · intros env1
    apply h

/-
theorem zero_of_ofInt_zero_of_lt (i : Int) (w : Nat)
    (h : BitVec.ofInt w i = 0#w) (h' : i.natAbs < 2^w) : i = 0 := by
  have : (BitVec.ofInt w i).toNat = (0#w).toNat := by rw [h]
  simp at this
  rw [Int.emod_def] at this
  rw [Int.ediv_eq_of_eq_mul_left] at this
  · simp at this
    sorry
-/


/--
This theory should work: Just pick a large enough field where showing that the value is zero
will prove that the value is zero
theorem Eqn.denote_hard_case_of_denote_mpr (e : Eqn)
    (h : ∀ (w : Nat) (env : List (BitVec w)), e.reflect env = 0) :
    ∀ (env1 : EnvFin 1 e.numVars), e.denoteFin env1 = 0 := by
  intros env1
  let size := (e.denoteFin env1).natAbs.log2 + 1
  specialize h size
  let env' := List.finRange e.numVars |>.map fun x => (env1 x).signExtend size
  specialize h env'
  simp [env'] at h
  sorry
-/


/-
instance decEqnDenoteFinWidth1 {e : Eqn} : Decidable (∀ env1 : Env (BitVec 1), Eqn.denoteFin e env1 = 0) :=
  sorry

instance {e : Eqn} : Decidable (∀ env1 : List (BitVec 1), Eqn.denote e env1 = 0) :=
  sorry
-/

def Eqn.reflectEqZero (w : Nat) (eqn : Eqn) (env : Env w) : Prop :=
  Eqn.reflect eqn env = BitVec.ofInt w 0

/--
Central theorem: To decide if a bitvector equation is zero for all widths, it sufficest to check that the denotation is zero at width zero.
-/
theorem Eqn.forall_width_reflect_zero_of_width_one_denote_zero (e : Eqn) (w : Nat) (env : List (BitVec w))
    (h : (∀ env1 : EnvFin 1 e.numVars, Eqn.denoteFin e env1 = 0)) :
    Eqn.reflectEqZero w e env  := by
  rw [Eqn.reflectEqZero]
  rw [Eqn.denote_hard_case_of_denote]
  simp
  apply h

#check Eqn.forall_width_reflect_zero_of_width_one_denote_zero

@[simp]
theorem EnvFin.eq_elim0 (envFin : EnvFin w 0) : envFin = fun i => i.elim0 := by
  simp [EnvFin] at *
  ext i
  exact i.elim0

def EnvFin.getAll1 (n : Nat) : { envs : List (EnvFin 1 n) // ∀ (envFin : EnvFin 1 n), envFin ∈ envs } :=
  match hn : n with
  | 0 => ⟨[fun i => i.elim0], by intros envFin; simp⟩
  | n' + 1 =>
     let ⟨envs, henvs⟩ := EnvFin.getAll1 n'
     let out := envs.flatMap (fun env => [env.cons (BitVec.ofBool false), env.cons (BitVec.ofBool true)])
     ⟨out, by
       intros envFin
       simp [out]
       let envFinSmaller := envFin.comap Fin.succ
       specialize henvs envFinSmaller
       exists envFinSmaller
       simp only [henvs, true_and, out]
       have hv : (envFin 0) = 0#1 ∨ (envFin 0) = 1#1 := by
         generalize envFin 0 = a
         revert a
         decide
       rcases hv with hv | hv
       · left
         funext i
         cases i using Fin.cases
         case zero => simp [hv]
         case succ i' =>
           simp [envFinSmaller]
       · right
         funext i
         cases i using Fin.cases
         case zero => simp [hv]
         case succ i' =>
           simp [envFinSmaller]
     ⟩

/--
Show how to exhaustively enumerate environments to check that the denotation at 1-bit is zero.
-/
instance (e : Eqn) : Decidable (∀ env1 : EnvFin 1 e.numVars, Eqn.denoteFin e env1 = 0) :=
  let ⟨allEnvs, hAllEnvs⟩ := EnvFin.getAll1 e.numVars
  let b := allEnvs.all (fun env1 => e.denoteFin env1 = 0)
  match hb : b with
  | true => .isTrue <| by
    simp [b] at hb
    intros env1
    apply hb
    apply hAllEnvs
  | false => .isFalse <| by
    simp
    simp [b] at hb
    obtain ⟨env, henvMem, henvDenote⟩ := hb
    exists env


namespace Tactic

/-- Two bitvectors are equal iff their different is zero. -/
theorem BitVec.eq_iff_sub_zero (x y : BitVec w) : x = y ↔ x - y = 0 := by
  constructor
  · intros h
    simp [h]
  · intros h
    obtain h : (x - y) + y = y := by simp [h]
    obtain h : (x + (-y)) + y = y := by simp [← BitVec.sub_toAdd, h]
    obtain h : x + (-y + y) = y := by simp [← BitVec.add_assoc, h]
    simp [BitVec.add_comm _ y, ← BitVec.sub_toAdd] at h
    exact h

theorem BitVec.eq_of_sub_zero {x y : BitVec w} (h : x - y = 0#w) :  x = y := by
  simp [BitVec.eq_iff_sub_zero, h]

@[bv_mba_preprocess, simp]
theorem BitVec.sub_distrib_sub (x y z : BitVec w) :
    x - (y - z) = x - y + z := by 
  apply BitVec.eq_of_toInt_eq
  simp only [BitVec.toInt_sub, Int.sub_bmod_bmod, BitVec.toInt_add, Int.bmod_add_bmod_congr]
  congr
  omega

@[bv_mba_preprocess, simp]
theorem BitVec.sub_distrib_add (x y z : BitVec w) :
    x - (y + z) = x - y - z := by
  apply BitVec.eq_of_toInt_eq
  simp only [BitVec.toInt_sub, BitVec.toInt_add, Int.sub_bmod_bmod, Int.bmod_sub_bmod_congr]
  congr 1
  omega


attribute [bv_mba_preprocess] BitVec.sub_toAdd

@[bv_mba_preprocess]
theorem BitVec.ofNat_eq_ofInt (n w : Nat) :
    BitVec.ofNat w n = BitVec.ofInt w n := by
  apply BitVec.eq_of_toInt_eq
  simp[BitVec.toInt_ofNat]


attribute [bv_mba_preprocess] BitVec.ofNat_eq_ofNat

theorem BitVec.neg_eq_zero_sub {w : Nat} (x : BitVec w) : -x = 0#w - x := by
  exact rfl


attribute [simp] BitVec.neg_neg

theorem BitVec.ofInt_add {w : Nat} (i j : Int) :
    BitVec.ofInt w (i + j) = BitVec.ofInt w i + BitVec.ofInt w j := by
  apply BitVec.eq_of_toInt_eq
  simp

@[bv_mba_preprocess]
theorem BitVec.neg_ofInt {w : Nat} (i : Int) :
    - (BitVec.ofInt w i) = BitVec.ofInt w (-i) := by
  symm
  rw [BitVec.eq_iff_sub_zero]
  rw [BitVec.sub_toAdd, BitVec.neg_neg]
  rw [← BitVec.ofInt_add]
  simp [show -i + i = 0 by omega]

@[bv_mba_preprocess]
theorem BitVec.neg_add {x y : BitVec w} : - (x + y) = (-x) + (-y) := by
  rw [BitVec.neg_eq_zero_sub]
  simp only [sub_distrib_add, BitVec.zero_sub]
  exact BitVec.sub_toAdd (-x) y

@[bv_mba_preprocess]
theorem BitVec.neg_sub {x y : BitVec w} : - (x - y) = (-x) + y := by
  rw [BitVec.neg_eq_zero_sub]
  simp only [sub_distrib_sub, BitVec.zero_sub]

theorem BitVec.mul_distrib_add_left (x y z : BitVec w) : x * (y + z) = x * y + x * z := by
  apply BitVec.eq_of_toNat_eq
  simp [← Nat.mul_add]
  conv => 
    rhs 
    rw [Nat.mul_mod]
  simp

theorem BitVec.mul_distrib_add_right (x y z : BitVec w) :  (y + z) * x = y * x + z * x := by
  rw [BitVec.mul_comm]
  rw [BitVec.mul_distrib_add_left]
  ac_nf

@[bv_mba_preprocess]
theorem BitVec.neg_mul_eq_neg_left_mul {w : Nat} (x y : BitVec w) :
    - (x * y) = (- x) * y := by
  symm
  rw [BitVec.eq_iff_sub_zero]
  rw [BitVec.sub_toAdd]
  rw [BitVec.neg_neg]
  rw [← BitVec.mul_distrib_add_right]
  have : -x + x = 0 := by 
    rw [BitVec.add_comm]
    rw [← BitVec.sub_toAdd]
    simp
  simp [this]

attribute [bv_mba_preprocess] Int.Nat.cast_ofNat_Int
attribute [bv_mba_preprocess] Int.reduceNeg
attribute [bv_mba_preprocess] Int.reduceAdd
attribute [bv_mba_preprocess] Int.zero_add
attribute [bv_mba_preprocess] BitVec.add_zero
attribute [bv_mba_preprocess] BitVec.zero_add
attribute [bv_mba_preprocess] Int.neg_eq_of_add_eq_zero

@[bv_mba_preprocess]
theorem BitVec.add_ofInt_zero (x : BitVec w) : x + BitVec.ofInt w 0 = x := by simp

/- Right associate, so our expressions are of the form x1 + (x2 + (x3 + ...))) -/
attribute [bv_mba_preprocess] BitVec.add_assoc



namespace Reflect
open Lean Elab Meta Tactic

abbrev Ix := Nat

structure State where
  -- Exprressions to indexes in the interned object.
  e2ix : Std.HashMap Expr Ix := {}

abbrev M := StateRefT State MetaM

partial def reflectFactor (e : Expr) : M Factor := do
  match_expr e with
  | HAnd.hAnd _bv _bv _bv _inst a b =>
     return Factor.and (← reflectFactor a) (← reflectFactor b)
  | HOr.hOr _bv _bv _bv _inst a b =>
     return Factor.or (← reflectFactor a) (← reflectFactor b)
  | HXor.hXor _bv _bv _bv _inst a b =>
     return Factor.xor (← reflectFactor a) (← reflectFactor b)
  | Complement.complement _bv _inst a =>
     return Factor.not (← reflectFactor a)
  | _ =>
    let s ← get
    match s.e2ix[e]? with
    | .some ix => return Factor.var ix
    | .none => do
       let ix := s.e2ix.size
       set { s with e2ix := s.e2ix.insert e ix }
       return .var ix

def reflectTermCoeff (e : Expr) : M Int :=
  match_expr e with
  | BitVec.ofInt _w i => do
    let .some i := Expr.int? i
      | throwError "Expected 'BitVec.ofInt w <constant int>' at '{e}', found {i}"
    return i
  | Int.cast _ _ i => do
    let .some i := Expr.int? i
      | throwError "Expected Int.cast <constant int>' at '{indentD e}', found {i}"
    return i
  | _ => throwError "unable to reflect term coefficient '{indentD e}'. Expected an integer."

def reflectTerm (e : Expr) : M Term :=
  match_expr e with
  | HMul.hMul _bv _bv _bv _inst l r => do
    let c ← reflectTermCoeff l
    let f ← reflectFactor r
    return { c, f }
  | _ => throwError "unable to reflect term '{indentD e}'.\nExpected 'int * variable'."

/-!
Recall that add and sub in lean are associated to the left, so we have
((a + b) + c) + d and so on.
-/
partial def reflectEqnAux (e : Expr) : M Eqn :=
  match_expr e with
  | HAdd.hAdd _bv _bv _bv _inst l rs => do
    let t ← reflectTerm l
    let eqn ← reflectEqnAux rs
    return t :: eqn
  | _ => do return [← reflectTerm e]

/- The expression corresponding to the bitwidth we are working with -/
abbrev WidthExpr := Expr

def reflectEqn (e : Expr) : M (WidthExpr × Eqn) := do
  let .some (ty, lhs, _rhs) := Expr.eq? e
    | throwError "expected top-level equality, but found {e}"
  let_expr BitVec w := ty
    | throwError "expected equality of bitvectors, but found {indentD ty}"
  logInfo m!"found top-level equality LHS '{lhs}'"
  return (w, ← reflectEqnAux lhs)

def runM (x : M α) : MetaM (α × State) := x.run {}

def runBvMbaPreprocess (g : MVarId) : MetaM (Option MVarId) := do
  let simpName := `bv_mba_preprocess
  let some ext ← (getSimpExtension? simpName)
    | throwError m!"[bv_mba] Error: {simpName} simp attribute not found!"
  let theorems ← ext.getTheorems
  let some ext ← (Simp.getSimprocExtension? simpName)
    | throwError m!"[bv_nnf] Error: {simpName}} simp attribute not found!"
  let simprocs ← ext.getSimprocs
  let config : Simp.Config := { Simp.neutralConfig with
    failIfUnchanged   := false,
  }
  let ctx ← Simp.mkContext (config := config)
    (simpTheorems := #[theorems])
    (congrTheorems := ← Meta.getSimpCongrTheorems)
  match ← simpGoal g ctx (simprocs := #[simprocs]) with
  | (none, _) => return none
  | (some (_newHyps, g'), _) => pure g'

def WidthExpr.toBitVecType (w : WidthExpr) : Expr :=
  mkApp (mkConst ``BitVec) w

/-- Make an 'Env' out of the state by reading the values -/
def State.envToExpr (w : WidthExpr) (s : State) : MetaM Expr := do
  let mut ix2e : Std.HashMap Nat Expr := {}
  for (e, ix) in s.e2ix do
    ix2e := ix2e.insert ix e
  let bvTy := w.toBitVecType
  let mut env :=  mkApp (mkConst ``List.nil [Level.zero]) bvTy
  for i in [0:ix2e.size] do
    let i := ix2e.size - 1 - i
    env := mkApp3 (mkConst ``List.cons [Level.zero]) bvTy  ix2e[i]! env
  return env

open Std Lean in
def mbaTac (g : MVarId) : TermElabM (List MVarId) := do
  g.withContext do
    let [g] ← g.apply (mkConst ``BitVec.eq_of_sub_zero)
      | throwError m!"unable to apply `BitVec.eq_of_sub_zero`."
    let .some g ← runBvMbaPreprocess  g
      | do
         logInfo "goal closed by Mba normalizer."
         return []
    logInfo m!"Normalized goal state to {indentD g}"
    let ((widthExpr, eqn), reflectState) ← g.withContext do runM <| reflectEqn (← g.getType)
    logInfo m!"found expression of width: '{indentD widthExpr}'"
    let env ← State.envToExpr widthExpr reflectState
    logInfo m!"replacing goal with reflected version. Equation: {indentD <| repr eqn}"
    logInfo m!"Environment: {indentD (toMessageData reflectState.e2ix.toList)}"
    -- let reflectedLhs ← mkAppM ``Eqn.reflect #[Eqn.toExpr eqn, env]
    -- let reflectedRhs := mkApp2 (mkConst ``BitVec.ofInt) widthExpr (toExpr (0 : Int))
    -- let g ← g.replaceTargetDefEq (← mkEq reflectedLhs reflectedRhs)
    -- logInfo m!"Replaced. {indentD g}"
    -- apply: Eqn.forall_width_reflect_zero_of_width_one_denote_zero

    let gs ← g.withContext do g.apply (mkAppN (mkConst ``Eqn.forall_width_reflect_zero_of_width_one_denote_zero []) #[Eqn.toExpr eqn, widthExpr, env])
    let [g] := gs
      | throwError m!"expected single goal after applying reflection theorem, found {gs}"
    let dec ← mkDecideProof <| ← g.getType
    if ← isDefEq (mkMVar g) dec then
      logInfo "successfully decided!"
      return []
    else
      logWarning "failed to prove theorem using decision procedure, statement is false."
      return [g]
    -- let [g] ← g.apply <| (mkConst ``of_decide_eq_true)
    --  | throwError m!"Failed to apply `of_decide_eq_true on goal '{indentD g}'"
    -- let [] ← g.apply <| (mkConst ``Lean.ofReduceBool)
    --     | throwError m!"Failed to decide with `Lean.ofReducebool` applied to '{indentD g}'"

syntax (name := bvMba) "bv_mba" : tactic

@[tactic bvMba]
def evalBvMba : Tactic := fun
  | `(tactic| bv_mba) => do
     let gs ← mbaTac (← getMainGoal)
     replaceMainGoal gs
  | _ => throwUnsupportedSyntax

end Reflect
end Tactic

namespace Examples


example (x y : BitVec w) :
  Eqn.reflectEqZero w
    [Term.mk 1 (.var 0), Term.mk 2 (.var 1)] [x, y] =
    (BitVec.ofInt w 1 * x + BitVec.ofInt w 2 * y = BitVec.ofInt w 0) := rfl

example (x y : BitVec w) :
  Eqn.reflectEqZero w
    [Term.mk 1 (.var 0), Term.mk 2 (.var 1), Term.mk (-1) (.var 0)] [x, y] =
    (BitVec.ofInt w 1 * x + (BitVec.ofInt w 2 * y + BitVec.ofInt w (-1) * x) = BitVec.ofInt w 0) := rfl

theorem eg3 (x y : BitVec w) :
     - 2 *  ~~~(x &&&  ~~~y) + 2 *  ~~~x - 5 *  ~~~(x |||  ~~~y) = 3 * (x &&& y) - 5 * y := by
  bv_mba

/-- info: 'MBA.Examples.eg3' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms eg3

end Examples
end MBA


