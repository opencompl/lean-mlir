import SSA.Core

open Ctxt (Var Valuation)

/- # Datastructures -/
section DataStructures

inductive Op
  | const (x : Nat)
  | add
  | ite
  deriving DecidableEq

inductive Ty
  | nat
  deriving DecidableEq

def Op.outTy : Op → Ty
  | _ => .nat

def Op.sig : Op → List Ty
  | .const _ => []
  | .add => [.nat, .nat]
  | .ite => [.nat]

def Op.regSig : Op → RegionSignature Ty
  | .const _ | .add => []
  | .ite => [
      ⟨ ∅, .nat ⟩,
      ⟨ ∅, .nat ⟩
    ]


instance : TyDenote Ty where
  toType
  | .nat => Nat


inductive Terminator (ℓ : Type) (L : ℓ → Ty) (Γ : Ctxt Ty) : (t : Ty) → Type
  | ret (v : Γ.Var t) : Terminator ℓ L Γ t
  | goto (l : ℓ) : Terminator ℓ L Γ (L l)

mutual

/-- An intrinsically typed instruction whose effect is *at most* EffectKind -/
inductive Inst : (Γ : Ctxt Ty) → (ty : Ty) → Type where
  | mk {Γ} {ty} (op : Op)
    (ty_eq : ty = op.outTy)
    (args : HVector (Var Γ) <| op.sig)
    (regArgs : Regions <| op.regSig) : Inst Γ ty

inductive Region : (Γ : Ctxt Ty) → (ty : Ty) → Type
  | mk
      (ℓ : Set String)
      (entry : ℓ)
      (L : ℓ → Ty)
      (blocks : (l : ℓ) → Block ℓ L Γ (L l))
      : Region Γ (L entry)

inductive Regions : (ρ : RegionSignature Ty) → Type
  | mk : HVector (fun r => Region r.1 r.2) ρ → Regions ρ

/-- A very simple intrinsically typed program: a sequence of let bindings.
Note that the `EffectKind` is uniform: if a `Com` is `pure`, then the expression
and its body are pure, and if a `Com` is `impure`, then both the expression and
the body are impure!
-/
inductive Block : (ℓ : Set String) → (L : ℓ → Ty) → (Γ : Ctxt Ty) → (t : Ty) → Type where
  | term {ℓ : Set String} {L : ℓ → Ty} : Terminator ℓ L Γ t → Block ℓ L Γ t
  | var (e : Inst Γ α) (body : Block ℓ L (Γ.snoc α) β) : Block ℓ L Γ β

end


/-!

## Semantics

-/


mutual


def Inst.denote (i : Inst Γ ty) (V : Γ.Valuation) : Option (Γ.snoc ty).Valuation :=
  match i with
  | ⟨op, _ty_eq, args, regArgs⟩ => do
    let val : Option ⟦ty⟧ := match op, args, regArgs with
      | .const x, _, _ => some x
      | .add, v ::ₕ (w ::ₕ _), _ =>
          let x : Nat := V v
          let y : Nat := V w
          some <| x + y
      | .ite, v ::ₕ _, ⟨th ::ₕ els ::ₕ _⟩ =>
          let c : Nat := V v
          -- if c = 0 then
          th.denote .nil
          -- else
          --   els.denote .nil
          -- c
    (V.snoc ·) <$> val
  partial_fixpoint

def Block.denote (V : Γ.Valuation) : Block ℓ L Γ t → Option (⟦t⟧ ⊕ { l : ℓ // L l = t } )
  | .term t => match t with
    | .ret v => return .inl (V v)
    | .goto l => return .inr ⟨l, rfl⟩
  | .var i body => do
      let V ← i.denote V
      body.denote V
  partial_fixpoint

def Region.denote (V : Γ.Valuation) : Region Γ t → Option ⟦t⟧
  | .mk ℓ entry L blocks =>
    Region.denoteBlock V ℓ entry L blocks
  partial_fixpoint

def Region.denoteBlock (V : Γ.Valuation) (ℓ : Set String) (l : ℓ) (L : ℓ → Ty)
      (blocks : (l : ℓ) → Block ℓ L Γ (L l)) : Option ⟦L l⟧ := do
  match (← (blocks l).denote V) with
  | .inl val      => return val
  | .inr l'  =>
    let ⟨l', h⟩ := l'
    (h ▸ ·) <$> Region.denoteBlock V ℓ l' L blocks
  partial_fixpoint

def Regions.denote  : Regions ρ → (HVector (fun r => r.1.Valuation → Option ⟦r.2⟧) ρ)
  | .mk regions =>
      sorry
      -- regions.map (fun _ r V => r.denote V)

end
