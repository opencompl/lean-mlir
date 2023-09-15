-- should replace with Lean import once Pure is upstream
import SSA.Projects.MLIRSyntax.AST
import SSA.Projects.InstCombine.Base
import SSA.Experimental.IntrinsicAsymptotics

abbrev Context := List InstCombine.Ty
abbrev Expr (Γ : Context) (ty : InstCombine.Ty) := IExpr InstCombine.Op Γ ty
abbrev Com (Γ : Context) (ty : InstCombine.Ty) := ICom InstCombine.Op Γ ty
--abbrev Bitvec (w : Nat) := InstCombine.Ty.bitvec w

abbrev Com.lete (body : Expr Γ ty₁) (rest : Com (ty₁::Γ) ty₂) := 
  ICom.lete body rest

namespace MLIR.AST

/--
Store the names of the raw SSA variables (as strings).
The order in the list should match the order in which they appear in the code.
-/
abbrev NameMapping := List String

def NameMapping.lookup (nm : NameMapping) (name : String) : Option Nat :=
  nm.indexOf? name

def NameMapping.addGet (nm : NameMapping) (name : String) : NameMapping × Nat := 
  match nm.lookup name with
    | none => (name::nm, nm.length)
    | some n => (nm, n)

abbrev ExceptM := Except String
abbrev BuilderM := StateT NameMapping ExceptM
abbrev ReaderM := ReaderT NameMapping ExceptM

instance : MonadLift ReaderM BuilderM where
  monadLift x := do (ReaderT.run x (←get) : ExceptM _)

structure DerivedContext (Γ : Context) where
  ctxt : Context
  diff : Ctxt.Diff Γ ctxt

namespace DerivedContext

/-- `snoc` of a derived context applies `snoc` to the underlying context, and updates the diff -/
def snoc : DerivedContext Γ → InstCombine.Ty → DerivedContext Γ 
  | ⟨ctxt, diff⟩, ty => ⟨ty::ctxt, diff.toSnoc⟩

instance : CoeHead (DerivedContext Γ) Context where
  coe := fun ⟨Γ', _⟩ => Γ'

instance : CoeDep Context Γ (DerivedContext Γ) where
  coe := ⟨Γ, .zero _⟩

instance {Γ' : DerivedContext Γ} : CoeHead (DerivedContext Γ') (DerivedContext Γ) where
  coe := fun ⟨Γ'', diff⟩ => ⟨Γ'', Γ'.diff + diff⟩

instance {Γ' : DerivedContext Γ} : Coe (Expr Γ t) (Expr Γ' t) where
  coe e := e.changeVars Γ'.diff.toHom

end DerivedContext

/--
  Add a new variable to the context, and record it's (absolute) index in the name mapping

  Throws an error if the variable name already exists in the mapping, essentially disallowing
  shadowing
-/
def addValToMapping (Γ : Context) (name : String) (ty : InstCombine.Ty) : 
    BuilderM (DerivedContext Γ) := do
  let nm ← get
  match nm.lookup name with
    | none => 
      set (name :: nm)
      return ⟨ty::Γ, Ctxt.Diff.zero Γ |>.toSnoc⟩
    | some _ => throw s!"Already declared {name}, shadowing is not allowed"

/--
  Look up a name from the name mapping, and return the corresponding variable in the given context.

  Throws an error if the name is not present in the mapping (this indicates the name may be free),
  or if the type of the variable in the context is different from `expectedType`
-/
def getValFromContext (Γ : Context) (name : String) (expectedType : InstCombine.Ty) : 
    ReaderM (Ctxt.Var Γ expectedType) := do
  let index := (←read).lookup name
  let some index := index | throw s!"Undeclared name '{name}'"
  let n := Γ.length
  if h : index >= n then
    /-  This should not happen, it indicates the passed context `Γ` is out of sync with the 
        namemapping stored in the monad -/
    throw s!"Index of '{name}' out of bounds of the given context"
  else
    let t := List.get Γ ⟨index, Nat.lt_of_not_le h⟩
    if h : t = expectedType then
      return ⟨index, by simp[←h, ←List.get?_eq_get]⟩
    else
      throw s!"Type mismatch: expected '{expectedType}', but 'name' has type {t}"


