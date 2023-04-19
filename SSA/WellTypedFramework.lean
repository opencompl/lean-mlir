import SSA.Framework

class TypeSemantics (Kind : Type) : Type 1 where
  toType : Kind → Type
  unit : Kind
  pair : Kind → Kind → Kind
  triple : Kind → Kind → Kind → Kind
  mkPair : ∀ {k1 k2 : Kind}, toType k1 → toType k2 → toType (pair k1 k2)
  fstPair : ∀ {k1 k2 : Kind}, toType (pair k1 k2) → toType k1
  sndPair : ∀ {k1 k2 : Kind}, toType (pair k1 k2) → toType k2
  mkTriple : ∀ {k1 k2 k3 : Kind}, toType k1 → toType k2 → toType k3 → toType (triple k1 k2 k3)
  fstTriple : ∀ {k1 k2 k3 : Kind}, toType (triple k1 k2 k3) → toType k1
  sndTriple : ∀ {k1 k2 k3 : Kind}, toType (triple k1 k2 k3) → toType k2
  trdTriple : ∀ {k1 k2 k3 : Kind}, toType (triple k1 k2 k3) → toType k3

open TypeSemantics

class TypedUserSemantics (Op : Type) (Kind : Type) [TypeSemantics Kind] where
  argKind : Op → Kind
  rgnDom : Op → Kind
  rgnCod : Op → Kind
  outKind : Op → Kind
  eval : ∀ (o : Op), toType (argKind o) → (toType (rgnDom o) →
    toType (rgnCod o)) → toType (outKind o)


namespace TypedUserSemantics

variable (Op : Type) (Kind : Type) [TypeSemantics Kind] [TypedUserSemantics Op Kind]

inductive Context (Kind : Type) where
  | empty : Context Kind
  | push : Context Kind → Var → Kind → Context Kind

inductive CVar {Kind : Type} : Context Kind → Kind → Type where
  | here : ∀ {Γ : Context Kind} {k : Kind}, CVar (Γ.push v k) k
  | there : ∀ {Γ : Context Kind} {k₁ k₂ : Kind} {v : Var}, CVar Γ k₁ → CVar (Γ.push v k₂) k₁

/-- Us mucking around to avoid mutual inductives.  -/
inductive TSSAIndex : Type
/-- LHS := RHS. LHS is a `Var` and RHS is an `SSA Op .EXPR` -/
| STMT : Context Kind → TSSAIndex
/-- Ways of making an RHS -/
| EXPR : Kind → TSSAIndex
/-- The final instruction in a region. Must be a return -/
| TERMINATOR : Kind → TSSAIndex
/-- a lambda -/
| REGION : Kind → Kind → TSSAIndex

inductive TSSA (Op : Type) {Kind : Type} [TypeSemantics Kind] [TypedUserSemantics Op Kind] :
    (Γ : Context Kind) → (Γr : Context (Kind × Kind)) → TSSAIndex Kind → Type where
  /-- lhs := rhs; rest of the program -/
  | assign {k : Kind} (lhs : Var) (rhs : TSSA Op Γ Γr (.EXPR k))
      (rest : TSSA Op (Γ.push lhs k) Γr (.STMT Γ')) : TSSA Op Γ Γr (.STMT (Γ'.push lhs k))
  /-- no operation. -/
  | nop : TSSA Op Γ Γr (.STMT Context.empty)
  /-- above; ret v -/
  | ret {k : Kind} (above : TSSA Op Γ Γr (.STMT Γ')) (v : CVar Γ' k) : TSSA Op Γ Γr (.TERMINATOR k)
  /-- (fst, snd) -/
  | pair (fst : CVar Γ k₁) (snd : CVar Γ k₂) : TSSA Op Γ Γr (.EXPR (pair k₁ k₂))
  /-- (fst, snd, third) -/
  | triple (fst : CVar Γ k₁) (snd : CVar Γ k₂) (third : CVar Γ k₃) : TSSA Op Γ Γr (.EXPR (triple k₁ k₂ k₃))
  /-- op (arg) { rgn } rgn is an argument to the operation -/
  | op (o : Op) (arg : CVar Γ (argKind o)) (rgn : TSSA Op Γ Γr (.REGION (rgnDom o) (rgnCod o))) :
      TSSA Op Γ Γr (.EXPR (outKind o))
  /- fun arg => body -/
  | rgn {arg : Var} {dom cod : Kind} (body : TSSA Op (Γ.push arg dom) Γr (.TERMINATOR cod)) :
      TSSA Op Γ Γr (.REGION dom cod)
  /- no function / non-existence of region. -/
  | rgn0 : TSSA Op Γ Γr (.REGION unit unit)
  /- a region variable. --/
  | rgnvar (v : CVar Γr (k₁, k₂)) : TSSA Op Γ Γr (.REGION k₁ k₂)
  /-- a variable. -/
  | var (v : CVar Γ k) : TSSA Op Γ Γr (.EXPR k)
/- TODO - Write a translation that takes a pair of SSA and optionally returns a pair
 of valid contexts and TSSA. Write the evaluation for a TSSA. -/

variable {Op Kind}

@[simp]
def Context.eval (Γ : Context Kind) : Type :=
  ∀ ⦃k : Kind⦄, CVar Γ k → toType k

@[simp]
def Context.evalr (Γr : Context (Kind × Kind)) : Type :=
  ∀ ⦃k₁ k₂ : Kind⦄, CVar Γr (k₁, k₂) → toType k₁ → toType k₂

@[simp]
def TSSAIndex.eval : TSSAIndex Kind → Type
  | .STMT Γ' => Context.eval Γ'
  | .EXPR k => toType k
  | .TERMINATOR k => toType k
  | .REGION dom cod => toType dom → toType cod

@[simp]
def TSSA.eval : {Γ : Context Kind} → {Γr : Context (Kind × Kind)} →
    {i : TSSAIndex Kind} → TSSA Op Γ Γr i → Γ.eval → Γr.evalr → i.eval
  | Γ, Γr, _, .assign lhs rhs rest => fun c₁ c₂ _ v =>
    match v with
    | CVar.here => rhs.eval c₁ c₂
    | CVar.there v => rest.eval
      (fun _ v' =>
        match v' with
        | CVar.here => rhs.eval c₁ c₂
        | CVar.there v'' => c₁ v'') c₂ v
  | _, _, _, .nop => fun _ _ _ v => by cases v
  | _, _, _, .ret above v => fun c₁ c₂ => above.eval c₁ c₂ v
  | _, _, _, .pair fst snd => fun c₁ _ => mkPair (c₁ fst) (c₁ snd)
  | _, _, _, .triple fst snd third =>
    fun c₁ _ => mkTriple (c₁ fst) (c₁ snd) (c₁ third)
  | _, _, _, TSSA.op o arg rg => fun c₁ c₂ =>
    TypedUserSemantics.eval o (c₁ arg) (rg.eval c₁ c₂)
  | _, _, _, .rgn body => fun c₁ c₂ arg =>
    body.eval (fun _ v =>
      match v with
      | CVar.here => arg
      | CVar.there v' => c₁ v') c₂
  | _, _, _, .rgn0 => fun _ _ => id
  | _, _, _, .rgnvar v => fun _ c₂ => c₂ v
  | _, _, _, .var v => fun c₁ _ => c₁ v

end TypedUserSemantics