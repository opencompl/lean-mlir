import SSA.Framework
import Mathlib.Data.Option.Basic
import Mathlib.Data.List.AList

/-
Typeclass for a `baseType` which is a godel code of
Lean types.
-/


class Goedel (β : Type)  : Type 1 where
  toType : β → Type
open Goedel /- make toType publically visible in module. -/

notation "⟦" x "⟧" => Goedel.toType x

instance : Goedel Unit where toType := fun _ => Unit

namespace SSA

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


structure UserData {β : Type} [Goedel β] where
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

def TypeData.toUserType : TypeData β → Option (UserType β)
  | TypeData.some t => do return UserType.base t
  | TypeData.unit => do return UserType.unit
  | TypeData.pair k₁ k₂ => do UserType.pair (← k₁.toUserType) (← k₂.toUserType)
  | TypeData.triple k₁ k₂ k₃ => do UserType.triple (← k₁.toUserType) (← k₂.toUserType) (← k₃.toUserType)
  | TypeData.any => none
  | TypeData.unused => none

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

def Context (α : Type) : Type :=
  AList (fun _ : Var => α)

instance {α : Type} : EmptyCollection (Context α) := by
  dsimp [Context]; infer_instance

def Context.pmapCore {α β : Type} (f : α → Option β) :
    List (Σ _ : Var, α) → Option (List (Σ _ : Var, β))
  | [] => some []
  | (⟨v, a⟩ :: l) => do
    let b ← f a
    let l' ← Context.pmapCore f l
    some (⟨v, b⟩ :: l')

theorem Context.pmapCore_keys {α β : Type} (f : α → Option β) :
    ∀ (l : List (Σ _ : Var, α)),
    ∀ l' ∈ (Context.pmapCore f l), l'.keys = l.keys
  | [] => by simp [Context.pmapCore]
  | (a::l) => by
    rintro l'
    simp only [Context.pmapCore, List.keys_cons]
    cases h : f a.2
    . simp [bind]
    . cases h' : pmapCore f l
      . simp [bind]
      . simp only [Option.some_bind, Option.mem_def, Option.some.injEq, bind]
        rintro rfl
        rw [← Context.pmapCore_keys f _ _ h']
        simp

def Context.pmap {α β : Type} (f : α → Option β) (l : Context α) : Option (Context β) := by
  cases h : Context.pmapCore f l.1 with
  | none => exact none
  | some l' => exact some ⟨l', by rw [List.NodupKeys, Context.pmapCore_keys _ _ _ h]; exact l.2⟩


@[simp]
def SSAIndex.ieval (β : Type) : SSAIndex → Type
  | .TERMINATOR => TypeData β
  | .EXPR => TypeData β
  | .REGION => TypeData β × TypeData β
  | .STMT => List Var

def SSAIndex.ieval.any {β : Type} : (i : SSAIndex) → i.ieval β
  | .TERMINATOR => TypeData.any
  | .EXPR => TypeData.any
  | .REGION => (TypeData.any, TypeData.any)
  | .STMT => []

abbrev K (β : Type)
  : Type → Type := StateT ((Context (TypeData β)) × (Context (TypeData β × TypeData β))) Option

-- Lean gets very picky here and wants to get all instances passed explicit to be sure they're the same
def getVars : K β (Var → TypeData β) := do
  let al := (← StateT.get).1
  return (fun v => match al.lookup v with
    | some t => t
    | none => TypeData.unused)

def getRVars : K β (Var → TypeData β × TypeData β) := do
  let al := (← StateT.get).2
  return (fun v => match al.lookup v with
    | some t => t
    | none => (TypeData.unused, TypeData.unused))

def getVarType (v : Var) : K β (TypeData β) :=
  do return (← getVars) v

def updateType (v : Var) (t : TypeData β) : K β Unit := do
  StateT.modifyGet (fun s => ((), s.1.insert v t, s.2))

/-- assign a variable. Fails if the variable is not unused to start with -/
def assignVar (v : Var) (t : TypeData β) : K β Unit := do
  let k ← getVarType v
  match k with
  | .unused => updateType v t
  | _ => failure

/-- Does not change the state. Fails if impossible to unify.
TypeData is a meet semilattice with top element `unused`.  -/
def unify : (t₁ t₂ : TypeData β) → K β (TypeData β)
  | .unused, k => return k
  | k, .unused => return k
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
  let s ← getRVars
  let dom' ← unify dom (s v).1
  let cod' ← unify cod (s v).2
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
def inferTypeCore {Op : Type}  [TUS : TypedUserSemantics Op β] :
    {i : SSAIndex} → SSA Op i →
    (i.ieval β)
    → K β (i.ieval β)
  | _,  .assign lhs rhs rest, _ => do
    let k ← inferTypeCore rhs (← getVarType lhs)
    assignVar lhs k
    let l ← inferTypeCore rest []
    return lhs :: l
  | _, .nop, _ => return []
  | _, .ret s v, k => do
    let l ← inferTypeCore s []
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
    let _ ← inferTypeCore r (dom, cod)
    return (TypedUserSemantics.outKind o).toTypeData
  | _, .var v, k => unifyVar v k
  | _, .rgnvar v, k => unifyRVar v k.1 k.2
  | _, .rgn0, k => do
    return (← unify k.1 UserType.unit.toTypeData, ← unify k.2 UserType.unit.toTypeData)
  | _, .rgn arg body, k => do
    let dom ← unifyVar arg k.1
    let cod ← inferTypeCore body k.2
    unassignVars [arg]
    return (dom, cod)

def inferType {Op : Type} [TypedUserSemantics Op β]
    {i : SSAIndex} (e : SSA Op i) :
    Option ((i.ieval β) × Context (UserType β) × Context (UserType β × UserType β)) := do
  let k ← inferTypeCore (β := β) e (SSAIndex.ieval.any i) (∅, ∅)
  return (k.1, ← k.2.1.pmap TypeData.toUserType, ← k.2.2.pmap
    fun x => do return (← x.1.toUserType, ← x.2.toUserType))

def EnvC (c : Context (UserType β)) :=
  ∀ (v : Var), (c.lookup v).elim Unit UserType.toType

variable (β)

def UVal := Σ (k : UserType β), k.toType

def EnvU : Type :=
  Var → Option (UVal β)

variable {β}

def EnvC.toEnvU {c : Context (UserType β)} (e : EnvC c) : EnvU β := by
  dsimp [EnvC] at *
  intro v
  have ev := e v
  revert ev
  cases c.lookup v
  . exact fun _ => none
  . exact fun x => some ⟨_, x⟩

-- def SSA.teval {Op : Type} [TypedUserSemantics Op β]
--   (e : EnvU β) (er : ) :
--   (e : EnvC c) → SSA Op k → k.eval Val
-- | .assign lhs rhs rest =>
--     rest.teval (e.set lhs (rhs.eval e re)) re
-- | .nop => _
-- | .ret above v => _
-- | .pair fst snd => _
-- | .triple fst snd third => _
-- | .op o arg r => _
-- | .var v => _
-- | .rgnvar v => _
-- | .rgn0 => _
-- | .rgn arg body => _

-- @chris: TODO: implement `eval`:
--   `SSA Op i → Environment (Option Context β) → Option i.eval` or some such.

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

end SSA
