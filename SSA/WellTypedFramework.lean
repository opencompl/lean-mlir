import SSA.Framework
import Mathlib.Data.Option.Basic
import Mathlib.Data.List.AList

/-- Typeclass for a `baseType` which is a Gödel code of
Lean types. -/
class Goedel (β : Type)  : Type 1 where
  toType : β → Type
open Goedel /- make toType publically visible in module. -/

notation "⟦" x "⟧" => Goedel.toType x

instance : Goedel Unit where toType := fun _ => Unit

namespace SSA

/-- A `UserType` is a type of an `SSA` program. -/
inductive UserType (T : Type) : Type where
  | base : T → UserType T
  | pair : UserType T → UserType T → UserType T
  | triple : UserType T → UserType T → UserType T → UserType T
  | unit : UserType T
  | region : UserType T → UserType T → UserType T
  deriving DecidableEq

namespace UserType

instance: Inhabited (UserType β) where default := UserType.unit

@[reducible]
def toType [Goedel β] : UserType β → Type
  | .base t =>  ⟦t⟧
  | .pair k₁ k₂ => (toType k₁) × (toType k₂)
  | .triple k₁ k₂ k₃ => toType k₁ × toType k₂ × toType k₃
  | .unit => Unit
  | .region k₁ k₂ => toType k₁ → Option (toType k₂)

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

/-- `TypeData` is a `Type` used to represent a potentially unknown `UserType`,
usually of a variable in the context.
for the purposes of type inference of `SSA`. `any` means that the `UserType`
is completely unknown, `unused` means that a variable is unused, `pair` means that
it is known that the type is a pair, but the elements of the pair are not necessarily
known and so on. -/
inductive  TypeData (β : Type) : Type
  | some : β → TypeData β
  | unit : TypeData β
  | pair : TypeData β → TypeData β → TypeData β
  | triple : TypeData β → TypeData β → TypeData β → TypeData β
  | region : TypeData β → TypeData β → TypeData β
  | any : TypeData β
  | unused : TypeData β -- Or bound

@[coe]
def UserType.toTypeData [Goedel β] : UserType β → TypeData β
  | UserType.base t => TypeData.some t
  | UserType.unit => TypeData.unit
  | UserType.pair k₁ k₂ => TypeData.pair (UserType.toTypeData k₁) (UserType.toTypeData k₂)
  | UserType.triple k₁ k₂ k₃ => TypeData.triple (UserType.toTypeData k₁) (UserType.toTypeData k₂)
    (UserType.toTypeData k₃)
  | UserType.region k₁ k₂ => TypeData.region (UserType.toTypeData k₁) (UserType.toTypeData k₂)

variable {β : Type} [instDecidableEqBaseType : DecidableEq β] [instGoedel : Goedel β]
instance : Coe (UserType β) (TypeData β) := ⟨UserType.toTypeData⟩

def TypeData.toUserType : TypeData β → Option (UserType β)
  | TypeData.some t => do return UserType.base t
  | TypeData.unit => do return UserType.unit
  | TypeData.pair k₁ k₂ => do UserType.pair (← k₁.toUserType) (← k₂.toUserType)
  | TypeData.triple k₁ k₂ k₃ => do UserType.triple (← k₁.toUserType) (← k₂.toUserType) (← k₃.toUserType)
  | TypeData.region k₁ k₂ => do UserType.region (← k₁.toUserType) (← k₂.toUserType)
  | TypeData.any => none
  | TypeData.unused => none

/-- Typeclass for a user semantics of `Op`, with base type `β`.
    The type β has to implement the `Goedel` typeclass, mapping into `Lean` types.
    This typeclass has several arguments that have to be defined to give semantics to
    the operations of type `Op`:
    * `argUserType` and `outUserType`, functions of type `Op → UserType β`, give the type of the
      arguments and the output of the operation.
    * `rgnDom` and `rgnCod`, functions of type `Op → UserType β`, give the type of the
      domain and codomain of regions within the operation.
    * `eval` gives the actual evaluation semantics of the operation, by defining a function for
      every operation `o : Op` of type `toType (argUserType o) → (toType (rgnDom o) → toType (rgnCod o)) → toType (outUserType o)`.
-/
class TypedUserSemantics (Op : Type) (β : Type) [Goedel β] where
  argUserType : Op → UserType β
  rgnDom : Op → UserType β
  rgnCod : Op → UserType β
  outUserType : Op → UserType β
  eval : ∀ (o : Op), toType (argUserType o) → (toType (rgnDom o) →
    Option (toType (rgnCod o))) → Option (toType (outUserType o))

