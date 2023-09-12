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

abbrev BuilderM := StateT (NameMapping × Context) Option

def mkUnaryOp {Γ : Ctxt _} {ty : InstCombine.Ty} (op : InstCombine.Op)
 (e : Ctxt.Var Γ ty) : BuilderM <| IExpr InstCombine.Op Γ ty :=
 match ty with
 | .bitvec w =>
   match op with
   -- Can't use a single arm, Lean won't write the rhs accordingly
    | .neg w' => if h : w = w' 
      then some { op := .neg w'
                  ty_eq := by simp [OpSignature.outTy, h]
                  args := .cons (h ▸ e) .nil }
      else none
    | .not w' => if h : w = w' 
      then some { op := .not w'
                  ty_eq := by simp [OpSignature.outTy, h]
                  args := .cons (h ▸ e) .nil }
      else none
    | .copy w' => if h : w = w' 
      then some { op := .copy w'
                  ty_eq := by simp [OpSignature.outTy, h]
                  args := .cons (h ▸ e) .nil }
      else none
    | _ => none

def mkBinOp {Γ : Ctxt _} {ty : InstCombine.Ty} (op : InstCombine.Op)
 (e₁ e₂ : Ctxt.Var Γ ty) : BuilderM <| IExpr InstCombine.Op Γ ty :=
 match ty with
 | .bitvec w =>
   match op with
   -- Can't use a single arm, Lean won't write the rhs accordingly
    | .add w' => if h : w = w' 
      then some { op := .add w'
                  ty_eq := by simp [OpSignature.outTy, h]
                  args := .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil }
      else none
    | .and w' => if h : w = w' 
      then some { op := .and w'
                  ty_eq := by simp [OpSignature.outTy, h]
                  args := .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil }
      else none
    | .or w' => if h : w = w' 
      then some { op := .or w'
                  ty_eq := by simp [OpSignature.outTy, h]
                  args := .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil }
      else none
    | .xor w' => if h : w = w' 
      then some { op := .xor w'
                  ty_eq := by simp [OpSignature.outTy, h]
                  args := .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil }
      else none
    | .shl w' => if h : w = w' 
      then some { op := .shl w'
                  ty_eq := by simp [OpSignature.outTy, h]
                  args := .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil }
      else none
    | .lshr w' => if h : w = w' 
      then some { op := .lshr w'
                  ty_eq := by simp [OpSignature.outTy, h]
                  args := .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil }
      else none
    | .ashr w' => if h : w = w' 
      then some { op := .ashr w'
                  ty_eq := by simp [OpSignature.outTy, h]
                  args := .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil }
      else none
     | .urem w' => if h : w = w' 
      then some { op := .urem w'
                  ty_eq := by simp [OpSignature.outTy, h]
                  args := .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil }
      else none
     | .srem w' => if h : w = w' 
      then some { op := .srem w'
                  ty_eq := by simp [OpSignature.outTy, h]
                  args := .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil }
      else none
     | .mul w' => if h : w = w' 
      then some { op := .mul w'
                  ty_eq := by simp [OpSignature.outTy, h]
                  args := .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil }
      else none
      | .sub w' => if h : w = w'
      then some { op := .sub w'
                  ty_eq := by simp [OpSignature.outTy, h]
                  args := .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil }
      else none
      | .sdiv w' => if h : w = w'
      then some { op := .sdiv w'
                  ty_eq := by simp [OpSignature.outTy, h]
                  args := .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil }
      else none
      | .udiv w' => if  h : w = w'
      then some { op := .udiv w'
                  ty_eq := by simp [OpSignature.outTy, h]
                  args := .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil }
      else none
    | _ => none

def mkIcmp {Γ : Ctxt _} {ty : InstCombine.Ty} (op : InstCombine.Op)
 (e₁ e₂ : Ctxt.Var Γ ty) : BuilderM <| IExpr InstCombine.Op Γ (.bitvec 1) :=
 match ty with
 | .bitvec w =>
   match op with
      | .icmp p w' => if  h : w = w'
      then some { op := .icmp p w'
                  ty_eq := by simp [OpSignature.outTy, h]
                  args := .cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil }
      else none
      | _ => none

def mkSelect {Γ : Ctxt _} {ty : InstCombine.Ty} (op : InstCombine.Op)
 (c : Ctxt.Var Γ (.bitvec 1)) (e₁ e₂ : Ctxt.Var Γ ty) : BuilderM <| IExpr InstCombine.Op Γ ty :=
 match ty with
 | .bitvec w =>
   match op with
      | .select w' => if  h : w = w'
      then some { op := .select w'
                  ty_eq := by simp [OpSignature.outTy, h]
                  args := .cons c <|.cons (h ▸ e₁) <| .cons (h ▸ e₂) .nil }
      else none
      | _ => none

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
| .const _ => none

def MLIRType.mkTy : MLIRType → BuilderM InstCombine.Ty
  | MLIRType.int Signedness.Signless w => some <| InstCombine.Ty.bitvec w
  | _ => none

def TypedSSAVal.mkTy : TypedSSAVal → BuilderM InstCombine.Ty
  | (.SSAVal _, ty) => ty.mkTy

