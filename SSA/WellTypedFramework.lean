import SSA.Framework
import Mathlib.Data.Option.Basic

class BaseTypeClass (BaseType : Type) : Type 1 where
  toType : BaseType → Type

instance : BaseTypeClass Unit where toType := fun _ => Unit

inductive UserType (T : Type) [BaseTypeClass T]: Type where
  | base : T → UserType T
  | pair : UserType T → UserType T → UserType T
  | triple : UserType T → UserType T → UserType T → UserType T
  | unit : UserType T

namespace UserType

instance {BaseType : Type} [BaseTypeClass BaseType]: Inhabited (UserType BaseType) where default := UserType.unit

def toType {BaseType : Type} [BaseTypeClass BaseType] : UserType BaseType → Type
  | .base t => BaseTypeClass.toType t
  | .pair k₁ k₂ => (toType k₁) × (toType k₂)
  | .triple k₁ k₂ k₃ => toType k₁ × toType k₂ × toType k₃
  | .unit => Unit

def mkPair {BaseType : Type} [BaseTypeClass BaseType] {k₁ k₂ : UserType BaseType}: toType k₁ → toType k₂ → toType (.pair k₁ k₂)
  | k₁, k₂ => (k₁, k₂)

def mkTriple {BaseType : Type} [BaseTypeClass BaseType] {k₁ k₂ k₃ : UserType BaseType}: toType k₁ → toType k₂ → toType k₃ → toType (.triple k₁ k₂ k₃)
  | k₁, k₂, k₃ => (k₁, k₂, k₃)

def fstPair {BaseType : Type} [BaseTypeClass BaseType] {k₁ k₂ : UserType BaseType} : toType (.pair k₁ k₂) → toType k₁
  | (k₁, _) => k₁

def sndPair {BaseType : Type} [BaseTypeClass BaseType] {k₁ k₂ : UserType BaseType} : toType (.pair k₁ k₂) → toType k₂
  | (_, k₂) => k₂

def fstTriple {BaseType : Type} [BaseTypeClass BaseType] {k₁ k₂ k₃ : UserType BaseType} : toType (.triple k₁ k₂ k₃) → toType k₁
  | (k₁, _, _) => k₁

def sndTriple {BaseType : Type} [BaseTypeClass BaseType] {k₁ k₂ k₃ : UserType BaseType} : toType (.triple k₁ k₂ k₃) → toType k₂
  | (_, k₂, _) => k₂

def trdTriple {BaseType : Type} [BaseTypeClass BaseType] {k₁ k₂ k₃ : UserType BaseType} : toType (.triple k₁ k₂ k₃) → toType k₃
  | (_, _, k₃) => k₃

end UserType


structure UserData {BaseType : Type} [BaseTypeClass BaseType] where
  type : UserType BaseType
  value : type.toType


inductive  TypeData (BaseType : Type) [BaseTypeClass BaseType] : Type
  | some : BaseType → TypeData BaseType
  | unit : TypeData BaseType
  | pair : TypeData BaseType → TypeData BaseType → TypeData BaseType
  | triple : TypeData BaseType → TypeData BaseType → TypeData BaseType → TypeData BaseType
  | any : TypeData BaseType
  | unused : TypeData BaseType -- Or bound

@[coe]
def UserType.toTypeData [BaseTypeClass BaseType] : UserType BaseType → TypeData BaseType
  | UserType.base t => TypeData.some t
  | UserType.unit => TypeData.unit
  | UserType.pair k₁ k₂ => TypeData.pair (UserType.toTypeData k₁) (UserType.toTypeData k₂)
  | UserType.triple k₁ k₂ k₃ => TypeData.triple (UserType.toTypeData k₁) (UserType.toTypeData k₂)
    (UserType.toTypeData k₃)

variable {BaseType : Type} [instBaseTypeClass : BaseTypeClass BaseType]
instance : Coe (UserType BaseType) (TypeData BaseType) := ⟨UserType.toTypeData⟩

