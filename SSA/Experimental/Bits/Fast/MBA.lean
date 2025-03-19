import SSA.Experimental.Bits.Fast.Attr
import Lean
import Lean.ToExpr
import Lean.Data.RArray
-- import Init.Data.Int.DivMod.Lemmas

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

def Env.sext (env : Env w) (w' : Nat) : Env w' :=
  List.map (fun x => x.signExtend w') env

def Factor.reflectBV {w : Nat} (xs : Env w) : Factor → BitVec w
| .var n => xs[n]?.getD (0#w)
| .and x y => x.reflectBV xs &&& y.reflectBV xs
| .or x y => x.reflectBV xs ||| y.reflectBV xs
| .xor x y => x.reflectBV xs ^^^ y.reflectBV xs
| .not x => ~~~ (x.reflectBV xs)

def Factor.denoteInt {w : Nat} (xs : Env w) (f : Factor) : Nat := f.reflectBV xs |>.toNat

theorem Factor.denote_eq_toNat_reflectBV {w : Nat} (xs : Env w) (f : Factor) :
  f.denoteInt xs = (f.reflectBV xs |>.toNat) := rfl

/--
Environment of *finite* size, which can agree with the `Factor.reflectBV`.
We need `Factor.reflectBVFin` to show that our brute-force evaluation for length 1 has a finite environment size for exhaustive enumeration,
We need `Factor.reflectBV` to def-eq-unify with the user's given goal state.
We show their equivalence to allow us to decide on `denoteIntFin`, and to use this when proving facts about `denoteInt`.
-/
def EnvFin (w : Nat) (n : Nat) := Fin n → (BitVec w)
def EnvFin.getLsb {w : Nat} (env : EnvFin (w + 1) n) : EnvFin 1 n := fun n => BitVec.ofBool <| (env n).getLsbD 0
def EnvFin.getNonLsbs {w : Nat} (env : EnvFin (w + 1) n) : EnvFin w n := fun n => (env n).extractLsb' 1 w

def EnvFin.sext (env : EnvFin w n) (w' : Nat) : EnvFin w' n := fun n => (env n).signExtend w'

@[simp]
theorem EnvFin.get_sext {env : EnvFin w n} {w' : Nat} (i : Fin n) :
  ((env.sext w') i) = (env i).signExtend w' := rfl

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

def Factor.reflectBVFin {w : Nat} (f : Factor) (xs : EnvFin w f.numVars) : BitVec w :=
  match f with
  | .var n => xs ⟨n, by simp⟩
  | .and x y =>
    x.reflectBVFin (fun n => xs ⟨n, by simp [numVars]; omega⟩) &&& y.reflectBVFin (fun n => xs ⟨n, by simp [numVars]; omega⟩)
  | .or x y =>
     x.reflectBVFin (fun n => xs ⟨n, by simp [numVars]; omega⟩) ||| y.reflectBVFin (fun n => xs ⟨n, by simp [numVars]; omega⟩)
  | .xor x y =>
     x.reflectBVFin (fun n => xs ⟨n, by simp [numVars]; omega⟩) ^^^ y.reflectBVFin (fun n => xs ⟨n, by simp [numVars]; omega⟩)
  | .not x =>
     ~~~ x.reflectBVFin (fun n => xs ⟨n, by simp [numVars]⟩)


/-- Show that reflectBV and reflectBVFin agree in their values -/
theorem Factor.reflectBV_eq_reflectBVFin {f : Factor} {xs : List (BitVec w)} {xsFin : EnvFin w f.numVars}
    (h : ∀ (i : Fin f.numVars), xs[i]?.getD 0#w = xsFin i) :
    f.reflectBV xs = f.reflectBVFin xsFin := by
  induction f
  case var n => simp [reflectBV, reflectBVFin] at h ⊢; rw[← h]
  case and x y hx hy =>
    simp [reflectBV, reflectBVFin] at h ⊢
    rw[← hx, ← hy]
    · intros i
      simp [← h]
    · intros i
      simp [← h]
  case or x y hx hy =>
    simp [reflectBV, reflectBVFin] at h ⊢
    rw[← hx, ← hy]
    · intros i
      simp [← h]
    · intros i
      simp [← h]
  case xor x y hx hy =>
    simp [reflectBV, reflectBVFin] at h ⊢
    rw[← hx, ← hy]
    · intros i
      simp [← h]
    · intros i
      simp [← h]
  case not x hx =>
    simp [reflectBV, reflectBVFin] at h ⊢
    rw[← hx]
    · intros i
      simp [← h]

def Factor.denoteIntFin {w : Nat} (f : Factor) (xs : EnvFin w f.numVars) : Nat := f.reflectBVFin xs |>.toNat

theorem Factor.denoteFin_eq_toNat_reflectBVFin (f : Factor) (xs : EnvFin w f.numVars) :
  f.denoteIntFin xs = (f.reflectBVFin xs).toNat := rfl

/-- Show that 'denote'  agrees with 'denoteFin' -/
theorem Factor.denoteIntFin_eq_denoteInt {f : Factor} {xs : List (BitVec w)} {xsFin : EnvFin w f.numVars}
    (h : ∀ (i : Fin f.numVars), xs[i]?.getD 0#w = xsFin i) :
    f.denoteIntFin xsFin = f.denoteInt xs := by
  rw [Factor.denoteInt, Factor.denoteIntFin, Factor.reflectBV_eq_reflectBVFin h]

theorem Factor.reflectBV_eq_ofInt_denote {w : Nat} (xs : Env w) (f : Factor) :
    f.reflectBV xs = (BitVec.ofInt w <| f.denoteInt xs) := by
  simp [reflectBV, denoteInt]

@[simp]
theorem Factor.reflectBV_zero_of_denote_zero {w : Nat} {f : Factor} {xs : Env w} (h : f.denoteInt xs = 0) :
    f.reflectBV xs = 0#w := by
  simp [reflectBV_eq_ofInt_denote, h]

@[simp]
theorem Factor.reflectBV_width_zero  (f : Factor) (env : Env 0) : f.reflectBV env = 0#0 := by
  apply Subsingleton.elim

@[simp]
theorem Factor.denote_width_zero  (f : Factor) (env : Env 0) : f.denoteInt env = 0 := by
  simp [denoteInt]

@[simp]
theorem Factor.reflectBVFin_width_zero  (f : Factor) (env : EnvFin 0 f.numVars) : f.reflectBVFin env = 0#0 := by
  apply Subsingleton.elim

/--
The value of 'x.reflectBVFin env' can be computed from using
'(x.reflectBVFin env.getlsb)' and '(x.reflectBVFin env.getNonLsbs)'.
-/
theorem Factor.getLsb_reflectBVFin_eq_or_reflectBVFin_getLsb_reflectBVFin_getNonLsbs
    {w : Nat} {x : Factor} {env : EnvFin (w +1) x.numVars} :
    (x.reflectBVFin env).getLsbD i = if i = 0 then ((x.reflectBVFin env.getLsb).getLsbD 0) else (x.reflectBVFin env.getNonLsbs).getLsbD (i - 1) := by
  rcases i with rfl | i
  · simp
    induction x
    case var n =>
      simp [reflectBVFin]
    case and x y hx hy =>
      simp [reflectBVFin]
      simp [hx, hy]
      rfl
    case or x y hx hy =>
      simp [reflectBVFin]
      simp [hx, hy]
      rfl
    case xor x y hx hy =>
      simp only [reflectBVFin, BitVec.getLsbD_xor]
      simp only [hx, hy]
      rfl
    case not x hx  =>
      simp only [reflectBVFin, BitVec.getLsbD_not]
      simp [hx]
  · simp
    induction x
    case var n =>
      simp [reflectBVFin]
      intros h
      apply Classical.byContradiction
      intros hcontra
      simp at hcontra
      have := BitVec.getLsbD_ge (env ⟨n, by simp⟩) (i + 1) (by omega)
      simp [this] at h
    case and x y hx hy =>
      simp [reflectBVFin]
      simp [hx, hy]
      rfl
    case or x y hx hy =>
      simp [reflectBVFin]
      simp [hx, hy]
      rfl
    case xor x y hx hy =>
      simp only [reflectBVFin, BitVec.getLsbD_xor]
      simp only [hx, hy]
      rfl
    case not x hx  =>
      simp only [reflectBVFin, BitVec.getLsbD_not]
      simp [hx]

theorem Factor.reflectBVFin_eq_reflectBVFin_getLsb_reflectBVFin_getNonLsbs
    {w : Nat} {x : Factor} {env : EnvFin (w +1) x.numVars} :
    (x.reflectBVFin env) = (x.reflectBVFin env.getNonLsbs).concat ((x.reflectBVFin env.getLsb).getLsbD 0) := by
  apply BitVec.eq_of_getLsbD_eq
  intros i hi
  conv =>
    lhs
    rw [getLsb_reflectBVFin_eq_or_reflectBVFin_getLsb_reflectBVFin_getNonLsbs]
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


@[simp]
theorem Env.sext_ofEnvFin (envFin : EnvFin w n) (w' : Nat) :
    (Env.ofEnvFin envFin).sext w' = Env.ofEnvFin (envFin.sext w') := by
  ext i x
  simp [Env.sext, EnvFin.sext]
  constructor
  · intros h
    simp only [ofEnvFin, List.getElem?_map, Option.map_eq_some', EnvFin.sext] at h ⊢
    obtain ⟨h₁, h₂⟩ := h
    obtain ⟨h₃, h₄⟩ := h₂
    obtain ⟨a, h₃⟩ := h₃
    exists a
    simp [h₃, h₄]
  · intros h
    simp only [ofEnvFin, List.getElem?_map, Option.map_eq_some', EnvFin.sext] at h ⊢
    obtain ⟨a, h₁⟩ := h
    exists (envFin a)
    simp [h₁]

theorem Factor.denote_eq_toNat_reflectBVFin {w : Nat} (xs : Env w) (f : Factor) :
    f.denoteInt xs = (f.reflectBVFin (EnvFin.ofEnv xs _)).toNat := by
  rw [Factor.denote_eq_toNat_reflectBV]
  rw [reflectBV_eq_reflectBVFin]
  simp

theorem Factor.reflectBVFin_toNat_eq_add
    {w : Nat} {x : Factor} {env : EnvFin (w +1) x.numVars} :
    (x.reflectBVFin env).toNat = 2 * (x.reflectBVFin env.getNonLsbs).toNat + ((x.reflectBVFin env.getLsb).getLsbD 0).toNat := by
  rw [Factor.reflectBVFin_eq_reflectBVFin_getLsb_reflectBVFin_getNonLsbs]
  simp
  rw [Nat.mul_comm]


/-- Split a denoteInt at an env intoa denoteInt at the LSB and the denoteInt at the non-Lsbs -/
theorem Factor.denoteFin_eq_add {w : Nat} (x : Factor) (env : EnvFin (w + 1) x.numVars) :
    x.denoteIntFin env = 2 * x.denoteIntFin env.getNonLsbs + x.denoteIntFin env.getLsb := by
  rw [Factor.denoteFin_eq_toNat_reflectBVFin]
  rw [Factor.denoteFin_eq_toNat_reflectBVFin]
  rw [Factor.denoteFin_eq_toNat_reflectBVFin]
  rw [Factor.reflectBVFin_toNat_eq_add]
  simp
  generalize (x.reflectBVFin env.getLsb) = bv
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

/-- reflectBV is what we use for reflectBVion -/
def Term.reflectBV {w : Nat}  (t : Term) (xs: Env w) : BitVec w :=
  (BitVec.ofInt w t.c) * t.f.reflectBV xs

def Term.denoteInt {w : Nat} (t : Term) (xs : Env w) : Int :=
  t.c * t.f.denoteInt xs

def Term.denoteIntFin {w : Nat} (t : Term) (xs : EnvFin w t.numVars) : Int :=
  t.c * t.f.denoteIntFin xs

/-- Split a denoteInt at an env intoa denoteInt at the LSB and the denoteInt at the non-Lsbs -/
theorem Term.denoteFin_eq_add {w : Nat} (t : Term) (env : EnvFin (w + 1) t.numVars) :
    t.denoteIntFin env = 2 * t.denoteIntFin env.getNonLsbs + t.denoteIntFin env.getLsb := by
  rw [Term.denoteIntFin]
  rw [Factor.denoteFin_eq_add]
  rw [Term.denoteIntFin]
  rw [Term.denoteIntFin]
  simp only [Int.natCast_add, Int.natCast_mul, Int.Nat.cast_ofNat_Int]
  rw [Int.mul_add]
  ac_nf

theorem Term.denoteIntFin_eq_denoteInt {t : Term} {xs : List (BitVec w)} {xsFin : EnvFin w t.numVars} (h : ∀ (i : Fin t.numVars), xs[i]?.getD 0#w = xsFin i) :
    t.denoteIntFin xsFin = t.denoteInt xs := by
  simp [Term.denoteIntFin, Term.denoteInt, Factor.denoteIntFin_eq_denoteInt h]

@[simp]
theorem Term.reflectBV_eq_ofInt_denote {w : Nat} {t : Term} {xs : Env w} :
    t.reflectBV xs = (BitVec.ofInt w <| t.denoteInt xs) := by
  obtain ⟨c, f⟩ := t
  simp [Term.reflectBV, Term.denoteInt]
  rw [BitVec.ofInt_mul]
  rw [Factor.reflectBV_eq_ofInt_denote]

@[simp]
theorem Term.reflectBV_zero_of_denote_zero {w : Nat} {t : Term} {xs : Env w} (h : t.denoteInt xs = 0) :
    t.reflectBV xs = 0#w := by
  simp [Term.reflectBV_eq_ofInt_denote, h]

@[simp]
theorem Term.reflectBV_width_zero  (t : Term) (env : Env 0) :
    t.reflectBV env = 0 := by simp [Term.reflectBV]

@[simp]
theorem Term.denote_width_zero  (t : Term) (env : Env 0) :
    t.denoteInt env = 0 := by simp [Term.denoteInt]

@[simp]
theorem Term.denoteFin_width_zero  (t : Term) (env : EnvFin 0 t.numVars) :
    t.denoteIntFin env = 0 := by simp [Term.denoteIntFin, Factor.denoteIntFin]

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

def Eqn.reflectBV {w : Nat} (e : Eqn) (env : Env w) : BitVec w :=
  match e with
  | [] => 0
  | t :: [] => t.reflectBV env
  | t :: ts => t.reflectBV env + Eqn.reflectBV ts env


@[simp]
theorem Eqn.reflectBV_nil  {w : Nat} (env : Env w) :
    Eqn.reflectBV [] env = 0 := rfl

@[simp]
theorem Eqn.reflectBV_cons {w : Nat}
    (t : Term) (ts : List Term) (env : Env w) :
    Eqn.reflectBV (t :: ts) env = t.reflectBV env + Eqn.reflectBV ts env := by
  rcases ts with t | ts
  simp [reflectBV]
  simp [reflectBV]


def Eqn.denoteInt {w : Nat} (e : Eqn) (env : Env w) : Int :=
  match e with
  | [] => 0
  | t :: ts => t.denoteInt env + Eqn.denoteInt ts env

@[simp]
theorem Eqn.denote_nil  {w : Nat} (env : Env w) :
    Eqn.denoteInt [] env = 0 := rfl

@[simp]
theorem Eqn.denote_cons {w : Nat}
    (t : Term) (ts : List Term) (env : Env w) :
    Eqn.denoteInt (t :: ts) env = t.denoteInt env + Eqn.denoteInt ts env := rfl

def Eqn.denoteIntFin {w : Nat} (e : Eqn) (envFin : EnvFin w e.numVars) : Int :=
  match e with
  | [] => 0
  | t :: ts =>
    t.denoteIntFin (envFin.castLe (by simp; omega)) +
    Eqn.denoteIntFin ts (envFin.castLe (by simp; omega))

@[simp]
theorem Eqn.denoteFin_nil {w : Nat} (envFin : EnvFin w 0) :
  Eqn.denoteIntFin [] envFin = 0 := rfl

@[simp]
theorem Eqn.denoteFin_cons {w : Nat} (t : Term) (eqn : Eqn)
    (envFin : EnvFin w (max t.numVars  eqn.numVars)) :
  Eqn.denoteIntFin (t :: eqn) envFin =
  t.denoteIntFin (envFin.castLe (by omega)) +
  Eqn.denoteIntFin eqn (envFin.castLe (by omega)) := rfl

theorem Eqn.denoteFin_eq_add {w : Nat} (eqn : Eqn) (env : EnvFin (w + 1) eqn.numVars) :
    eqn.denoteIntFin env = 2 * eqn.denoteIntFin env.getNonLsbs + eqn.denoteIntFin env.getLsb := by
  induction eqn
  case nil => simp [denoteIntFin]
  case cons x xs ih =>
    simp only [denoteIntFin]
    simp only [ih]
    rw [Term.denoteFin_eq_add x]
    rw [Int.mul_add]
    ac_nf

/-- To evaluate `e.denoteInt`, one can equally well evaluate `e.denoteIntFin` -/
theorem Eqn.denoteIntFin_eq_denoteInt {e : Eqn} {xs : List (BitVec w)} {xsFin : EnvFin w e.numVars}
    (h : ∀ (i : Fin e.numVars), xs[i]?.getD 0#w = xsFin i) :
    e.denoteIntFin xsFin = e.denoteInt xs := by
  induction e
  case nil => simp [Eqn.denoteIntFin]
  case cons t es ih =>
    simp
    rw [ih]
    · congr
      apply Term.denoteIntFin_eq_denoteInt
      intros i
      specialize h ⟨i, by simp; omega⟩
      assumption
    · intros i
      specialize h ⟨i, by simp; omega⟩
      assumption

@[simp]
theorem Eqn.reflectBV_width_zero  (es : Eqn) (env : Env 0) :
    Eqn.reflectBV es env = 0 := by
  induction es
  case nil => simp [Eqn.reflectBV]
  case cons e es ih =>
    simp [ih, Eqn.reflectBV]

@[simp]
theorem Eqn.denote_width_zero  (es : Eqn) (env : Env 0) :
    Eqn.denoteInt es env = 0 := by
  induction es
  case nil => simp [Eqn.denoteInt]
  case cons e es ih =>
    simp [ih, Eqn.denoteInt]

@[simp]
theorem Eqn.denoteFin_width_zero  (es : Eqn) (env : EnvFin 0 es.numVars) :
    Eqn.denoteIntFin es env = 0 := by
  induction es
  case nil => simp [Eqn.denoteIntFin]
  case cons e es ih =>
    simp [ih, Eqn.denoteIntFin]

@[simp]
theorem Eqn.reflectBV_eq_ofInt_denote {w : Nat} (xs : Env w) (e : Eqn) :
    e.reflectBV xs = BitVec.ofInt w (e.denoteInt xs) := by
  induction e
  case nil => simp
  case cons t ts ih =>
    simp
    simp [BitVec.ofInt_add, ih]

@[simp]
theorem Eqn.reflectBV_zero_of_denote_zero {w : Nat} (xs : Env w) (e : Eqn) (h : e.denoteInt xs = 0) :
    e.reflectBV xs = 0 := by simp [h]

@[simp]
def Env.getLsb_eq_of_width_one (env : List (BitVec 1)) : Env.getLsb env = env := by
  simp [getLsb]
  suffices heq : (fun x => BitVec.ofBool (x.getLsbD 0)) = id by simp [heq]
  ext x i hi
  have : i = 0 := by omega
  simp [this]



theorem Eqn.denoteFin_eq_zero_of_denoteFin_width_one_eq_zero {eqn : Eqn}
    (h1 : ∀ (env1 : EnvFin 1 eqn.numVars), eqn.denoteIntFin env1 = 0) :
    ∀ {w : Nat} (env : EnvFin w eqn.numVars), eqn.denoteIntFin env = 0 := by
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

theorem Eqn.denoteFin_width_one_eq_zero_of_denoteFin_eq_zero {eqn : Eqn}
    (h1 : ∀ {w : Nat} (env : EnvFin w eqn.numVars), eqn.denoteIntFin env = 0) :
    ∀ (env1 : EnvFin 1 eqn.numVars), eqn.denoteIntFin env1 = 0 := by
  apply h1


/--
Core theorem: the denotation at width 1 is always zero iff
the denotation at all widths is zero.
-/
theorem Eqn.denoteFin_width_one_eq_zero_iff_denoteFin_eq_zero (eqn : Eqn) :
    (∀ (env1 : EnvFin 1 eqn.numVars), eqn.denoteIntFin env1 = 0) ↔
    (∀ {w : Nat} (env : EnvFin w eqn.numVars), eqn.denoteIntFin env = 0) where
  mp := Eqn.denoteFin_eq_zero_of_denoteFin_width_one_eq_zero
  mpr := Eqn.denoteFin_width_one_eq_zero_of_denoteFin_eq_zero

/--
To check that the BV value is always zero, it suffices to check that the 'Int' based relation stating with BV 1 suffices.
-/
theorem Eqn.reflectBV_eq_zero_of_denoteFin_width_one_eq_zero (e : Eqn)
    (h : ∀ (env1 : EnvFin 1 e.numVars), e.denoteIntFin env1 = 0) :
    ∀ {w : Nat} (env : List (BitVec w)), e.reflectBV env = 0 := by
  intros w env
  rw [Eqn.reflectBV_eq_ofInt_denote]
  rw [← Eqn.denoteIntFin_eq_denoteInt (xsFin := EnvFin.ofEnv env e.numVars) (h := by simp)]
  rw [Eqn.denoteFin_eq_zero_of_denoteFin_width_one_eq_zero]
  · simp
  · intros env1
    apply h

theorem Int.lt_twoPow_natAbs_self (i : Int) : i < 2^i.natAbs := by
  have hi : i < 0 ∨ i ≥ 0 := by omega
  rcases hi with hi | hi
  · have : 2^i.natAbs > 0 := by apply Nat.pow_pos; omega
    norm_cast
    omega
  · obtain ⟨n, hn⟩ := Int.eq_ofNat_of_zero_le hi
    subst hn
    simp
    norm_cast
    exact Nat.lt_two_pow_self

theorem Int.bmod_twoPow_self_eq_self {i : Int} : i.bmod (2 ^ i.natAbs)  = i := by
  rw [Int.bmod_def]
  rw [Int.emod_def]
  have : i < 2^i.natAbs := by
    apply Int.lt_twoPow_natAbs_self
  have : i / ((2^i.natAbs) : Nat) = 0 := by
    sorry
  simp only [this, Int.mul_zero, Int.sub_zero]
  have : i < ((2^i.natAbs : Nat) + 1) / 2 := by 
    sorry
  simp [this]

theorem int_eq_zero_of_natAbs_ofInt_eq_zero {i : Int} {w : Nat}
    (h : BitVec.ofInt w i = 0#w)
    (hw : w = i.natAbs) : i = 0 := by
  have : BitVec.toInt (BitVec.ofInt w i) = BitVec.toInt (BitVec.ofNat w 0) := by rw [h]
  simp at this
  subst w
  rw [Int.bmod_twoPow_self_eq_self] at this
  simp [this]


/-- To show 'i = 0', it suffices to show that it's zero for all large enough bitvectors -/
theorem Int.eq_zero_iff_ofInt_zero (i : Int) : (i = 0) ↔ (∀ (w : Nat), BitVec.ofInt w i = 0#w) := by
  constructor
  · intros h
    simp [h]
  · intros h
    apply Classical.byContradiction
    intros hcontra
    specialize (h i.natAbs)
    have := int_eq_zero_of_natAbs_ofInt_eq_zero h rfl
    contradiction

/--
Denoting at an environment also works at a sign-extended environment.
The proof technique will be to show that Factor.signExtend (actually, we should use zeroExtend)
will extend cleanly, and then the same will work for Term.

-/
theorem Eqn.denoteIntFin_eq_denoteIntFin_sext {e : Eqn} {xsFin : EnvFin w e.numVars} (w' : Nat) (hw' : w ≤ w') :
  e.denoteIntFin xsFin = e.denoteIntFin (xsFin.sext w') := by sorry

-- a => b,
-- b => a =|= !a => !b
theorem Eqn.reflectBV_neq_zero_iff_denoteFin_width_one_neq_zero (e : Eqn)
    (h : ∀ {w : Nat} (env : List (BitVec w)), e.reflectBV env = 0) :
    (∀ (env1 : EnvFin 1 e.numVars), e.denoteIntFin env1 = 0) := by
  intros env1
  apply Int.eq_zero_iff_ofInt_zero _ |>.mpr
  intros w
  by_cases hw : w = 0
  · subst hw
    apply Subsingleton.elim
  · simp [Eqn.reflectBV_eq_ofInt_denote] at h
    -- OK, I now know what we need to do.
    -- (1) change environments to a zext'd environment.
    let envA := Env.sext (Env.ofEnvFin env1) w
    let envB := EnvFin.sext env1 w
    specialize h envA
    have := Eqn.denoteIntFin_eq_denoteInt (e := e) (xs := Env.ofEnvFin envB) (xsFin := envB) (by sorry)
    rw [Eqn.denoteIntFin_eq_denoteIntFin_sext w]
    · rw [this]
      have envA_eq_envB : Env.ofEnvFin envB = envA := by
        simp [envA, envB]
      rw [envA_eq_envB]
      exact h
    · omega







#check Int.bdiv_add_bmod
#check Int.bdiv
#eval (12 : Int).bdiv 6
#eval (11 : Int).bdiv 6
#eval (10 : Int).bdiv 6
#eval (9 : Int).bdiv 6  -- >= half rounds upwards
#eval (8 : Int).bdiv 6
#eval (7 : Int).bdiv 6
#eval (6 : Int).bdiv 6
#eval (5 : Int).bdiv 6
#eval (4 : Int).bdiv 6
#eval (3 : Int).bdiv 6  -- >= half rounds upwards
#eval (2 : Int).bdiv 6
#eval (1 : Int).bdiv 6
#eval (0 : Int).bdiv 6
#eval (-1 : Int).bdiv 6
#eval (-2 : Int).bdiv 6
#eval (-3 : Int).bdiv 6 -- >= half rounds upwards
#eval (-4 : Int).bdiv 6
#eval (-5 : Int).bdiv 6
#eval (-6 : Int).bdiv 6
#eval (-7 : Int).bdiv 6
#eval (-8 : Int).bdiv 6
#eval (-9 : Int).bdiv 6 -- >= half rounds upwards
#eval (-10 : Int).bdiv 6
#eval (-11 : Int).bdiv 6


-- ediv: In posittive side, floor. In negative side, floor
#eval (12 : Int).ediv 6
#eval (11 : Int).ediv 6
#eval (10 : Int).ediv 6
#eval (9 : Int).ediv 6  -- >= half rounds upwards
#eval (8 : Int).ediv 6
#eval (7 : Int).ediv 6
#eval (6 : Int).ediv 6
#eval (5 : Int).ediv 6
#eval (4 : Int).ediv 6
#eval (3 : Int).ediv 6  -- >= half rounds upwards
#eval (2 : Int).ediv 6
#eval (1 : Int).ediv 6
#eval (0 : Int).ediv 6
#eval (-1 : Int).ediv 6 -- anything negative rounds to -1
#eval (-2 : Int).ediv 6
#eval (-3 : Int).ediv 6
#eval (-4 : Int).ediv 6
#eval (-5 : Int).ediv 6
#eval (-6 : Int).ediv 6 -- anything negative rounds to -1
#eval (-7 : Int).ediv 6
#eval (-8 : Int).ediv 6
#eval (-9 : Int).ediv 6
#eval (-10 : Int).ediv 6
#eval (-11 : Int).ediv 6

class Nonneg (i : Int) where
  Nonneg : i ≥ 0

class Nonpos (i : Int) where
  Nonpos : i ≤ 0


theorem ediv_natCast_eq_of_le (x : Int) (hx : 0 ≤ x)  (y : Nat) : x / (y : Int) = Int.ofNat (x.natAbs / y) := by
 rcases x with x | x
 · simp
 · omega
@[simp] theorem ofNat_ediv_ofNat_eq (x y : Nat) : (Int.ofNat x) / (Int.ofNat y) = Int.ofNat (x / y) := rfl

-- -x / y = if x = 0 then 0 else -((-x + 1) / y)
theorem negSucc_ediv_ofNat_eq (x y : Nat) : (Int.negSucc x) / (y : Int) = if y = 0 then 0 else Int.negSucc (x / y) := by
  rw [Int.div_def, Int.ediv.eq_def]
  rcases y with rfl | y <;> simp

theorem Int.natAbs_add_eq_of_le_of_le {x y : Int} (hx : 0 ≤ x) (hy : 0 ≤ y) : (x + y).natAbs = x.natAbs + y.natAbs := by
  rw [Int.natAbs.eq_def]
  rcases x with x | x <;> rcases y with y | y <;> first | omega | rfl

theorem Int.natAbs_add_eq_of_le_iff_le {x y : Int} (h : 0 ≤ x ↔ 0 ≤ y) : (x + y).natAbs = x.natAbs + y.natAbs := by
  by_cases hx : 0 ≤ x
  · have := h.mp hx
    rcases x with x | x <;> rcases y with y | y <;> first | omega | rfl
  · have := hx.imp h.mpr
    rcases x with x | x <;> rcases y with y | y <;> omega

/-
-- -x / y = if x = 0 then 0 else -((-x + 1) / y)
theorem ediv_ofNat_eq_of_lt {x : Int} (hx : x < 0)  {y : Nat} :  x / (y : Int) =
    if y = 0
    then 0
    else - ((-x + 1) / y) + 1 := by
  rcases x with x  | x
  · simp at hx
    omega
  · rw [negSucc_ediv_ofNat_eq]
    rcases y with rfl | y
    · simp
    · rw [ediv_natCast_eq_of_le]
      simp
      · rw [Int.natAbs_add_eq_of_le_iff_le]
        · simp
          sorry
        · omega
      · omega
-/


#check Int.ediv
@[simp] theorem ofNat_ediv_negSucc_eq (x y : Nat) : (Int.ofNat x) / (Int.negSucc y) = -Int.ofNat (x / (y +1)) := rfl

-- tdiv: In positive side, floor. In negative side, ceil.
#eval (12 : Int).tdiv 6
#eval (11 : Int).tdiv 6
#eval (10 : Int).tdiv 6
#eval (9 : Int).tdiv 6
#eval (8 : Int).tdiv 6
#eval (7 : Int).tdiv 6
#eval (6 : Int).tdiv 6
#eval (5 : Int).tdiv 6
#eval (4 : Int).tdiv 6
#eval (3 : Int).tdiv 6
#eval (2 : Int).tdiv 6
#eval (1 : Int).tdiv 6
#eval (0 : Int).tdiv 6
#eval (-1 : Int).tdiv 6 -- anything negative rounds to -1
#eval (-2 : Int).tdiv 6
#eval (-3 : Int).tdiv 6
#eval (-4 : Int).tdiv 6
#eval (-5 : Int).tdiv 6
#eval (-6 : Int).tdiv 6 -- anything negative rounds to -1
#eval (-7 : Int).tdiv 6
#eval (-8 : Int).tdiv 6
#eval (-9 : Int).tdiv 6
#eval (-10 : Int).tdiv 6
#eval (-11 : Int).tdiv 6
#eval (-12 : Int).tdiv 6


-- fdiv: in positive side, floor. in negative side, floor.
#eval (12 : Int).fdiv 6
#eval (11 : Int).fdiv 6
#eval (10 : Int).fdiv 6
#eval (9 : Int).fdiv 6
#eval (8 : Int).fdiv 6
#eval (7 : Int).fdiv 6
#eval (6 : Int).fdiv 6
#eval (5 : Int).fdiv 6
#eval (4 : Int).fdiv 6
#eval (3 : Int).fdiv 6
#eval (2 : Int).fdiv 6
#eval (1 : Int).fdiv 6
#eval (0 : Int).fdiv 6
#eval (-1 : Int).fdiv 6 -- anything negative rounds to -1
#eval (-2 : Int).fdiv 6
#eval (-3 : Int).fdiv 6
#eval (-4 : Int).fdiv 6
#eval (-5 : Int).fdiv 6
#eval (-6 : Int).fdiv 6 -- anything negative rounds to -1
#eval (-7 : Int).fdiv 6
#eval (-8 : Int).fdiv 6
#eval (-9 : Int).fdiv 6
#eval (-10 : Int).fdiv 6
#eval (-11 : Int).fdiv 6
#eval (-12 : Int).fdiv 6


-- n.ediv d =
-- theorem Int.ofNat_ediv_ofNat -- sorry
-- theorem Int.ofNat_ediv_negSucc -- sorry
-- theorem Int.ofNat_ediv_ofNat -- sorry
-- theorem Int.ofNat_ediv_ofNat -- sorry

/-
#check Int.bmod
#check Int.ediv_nonneg_of_nonpos_of_nonpos
theorem Int.bmod_eq_of_natAbs_lt (x : Int) (n : Nat) (hn : 2 * x.natAbs < n) :
    x.bmod n = x := by
  rcases x with x | x
  case ofNat =>
   simp at *;
   rw [Int.bmod_def]
   norm_cast
   have : x % n = x := by
    apply Nat.mod_eq_of_lt
    omega
   rw [this]
   have : x < (n + 1) / 2 := by
     rw [Nat.lt_div_iff_mul_lt (by decide)]
     omega
   simp [this]
  case negSucc =>
    simp at *
    norm_cast
    rw [Int.bmod_def]
    -- This is true because 'emod' will flip it over, making it larger that (n + 1) / 2
    have : ¬ (Int.negSucc x % (n : Int) < ((n : Int) + 1) / 2) := by
      rw [Int.emod_negSucc]
      simp
      sorry
    simp [this]
    have h := Int.ediv_add_emod (Int.negSucc x) n
    -- see that (Int.negSucc x / n) = -1, giving us the intended statement..
    -- This is true because 'Int.negSucc x < 0' and '(Int.negSucc x).natAbs < n'
    have hMinusOne : (Int.negSucc x / ↑n) = -1 := by
     rw [Int.div_def]
     sorry
    simp [hMinusOne] at h
    omega


theorem Int.eq_of_ofInt_zero_of_lt {w : Nat} {x : Int}
    (hx : BitVec.ofInt w x = 0#w) (hw : 2 * x.natAbs < 2 ^ w) : x = 0 := by
 have : BitVec.toInt (BitVec.ofInt w x) = BitVec.toInt (0#w) := by rw [hx]
 simp at this
 rw [Int.bmod_eq_of_natAbs_lt] at this
 · simp [this]
 · omega
-/

theorem BitVec.eq_zero_of_signExtend_eq_zero {x : BitVec w} {w' : Nat} (hw : w ≤ w')
    (hx : x.signExtend w' = 0#w') : x = 0#w := by
  have : (x.signExtend w').toNat = (0#w').toNat := by simp [hx]
  simp [BitVec.toNat_signExtend]at this
  apply BitVec.eq_of_toNat_eq
  simp only [BitVec.toNat_ofNat, Nat.zero_mod]
  have := this.1
  rw [Nat.mod_eq_of_lt] at this
  · exact this
  · apply Nat.lt_of_lt_of_le
    · exact x.isLt
    · apply Nat.pow_le_pow_of_le (by decide) hw

/-
theorem Factor.getLsbD_reflectBVFin_eq_false_iff_getLsbD_reflectBVFin_sext_eq_false (w w' : Nat) (f : Factor)
    (env : EnvFin w f.numVars) (hw : w ≤ w') :
    (∀ (i : Nat), (f.reflectBVFin env).getLsbD i = false) ↔ (∀ (i : Nat), (f.reflectBVFin (env.sext w')).getLsbD i = false) := by
  induction f
  case var n =>
    simp [reflectBVFin]
    constructor
    · intros h i
      simp [BitVec.getLsbD_signExtend, h i]
      intros hi hi'
      simp [BitVec.msb_eq_getLsbD_last, h]
      -- show that 2^w' <= 2^w
    · intros h
      intros i
      have := h i
      simp [BitVec.getLsbD_signExtend] at this
      sorry -- do case analysis
  case and x y hx hy  =>
   simp [reflectBVFin]
   sorry
  case or x y xh yh => sorry
  case xor x y xh yh => sorry
  case not x => sorry
-/




/-
/-- If we increase the bitwidth and sign-extend, the denotations must agree -/
theorem Eqn.denoteFin_eq_zero_iff_denoteFin_sext_eq_zero_of_le (w w' : Nat) (e : Eqn)
    (env : EnvFin w e.numVars) (hw : w ≤ w') :
    e.denoteIntFin env = 0 ↔ e.denoteIntFin (env.sext w') = 0 := by
  · sorry
-/

/--
This theory should work: Just pick a large enough field where showing that the value is zero
will prove that the value is zero
theorem Eqn.denote_hard_case_of_denote_mpr (e : Eqn)
    (h : ∀ (w : Nat) (env : List (BitVec w)), e.reflectBV env = 0) :
    ∀ (env1 : EnvFin 1 e.numVars), e.denoteIntFin env1 = 0 := by
  intros env1
  let size := (e.denoteIntFin env1).natAbs.log2 + 1
  specialize h size
  let env' := List.finRange e.numVars |>.map fun x => (env1 x).signExtend size
  specialize h env'
  simp [env'] at h
  sorry
-/


/-
instance decEqnDenoteFinWidth1 {e : Eqn} : Decidable (∀ env1 : Env (BitVec 1), Eqn.denoteIntFin e env1 = 0) :=
  sorry

instance {e : Eqn} : Decidable (∀ env1 : List (BitVec 1), Eqn.denoteInt e env1 = 0) :=
  sorry
-/

def Eqn.reflectBVEqZero (w : Nat) (eqn : Eqn) (env : Env w) : Prop :=
  Eqn.reflectBV eqn env = BitVec.ofInt w 0

/--
Central theorem: To decide if a bitvector equation is zero for all widths, it sufficest to check that the denotation is zero at width zero.
-/
theorem Eqn.forall_width_reflectBV_zero_of_width_one_denote_zero (e : Eqn) (w : Nat) (env : List (BitVec w))
    (h : (∀ env1 : EnvFin 1 e.numVars, Eqn.denoteIntFin e env1 = 0)) :
    Eqn.reflectBVEqZero w e env := by
  rw [Eqn.reflectBVEqZero]
  rw [Eqn.reflectBV_eq_zero_of_denoteFin_width_one_eq_zero]
  simp
  apply h


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
instance (e : Eqn) : Decidable (∀ env1 : EnvFin 1 e.numVars, Eqn.denoteIntFin e env1 = 0) :=
  let ⟨allEnvs, hAllEnvs⟩ := EnvFin.getAll1 e.numVars
  let b := allEnvs.all (fun env1 => e.denoteIntFin env1 = 0)
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



namespace reflectBV
open Lean Elab Meta Tactic

abbrev Ix := Nat

structure State where
  -- Exprressions to indexes in the interned object.
  e2ix : Std.HashMap Expr Ix := {}

abbrev M := StateRefT State MetaM

partial def reflectBVFactor (e : Expr) : M Factor := do
  match_expr e with
  | HAnd.hAnd _bv _bv _bv _inst a b =>
     return Factor.and (← reflectBVFactor a) (← reflectBVFactor b)
  | HOr.hOr _bv _bv _bv _inst a b =>
     return Factor.or (← reflectBVFactor a) (← reflectBVFactor b)
  | HXor.hXor _bv _bv _bv _inst a b =>
     return Factor.xor (← reflectBVFactor a) (← reflectBVFactor b)
  | Complement.complement _bv _inst a =>
     return Factor.not (← reflectBVFactor a)
  | _ =>
    let s ← get
    match s.e2ix[e]? with
    | .some ix => return Factor.var ix
    | .none => do
       let ix := s.e2ix.size
       set { s with e2ix := s.e2ix.insert e ix }
       return .var ix

def reflectBVTermCoeff (e : Expr) : M Int :=
  match_expr e with
  | BitVec.ofInt _w i => do
    let .some i := Expr.int? i
      | throwError "Expected 'BitVec.ofInt w <constant int>' at '{e}', found {i}"
    return i
  | Int.cast _ _ i => do
    let .some i := Expr.int? i
      | throwError "Expected Int.cast <constant int>' at '{indentD e}', found {i}"
    return i
  | _ => throwError "unable to reflectBV term coefficient '{indentD e}'. Expected an integer."

def reflectBVTerm (e : Expr) : M Term :=
  match_expr e with
  | HMul.hMul _bv _bv _bv _inst l r => do
    let c ← reflectBVTermCoeff l
    let f ← reflectBVFactor r
    return { c, f }
  | _ => throwError "unable to reflectBV term '{indentD e}'.\nExpected 'int * variable'."

/-!
Recall that add and sub in lean are associated to the left, so we have
((a + b) + c) + d and so on.
-/
partial def reflectBVEqnAux (e : Expr) : M Eqn :=
  match_expr e with
  | HAdd.hAdd _bv _bv _bv _inst l rs => do
    let t ← reflectBVTerm l
    let eqn ← reflectBVEqnAux rs
    return t :: eqn
  | _ => do return [← reflectBVTerm e]

/- The expression corresponding to the bitwidth we are working with -/
abbrev WidthExpr := Expr

def reflectBVEqn (e : Expr) : M (WidthExpr × Eqn) := do
  let .some (ty, lhs, _rhs) := Expr.eq? e
    | throwError "expected top-level equality, but found {e}"
  let_expr BitVec w := ty
    | throwError "expected equality of bitvectors, but found {indentD ty}"
  logInfo m!"found top-level equality LHS '{lhs}'"
  return (w, ← reflectBVEqnAux lhs)

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
    let ((widthExpr, eqn), reflectBVState) ← g.withContext do runM <| reflectBVEqn (← g.getType)
    logInfo m!"found expression of width: '{indentD widthExpr}'"
    let env ← State.envToExpr widthExpr reflectBVState
    logInfo m!"replacing goal with reflectBVed version. Equation: {indentD <| repr eqn}"
    logInfo m!"Environment: {indentD (toMessageData reflectBVState.e2ix.toList)}"
    -- let reflectBVedLhs ← mkAppM ``Eqn.reflectBV #[Eqn.toExpr eqn, env]
    -- let reflectBVedRhs := mkApp2 (mkConst ``BitVec.ofInt) widthExpr (toExpr (0 : Int))
    -- let g ← g.replaceTargetDefEq (← mkEq reflectBVedLhs reflectBVedRhs)
    -- logInfo m!"Replaced. {indentD g}"
    -- apply: Eqn.forall_width_reflectBV_zero_of_width_one_denote_zero

    let gs ← g.withContext do g.apply (mkAppN (mkConst ``Eqn.forall_width_reflectBV_zero_of_width_one_denote_zero []) #[Eqn.toExpr eqn, widthExpr, env])
    let [g] := gs
      | throwError m!"expected single goal after applying reflectBVion theorem, found {gs}"
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

end reflectBV
end Tactic

namespace Examples


example (x y : BitVec w) :
  Eqn.reflectBVEqZero w
    [Term.mk 1 (.var 0), Term.mk 2 (.var 1)] [x, y] =
    (BitVec.ofInt w 1 * x + BitVec.ofInt w 2 * y = BitVec.ofInt w 0) := rfl

example (x y : BitVec w) :
  Eqn.reflectBVEqZero w
    [Term.mk 1 (.var 0), Term.mk 2 (.var 1), Term.mk (-1) (.var 0)] [x, y] =
    (BitVec.ofInt w 1 * x + (BitVec.ofInt w 2 * y + BitVec.ofInt w (-1) * x) = BitVec.ofInt w 0) := rfl

theorem eg3 (x y : BitVec w) :
     - 2 *  ~~~(x &&&  ~~~y) + 2 *  ~~~x - 5 *  ~~~(x |||  ~~~y) = 3 * (x &&& y) - 5 * y := by
  bv_mba

/-- info: 'MBA.Examples.eg3' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms eg3

end Examples
end MBA


