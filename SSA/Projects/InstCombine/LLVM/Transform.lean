-- should replace with Lean import once Pure is upstream
import SSA.Projects.MLIRSyntax.AST
import SSA.Projects.InstCombine.Base
import SSA.Projects.InstCombine.LLVM.Transform.NameMapping
import SSA.Projects.InstCombine.LLVM.Transform.TransformError
import SSA.Core.Framework

universe u

namespace MLIR.AST

section Monads

/-!
  Even though we technically only need to know the `Ty` type, 
  our typeclass hierarchy is fully based on `Op`.
  It is thus more convenient to incorporate `Op` in these types, so that there will be no ambiguity
  errors.
-/

abbrev ExceptM  (Op) {Ty} [OpSignature Op Ty] := Except (TransformError Ty)
abbrev BuilderM (Op) {Ty} [OpSignature Op Ty] := StateT NameMapping (ExceptM Op)
abbrev ReaderM  (Op) {Ty} [OpSignature Op Ty] := ReaderT NameMapping (ExceptM Op)

variable {Op Ty} [OpSignature Op Ty]

instance : MonadLift (ReaderM Op) (BuilderM Op) where
  monadLift x := do (ReaderT.run x (←get) : ExceptM ..)

instance : MonadLift (ExceptM Op) (ReaderM Op) where
  monadLift x := do return ←x

def BuilderM.runWithNewMapping (k : BuilderM Op α) : ExceptM Op α :=
  Prod.fst <$> StateT.run k []

end Monads

class TransformDialect (Op : Type) (Ty : outParam (Type)) (φ : outParam Nat) extends OpSignature Op Ty where
  mkType   : MLIRType φ → ExceptM Op Ty
  mkReturn : (Γ : List Ty) → (opStx : AST.Op φ) → (args : List (Σ (ty : Ty), Ctxt.Var Γ ty))  
    → ReaderM Op (Σ ty, ICom Op Γ ty)
  mkExpr   : (Γ : List Ty) → (opStx : AST.Op φ) → (args : List (Σ (ty : Ty), Ctxt.Var Γ ty)) 
    → ReaderM Op (Σ ty, IExpr Op Γ ty)

variable (Op) {Ty φ} [d : TransformDialect Op Ty φ]

abbrev Context (Ty) := List (Ty)

abbrev Expr (Γ : Context Ty) (ty : Ty)  := IExpr Op Γ ty
abbrev Com (Γ : Context Ty) (ty : Ty)   := ICom Op Γ ty
abbrev Var (Γ : Context Ty) (ty : Ty)   := Ctxt.Var Γ ty



variable {Op} [d : TransformDialect Op Ty φ] [DecidableEq Ty]

abbrev Com.lete (body : Expr Op Γ ty₁) (rest : Com Op (ty₁::Γ) ty₂) : Com Op Γ ty₂ := 
  ICom.lete body rest





structure DerivedContext (Γ : Context Ty) where
  ctxt : Context Ty
  diff : Ctxt.Diff Γ ctxt

namespace DerivedContext

/-- Every context is trivially derived from itself -/
abbrev ofContext (Γ : Context Ty) : DerivedContext Γ := ⟨Γ, .zero _⟩

/-- `snoc` of a derived context applies `snoc` to the underlying context, and updates the diff -/
def snoc {Γ : Context Ty} : DerivedContext Γ → Ty → DerivedContext Γ 
  | ⟨ctxt, diff⟩, ty => ⟨ty::ctxt, diff.toSnoc⟩

instance {Γ : Context Ty} : CoeHead (DerivedContext Γ) (Context Ty) where
  coe := fun ⟨Γ', _⟩ => Γ'

instance {Γ : Context Ty} : CoeDep (Context Ty) Γ (DerivedContext Γ) where
  coe := ⟨Γ, .zero _⟩