def TypeSemantics : Type 1 :=
  ℕ → Type

inductive NatBaseType (TS : TypeSemantics) : Type
  | ofNat : ℕ → NatBaseType TS
deriving DecidableEq

instance : BaseTypeClass (NatBaseType TS) where toType :=
  fun n => match n with
    | .ofNat m => TS m

class TypedUserSemantics (Op : Type) (TS : TypeSemantics) where
  argKind : Op → UserType (NatBaseType TS)
  rgnDom : Op → UserType (NatBaseType TS)
  rgnCod : Op → UserType (NatBaseType TS)
  outKind : Op → UserType (NatBaseType TS)
  eval : ∀ (o : Op), (argKind o).toType → ((rgnDom o).toType →
    (rgnCod o).toType) → (outKind o).toType

variable (TS : TypeSemantics)
abbrev NatUserType := UserType (NatBaseType TS)
abbrev NatTypeData := TypeData (NatBaseType TS)

@[simp]
def NatTypeData.toType (TS : TypeSemantics) : @NatTypeData TS → Type
  | TypeData.some (.ofNat k) => TS k
  | TypeData.unit => Unit
  | TypeData.pair t₁ t₂ => (NatTypeData.toType TS t₁) × (NatTypeData.toType TS t₂)
  | TypeData.triple t₁ t₂ t₃ => (NatTypeData.toType TS t₁) × (NatTypeData.toType TS t₂) × (NatTypeData.toType TS t₃)
  | TypeData.any => Σ (k : NatUserType TS), @UserType.toType (@NatBaseType TS) (@instBaseTypeClassNatBaseType TS) k
  | TypeData.unused => Unit

/- Kind.toType = Kind.toTypeData.toType -/
theorem NatTypeDataToTypeEqTypeDataToType (a : NatUserType TS) : a.toType = NatTypeData.toType TS a.toTypeData := by
  induction a with
  | base n => rfl
  | unit => rfl
  | pair k₁ k₂ ih₁ ih₂ => simp [NatTypeData.toType, UserType.toType, ih₁, ih₂]
  | triple k₁ k₂ k₂ ih₁ ih₂ ih₃ => simp [NatTypeData.toType, UserType.toType, ih₁, ih₂, ih₃]

@[simp]
def SSAIndex.ieval (Op : Type) (TS : TypeSemantics)
    [TypedUserSemantics Op TS] : SSAIndex → Type
  | .TERMINATOR => TypeData (NatBaseType TS)
  | .EXPR => TypeData (NatBaseType TS)
  | .REGION => TypeData (NatBaseType TS) × TypeData (NatBaseType TS)
  | .STMT => List Var

abbrev K : Type → Type := StateT ((Var → NatTypeData TS) × (Var → (NatTypeData TS × NatTypeData TS))) Option

def getVars : K TS (Var → NatTypeData TS) :=
  do return (← StateT.get).1

def getVarType (v : Var) : K TS (NatTypeData TS) :=
  do return (← getVars TS) v

