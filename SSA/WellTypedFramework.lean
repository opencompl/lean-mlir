import SSA.Framework
import Mathlib.Data.Option.Basic

/-
Typeclass for a `baseType` which is a godel code of 
Lean types.
-/
class Goedel (β : Type)  : Type 1 where
  toType : β → Type
open Goedel /- make toType publically visible in module. -/

notation "⟦" x "⟧" => Goedel.toType x

instance : Goedel Unit where toType := fun _ => Unit

inductive UserType (T : Type) : Type where
  | base : T → UserType T
  | pair : UserType T → UserType T → UserType T
  | triple : UserType T → UserType T → UserType T → UserType T
  | unit : UserType T

namespace UserType

instance: Inhabited (UserType β) where default := UserType.unit

def toType [Goedel β] : UserType β → Type
  | .base t =>  ⟦t⟧
  | .pair k₁ k₂ => (toType k₁) × (toType k₂)
  | .triple k₁ k₂ k₃ => toType k₁ × toType k₂ × toType k₃
  | .unit => Unit

instance [Goedel β] : Goedel (UserType β) where
  toType := toType 

def mkPair [Goedel β] {k₁ k₂ : UserType β}: ⟦k₁⟧ → ⟦k₂⟧ → ⟦k₁.pair k₂⟧
  | k₁, k₂ => (k₁, k₂)

def mkTriple [Goedel β] {k₁ k₂ k₃ : UserType β}: ⟦k₁⟧ → ⟦k₂⟧ → ⟦k₃⟧ → ⟦k₁.triple k₂ k₃⟧
  | k₁, k₂, k₃ => (k₁, k₂, k₃)

def fstPair [Goedel β] {k₁ k₂ : UserType β} : ⟦k₁.pair k₂⟧ → ⟦k₁⟧
  | (k₁, _) => k₁

def sndPair [Goedel β] {k₁ k₂ : UserType β} : ⟦k₁.pair k₂⟧ → ⟦k₂⟧
  | (_, k₂) => k₂

def fstTriple [Goedel β] {k₁ k₂ k₃ : UserType β} : ⟦k₁.triple k₂ k₃⟧ → ⟦k₁⟧
  | (k₁, _, _) => k₁

def sndTriple [Goedel β] {k₁ k₂ k₃ : UserType β} : ⟦k₁.triple k₂ k₃⟧ → ⟦k₂⟧
  | (_, k₂, _) => k₂

def trdTriple [Goedel β] {k₁ k₂ k₃ : UserType β} : ⟦k₁.triple k₂ k₃⟧ → ⟦k₃⟧
  | (_, _, k₃) => k₃

end UserType


structure UserData [Goedel β] where
  type : UserType β
  value : toType type


inductive  TypeData (β : Type) : Type
  | some : β → TypeData β
  | unit : TypeData β
  | pair : TypeData β → TypeData β → TypeData β
  | triple : TypeData β → TypeData β → TypeData β → TypeData β
  | any : TypeData β
  | unused : TypeData β -- Or bound

@[coe]
def UserType.toTypeData [Goedel β] : UserType β → TypeData β
  | UserType.base t => TypeData.some t
  | UserType.unit => TypeData.unit
  | UserType.pair k₁ k₂ => TypeData.pair (UserType.toTypeData k₁) (UserType.toTypeData k₂)
  | UserType.triple k₁ k₂ k₃ => TypeData.triple (UserType.toTypeData k₁) (UserType.toTypeData k₂)
    (UserType.toTypeData k₃)

variable {β : Type} [instDecidableEqBaseType : DecidableEq β] [instGoedel : Goedel β]
instance : Coe (UserType β) (TypeData β) := ⟨UserType.toTypeData⟩

class TypedUserSemantics (Op : Type) (β : Type) [Goedel β] where
  argKind : Op → UserType β
  rgnDom : Op → UserType β
  rgnCod : Op → UserType β
  outKind : Op → UserType β
  eval : ∀ (o : Op), toType (argKind o)  → (toType (rgnDom o) →
    toType (rgnCod o)) → toType (outKind o)

@[simp]
def TypeData.toType : TypeData β → Type
  | TypeData.some t => Goedel.toType t
  | TypeData.unit => Unit
  | TypeData.pair t₁ t₂ => (TypeData.toType  t₁) × (TypeData.toType t₂)
  | TypeData.triple t₁ t₂ t₃ => (TypeData.toType t₁) × (TypeData.toType t₂) × (TypeData.toType t₃)
  | TypeData.any => Σ (k : UserType β), ⟦k⟧
  | TypeData.unused => Unit