@[simp]
def TypeData.toType : TypeData β → Type
  | TypeData.some t => Goedel.toType t
  | TypeData.unit => Unit
  | TypeData.pair t₁ t₂ => (TypeData.toType  t₁) × (TypeData.toType t₂)
  | TypeData.triple t₁ t₂ t₃ => (TypeData.toType t₁) × (TypeData.toType t₂) × (TypeData.toType t₃)
  | TypeData.region t₁ t₂ => (TypeData.toType t₁) → Option (TypeData.toType t₂)
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
  | .REGION => TypeData β
  | .STMT => List Var

def SSAIndex.ieval.any {β : Type} : (i : SSAIndex) → i.ieval β
  | .TERMINATOR => TypeData.any
  | .EXPR => TypeData.any
  | .REGION => TypeData.region TypeData.any TypeData.any
  | .STMT => []

/-- A Monad used to keep track of a typing context for variables during `inferType`. -/
abbrev TypeContextM (β : Type)
  : Type → Type := StateT (Context (TypeData β)) Option

-- Lean gets very picky here and wants to get all instances passed explicit to be sure they're the same
def getVars : TypeContextM β (Var → TypeData β) := do
  let al := (← StateT.get)
  return (fun v => match al.lookup v with
    | some t => t
    | none => TypeData.unused)

def getVarType (v : Var) : TypeContextM β (TypeData β) :=
  do return (← getVars) v

def updateType (v : Var) (t : TypeData β) : TypeContextM β Unit := do
  StateT.modifyGet (fun s => ((), s.insert v t))

/-- assign a variable. Fails if the variable is not unused to start with -/
def assignVar (v : Var) (t : TypeData β) : TypeContextM β Unit := do
  let k ← getVarType v
  match k with
  | .unused => updateType v t
  | _ => failure

/-- Does not change the state. Fails if impossible to unify.
TypeData is a meet semilattice with top element `unused`.  -/
def unify : (t₁ t₂ : TypeData β) → TypeContextM β (TypeData β)
  | .unused, k => return k
  | k, .unused => return k
  | .any, k => return k
  | k, .any => return k
  | .some k₁, .some k₂ => do
    if k₁ = k₂
    then return .some k₁
    else failure
  | .pair k₁ k₂, .pair t₁ t₂ => do
    return .pair (← unify k₁ t₁) (← unify k₂ t₂)
  | .triple k₁ k₂ k₃, .triple t₁ t₂ t₃ => do
    return .triple (← unify k₁ t₁) (← unify k₂ t₂) (← unify k₃ t₃)
  | .region k₁ k₂, .region t₁ t₂ => do
    return .region (← unify k₁ t₁) (← unify k₂ t₂)
  | .unit, .unit => return .unit
  | _, _ => failure

def unifyVar (v : Var) (t : TypeData β) : TypeContextM β  (TypeData β) := do
  let k ← getVarType v
  let k' ← unify k t
  updateType v k'
  return k'

@[simp]
def assignAny (t : Var → TypeData β) (v : Var) : TypeContextM β Unit :=
  match t v with
  | .unused => assignVar v .any
  | _ => failure

def unassignVars (l : List Var) : TypeContextM β Unit := do
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
-- @chris: the type signature should be `SSA Op i → TypeContextM (Context β)`?
def inferTypeCore {Op : Type}  [TUS : TypedUserSemantics Op β] :
    {i : SSAIndex} → SSA Op i →
    (i.ieval β)
    → TypeContextM β (i.ieval β)
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
  | _, .unit, k => do
    unify .unit k
  | _, .pair fst snd, k => do
    unify (.pair (← getVarType fst) (← getVarType snd)) k
  | _, .triple fst snd trd, k => do
    unify (.triple (← getVarType fst) (← getVarType snd) (← getVarType trd)) k
  | _,  .op o arg r, _ => do
    let _ ← unifyVar arg (TUS.argUserType o)
    let dom := TUS.rgnDom o
    let cod := TUS.rgnCod o
    let _ ← inferTypeCore r (.region dom cod)
    return (TypedUserSemantics.outUserType o).toTypeData
  | _, .var v, k => unifyVar v k
  | _, .rgnvar v, k => do
    unifyVar v (← unify k (.region TypeData.any TypeData.any))
  | _, .rgn0, k => do
    unify k (.region TypeData.unit TypeData.unit)
  | _, .rgn arg body, k => do
    match ← unify k (.region TypeData.any TypeData.any) with
    | .region dom cod => do
      let dom ← unifyVar arg dom
      let cod ← inferTypeCore body cod
      unassignVars [arg]
      return .region dom cod
    | _ => failure