def updateType (v : Var) (t : NatTypeData TS) : K TS Unit := do
  StateT.modifyGet (fun s => ((), fun v' => if v' = v then t else s.1 v', s.2))

def assignVar (v : Var) (t : NatTypeData TS) : K TS Unit := do
  let k ← getVarType TS v
  match k with
  | .unused => updateType TS v t
  | _ => failure

/-- Does not change the state. Fails if impossible to unify or if either
input is `unused`. TypeData is a meet semilattice with top element `any`.  -/
def unify : (t₁ t₂ : NatTypeData TS) → K TS (NatTypeData TS)
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

def unifyVar (v : Var) (t : NatTypeData TS) : K TS (NatTypeData TS) := do
  let k ← getVarType TS v
  let k' ← unify TS k t
  updateType TS v k'
  return k'

def unifyRVar (v : Var) (dom : NatTypeData TS) (cod : NatTypeData TS) : K TS (NatTypeData TS × NatTypeData TS) := do
  let s ← StateT.get
  let dom' ← unify TS dom (s.2 v).1
  let cod' ← unify TS cod (s.2 v).2
  return (dom', cod')

@[simp]
def assignAny (t : Var → NatTypeData TS) (v : Var) : K TS Unit :=
  match t v with
  | .unused => assignVar TS v .any
  | _ => failure

def unassignVars (l : List Var) : K TS Unit := do
  l.forM (fun v => updateType TS v .unused)

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
-- @chris: the type signature should be `SSA Op i → K (Context BaseType)`?
def inferType {Op : Type} (TS : TypeSemantics) [TypedUserSemantics Op TS] :
    {i : SSAIndex} → SSA Op i → (i.ieval Op TS) → K TS (i.ieval Op TS)
  | _,  .assign lhs rhs rest, _ => do
    let k ← inferType TS rhs (← getVarType TS lhs)
    assignVar TS lhs k
    let l ← inferType TS rest []
    return lhs :: l
  | _, .nop, _ => return []
  | _, .ret s v, k => do
    let l ← inferType TS s []
    let k' ← unifyVar TS v k
    unassignVars TS l
    return k'
  | _, .pair fst snd, k => do
    unify TS (.pair (← getVarType TS fst) (← getVarType TS snd)) k
    /-
    match k with
    | .any => return (.pair (← getVarType fst) (← getVarType snd))
    | .pair k₁ k₂ => do
      let k₁' ← unifyVar fst k₁
      let k₂' ← unifyVar snd k₂
      return .pair k₁' k₂'
    | _ => failure
    -/
  | _, .triple fst snd trd, k => do
    unify (.triple (← getVarType fst) (← getVarType snd) (← getVarType trd)) k
    /-
    match k with
    | .any => return (.triple (← getVarType fst) (← getVarType snd) (← getVarType trd))
    | .triple k₁ k₂ k₃ => do
      let k₁' ← unifyVar fst k₁
      let k₂' ← unifyVar snd k₂
      let k₃' ← unifyVar trd k₃
      return .triple k₁' k₂' k₃'
    | _ => failure
    -/
  | _,  .op o arg r, _ => do
    let _ ← unifyVar arg (TypedUserSemantics.argKind TS o)
    let _ ← inferType TS r
      (TypedUserSemantics.rgnDom TS o, TypedUserSemantics.rgnCod TS o)
    return (TypedUserSemantics.outKind TS o).toTypeData
  | _, .var v, k => unifyVar v k
  | _, .rgnvar v, k => unifyRVar v k.1 k.2
  | _, .rgn0, k => do
    let _ ← unify k.1 Kind.unit.toTypeData
    let _ ← unify k.2 Kind.unit.toTypeData
    return (Kind.unit.toTypeData, Kind.unit.toTypeData)
  | _, .rgn arg body, k => do
    let dom ← unifyVar arg k.1
    let cod ← inferType TS body k.2
    unassignVars [arg]
    return (dom, cod)

-- @chris: TODO: implement `eval`:
--   `SSA Op i → Environment (Option Context BaseType) → Option i.eval` or some such.

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
def SSAIndex.teval (Op : Type)  (TS : TypeSemantics)
    [TypedUserSemantics Op TS] (sem : Var → TypeData) :
    SSAIndex → Type
  | .TERMINATOR => Var
  | .EXPR => Σ (t : TypeData) (_ : Var → TypeData),
      ((∀ v, (sem v).toType TS) → t.toType TS)
  | .REGION => Σ (dom cod : TypeData), ((∀ v, (sem v).toType TS) → dom.toType TS → cod.toType TS)
  | .STMT => (∀ v, (sem v).toType TS) → Σ (s : Var → TypeData),  (∀ v, (s v).toType TS)

open TypeData

def SSA.teval {Op : Type} (TS : TypeSemantics) [TypedUserSemantics Op TS]
    [DecidableEq Kind] : (sem : Var → TypeData) → {k : SSAIndex} → SSA Op k →
    k.teval Op TS sem
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
