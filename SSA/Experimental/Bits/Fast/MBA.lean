@[simp]
theorem BitVec.zero_concat (b : Bool) : (0#0).concat b = BitVec.ofBool b := by
  apply BitVec.eq_of_getLsbD_eq
  simp

namespace MBA

inductive Factor 
| ofNat (x : Nat)
| term (n : Nat)
| and (x y : Factor) 
| or (x y : Factor) 
| xor (x y : Factor) 
| not (x : Factor) 

def Factor.denote (w : Nat) (xs : List (BitVec w)) : Factor → BitVec w 
| .ofNat x => BitVec.ofNat w x
| .term n => xs.getD n (0#w)
| .and x y => x.denote w xs &&& y.denote w xs
| .or x y => x.denote w xs &&& y.denote w xs
| .xor x y => x.denote w xs &&& y.denote w xs
| .not x => ~~~ (x.denote w xs)

@[simp]
theorem Factor.denote_width_zero  (f : Factor) (env : List (BitVec 0)) : 
   f.denote 0 env = 0#0 := by
  apply Subsingleton.elim

def Eqn := List (Int × Factor)

def Eqn.denote (e : List (Int × Factor)) 
    (w : Nat) (env : List (BitVec w)) : Int := 
  match e with
  | [] => 0
  | (coeff, x) :: xs => coeff * (x.denote w env).toInt + Eqn.denote xs w env 

@[simp]
theorem Eqn.denote_nil  (w : Nat) (env : List (BitVec w)) : 
    Eqn.denote [] w env = 0 := rfl

@[simp]
theorem Eqn.denote_cons
    (coeff : Int) (x : Factor) (es : List (Int × Factor)) (w : Nat) (env : List (BitVec w)) : 
    Eqn.denote ((coeff, x) :: es) w env = coeff * (x.denote w env).toInt + Eqn.denote es w env := rfl

@[simp]
theorem Eqn.denote_width_zero  (es : List (Int × Factor)) (env : List (BitVec 0)) : 
    Eqn.denote es 0 env = 0 := by 
  induction es 
  case nil => simp [Eqn.denote]
  case cons e es ih => 
    obtain ⟨c, f⟩ := e
    simp [ih]

/-
@[simp]
theorem Eqn.denote_cons'
    (e : Int × Factor) (es : List (Int × Factor)) (w : Nat) (env : List (BitVec w)) : 
    Eqn.denote (e :: es) w env = e.1 * (e.2.denote w env) + Eqn.denote es w env := rfl

@[simp]
theorem Eqn.denote_zero (e : List (Int × Factor)) (env : List (BitVec 0)) : 
    Eqn.denote e 0 env = 0#0 := by 
  apply Subsingleton.elim
-/

theorem Eqn.denote_succ (e : Eqn) (w : Nat) (env : List (BitVec (w + 1))) : 
    Eqn.denote e (w + 1) env = 
      2 * (Eqn.denote e w (env.map <| fun x => x.extractLsb' 1 w)) +
      (Eqn.denote e 1 (env.map <| fun x => BitVec.ofBool <| x.getLsbD 0)) := by
  induction w
  case zero => 
    simp
    induction e 
    case nil => simp
    case cons e es ih =>
      obtain ⟨coeff, f⟩ := e
      simp
      rw [← ih]
      congr
      suffices heq : (fun x => BitVec.ofBool (x.getLsbD 0)) = id by simp [heq]
      ext x i hi
      have : i = 0 := by omega
      simp [this]
  case succ w ih =>
    sorry
    

theorem Eqn.denote_hard_case (e : Eqn) (h : ∀ (env : List (BitVec 1)), Eqn.denote e 1 env = 0) :
    ∀ (w : Nat) (env : List (BitVec w)), Eqn.denote e w env = 0 := by
  intros w env 
  induction w 
  case zero => simp
  case succ w ih =>
    rw [Eqn.denote_succ]
    rw [h]
    rw [ih]
    simp

theorem Eqn.denote_iff_denote_one (e : Eqn) : 
    (∀ (w : Nat) (env : List (BitVec w)), Eqn.denote e w env = 0) ↔ 
    (∀ env : List (BitVec 1), Eqn.denote e 1 env = 0) := by
  constructor 
  · intros h
    apply h
  · intros h
    intros w env
    rw [Eqn.denote_hard_case]
    exact h

end MBA