-- def addGetCtxt (Γ : Context) (name : String) (ty : InstCombine.Ty) : 
--   BuilderM ((Γ.Var ty) ⊕ (Γ.snoc ty |>.Var ty)) := do
--   let N := Γ.length
--   let nm ← get
--   let (nm',n) := nm.addGet name
--   if h : Γ.get? (N - n) = ty then
--     return .inl { val := (N - n), property := h}
--   else if Γ.get? n = none then
--      let Γ' := Γ.snoc ty  
--      if h : Γ'.get? 0 = some ty then
--        let _ ← set nm'
--        return .inr { val := 0, property := h }
--      else throw s!"Failed to add variable to context (size mismatch {n} ≠ {Γ'.length})"
--   else throw s!"Failed to add variable to context (type mismatch {Γ.get! <| N - n} ≠ {ty})"

def BuilderM.isOk {α : Type} (x : BuilderM α) : Bool := 
  match x.run [] with
  | Except.ok _ => true
  | Except.error _ => false

def BuilderM.isErr {α : Type} (x : BuilderM α) : Bool := 
  match x.run [] with
  | Except.ok _ => true
  | Except.error _ => false

def BuilderM.printErr {α : Type} (x : BuilderM α) : String := 
  match x.run [] with
  | Except.ok _ => "okay"
  | Except.error s => s

def mkUnaryOp {Γ : Ctxt _} {ty : InstCombine.Ty} (op : InstCombine.Op)
 (e : Ctxt.Var Γ ty) : ExceptM <| IExpr InstCombine.Op Γ ty :=
 match ty with
 | .bitvec w =>
   match op with
   -- Can't use a single arm, Lean won't write the rhs accordingly
    | .neg w' => if h : w = w' 
      then return { op := .neg w'
                    ty_eq := by simp [OpSignature.outTy, h]
                    args := .cons (h ▸ e) .nil }
      else throw s!"Type mismatch {w} ≠ {w'}"
    | .not w' => if h : w = w' 
      then return { op := .not w'
                    ty_eq := by simp [OpSignature.outTy, h]
                    args := .cons (h ▸ e) .nil }
      else throw s!"Type mismatch {w} ≠ {w'}"
    | .copy w' => if h : w = w' 
      then return { op := .copy w'
                    ty_eq := by simp [OpSignature.outTy, h]
                    args := .cons (h ▸ e) .nil }
      else throw s!"Type mismatch {w} ≠ {w'}"
    | _ => throw "Unsuported unuary operation"

def mkBinOp {Γ : Ctxt _} {ty : InstCombine.Ty} (op : InstCombine.Op)
 (e₁ e₂ : Ctxt.Var Γ ty) : ExceptM <| IExpr InstCombine.Op Γ ty :=
 match ty with
 | .bitvec w =>
   match op with
   -- Can't use a single arm, Lean won't write the rhs accordingly
    | .add w' => if h : w = w' 
      then return { op := .add w'
                    ty_eq := by simp [OpSignature.outTy, h]
                    args := .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil }
      else throw s!"Type mismatch {w} ≠ {w'}"
    | .and w' => if h : w = w' 
      then return { op := .and w'
                    ty_eq := by simp [OpSignature.outTy, h]
                    args := .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil }
      else throw s!"Type mismatch {w} ≠ {w'}"
    | .or w' => if h : w = w' 
      then return { op := .or w'
                    ty_eq := by simp [OpSignature.outTy, h]
                    args := .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil }
      else throw s!"Type mismatch {w} ≠ {w'}"
    | .xor w' => if h : w = w' 
      then return { op := .xor w'
                    ty_eq := by simp [OpSignature.outTy, h]
                    args := .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil }
      else throw s!"Type mismatch {w} ≠ {w'}"
    | .shl w' => if h : w = w' 
      then return { op := .shl w'
                    ty_eq := by simp [OpSignature.outTy, h]
                    args := .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil }
      else throw s!"Type mismatch {w} ≠ {w'}"
    | .lshr w' => if h : w = w' 
      then return { op := .lshr w'
                    ty_eq := by simp [OpSignature.outTy, h]
                    args := .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil }
      else throw s!"Type mismatch {w} ≠ {w'}"
    | .ashr w' => if h : w = w' 
      then return { op := .ashr w'
                    ty_eq := by simp [OpSignature.outTy, h]
                    args := .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil }
      else throw s!"Type mismatch {w} ≠ {w'}"
     | .urem w' => if h : w = w' 
      then return { op := .urem w'
                    ty_eq := by simp [OpSignature.outTy, h]
                    args := .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil }
      else throw s!"Type mismatch {w} ≠ {w'}"
     | .srem w' => if h : w = w' 
      then return { op := .srem w'
                    ty_eq := by simp [OpSignature.outTy, h]
                    args := .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil }
      else throw s!"Type mismatch {w} ≠ {w'}"
     | .mul w' => if h : w = w' 
      then return { op := .mul w'
                    ty_eq := by simp [OpSignature.outTy, h]
                    args := .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil }
      else throw s!"Type mismatch {w} ≠ {w'}"
      | .sub w' => if h : w = w'
      then return { op := .sub w'
                    ty_eq := by simp [OpSignature.outTy, h]
                    args := .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil }
      else throw s!"Type mismatch {w} ≠ {w'}"
      | .sdiv w' => if h : w = w'
      then return { op := .sdiv w'
                    ty_eq := by simp [OpSignature.outTy, h]
                    args := .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil }
      else throw s!"Type mismatch {w} ≠ {w'}"
      | .udiv w' => if  h : w = w'
      then return { op := .udiv w'
                    ty_eq := by simp [OpSignature.outTy, h]
                    args := .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil }
      else throw s!"Type mismatch {w} ≠ {w'}"
    | _ => throw "Unsuported binary operation"

def mkIcmp {Γ : Ctxt _} {ty : InstCombine.Ty} (op : InstCombine.Op)
    (e₁ e₂ : Ctxt.Var Γ ty) : ExceptM <| IExpr InstCombine.Op Γ (.bitvec 1) :=
  match ty with
  | .bitvec w =>
    match op with
      | .icmp p w' => if  h : w = w'
      then return { op := .icmp p w'
                    ty_eq := by simp [OpSignature.outTy, h]
                    args := .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil }
      else throw "Type mismatch {w} ≠ {w'}"
      | _ => throw "Unsupported icmp operation"

def mkSelect {Γ : Ctxt _} {ty : InstCombine.Ty} (op : InstCombine.Op)
    (c : Ctxt.Var Γ (.bitvec 1)) (e₁ e₂ : Ctxt.Var Γ ty) : ExceptM <| IExpr InstCombine.Op Γ ty :=
  match ty with
  | .bitvec w =>
    match op with
        | .select w' => if  h : w = w'
        then return { op := .select w'
                      ty_eq := by simp [OpSignature.outTy, h]
                      args := .cons c <|.cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil }
        else throw "Type mismatch {w} ≠ {w'}"
        | _ => throw "Unsupported select operation"

def mkOpExpr {Γ : Ctxt _} (op : InstCombine.Op) 
    (arg : HVector (fun t => Ctxt.Var Γ t) (OpSignature.sig op)) : 
    ExceptM <| IExpr InstCombine.Op Γ (OpSignature.outTy op) :=
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
  | .const _ => throw "Tried to build Op expression from constant"

def MLIRType.mkTy : MLIRType → ExceptM InstCombine.Ty
  | MLIRType.int Signedness.Signless w => do return InstCombine.Ty.bitvec w
  | _ => throw "Unsupported type"

def TypedSSAVal.mkTy : TypedSSAVal → ExceptM InstCombine.Ty
  | (.SSAVal _, ty) => ty.mkTy

def mkVal (ty : InstCombine.Ty) : Int → Bitvec ty.width
  | val => Bitvec.ofInt ty.width val

/-- Translate a `TypedSSAVal` (a name with an expected type), to a variable in the context.
    This expects the name to have already been declared before -/
def TypedSSAVal.mkVal (Γ : Context) : TypedSSAVal → ReaderM (Σ ty, Ctxt.Var Γ ty)
| (.SSAVal valStx, tyStx) => do
    let ty ← tyStx.mkTy
    let var ← getValFromContext Γ valStx ty
    return ⟨ty, var⟩

/-- Declare a new variable -/
def TypedSSAVal.newVal (Γ : Context) : TypedSSAVal → BuilderM (Σ ty, Ctxt.Var (ty::Γ) ty)
| (.SSAVal valStx, tyStx) => do
    let ty ← tyStx.mkTy
    let var ← getValFromContext Γ valStx ty
    return ⟨ty, var⟩

def mkExpr (opStx : Op) (Γ : Context) : ReaderM (Σ ty, Expr Γ ty) := do
  match opStx.args with
  | v₁Stx::v₂Stx::[] =>
    let ⟨ty₁, v₁⟩ ← TypedSSAVal.mkVal Γ v₁Stx
    let ⟨ty₂, v₂⟩ ← TypedSSAVal.mkVal Γ v₂Stx
    let op ← match opStx.name with
      | "llvm.and" => pure <| InstCombine.Op.and ty₁.width
      | "llvm.or" => pure <| InstCombine.Op.or ty₁.width
      | "llvm.xor" => pure <| InstCombine.Op.xor ty₁.width
      | "llvm.shl" => pure <| InstCombine.Op.shl ty₁.width
      | "llvm.lshr" => pure <| InstCombine.Op.lshr ty₁.width
      | "llvm.ashr" => pure <| InstCombine.Op.ashr ty₁.width
      | "llvm.urem" => pure <| InstCombine.Op.urem ty₁.width
      | "llvm.srem" => pure <| InstCombine.Op.srem ty₁.width
      | "llvm.select" => pure <| InstCombine.Op.select ty₁.width
      | "llvm.add" => pure <| InstCombine.Op.add ty₁.width
      | "llvm.mul" => pure <| InstCombine.Op.mul ty₁.width
      | "llvm.sub" => pure <| InstCombine.Op.sub ty₁.width
      | "llvm.sdiv" => pure <| InstCombine.Op.sdiv ty₁.width
      | "llvm.udiv" => pure <| InstCombine.Op.udiv ty₁.width
       --| "llvm.icmp" => return InstCombine.Op.icmp v₁.width
      | _ => throw "Unsuported operation or invalid arguments"
      if hty : ty₁ = ty₂ then 
        let binOp ← mkBinOp op v₁ (hty ▸ v₂)
        return ⟨ty₁, binOp⟩
      else 
        throw s!"mismatched types {ty₁} ≠ {ty₂} in binary op"
  | vStx::[] =>
    let ⟨ty, v⟩ ← TypedSSAVal.mkVal Γ vStx
    let op ← match opStx.name with
        | "llvm.not" =>
          pure <| InstCombine.Op.not ty.width
        | "llvm.neg" => do
          pure <| InstCombine.Op.neg ty.width
        | _ => throw s!"Unknown (unary) operation syntax {opStx.name}"
     return ⟨ty, ← mkUnaryOp op v⟩
  | [] => 
    if opStx.name ==  "llvm.mlir.constant" 
    then do
    let some att := opStx.attrs.getAttr "value"
      | throw "tried to resolve constant without 'value' attribute"
    match att with
      | .int val ty => 
          let opTy ← ty.mkTy
          return ⟨opTy, {
            op := InstCombine.Op.const <| mkVal opTy val
            args := HVector.nil
            ty_eq := by simp [OpSignature.outTy]
          }⟩ 
      | _ => throw "invalid constant attribute"
    else 
      throw s!"invalid (0-ary) expression {opStx.name}"
  | _ => throw s!"unsupported expression (with unsupported arity) {opStx.name}"

def mkReturn (Γ : Context) (opStx : Op) : ReaderM (Σ ty, Com Γ ty) := 
  if opStx.name == "llvm.return"
  then match opStx.args with
  | vStx::[] => do
    let ⟨ty, v⟩ ← vStx.mkVal Γ
    return ⟨ty, ICom.ret v⟩
  | _ => throw s!"Ill-formed return statement (wrong arity, expected 1, got {opStx.args.length})" 
  else throw s!"Tried to build return out of non-return statement {opStx.name}"

-- def IExpr.changeContext (h : Ctxt.Hom Γ Γ') : Expr Γ ty  → Expr Γ' ty := sorry

/-
  Should the name mapping be a ever growing list?
  Probably not, it might have to be more like a stack, where variables are added while they are
  in scope, and removed after.
  In particular, `mkComHelper` has to modify the name-mapping for recursive calls, but it should 
  probably not return a modified context.
  I.e., we might not want to have a state monad at all, only `ReaderM`, where `addValToMapping`
  should instead be some `withValMapping` combinator
-/


private def mkComHelper (Γ : Context) : 
    List Op → BuilderM (Σ (ty : _), Com Γ ty)
  | [retStx] => mkReturn Γ retStx
  | lete::rest => do
    let ⟨ty₁, expr⟩ ← mkExpr lete Γ
    let _ ← addValToMapping Γ lete.name ty₁
    let ⟨ty₂, body⟩ ← mkComHelper (ty₁::Γ) rest
    return ⟨ty₂, Com.lete expr body⟩
    -- return Sigma.mk Γ'' <| Sigma.mk ty₂ <| (ICom.lete v₁' v₂, diff₁ |>.append diff₂)
  | [] => throw "Ill-formed (empty) block"

private partial def argsToCtxt (Γ : Context) : List ((ty : InstCombine.Ty) × Ctxt.Var Γ ty) → Context
  | [] => Γ
  | (Sigma.mk ty _)::rest => 
    let restChanged := rest.map fun (Sigma.mk ty' v') => Sigma.mk ty' (Ctxt.Var.toSnoc v' (t' := ty))
    argsToCtxt (ty :: Γ) restChanged

def mkCom (Γ : Context) (reg : Region) : BuilderM (Σ (Γ' : Context)(ty : InstCombine.Ty) , Com Γ' ty) := 
  match reg.ops with
  | [] => throw "Ill-formed region (empty)"
  | coms => do
    let valList ← (reg.args.mapM <| TypedSSAVal.mkVal Γ : ReaderM _)
    let Γ' := argsToCtxt Γ valList
    let icom ← mkComHelper Γ' coms
    return Sigma.mk Γ' icom

end MLIR.AST
