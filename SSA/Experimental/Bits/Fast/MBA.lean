import Lean

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

def Factor.numVars : Factor → Nat
| .var n => n+1
| .and x y | .or x y | xor x y => max (x.numVars) (y.numVars)
| .not x => x.numVars

@[simp]
theorem Factor.numVars_term : (Factor.var n).numVars = n + 1 := rfl

abbrev Env (w : Nat) := List (BitVec w)
def Env.getLsb {w : Nat} (env : Env w) : Env 1 := env.map <| fun x => BitVec.ofBool <| x.getLsbD 0
def Env.getNonLsbs {w : Nat} (env : Env w) : Env (w-1) := env.map <| fun x => x.extractLsb' 1 (w-1)

@[simp]
theorem Env.getLsb_getElem {env : Env w} (n : Nat) : (Env.getLsb env)[n]? = (env[n]?).map (fun (x : BitVec w) => BitVec.ofBool (x.getLsbD 0)) := by
  simp [Env.getLsb]
  
def Factor.reflect {w : Nat} (xs : Env w) : Factor → BitVec w 
| .var n => xs.getD n (0#w)
| .and x y => x.reflect xs &&& y.reflect xs
| .or x y => x.reflect xs ||| y.reflect xs
| .xor x y => x.reflect xs ^^^ y.reflect xs
| .not x => ~~~ (x.reflect xs)



def Factor.denote {w : Nat} (xs : Env w) (f : Factor) : Int := f.reflect xs |>.toInt

theorem Factor.denote_eq_toInt_reflect {w : Nat} (xs : Env w) (f : Factor) : 
  f.denote xs = (f.reflect xs |>.toInt) := rfl

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

def Factor.denoteFin {w : Nat} (f : Factor) (xs : EnvFin w f.numVars) : Int := f.reflectFin xs |>.toInt

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

theorem Factor.denote_eq_toInt_reflectFin {w : Nat} (xs : Env w) (f : Factor) : 
    f.denote xs = (f.reflectFin (fun i => xs[i]?.getD 0#w)).toInt := by 
  rw [Factor.denote_eq_toInt_reflect]
  rw [reflect_eq_reflectFin]
  simp

theorem Factor.reflectFin_toInt_eq 
    {w : Nat} {x : Factor} {env : EnvFin (w +1) x.numVars} :
    (x.reflectFin env).toInt = 2 * (x.reflectFin env.getNonLsbs).toInt +  ((x.reflectFin env.getLsb).getLsbD 0).toInt := by
  rw [Factor.reflectFin_eq_reflectFin_getLsb_reflectFin_getNonLsbs]
  simp
  rcases w with rfl | w


/-- Split a denote at an env intoa denote at the LSB and the denote at the non-Lsbs -/
theorem Factor.denote_eq_add_denote_getLsb_denote_getNonLsbs (x : Factor) (xs : Env (w + 1)) : 
    x.denote env = 2 * x.denote xs.getNonLsbs + x.denote xs.getLsb := by
  simp

structure Term where 
  c : Int
  f : Factor

/-- Reflect is what we use for reflection -/
def Term.reflect {w : Nat}  (t : Term) (xs: Env w) : BitVec w := 
  t.c * t.f.reflect xs 

def Term.denote {w : Nat} (t : Term) (xs : Env w) : Int := 
  t.c * t.f.denote xs

def Term.numVars (t : Term) : Nat := t.f.numVars

def Term.denoteFin {w : Nat} (t : Term) (xsFin: EnvFin w t.numVars) : Int :=
  t.c * t.f.denoteFin xsFin

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

def Eqn := List Term

def Eqn.numVars (e : Eqn) : Nat := 
  match e with 
  | [] => 0 
  | e :: es => max e.numVars (Eqn.numVars es)

def Eqn.reflect {w : Nat} (e : Eqn) (env : Env w) : BitVec w := 
  match e with
  | [] => 0
  | t :: ts => t.reflect env + Eqn.reflect ts env


@[simp]
theorem Eqn.reflect_nil  {w : Nat} (env : Env w) : 
    Eqn.reflect [] env = 0 := rfl

@[simp]
theorem Eqn.reflect_cons {w : Nat}
    (t : Term) (ts : List Term) (env : Env w) : 
    Eqn.reflect (t :: ts) env = t.reflect env + Eqn.reflect ts env := rfl


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
  | t :: ts => t.denoteFin (fun n => envFin ⟨n, by simp [Eqn.numVars]; omega⟩) + Eqn.denoteFin ts (fun n => envFin ⟨n, by simp [Eqn.numVars]; omega⟩)

/- To evaluate `e.denote`, one can equally well evaluate `e.denoteFin` -/
theorem Eqn.denoteFin_eq_denote {e : Eqn} {xs : List (BitVec w)} {xsFin : EnvFin w e.numVars} (h : ∀ (i : Fin e.numVars), xs[i]?.getD 0#w = xsFin i) :
    e.denoteFin xsFin = e.denote xs := by 
  induction e 
  case nil => simp [Eqn.denoteFin]
  case cons t es ih => 
    simp [Eqn.denoteFin]
    rw [Term.denoteFin_eq_denote (xs := xs)]
    · simp
      rw [ih]
      · intros i 
        rw [← h]
        simp
    · intros i
      rw [← h]
      simp
       
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


theorem Eqn.denote_hard_case (e : Eqn) (h : ∀ (env1 : List (BitVec 1)), Eqn.denote e env1 = 0) :
    ∀ {w : Nat} (env : List (BitVec w)), e.reflect env = 0 := by
  intros w env 
  induction w 
  case zero => simp
  case succ w ih =>
    rw [Eqn.reflect_eq_ofInt_denote]
    induction e 
    case nil => simp
    case cons t es ih =>
    sorry

/-
instance decEqnDenoteFinWidth1 {e : Eqn} : Decidable (∀ env1 : Env (BitVec 1), Eqn.denoteFin e env1 = 0) := 
  sorry

instance {e : Eqn} : Decidable (∀ env1 : List (BitVec 1), Eqn.denote e env1 = 0) := 
  sorry
-/
  

/--
Central theorem: To decide if a bitvector equation is zero for all widths, it sufficest to check that the denotation is zero at width zero.
-/
theorem Eqn.forall_width_reflect_zero_of_width_one_denote_zero (e : Eqn) (h : (∀ env1 : List (BitVec 1), Eqn.denote e env1 = 0)) : 
    ∀ (w : Nat) (env : List (BitVec w)), Eqn.reflect e env = 0 := by
  intros w env
  rw [Eqn.denote_hard_case]
  exact h

end MBA