def mkVal (ty : InstCombine.Ty) : Int → Bitvec ty.width
  | val => Bitvec.ofInt ty.width val

-- [(SSAVal.SSAVal (EDSL.IntToString 2), MLIRType.int Signedness.Signless 32),
--                    (SSAVal.SSAVal (EDSL.IntToString 0), MLIRType.int Signedness.Signless 32)]

def TypedSSAVal.mkVal (Γ : Context) : TypedSSAVal → BuilderM (Σ ty : InstCombine.Ty, Ctxt.Var Γ ty)
| (.SSAVal valStx, tyStx) => do
    let ty ← tyStx.mkTy
    let valNat ← String.toNat? valStx
    if h : Γ.get? valNat = some ty 
      then return Sigma.mk ty { val := valNat, property := h}
      else none

def mkExpr (Γ : Context) (opStx : Op) : BuilderM (Σ ty : InstCombine.Ty, Expr Γ ty) := do
  match opStx.args with
  | v₁Stx::v₂Stx::[] =>
    let Sigma.mk ty₁ v₁ ← v₁Stx.mkVal Γ
    let Sigma.mk ty₂ v₂ ← v₂Stx.mkVal Γ
    if hty : ty₁ = ty₂ then 
      let op ← match opStx.name with
        | "llvm.and" => some <| InstCombine.Op.and ty₁.width
        | "llvm.or" => some <| InstCombine.Op.or ty₁.width
        | "llvm.xor" => some <| InstCombine.Op.xor ty₁.width
        | "llvm.shl" => some <| InstCombine.Op.shl ty₁.width
        | "llvm.lshr" => some <| InstCombine.Op.lshr ty₁.width
        | "llvm.ashr" => some <| InstCombine.Op.ashr ty₁.width
        | "llvm.urem" => some <| InstCombine.Op.urem ty₁.width
        | "llvm.srem" => some <| InstCombine.Op.srem ty₁.width
        | "llvm.select" => some <| InstCombine.Op.select ty₁.width
        | "llvm.add" => some <| InstCombine.Op.add ty₁.width
        | "llvm.mul" => some <| InstCombine.Op.mul ty₁.width
        | "llvm.sub" => some <| InstCombine.Op.sub ty₁.width
        | "llvm.sdiv" => some <| InstCombine.Op.sdiv ty₁.width
        | "llvm.udiv" => some <| InstCombine.Op.udiv ty₁.width
        | _ => panic! "Unsuported operation or invalid arguments"
      let binOp ← mkBinOp op v₁ (hty ▸ v₂)
      return Sigma.mk ty₁ binOp
    else none
         --| "llvm.icmp" => return InstCombine.Op.icmp v₁.width
  | vStx::[] =>
    let Sigma.mk ty v ← vStx.mkVal Γ
    match opStx.name with
        | "llvm.not" => do
          let op ← mkUnaryOp (InstCombine.Op.not ty.width) v
          return Sigma.mk ty op
        | "llvm.neg" => do
          let op ← mkUnaryOp (InstCombine.Op.neg ty.width) v
          return Sigma.mk ty op
        | _ => none
  | [] => 
    if opStx.name ==  "llvm.mlir.constant" 
    then do
    let att ← opStx.attrs.getAttr "value"
    match att with
        | .int val ty => 
            let opTy ← ty.mkTy
              return Sigma.mk opTy <|
                {
                op := InstCombine.Op.const <| mkVal opTy val
                args := HVector.nil
                ty_eq := by simp [OpSignature.outTy]
                }
        | _ => none
    else none
  | _ => none

def mkReturn (Γ : Context) (opStx : Op) : BuilderM (Σ ty : InstCombine.Ty, Com Γ ty) := 
  if opStx.name == "llvm.return"
  then match opStx.args with
  | vStx::[] => do
    let Sigma.mk ty v ← vStx.mkVal Γ
    return Sigma.mk ty (ICom.ret v)
  | _ => none 
  else none

--private
def mkComHelper (Γ : Context) : List Op → BuilderM (Σ ty : InstCombine.Ty, Com Γ ty)
  | [retStx] => mkReturn Γ retStx
  | lete::rest => do
    let Sigma.mk ty₁ e ← mkExpr Γ lete
    let Sigma.mk ty₂ r ← mkComHelper (Γ.snoc ty₁) rest
    return Sigma.mk ty₂ <| ICom.lete e r
  | _ => none

private partial def argsToCtxt (Γ : Context) : List ((ty : InstCombine.Ty) × Ctxt.Var Γ ty) → Context
  | [] => Γ
  | (Sigma.mk ty _)::rest => 
    let restChanged := rest.map fun (Sigma.mk ty' v') => Sigma.mk ty' (Ctxt.Var.toSnoc v' (t' := ty))
    argsToCtxt (Γ.snoc ty) restChanged

def mkCom (Γ : Context) (reg : Region) : BuilderM (Σ (Γ' : Context)(ty : InstCombine.Ty) , Com Γ' ty) := 
  match reg.ops with
  | [] => none
  | coms => do
    let valList ← reg.args.mapM <| TypedSSAVal.mkVal Γ
    let Γ' := argsToCtxt Γ valList
    let icom ← mkComHelper Γ' coms
    return Sigma.mk Γ' icom

end MLIR.AST
