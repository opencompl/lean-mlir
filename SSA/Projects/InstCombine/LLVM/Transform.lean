-- should replace with Lean import once Pure is upstream
import SSA.Projects.MLIRSyntax.AST
import SSA.Projects.InstCombine.Base
import SSA.Core.Framework

universe u

namespace MLIR.AST

open InstCombine (Width)

inductive TransformError (MTy : α → Type*)
  | nameAlreadyDeclared (var : String)
  | undeclaredName (var : String)
  | indexOutOfBounds (name : String) (index len : Nat)
  | typeError {φ} (expected got : MTy φ)
  | widthError {φ} (expected got : Width φ)
  | unsupportedUnaryOp
  | unsupportedBinaryOp
  | unsupportedOp
  | unsupportedType
  | generic (error : String)

namespace TransformError

instance : Lean.ToFormat (InstCombine.MTy φ) where
  format := repr

instance {α : Type*} (MTy : α → Type) [∀ φ, Lean.ToFormat (MTy φ)] : Repr (TransformError MTy) where
  reprPrec err _ := match err with
    | nameAlreadyDeclared var => f!"Already declared {var}, shadowing is not allowed"
    | undeclaredName name => f!"Undeclared name '{name}'"
    | indexOutOfBounds name index len => 
        f!"Index of '{name}' out of bounds of the given context (index was {index}, but context has length {len})"
    | typeError expected got => f!"Type mismatch: expected '{expected}', but 'name' has type '{got}'"
    | widthError expected got => f!"Type mismatch: {expected} ≠ {got}"
    | unsupportedUnaryOp => f!"Unsuported unary operation"
    | unsupportedBinaryOp => f!"Unsuported binary operation"
    | unsupportedOp => f!"Unsuported operation"
    | unsupportedType => f!"Unsuported type"
    | generic err => err

end TransformError

class DialectFamily (Op : Type) where
  /-- The meta context gives static information about, e.g., the number of metavariables that may
    occur -/
  (MetaContext : Type)
  (MOp MTy : MetaContext → Type)
  {Ty : Type}
  [instSig  : OpSignature Op Ty]
  [instSigM : ∀ (φ : MetaContext), OpSignature (MOp φ) (MTy φ)]
  [instDecEqOp : ∀ φ, DecidableEq (MOp φ)]
  [instDecEqTy : ∀ φ, DecidableEq (MTy φ)]
  /-- A valuation for a meta context contains the information needed to instantiate a family of
    programs, for a given context, to a concrete program -/
  (MetaContextValuation : MetaContext → Type)
  (instantiate : ∀ φ, MetaContextValuation φ → DialectMorphism (MOp φ) Op)

variable (Op : Type) [dialectFamily : DialectFamily Op]

instance : OpSignature (dialectFamily.MOp φ) (dialectFamily.MTy φ) := dialectFamily.instSigM _
instance : DecidableEq (dialectFamily.MOp φ) := dialectFamily.instDecEqOp _
instance : DecidableEq (dialectFamily.MTy φ) := dialectFamily.instDecEqTy _

abbrev Context (φ) := List (dialectFamily.MTy φ)

abbrev Expr (Γ : Context _ φ) (ty : dialectFamily.MTy φ)  := IExpr (dialectFamily.MOp φ) Γ ty
abbrev Com (Γ : Context _ φ) (ty : dialectFamily.MTy φ)   := ICom (dialectFamily.MOp φ) Γ ty
abbrev Var (Γ : Context _ φ) (ty : dialectFamily.MTy φ)   := Ctxt.Var Γ ty

abbrev Com.lete (body : Expr Op Γ ty₁) (rest : Com Op (ty₁::Γ) ty₂) : Com Op Γ ty₂ := 
  ICom.lete body rest

-- instance : DialectFamily InstCombine.Op where
--   Ty := InstCombine.Ty
--   MetaContext := Nat
--   MetaContextValuation := Vector Nat
--   MOp := InstCombine.MOp
--   MTy := InstCombine.MTy
--   instantiate := sorry

/--
Store the names of the raw SSA variables (as strings).
The order in the list should match the order in which they appear in the code.
-/
abbrev NameMapping := List String

