-- should replace with Lean import once Pure is upstream
import SSA.Projects.MLIRSyntax.AST
import SSA.Projects.InstCombine.Base
import SSA.Experimental.IntrinsicAsymptotics

abbrev Context := Ctxt InstCombine.Ty
abbrev Expr (Γ : Context) (ty : InstCombine.Ty) := IExpr InstCombine.Op Γ ty
abbrev Com (Γ : Context) (ty : InstCombine.Ty) := ICom InstCombine.Op Γ ty
--abbrev Bitvec (w : Nat) := InstCombine.Ty.bitvec w

namespace MLIR.AST

abbrev NameMapping := List String

def NameMapping.lookup (nm : NameMapping) (name : String) : Option Nat :=
  nm.indexOf? name

def NameMapping.addGet (nm : NameMapping) (name : String) : NameMapping × Nat := 
  match nm.lookup name with
    | none => (name::nm, nm.length)
    | some n => (nm, n)

abbrev BuilderM := StateT NameMapping <| Except String

def addGetCtxt (Γ : Context) (name : String) (ty : InstCombine.Ty) : 
  BuilderM ((Γ.Var ty) ⊕ (Γ.snoc ty |>.Var ty)) := do
  let nm ← get
  let (nm',n) := nm.addGet name
  if h : Γ.get? n = ty then
    return .inl { val := n, property := h}
  else if Γ.get? n = none then
     let Γ' := Γ.snoc ty  
     if h : Γ'.get? n = some ty then
       let _ ← set nm'
       return .inr { val := n, property := h }
     else throw s!"Failed to add variable to context (size mismatch {n} ≠ {Γ'.length})"
  else throw s!"Failed to add variable to context (type mismatch {Γ.get! n} ≠ {ty})"

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
 (e : Ctxt.Var Γ ty) : BuilderM <| IExpr InstCombine.Op Γ ty :=
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
 (e₁ e₂ : Ctxt.Var Γ ty) : BuilderM <| IExpr InstCombine.Op Γ ty :=
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
 (e₁ e₂ : Ctxt.Var Γ ty) : BuilderM <| IExpr InstCombine.Op Γ (.bitvec 1) :=
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
 (c : Ctxt.Var Γ (.bitvec 1)) (e₁ e₂ : Ctxt.Var Γ ty) : BuilderM <| IExpr InstCombine.Op Γ ty :=
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
BuilderM <| IExpr InstCombine.Op Γ (OpSignature.outTy op) :=
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

def MLIRType.mkTy : MLIRType → BuilderM InstCombine.Ty
  | MLIRType.int Signedness.Signless w => do return InstCombine.Ty.bitvec w
  | _ => throw "Unsupported type"

def TypedSSAVal.mkTy : TypedSSAVal → BuilderM InstCombine.Ty
  | (.SSAVal _, ty) => ty.mkTy

def mkVal (ty : InstCombine.Ty) : Int → Bitvec ty.width
  | val => Bitvec.ofInt ty.width val

def TypedSSAVal.mkVal (Γ : Context) : TypedSSAVal → BuilderM 
  (Σ (ty : InstCombine.Ty), (Γ.Var ty) ⊕ (Γ.snoc ty).Var ty)
| (.SSAVal valStx, tyStx) => do
    let ty ← tyStx.mkTy
    let eitherV ← addGetCtxt Γ valStx ty
    match eitherV with
      | .inl v => return Sigma.mk ty <| .inl v
      | .inr v => return Sigma.mk ty <| .inr v

def TypedSSAVal.mkValPair (Γ : Context) : TypedSSAVal →TypedSSAVal → BuilderM 
  (Σ (ty₁ ty₂ : InstCombine.Ty),
    ((Ctxt.Var Γ ty₁ × Ctxt.Var Γ ty₂) ⊕ 
     (Ctxt.Var (Γ.snoc ty₂) ty₁ × Ctxt.Var (Γ.snoc ty₂) ty₂)) ⊕
    ((Ctxt.Var (Γ.snoc ty₁) ty₁ × Ctxt.Var (Γ.snoc ty₁) ty₂) ⊕ 
     (Ctxt.Var (Γ.snoc ty₁ |>.snoc ty₂) ty₁ × Ctxt.Var (Γ.snoc ty₁ |>.snoc ty₂) ty₂))
  ) 
| (.SSAVal valStx₁, tyStx₁), (.SSAVal valStx₂, tyStx₂) => do
    let ty₁ ← tyStx₁.mkTy
    let ty₂ ← tyStx₂.mkTy
    let eitherV₁ ← addGetCtxt Γ valStx₁ ty₁
    let res  ← match eitherV₁ with
      | .inl v₁ => do
        let eitherV₂ ← addGetCtxt Γ valStx₂ ty₂
        match eitherV₂ with
          | .inl v₂ => 
            pure <| Sum.inl <| Sum.inl (v₁, v₂)
          | .inr v₂ =>  
            let v₁' := Ctxt.Var.toSnoc v₁ (t' := ty₂)
            pure <| Sum.inl <| Sum.inr (v₁', v₂)
      | .inr v₁ => do
        let eitherV₂ ← addGetCtxt (Γ.snoc ty₁) valStx₂ ty₂
        match eitherV₂ with
          | .inl v₂ =>
            pure <| Sum.inr <| Sum.inl (v₁, v₂)
          | .inr v₂ =>  
            let v₁' := Ctxt.Var.toSnoc v₁ (t' := ty₂)
            pure <| Sum.inr <| Sum.inr (v₁', v₂)
    return Sigma.mk ty₁ <| Sigma.mk ty₂ res

def mkExpr (opStx : Op) (Γ : Context) : BuilderM (Σ (Γ' : Context) (ty : InstCombine.Ty), Expr Γ' ty) := do
  match opStx.args with
  | v₁Stx::v₂Stx::[] =>
    let Sigma.mk ty₁ (Sigma.mk ty₂ vSum) ← TypedSSAVal.mkValPair Γ v₁Stx v₂Stx
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
        match vSum with
        | Sum.inl (Sum.inl (v₁, v₂)) =>
            let binOp ← mkBinOp op v₁ (hty ▸ v₂)
            return Sigma.mk Γ <| Sigma.mk ty₁ binOp
        | Sum.inl (Sum.inr (v₁, v₂)) =>
            let binOp ← mkBinOp op v₁ (hty ▸ v₂)
            return Sigma.mk (Γ.snoc ty₂) <| Sigma.mk ty₁ binOp
        | Sum.inr (Sum.inl (v₁, v₂)) =>
            let binOp ← mkBinOp op v₁ (hty ▸ v₂)
            return Sigma.mk (Γ.snoc ty₁) <| Sigma.mk ty₁ binOp
        | Sum.inr (Sum.inr (v₁, v₂)) =>
            let binOp ← mkBinOp op v₁ (hty ▸ v₂)
            return Sigma.mk (Γ.snoc ty₁ |>.snoc ty₂) <| Sigma.mk ty₁ binOp
      else throw s!"mismatched types {ty₁} ≠ {ty₂} in binary op"
  | vStx::[] =>
    let Sigma.mk ty vSum ← vStx.mkVal Γ
    let op ← match opStx.name with
        | "llvm.not" =>
          pure <| InstCombine.Op.not ty.width
        | "llvm.neg" => do
          pure <| InstCombine.Op.neg ty.width
        | _ => throw s!"Unknown (unary) operation syntax {opStx.name}"
     match vSum with
       | Sum.inl v => 
         let unOp ← mkUnaryOp op v
         return Sigma.mk Γ <| Sigma.mk ty (← mkUnaryOp op v)
       | Sum.inr v => 
         return Sigma.mk (Γ.snoc ty) <| Sigma.mk ty (← mkUnaryOp op v)
  | [] => 
    if opStx.name ==  "llvm.mlir.constant" 
    then do
    let some att := opStx.attrs.getAttr "value"
      | throw "tried to resolve constant without 'value' attribute"
    match att with
        | .int val ty => 
            let opTy ← ty.mkTy
              return Sigma.mk Γ <| Sigma.mk opTy <|
                {
                op := InstCombine.Op.const <| mkVal opTy val
                args := HVector.nil
                ty_eq := by simp [OpSignature.outTy]
                }
        | _ => throw "invalid constant attribute"
    else throw s!"invalid (0-ary) expression {opStx.name}"
  | _ => throw s!"unsupported expression (with unsupported arity) {opStx.name}"

def mkReturn (Γ : Context) (opStx : Op) : BuilderM (Σ (Γ' : Context) (ty : InstCombine.Ty), Com Γ' ty) := 
  if opStx.name == "llvm.return"
  then match opStx.args with
  | vStx::[] => do
    let Sigma.mk ty vSum ← vStx.mkVal Γ
    match vSum with
      | Sum.inl v => return Sigma.mk Γ <| Sigma.mk ty (ICom.ret v)
      | Sum.inr v => return Sigma.mk (Γ.snoc ty) <| Sigma.mk ty (ICom.ret v)
  | _ => throw s!"Ill-formed return statement (wrong arity, expected 1, got {opStx.args.length})" 
  else throw s!"Tried to build return out of non-return statement {opStx.name}"

private def mkComHelper (Γ : Context) : List Op → BuilderM (Σ (Γ' : Context) (ty : InstCombine.Ty), Com Γ' ty)
  | [retStx] => mkReturn Γ retStx
  | lete::rest => do
    let Sigma.mk Γ' (Sigma.mk ty₁ e) ← mkExpr lete Γ
    let Sigma.mk Γ'' (Sigma.mk ty₂ r) ← mkComHelper Γ' rest
    return Sigma.mk Γ'' <| Sigma.mk ty₂ <| ICom.lete e r
  | [] => throw "Ill-formed (empty) block"

private partial def argsToCtxt (Γ : Context) : List ((ty : InstCombine.Ty) × Ctxt.Var Γ ty) → Context
  | [] => Γ
  | (Sigma.mk ty _)::rest => 
    let restChanged := rest.map fun (Sigma.mk ty' v') => Sigma.mk ty' (Ctxt.Var.toSnoc v' (t' := ty))
    argsToCtxt (Γ.snoc ty) restChanged

def mkCom (Γ : Context) (reg : Region) : BuilderM (Σ (Γ' : Context)(ty : InstCombine.Ty) , Com Γ' ty) := 
  match reg.ops with
  | [] => throw "Ill-formed region (empty)"
  | coms => do
    let valList ← reg.args.mapM <| TypedSSAVal.mkVal Γ
    let Γ' := argsToCtxt Γ valList
    let icom ← mkComHelper Γ' coms
    return Sigma.mk Γ' icom

end MLIR.AST