def inferType {Op : Type} [TypedUserSemantics Op β]
    {i : SSAIndex} (e : SSA Op i) :
    Option ((i.ieval β) × Context (UserType β)) := do
  let k ← inferTypeCore (β := β) e (SSAIndex.ieval.any i) ∅
  return (k.1, ← k.2.pmap TypeData.toUserType)

/-- A typed evaluation environment, given a typing context `c`, an `EnvC c`
contains semantics for all of the variables in the `Context`, `c`. -/
def EnvC (c : Context (UserType β)) :=
  ∀ (v : Var), (c.lookup v).elim Unit UserType.toType

--instance {β : Type} [Goedel β] {c : Context (UserType β)}: EmptyCollection (EnvC c) := by
--  sorry

variable (β)

/-- An untyped value - the semantics of many programs will return a `UVal` -/
def UVal := Σ (k : UserType β), k.toType

/-- An untyped evaluation environment, contains optional semantics for all variables. -/
def EnvU : Type :=
  Var → Option (UVal β)

instance {β : Type} [Goedel β] : EmptyCollection (EnvU β) where
  emptyCollection := (fun _ => none)

variable {β}

@[simp]
def EnvC.toEnvU {c : Context (UserType β)} (e : EnvC c) : EnvU β := by
  dsimp [EnvC] at *
  intro v
  have ev := e v
  revert ev
  cases c.lookup v
  . exact fun _ => none
  . exact fun x => return ⟨_, x⟩

@[simp]
def EnvU.set : EnvU β → Var → UVal β → EnvU β
  | e, v, u => fun v' => if v = v' then u else e v'

@[simp]
def SSAIndex.teval (Op : Type) (β : Type) [Goedel β]
    [TypedUserSemantics Op β] : SSAIndex → Type
| .STMT => Option (EnvU β)
| .TERMINATOR => Option (UVal β)
| .EXPR => Option (UVal β)
| .REGION => ∀ (k₁ k₂ : UserType β), k₁.toType → Option k₂.toType

@[simp]
def SSA.teval {Op : Type} [TUS : TypedUserSemantics Op β]
  (e : EnvU β) : SSA Op k → k.teval Op β
| .assign lhs rhs rest => do
  rest.teval (e.set lhs (← rhs.teval e))
| .nop => return e
| .unit => return ⟨.unit, ()⟩
| .ret above v => do (← above.teval e) v
| .pair fst snd => do
  let fst ← e fst
  let snd ← e snd
  return ⟨.pair fst.fst snd.fst, (fst.2, snd.2)⟩
| .triple fst snd third => do
  let fst ← e fst
  let snd ← e snd
  let third ← e third
  return ⟨.triple fst.fst snd.fst third.fst, (fst.2, snd.2, third.2)⟩
| .op o arg r => do
  let ⟨argK, argV⟩ ← e arg
  let f := teval e r
  if h : TUS.argUserType o = argK
    then by
          subst argK
          exact do return ⟨TUS.outUserType o, ← TUS.eval o argV (f _ _)⟩
    else none
| .var v => e v
| .rgnvar v => fun k₁ k₂ x => do
  let ⟨k, f⟩ ← e v
  match k, f with
  | .region dom cod, f =>
    if h : k₁ = dom ∧ k₂ = cod
      then by
            rcases h with ⟨rfl, rfl⟩
            exact f x
      else none
  | _, _ => failure
| .rgn0 => fun k₁ k₂ _ =>
    if h : k₁ = .unit ∧ k₂ = .unit
    then by rcases h with ⟨rfl, rfl⟩; exact return ()
    else none
| .rgn arg body => fun k₁ k₂ x => do
  let fx ← teval (e.set arg ⟨k₁, x⟩) body
  match fx with
  | ⟨k₂', y⟩ =>
    if h : k₂' = k₂
    then by subst h; exact return y
    else none

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
  | TypeData.region t₁ t₂ => (NatTypeData.toType TS t₁) → (NatTypeData.toType TS t₂)

end SSA

register_simp_attr Bind.bind
register_simp_attr Option.bind
register_simp_attr TypedUserSemantics.eval
register_simp_attr TypedUserSemantics.argUserType
register_simp_attr TypedUserSemantics.outUserType
register_simp_attr TypedUserSemantics.regionDom
register_simp_attr TypedUserSemantics.regionCod