instance : Goedel (TypeData β) where
  toType := TypeData.toType

theorem TypeDataToTypeEqUserTypeToType (a : UserType β) : 
  toType a = TypeData.toType a.toTypeData :=
  by
    induction a <;> 
      (simp [Goedel.toType, TypeData.toType, UserType.toType] at * <;> aesop)


@[simp]
def SSAIndex.ieval (Op : Type) (β : Type) : SSAIndex → Type
  | .TERMINATOR => TypeData β
  | .EXPR => TypeData β
  | .REGION => TypeData β × TypeData β
  | .STMT => List Var

abbrev K (β : Type)  
  : Type → Type := StateT ((Var → TypeData β) × (Var → (TypeData  β × TypeData β))) Option

-- Lean gets very picky here and wants to get all instances passed explicit to be sure they're the same
def getVars : K β (Var → TypeData β) :=
  do return (← StateT.get).1

def getVarType (v : Var) : K β (TypeData β) :=
  do return (← getVars) v

def updateType (v : Var) (t : TypeData β) : K β Unit := do
  StateT.modifyGet (fun s => ((), fun v' => if v' = v then t else s.1 v', s.2))

def assignVar (v : Var) (t : TypeData β) : K β Unit := do
  let k ← getVarType v
  match k with
  | .unused => updateType v t
  | _ => failure

/-- Does not change the state. Fails if impossible to unify or if either
input is `unused`. TypeData is a meet semilattice with top element `any`.  -/
def unify : (t₁ t₂ : TypeData β) → K β (TypeData β)
  | .unused, _ => failure
  | _, .unused => failure
  | .any, k => return k
  | k, .any => return k
  | .some k₁, .some k₂ => do
    if k₁ = k₂
    then return .some k₁
    else failure
  | .pair k₁ k₂, .pair t₁ t₂ => do
    let k₁' ← unify k₁ t₁
    let k₂' ← unify k₂ t₂
    return .pair k₁' k₂'
  | .triple k₁ k₂ k₃, .triple t₁ t₂ t₃ => do
    let k₁' ← unify k₁ t₁
    let k₂' ← unify k₂ t₂
    let k₃' ← unify k₃ t₃
    return .triple k₁' k₂' k₃'
  | .unit, .unit => return .unit
  | _, _ => failure

def unifyVar (v : Var) (t : TypeData β) : K β  (TypeData β) := do
  let k ← getVarType v
  let k' ← unify k t
  updateType v k'
  return k'

def unifyRVar (v : Var) (dom : TypeData β) (cod : TypeData β) : K β (TypeData  β × TypeData β) := do
  let s ← StateT.get
  let dom' ← unify dom (s.2 v).1
  let cod' ← unify cod (s.2 v).2
  return (dom', cod')

@[simp]
def assignAny (t : Var → TypeData β) (v : Var) : K β Unit :=
  match t v with
  | .unused => assignVar v .any
  | _ => failure

def unassignVars (l : List Var) : K β Unit := do
  l.forM (fun v => updateType v .unused)

/-- Given an expected type, tries to infer the type of an expression.
The state consists of the expected type of any free variables, and this state is
updated based on the new information.
* If `STMT` then return a list of names of variables used in the `STMT`.
Change the state to include types for all variables assigned in the `STMT`.
Ignore expected type, because this is a list of variables anyway.
Fails if assigned variable is not `unused` in initial state.
* If `TERMINATOR` then change state for free variables, but not bound ones.
Return the type of the returned variable. Fails when bound variable is not `unused` initially
* If `EXPR`, then return type of expression, and do not change the type of bound
variables, only free variables.
* If `REGION` then as for `EXPR`  -/
-- @chris: the type signature should be `SSA Op i → K (Context β)`?
def inferType {Op : Type}  [TUS : TypedUserSemantics Op β] :
    {i : SSAIndex} → SSA Op i →
    (i.ieval Op β)
    → K β (i.ieval Op β)
  | _,  .assign lhs rhs rest, _ => do
    let k ← inferType rhs (← getVarType lhs)
    assignVar lhs k
    let l ← inferType rest []
    return lhs :: l
  | _, .nop, _ => return []
  | _, .ret s v, k => do
    let l ← inferType s []
    let k' ← unifyVar v k
    unassignVars l
    return k'
  | _, .pair fst snd, k => do
    unify (.pair (← getVarType fst) (← getVarType snd)) k
  | _, .triple fst snd trd, k => do
    unify (.triple (← getVarType fst) (← getVarType snd) (← getVarType trd)) k
  | _,  .op o arg r, _ => do
    let _ ← unifyVar arg (TUS.argKind o)
    let dom := TUS.rgnDom o 
    let cod := TUS.rgnCod o
    let _ ← inferType r (dom, cod)
    return (TypedUserSemantics.outKind o).toTypeData
  | _, .var v, k => unifyVar v k
  | _, .rgnvar v, k => unifyRVar v k.1 k.2
  | _, .rgn0, k => do
    let _ ← unify k.1 UserType.unit.toTypeData
    let _ ← unify k.2 UserType.unit.toTypeData
    return (UserType.unit.toTypeData, UserType.unit.toTypeData)
  | _, .rgn arg body, k => do
    let dom ← unifyVar arg k.1
    let cod ← inferType body k.2
    unassignVars [arg]
    return (dom, cod)

-- @chris: TODO: implement `eval`:
--   `SSA Op i → Environment (Option Context β) → Option i.eval` or some such.

-- @[simp]
-- def TypeData.inf {Kind : Type} [DecidableEq Kind] :
--     TypeData Kind → TypeData Kind → TypeData Kind
--   | .none, _ => .none
--   | _, .none => .none
--   | .some k₁, .some k₂ => if k₁ = k₂ then .some k₁ else .none
--   | .some k, _ => .some k
--   | _, .some k => .some k
--   | .any, _ => .any
--   | _, .any => .any
--   | _, _ => .unused



-- @[simp]
-- def ofInfLeft [DecidableEq Kind] [TypeSemantics Kind] :
--     {t₁ t₂ : TypeData Kind} → (t₁.inf t₂).toType → t₁.toType
--   | .unused, .unused, x => x
--   | .unused, _, _ => ()
--   | .any, .unused, x => x
--   | .any, .any, x => x
--   | .any, .some _, x => ⟨_, x⟩
--   | .some _, .unused, x => x
--   | .some _, .any, x => x
--   | .some k₁, .some k₂, x =>
--       if h : k₁ = k₂
--       then by
--         subst h
--         simp at x
--         exact x
--       else by simp [h] at x; exact Empty.elim x

-- @[simp]
-- def ofInfRight [DecidableEq Kind] [TypeSemantics Kind] :
--     {t₁ t₂ : TypeData Kind} → (t₁.inf t₂).toType → t₂.toType
--   | .unused, .unused, x => x
--   | _, .unused, _ => ()
--   | .unused, .any, x => x
--   | .any, .any, x => x
--   | .some _, .any, x => ⟨_, x⟩
--   | .unused, .some _, x => x
--   | .any, .some _, x => x
--   | .some k₁, .some k₂, x =>
--       if h : k₁ = k₂
--       then by
--         subst h
--         simp at x
--         exact x
--       else by simp [h] at x; exact Empty.elim x

-- @[simp]
-- def toInfLeft [DecidableEq Kind] [TypeSemantics Kind] :
--     {t₁ t₂ : TypeData Kind} → t₁.toType → t₂.toType → (t₁.inf t₂).toType
--   | .unused, .unused, x, y => by simp; exact ()
--   | .unused, .any, x, y => y
--   | .unused, .some _, x, y => y
--   | .any, .unused, x, y => x
--   | .any, .any, x, y => x
--   | .any, .some _, x, y => y
--   | .some _, .unused, x, y => x
--   | .some _, .any, x, y => x
--   | .some k₁, .some k₂, x, y =>
--     if h : k₁ = k₂
--     then by
--       subst h
--       simp
--       exact x
--     else by simp [h]



-- @[simp]
-- def unassign (t : Var → TypeData Kind) (v : Var) :
--     Var → TypeData Kind :=
--   fun v' => if v = v' then .unused else t v'

-- @[simp]
-- def toUnassign [TypeSemantics Kind] (t : Var → TypeData Kind) (v : Var) :
--     ∀ v', (t v').toType → (unassign t v v').toType :=
--   fun v' => if h : v = v' then by subst h; simp; exact fun _ => ()
--     else by simp [h]; exact id



-- @[simp]
-- def ofAssign [DecidableEq Kind] [TypeSemantics Kind] (t : Var → TypeData Kind) (v : Var) (k : TypeData Kind) :
--     ∀ v', (assign t v k v').toType → (t v').toType :=
--   fun v' =>
--   if h : v = v'
--   then by simp only [h, assign, if_true]; exact ofInfLeft
--   else by simp only [h, assign, if_false]; exact id

-- @[simp]
-- def toAssign [DecidableEq Kind] [TypeSemantics Kind]
--    (t : Var → TypeData Kind) (v : Var) (k : TypeData Kind) (semk : TypeData.toType k) :
--     ∀ v', (t v').toType → (assign t v k v').toType :=
--   fun v' =>
--   if h : v = v'
--   then by simp only [h, assign, if_true]; _
--   else by simp only [h, assign, if_false]; exact id

-- @[simp]
-- def TypeData.rToType {Kind : Type} [TypeSemantics Kind] :
--     TypeData (Kind × Kind) → Type
--   | TypeData.none => Empty
--   | TypeData.some (k₁, k₂) => TypeSemantics.toType k₁ → TypeSemantics.toType k₂
--   | TypeData.any => Σ (k₁ k₂ : Kind),
--       TypeSemantics.toType k₁ → TypeSemantics.toType k₂
--   | TypeData.unused => Unit

-- @[simp]
-- def SSAIndex.teval (Op : Type) (Kind : Type) [TypeSemantics Kind]
--     [TypedUserSemantics Op Kind] : SSAIndex → Type
--   | .STMT => Σ (sem : Var → TypeData Kind), (∀ v, (sem v).toType)
--   | .REGION => Σ k₁ k₂ : Kind, TypeSemantics.toType k₁ → TypeSemantics.toType k₂
--   | .TERMINATOR => Σ k : Kind, TypeSemantics.toType k
--   | .EXPR => Σ k : Kind, TypeSemantics.toType k

@[simp]
def SSAIndex.teval (Op : Type)
    [TypedUserSemantics Op β] (sem : Var → TypeData β) :
    SSAIndex → Type
  | .TERMINATOR => Var
  | .EXPR => Σ (t : TypeData β) (_ : Var → TypeData β),
      ((∀ v, (sem v).toType) → t.toType)
  | .REGION => Σ (dom cod : TypeData β), ((∀ v, (sem v).toType) → dom.toType → cod.toType)
  | .STMT => (∀ v, (sem v).toType) → Σ (s : Var → TypeData β),  (∀ v, (s v).toType)

open TypeData

def SSA.teval {Op : Type} [TypedUserSemantics Op β]
    : (sem : Var → TypeData β) → {k : SSAIndex} → SSA Op k →
    k.teval Op sem
| sem, _, .assign lhs rhs rest => fun s => sorry
  -- let ⟨sem₁, rest⟩ := SSA.teval (Kind := Kind) sem rest s
  -- let ⟨t, sem₂, f⟩ := SSA.teval (Kind := Kind) sem rhs
  -- let sem₁' := unassign sem₁ lhs
  -- ⟨_root_.assign (fun v => ((sem₁' v).inf (sem₂ v))) lhs t,
  --   fun v => sorry⟩
| sem, _, .nop => fun f => ⟨sem, f⟩
| _, _, .ret above v => v
| _, _, .pair fst snd =>
  ⟨TypeData.pair .any .any,
   _⟩
| _, _, .triple fst snd third => _
| _, _, .op o arg r =>
  ⟨_, _⟩
| _, _, .var v => _
| _, _, .rgnvar v => _
| _, _, .rgn0 => _
| _, _, .rgn arg body => _

-- We can recover the case with the TypeSemantics as an instance
def TypeSemantics : Type 1 :=
  ℕ → Type

inductive NatBaseType (TS : TypeSemantics) : Type
  | ofNat : ℕ → NatBaseType TS
deriving DecidableEq

instance : Goedel (NatBaseType TS) where toType :=
  fun n => match n with
    | .ofNat m => TS m

variable {TS : TypeSemantics}
abbrev NatUserType := UserType (NatBaseType TS)
abbrev NatTypeData := TypeData (NatBaseType TS)

@[simp]
def NatTypeData.toType (TS : TypeSemantics) : @NatTypeData TS → Type
  | TypeData.some (.ofNat k) => TS k
  | TypeData.unit => Unit
  | TypeData.pair t₁ t₂ => (NatTypeData.toType TS t₁) × (NatTypeData.toType TS t₂)
  | TypeData.triple t₁ t₂ t₃ => (NatTypeData.toType TS t₁) × (NatTypeData.toType TS t₂) × (NatTypeData.toType TS t₃)
  | TypeData.any => Σ (k : NatUserType), @UserType.toType (@NatBaseType TS) instGoedelNatBaseType k
  | TypeData.unused => Unit