def NameMapping.lookup (nm : NameMapping) (name : String) : Option Nat :=
  nm.indexOf? name

/--
  Add a new name to the mapping, assuming the name is not present in the list yet.
  If the name is already present, return `none`
-/
def NameMapping.add (nm : NameMapping) (name : String) : Option NameMapping := 
  match nm.lookup name with
    | none => some <| name::nm
    | some _ => none

section Monads
variable {α : Type*} (MTy : α → Type*)

abbrev ExceptM  := Except (TransformError MTy)
abbrev BuilderM := StateT NameMapping (ExceptM MTy)
abbrev ReaderM  := ReaderT NameMapping (ExceptM MTy)

instance : MonadLift (ReaderM MTy) (BuilderM MTy) where
  monadLift x := do (ReaderT.run x (←get) : ExceptM ..)

instance : MonadLift (ExceptM MTy) (ReaderM MTy) where
  monadLift x := do return ←x

def BuilderM.runWithNewMapping {MTy : α → Type*} (k : BuilderM MTy β) : ExceptM MTy β :=
  Prod.fst <$> StateT.run k []

end Monads

structure DerivedContext (Γ : Context Op φ) where
  ctxt : Context Op φ
  diff : Ctxt.Diff Γ ctxt

variable {Op : Type} [dialectFamily : DialectFamily Op]
open DialectFamily (Ty MOp MTy)

namespace DerivedContext

/-- Every context is trivially derived from itself -/
abbrev ofContext (Γ : Context Op φ) : DerivedContext Op Γ := ⟨Γ, .zero _⟩

/-- `snoc` of a derived context applies `snoc` to the underlying context, and updates the diff -/
def snoc {Γ : Context Op φ} : DerivedContext Op Γ → dialectFamily.MTy φ → DerivedContext Op Γ 
  | ⟨ctxt, diff⟩, ty => ⟨ty::ctxt, diff.toSnoc⟩

instance {Γ : Context Op φ} : CoeHead (DerivedContext Op Γ) (Context Op φ) where
  coe := fun ⟨Γ', _⟩ => Γ'

instance {Γ : Context Op φ} : CoeDep (Context Op φ) Γ (DerivedContext Op Γ) where
  coe := ⟨Γ, .zero _⟩

