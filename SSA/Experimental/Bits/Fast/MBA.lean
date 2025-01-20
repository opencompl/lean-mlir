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

def Eqn := List (Int × Factor)

def Eqn.denote (e : List (Int × Factor)) 
    (w : Nat) (env : List (BitVec w)) : BitVec w := 
  match e with
  | [] => 0#w
  | (coeff, x) :: xs => coeff * (x.denote w env) + Eqn.denote xs w env 

theorem Eqn.denote_succ (e : Eqn) (w : Nat) (env : List (BitVec (w + 1))) : 
    Eqn.denote e (w + 1) env = 
    BitVec.concat (Eqn.denote e w (env.map <| fun x => x.setWidth ..))
      ((Eqn.denote e 1 (env.map <| fun x => BitVec.ofBool <| x.getLsbD 0)).getLsbD 0) := sorry

theorem Eqn.denote_hard_case (e : Eqn) (h : ∀ (env : List (BitVec 1)), Eqn.denote e 1 env = 0) :
    ∀ (w : Nat) (env : List (BitVec w)), Eqn.denote e w env = 0 := by
  intros w env 
  induction w 
  case zero =>
    apply Subsingleton.elim
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

end MBA