instance {Γ : Context Ty} {Γ' : DerivedContext Γ} : 
    CoeHead (DerivedContext (Γ' : Context Ty)) (DerivedContext Γ) where
  coe := fun ⟨Γ'', diff⟩ => ⟨Γ'', Γ'.diff + diff⟩

instance {Γ : Context Ty} {Γ' : DerivedContext Γ} : Coe (Expr Op Γ t) (Expr Op Γ' t) where
  coe e := e.changeVars Γ'.diff.toHom

instance {Γ' : DerivedContext Γ} : Coe (Var Γ t) (Var (Γ' : Context Ty) t) where
  coe v := Γ'.diff.toHom v

end DerivedContext

/--
  Add a new variable to the context, and record it's (absolute) index in the name mapping

  Throws an error if the variable name already exists in the mapping, essentially disallowing
  shadowing
-/
def addValToMapping (Γ : Context Ty) (name : String) (ty : Ty) : 
    BuilderM Op (Σ (Γ' : DerivedContext Γ), Var Γ' ty) := do
  let some nm := (←get).add name
    | throw <| .nameAlreadyDeclared name
  set nm
  return ⟨DerivedContext.ofContext Γ |>.snoc ty, Ctxt.Var.last ..⟩

/--
  Look up a name from the name mapping, and return the corresponding variable in the given context.

  Throws an error if the name is not present in the mapping (this indicates the name may be free),
  or if the type of the variable in the context is different from `expectedType`
-/
def getValFromContext (Γ : Context Ty) (name : String) (expectedType : Ty) : 
    ReaderM Op (Ctxt.Var Γ expectedType) := do
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

def BuilderM.isOk {α : Type} (x : BuilderM Op α) : Bool := 
  match x.run [] with
  | Except.ok _ => true
  | Except.error _ => false

def BuilderM.isErr {α : Type} (x : BuilderM Op α) : Bool := 
  match x.run [] with
  | Except.ok _ => true
  | Except.error _ => false

def MLIRType.mkTy : MLIRType φ → ExceptM Op Ty :=
  d.mkType
  

def TypedSSAVal.mkTy : TypedSSAVal φ → ExceptM Op Ty
  | (.SSAVal _, ty) => ty.mkTy

def mkVal (ty : InstCombine.Ty) : Int → Bitvec ty.width
  | val => Bitvec.ofInt ty.width val

/-- Translate a `TypedSSAVal` (a name with an expected type), to a variable in the context.
    This expects the name to have already been declared before -/
def TypedSSAVal.mkVal (Γ : Context Ty) : TypedSSAVal φ → 
    ReaderM Op (Σ (ty : Ty), Var Γ ty)
| (.SSAVal valStx, tyStx) => do
    let ty ← (tyStx.mkTy : ExceptM Op ..)
    let var ← getValFromContext Γ valStx ty
    return ⟨ty, var⟩

/-- Declare a new variable, 
    by adding the passed name to the name mapping stored in the monad state -/
def TypedSSAVal.newVal (Γ : Context Ty) : TypedSSAVal φ → 
    BuilderM Op (Σ (Γ' : DerivedContext Γ) (ty : Ty), Var Γ' ty)
| (.SSAVal valStx, tyStx) => do
    let ty ← (tyStx.mkTy : ExceptM Op ..)
    let ⟨Γ, var⟩ ← addValToMapping Γ valStx ty
    return ⟨Γ, ty, var⟩

/-- Given a list of `TypedSSAVal`s, treat each as a binder and declare a new variable with the 
    given name and type -/
private def declareBindings (Γ : Context Ty) (vals : List (TypedSSAVal φ)) : 
    BuilderM Op (DerivedContext Γ) := do
  vals.foldlM (fun Γ' ssaVal => do
    let ⟨Γ'', _⟩ ← TypedSSAVal.newVal Γ' ssaVal
    return Γ''
  ) (.ofContext Γ)

def mkExpr (Γ : Context Ty) (opStx : AST.Op φ) : ReaderM Op (Σ ty, Expr Op Γ ty) := do
  let args ← opStx.args.mapM (TypedSSAVal.mkVal Γ)
  d.mkExpr Γ opStx args

private def mkComHelper (Γ : Context Ty) : 
    List (AST.Op φ) → BuilderM Op (Σ (ty : _), Com Op Γ ty)
  | [retStx] => do
    let args ← (retStx.args.mapM (TypedSSAVal.mkVal Γ) : ReaderM Op ..)
    d.mkReturn Γ retStx args
  | lete::rest => do
    let ⟨ty₁, expr⟩ ← (mkExpr Γ lete : ReaderM Op ..)
    if h : lete.res.length != 1 then
      throw <| .generic s!"Each let-binding must have exactly one name on the left-hand side. Operations with multiple, or no, results are not yet supported.\n\tExpected a list of length one, found `{repr lete}`"
    else
      let _ ← addValToMapping Γ (lete.res[0]'(by simp_all) |>.fst |> SSAValToString) ty₁
      let ⟨ty₂, body⟩ ← mkComHelper (ty₁::Γ) rest
      return ⟨ty₂, Com.lete expr body⟩
  | [] => throw <| .generic "Ill-formed (empty) block"

variable (Op)

def mkCom (reg : Region φ) : ExceptM Op (Σ (Γ : Context Ty) (ty : Ty), Com Op Γ ty) := 
  match reg.ops with
  | [] => throw <| .generic "Ill-formed region (empty)"
  | coms => BuilderM.runWithNewMapping <| do
    let Γ ← declareBindings ∅ reg.args
    let icom ← mkComHelper Γ coms
    return ⟨Γ, icom⟩



end MLIR.AST