instance {Γ : Context Op φ} {Γ' : DerivedContext Op Γ} : 
    CoeHead (DerivedContext Op (Γ' : Context Op φ)) (DerivedContext Op Γ) where
  coe := fun ⟨Γ'', diff⟩ => ⟨Γ'', Γ'.diff + diff⟩

instance {Γ : Context Op φ} {Γ' : DerivedContext Op Γ} : Coe (Expr Op Γ t) (Expr Op Γ' t) where
  coe e := e.changeVars Γ'.diff.toHom

instance {Γ' : DerivedContext Op Γ} : Coe (Var Op Γ t) (Var Op Γ' t) where
  coe v := Γ'.diff.toHom v

end DerivedContext

/--
  Add a new variable to the context, and record it's (absolute) index in the name mapping

  Throws an error if the variable name already exists in the mapping, essentially disallowing
  shadowing
-/
def addValToMapping (Γ : Context Op φ) (name : String) (ty : dialectFamily.MTy φ) : 
    BuilderM dialectFamily.MTy (Σ (Γ' : DerivedContext Op Γ), Var Op Γ' ty) := do
  let some nm := (←get).add name
    | throw <| .nameAlreadyDeclared name
  set nm
  return ⟨DerivedContext.ofContext Γ |>.snoc ty, Ctxt.Var.last ..⟩

/--
  Look up a name from the name mapping, and return the corresponding variable in the given context.

  Throws an error if the name is not present in the mapping (this indicates the name may be free),
  or if the type of the variable in the context is different from `expectedType`
-/
def getValFromContext (Γ : Context Op φ) (name : String) (expectedType : dialectFamily.MTy φ) : 
    ReaderM dialectFamily.MTy (Var Op Γ expectedType) := do
  let index := (←read).lookup name
  let some index := index | throw <| .undeclaredName name
  let n := Γ.length
  if h : index >= n then
    /-  This should not happen, it indicates the passed context `Γ` is out of sync with the 
        namemapping stored in the monad -/
    throw <| .indexOutOfBounds name index n
  else
    let t := List.get Γ ⟨index, Nat.lt_of_not_le h⟩
    if h : t = expectedType then
      return ⟨index, by simp[←h, ←List.get?_eq_get]⟩
    else
      throw <| .typeError expectedType t

def BuilderM.isOk {α : Type} (x : BuilderM dialectFamily.MTy α) : Bool := 
  match x.run [] with
  | Except.ok _ => true
  | Except.error _ => false

def BuilderM.isErr {α : Type} (x : BuilderM dialectFamily.MTy α) : Bool := 
  match x.run [] with
  | Except.ok _ => true
  | Except.error _ => false

-- InstCombine specific
def mkUnaryOp {Γ : Context Op φ} {ty : dialectFamily.MTy φ} (op : dialectFamily.MOp φ)
  (e : Var Op Γ ty) : ExceptM dialectFamily.MTy <| Expr Op Γ ty :=
 match ty with
 | .bitvec w =>
   match op with
   -- Can't use a single arm, Lean won't write the rhs accordingly
    | .neg w' => if h : w = w' 
      then return ⟨
        .neg w',
        by simp [OpSignature.outTy, signature, h],
        .cons (h ▸ e) .nil,
        .nil
      ⟩
      else throw <| .widthError w w'
    | .not w' => if h : w = w' 
      then return ⟨
        .not w',
        by simp [OpSignature.outTy, signature, h],
        .cons (h ▸ e) .nil,
        .nil
      ⟩ 
      else throw <| .widthError w w'
    | .copy w' => if h : w = w' 
      then return ⟨
        .copy w',
        by simp [OpSignature.outTy, signature, h],
        .cons (h ▸ e) .nil,
        .nil
      ⟩
      else throw <| .widthError w w'
    | _ => throw <| .unsupportedUnaryOp

def mkBinOp {Γ : Ctxt _} {ty : MTy φ} (op : MOp φ)
    (e₁ e₂ : Ctxt.Var Op Γ ty) : ExceptM <| Expr Op Γ ty :=
 match ty with
 | .bitvec w =>
   match op with
   -- Can't use a single arm, Lean won't write the rhs accordingly
    | .add w' => if h : w = w' 
      then return ⟨
        .add w',
        by simp [OpSignature.outTy, signature, h],
        .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil ,
        .nil
      ⟩
      else throw <| .widthError w w'
    | .and w' => if h : w = w' 
      then return ⟨
        .and w',
        by simp [OpSignature.outTy, signature, h],
        .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil ,
        .nil
      ⟩
      else throw <| .widthError w w'
    | .or w' => if h : w = w' 
      then return ⟨
        .or w',
        by simp [OpSignature.outTy, signature, h],
        .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil ,
        .nil
      ⟩
      else throw <| .widthError w w'
    | .xor w' => if h : w = w' 
      then return ⟨
        .xor w',
        by simp [OpSignature.outTy, signature, h],
        .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil ,
        .nil
      ⟩
      else throw <| .widthError w w'
    | .shl w' => if h : w = w' 
      then return ⟨
        .shl w',
        by simp [OpSignature.outTy, signature, h],
        .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil ,
        .nil
      ⟩
      else throw <| .widthError w w'
    | .lshr w' => if h : w = w' 
      then return ⟨
        .lshr w',
        by simp [OpSignature.outTy, signature, h],
        .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil ,
        .nil
      ⟩
      else throw <| .widthError w w'
    | .ashr w' => if h : w = w' 
      then return ⟨
        .ashr w',
        by simp [OpSignature.outTy, signature, h],
        .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil ,
        .nil
      ⟩
      else throw <| .widthError w w'
     | .urem w' => if h : w = w' 
      then return ⟨
        .urem w',
        by simp [OpSignature.outTy, signature, h],
        .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil ,
        .nil
      ⟩
      else throw <| .widthError w w'
     | .srem w' => if h : w = w' 
      then return ⟨
        .srem w',
        by simp [OpSignature.outTy, signature, h],
        .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil ,
        .nil
      ⟩
      else throw <| .widthError w w'
     | .mul w' => if h : w = w' 
      then return ⟨
        .mul w',
        by simp [OpSignature.outTy, signature, h],
        .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil ,
        .nil
      ⟩
      else throw <| .widthError w w'
      | .sub w' => if h : w = w'
      then return ⟨
        .sub w',
        by simp [OpSignature.outTy, signature, h],
        .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil ,
        .nil
      ⟩
      else throw <| .widthError w w'
      | .sdiv w' => if h : w = w'
      then return ⟨
        .sdiv w',
        by simp [OpSignature.outTy, signature, h],
        .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil ,
        .nil
      ⟩
      else throw <| .widthError w w'
      | .udiv w' => if  h : w = w'
      then return ⟨
        .udiv w',
        by simp [OpSignature.outTy, signature, h],
        .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil ,
        .nil
      ⟩
      else throw <| .widthError w w'
    | _ => throw <| .unsupportedBinaryOp

def mkIcmp {Γ : Ctxt _} {ty : MTy φ} (op : MOp φ)
    (e₁ e₂ : Ctxt.Var Op Γ ty) : ExceptM <| Expr Op Γ (.bitvec 1) :=
  match ty with
  | .bitvec w =>
    match op with
      | .icmp p w' => if  h : w = w'
      then return ⟨
        .icmp p w',
        by simp [OpSignature.outTy, signature, h],
        .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil ,
        .nil
⟩
      else throw <| .widthError w w'
      | _ => throw .unsupportedOp -- unsupported icmp operation

def mkSelect {Γ : Context Op φ} {ty : MTy φ} (op : MOp φ)
    (c : Var Op Γ (.bitvec 1)) (e₁ e₂ : Var Op Γ ty) :
    ExceptM <| Expr Op Γ ty :=
  match ty with
  | .bitvec w =>
    match op with
        | .select w' => if  h : w = w'
        then return ⟨
          .select w',
          by simp [OpSignature.outTy, signature, h],
          .cons c <|.cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil ,
          .nil
        ⟩
        else throw <| .widthError w w'
        | _ => throw .unsupportedOp -- "Unsupported select operation"

def mkOpExpr {Γ : Context Op φ} (op : MOp φ) 
    (arg : HVector (fun t => Ctxt.Var Op Γ t) (OpSignature.sig op)) : 
    ExceptM <| Expr Op Γ (OpSignature.outTy op) :=
  match op with
  | .and _ | .or _ | .xor _ | .shl _ | .lshr _ | .ashr _
  | .add _ | .mul _ | .sub _ | .udiv _ | .sdiv _ 
  | .srem _ | .urem _  => 
    let (e₁, e₂) := arg.toTuple
    mkBinOp op e₁ e₂
  | .icmp _ _ => 
    let (e₁, e₂) := arg.toTuple
    mkIcmp op e₁ e₂
  | .not _ | .neg _ | .copy _ => 
    mkUnaryOp op arg.head
  | .select _ => 
    let (c, e₁, e₂) := arg.toTuple
    mkSelect op c e₁ e₂
  | .const .. => throw .unsupportedOp -- "Tried to build Op expression from constant"

def MLIRType.mkTy : MLIRType φ → ExceptM (MTy φ)
  | MLIRType.int Signedness.Signless w => do 
    return .bitvec w
  | _ => throw .unsupportedType -- "Unsupported type"

def TypedSSAVal.mkTy : TypedSSAVal φ → ExceptM (MTy φ)
  | (.SSAVal _, ty) => ty.mkTy

def mkVal (ty : InstCombine.Ty) : Int → Bitvec ty.width
  | val => Bitvec.ofInt ty.width val

/-- Translate a `TypedSSAVal` (a name with an expected type), to a variable in the context.
    This expects the name to have already been declared before -/
def TypedSSAVal.mkVal (Γ : Context Op φ) : TypedSSAVal φ → 
    ReaderM (Σ (ty : MTy φ), Var Op Γ ty)
| (.SSAVal valStx, tyStx) => do
    let ty ← tyStx.mkTy
    let var ← getValFromContext Op Γ valStx ty
    return ⟨ty, var⟩

/-- Declare a new variable, 
    by adding the passed name to the name mapping stored in the monad state -/
def TypedSSAVal.newVal (Γ : Context Op φ) : TypedSSAVal φ → 
    BuilderM (Σ (Γ' : DerivedContext Op Γ) (ty : MTy φ), Var Op Γ' ty)
| (.SSAVal valStx, tyStx) => do
    let ty ← tyStx.mkTy
    let ⟨Γ, var⟩ ← addValToMapping Γ valStx ty
    return ⟨Γ, ty, var⟩

def mkExpr (Γ : Context Op φ) (opStx : Op φ) : ReaderM (Σ ty, Expr Op Γ ty) := do
  let args ← opStx.args.mapM (TypedSSAVal.mkVal Γ)
  match args with
  | [⟨.bitvec w₁, v₁⟩, ⟨.bitvec w₂, v₂⟩] =>
    let op ← match opStx.name with
      | "llvm.and"    => pure (MOp.and w₁)
      | "llvm.or"     => pure (MOp.or w₁)
      | "llvm.xor"    => pure (MOp.xor w₁)
      | "llvm.shl"    => pure (MOp.shl w₁)
      | "llvm.lshr"   => pure (MOp.lshr w₁)
      | "llvm.ashr"   => pure (MOp.ashr w₁)
      | "llvm.urem"   => pure (MOp.urem w₁)
      | "llvm.srem"   => pure (MOp.srem w₁)
      | "llvm.select" => pure (MOp.select w₁)
      | "llvm.add"    => pure (MOp.add w₁)
      | "llvm.mul"    => pure (MOp.mul w₁)
      | "llvm.sub"    => pure (MOp.sub w₁)
      | "llvm.sdiv"   => pure (MOp.sdiv w₁)
      | "llvm.udiv"   => pure (MOp.udiv w₁)
       --| "llvm.icmp" => return InstCombine.Op.icmp v₁.width
      | _ => throw .unsupportedOp -- "Unsuported operation or invalid arguments"
    if hty : w₁ = w₂ then 
      let binOp ← (mkBinOp op v₁ (hty ▸ v₂) : ExceptM _)
      return ⟨.bitvec w₁, binOp⟩
    else 
      throw <| .widthError w₁ w₂ -- s!"mismatched types {ty₁} ≠ {ty₂} in binary op"
  | [⟨.bitvec w, v⟩] =>
    let op ← match opStx.name with
        | "llvm.not" => pure <| MOp.not w
        | "llvm.neg" => pure <| MOp.neg w
        | _ => throw <| .generic s!"Unknown (unary) operation syntax {opStx.name}"
    let op ← mkUnaryOp op v
    return ⟨.bitvec w, op⟩
  | [] => 
    if opStx.name ==  "llvm.mlir.constant" 
    then do
    let some att := opStx.attrs.getAttr "value"
      | throw <| .generic "tried to resolve constant without 'value' attribute"
    match att with
      | .int val ty =>
          let opTy@(MTy.bitvec w) ← ty.mkTy
          return ⟨opTy, ⟨
            MOp.const w val, 
            by simp [OpSignature.outTy, signature, *],
            HVector.nil,
            HVector.nil
          ⟩⟩
      | _ => throw <| .generic "invalid constant attribute"
    else 
      throw <| .generic s!"invalid (0-ary) expression {opStx.name}"
  | _ => throw <| .generic s!"unsupported expression (with unsupported arity) {opStx.name}"

def mkReturn (Γ : Context Op φ) (opStx : Op φ) : ReaderM (Σ ty, Com Γ ty) := 
  if opStx.name == "llvm.return"
  then match opStx.args with
  | vStx::[] => do
    let ⟨ty, v⟩ ← vStx.mkVal Γ
    return ⟨ty, ICom.ret v⟩
  | _ => throw <| .generic s!"Ill-formed return statement (wrong arity, expected 1, got {opStx.args.length})" 
  else throw <| .generic s!"Tried to build return out of non-return statement {opStx.name}"

/-- Given a list of `TypedSSAVal`s, treat each as a binder and declare a new variable with the 
    given name and type -/
private def declareBindings (Γ : Context Op φ) (vals : List (TypedSSAVal φ)) : 
    BuilderM (DerivedContext Op Γ) := do
  vals.foldlM (fun Γ' ssaVal => do
    let ⟨Γ'', _⟩ ← TypedSSAVal.newVal Γ' ssaVal
    return Γ''
  ) (.ofContext Op Γ)

private def mkComHelper (Γ : Context Op φ) : 
    List (Op φ) → BuilderM (Σ (ty : _), Com Γ ty)
  | [retStx] => mkReturn Γ retStx
  | lete::rest => do
    let ⟨ty₁, expr⟩ ← mkExpr Op Γ lete
    if h : lete.res.length != 1 then
      throw <| .generic s!"Each let-binding must have exactly one name on the left-hand side. Operations with multiple, or no, results are not yet supported.\n\tExpected a list of length one, found `{repr lete}`"
    else
      let _ ← addValToMapping Γ (lete.res[0]'(by simp_all) |>.fst |> SSAValToString) ty₁
      let ⟨ty₂, body⟩ ← mkComHelper (ty₁::Γ) rest
      return ⟨ty₂, Com.lete expr body⟩
  | [] => throw <| .generic "Ill-formed (empty) block"

def mkCom (reg : Region φ) : ExceptM (Σ (Γ : Context Op φ) (ty : MTy φ), Com Γ ty) := 
  match reg.ops with
  | [] => throw <| .generic "Ill-formed region (empty)"
  | coms => BuilderM.runWithNewMapping <| do
    let Γ ← declareBindings ∅ reg.args
    let icom ← mkComHelper Γ coms
    return ⟨Γ, icom⟩

/-!
  ## Instantiation
  Finally, we show how to instantiate a family of programs to a concrete program
-/

def _root_.InstCombine.MTy.instantiate (vals : Vector Nat φ) : MTy φ → InstCombine.Ty
  | .bitvec w => .bitvec <| .concrete <| w.instantiate vals

def _root_.InstCombine.MOp.instantiate (vals : Vector Nat φ) : MOp φ → InstCombine.Op
  | .and w => .and (w.instantiate vals)
  | .or w => .or (w.instantiate vals)
  | .not w => .not (w.instantiate vals)
  | .xor w => .xor (w.instantiate vals)
  | .shl w => .shl (w.instantiate vals)
  | .lshr w => .lshr (w.instantiate vals)
  | .ashr w => .ashr (w.instantiate vals)
  | .urem w => .urem (w.instantiate vals)
  | .srem w => .srem (w.instantiate vals)
  | .select w => .select (w.instantiate vals)
  | .add w => .add (w.instantiate vals)
  | .mul w => .mul (w.instantiate vals)
  | .sub w => .sub (w.instantiate vals)
  | .neg w => .neg (w.instantiate vals)
  | .copy w => .copy (w.instantiate vals)
  | .sdiv w => .sdiv (w.instantiate vals)
  | .udiv w => .udiv (w.instantiate vals)
  | .icmp c w => .icmp c (w.instantiate vals)
  | .const w val => .const (w.instantiate vals) val

def Context.instantiate (vals : Vector Nat φ) (Γ : Context Op φ) : Ctxt InstCombine.Ty :=
  Γ.map (MTy.instantiate vals)

def MOp.instantiateCom (vals : Vector Nat φ) : DialectMorphism (MOp φ) (InstCombine.Op) where
  mapOp := MOp.instantiate vals
  mapTy := MTy.instantiate vals
  preserves_signature op := by
    simp only [MTy.instantiate, MOp.instantiate, ConcreteOrMVar.instantiate, (· <$> ·), signature, 
      InstCombine.MOp.sig, InstCombine.MOp.outTy, Function.comp_apply, List.map, Signature.mk.injEq, 
      true_and]
    cases op <;> simp only [List.map, and_self, List.cons.injEq]
    

open InstCombine (Op Ty) in
def mkComInstantiate (reg : Region φ) : 
    ExceptM (Vector Nat φ → Σ (Γ : Ctxt Ty) (ty : Ty), ICom InstCombine.Op Γ ty) := do
  let ⟨Γ, ty, icom⟩ ← mkCom reg
  return fun vals =>
    ⟨Γ.instantiate vals, ty.instantiate vals, icom.map (MOp.instantiateCom vals)⟩

end MLIR.AST
