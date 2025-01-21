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
| term (n : Nat)
| and (x y : Factor) 
| or (x y : Factor) 
| xor (x y : Factor) 
| not (x : Factor) 

def Env (w : Nat) := List (BitVec w)
def Env.getLsb (env : Env w) : Env 1 := env.map <| fun x => BitVec.ofBool <| x.getLsbD 0
def Env.getNonLsbs (env : Env w) : Env (w-1) := env.map <| fun x => x.extractLsb' 1 (w-1)
  

def Factor.reflect {w : Nat} (xs : Env w) : Factor → BitVec w 
| .term n => xs.getD n (0#w)
| .and x y => x.reflect xs &&& y.reflect xs
| .or x y => x.reflect xs ||| y.reflect xs
| .xor x y => x.reflect xs ^^^ y.reflect xs
| .not x => ~~~ (x.reflect xs)

def Factor.denote {w : Nat} (xs : Env w) (f : Factor) : Int := f.reflect xs |>.toInt

theorem Factor.reflect_eq_ofInt_denote {w : Nat} (xs : Env w) (f : Factor) : 
    f.reflect xs = (BitVec.ofInt w <| f.denote xs) := by
  simp [reflect, denote]

@[simp]
theorem Factor.reflect_zero_of_denote_zero {w : Nat} {f : Factor} {xs : Env w} (h : f.denote xs = 0) : 
    f.reflect xs = 0#w := by
  simp [reflect_eq_ofInt_denote, h]


@[simp]
theorem Factor.reflect_width_zero  (f : Factor) (env : Env 0) : 
   f.reflect env = 0#0 := by
  apply Subsingleton.elim


structure Term where 
  c : Int
  f : Factor

/-- Reflect is what we use for reflection -/
def Term.reflect {w : Nat}  (t : Term) (xs: Env w) : BitVec w := 
  t.c * t.f.reflect xs 

def Term.denote {w : Nat} (t : Term) (xs : Env w) : Int := 
  t.c * t.f.denote xs


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

def Eqn := List Term

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

@[simp]
theorem Eqn.reflect_width_zero  (es : Eqn) (env : Env 0) : 
    Eqn.reflect es env = 0 := by 
  induction es 
  case nil => simp [Eqn.reflect]
  case cons e es ih => 
    simp [ih, Eqn.reflect]
    apply Subsingleton.elim

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
  
      
theorem Eqn.denote_hard_case (e : Eqn) (h : ∀ (env1 : List (BitVec 1)), Eqn.reflect e env1 = 0) :
    ∀ {w : Nat} (env : List (BitVec w)), e.reflect env = 0 := by
  intros w env 
  induction w 
  case zero => simp
  case succ w ih =>
    sorry

theorem Eqn.denote_iff_denote_one (e : Eqn) : 
    (∀ (w : Nat) (env : List (BitVec w)), Eqn.reflect e env = 0) ↔ 
    (∀ env1 : List (BitVec 1), Eqn.reflect e env1 = 0) := by
  constructor 
  · intros h
    apply h
  · intros h
    intros w env
    rw [Eqn.denote_hard_case]
    exact h

end MBA

