import SSA.Projects.InstCombine.LLVM.Transform

namespace InstCombine

open MLIR
open AST (TypedSSAVal)
open Ctxt (Var)

protected abbrev ExceptM  (φ) := AST.ExceptM (MOp φ)
protected abbrev ReaderM  (φ) := AST.ReaderM (MOp φ)
protected abbrev BuilderM (φ) := AST.BuilderM (MOp φ)

protected abbrev Context  (φ) := List (MTy φ)
protected abbrev Expr     {φ} := IExpr (MOp φ)

open InstCombine (ExceptM ReaderM BuilderM Context Expr)

def mkType : AST.MLIRType φ → ExceptM φ (MTy φ)
  | .int .Signless w  => return .bitvec w
  | _                 => throw .unsupportedType -- "Unsupported type"

def mkUnaryOp {Γ : Context φ} {ty : MTy φ} (op : MOp φ)
  (e : Var Γ ty) : ExceptM φ <| Expr Γ ty :=
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

def mkBinOp {Γ : Context φ} {ty : MTy φ} (op : MOp φ)
    (e₁ e₂ : Var Γ ty) : ExceptM φ <| Expr Γ ty :=
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

def mkIcmp {Γ : Context φ} {ty : MTy φ} (op : MOp φ)
    (e₁ e₂ : Var Γ ty) : ExceptM φ <| Expr Γ (.bitvec 1) :=
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

def mkSelect {Γ : Context φ} {ty : MTy φ} (op : MOp φ)
    (c : Var Γ (.bitvec 1)) (e₁ e₂ : Var Γ ty) :
    ExceptM φ <| Expr Γ ty :=
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

def mkOpExpr {Γ : Context φ} (op : MOp φ) 
    (arg : HVector (fun t => Ctxt.Var Γ t) (OpSignature.sig op)) : 
    ExceptM φ <| Expr Γ (OpSignature.outTy op) :=
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

def mkExpr (Γ : Context φ) (opStx : AST.Op φ) (args : List (Σ (ty : MTy φ), Ctxt.Var Γ ty)) : 
    ReaderM φ (Σ ty, Expr Γ ty) := do
  match args with
  | ⟨.bitvec w₁, v₁⟩::⟨.bitvec w₂, v₂⟩::[] =>
    -- let ty₁ := ty₁.instantiave 
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
      let binOp ← (mkBinOp op v₁ (hty ▸ v₂) : ExceptM ..)
      return ⟨.bitvec w₁, binOp⟩
    else 
      throw <| .widthError w₁ w₂ -- s!"mismatched types {ty₁} ≠ {ty₂} in binary op"
  | ⟨.bitvec w, v⟩::[] =>
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
          let opTy@(MTy.bitvec w) ← mkType ty
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

def mkReturn (Γ : Context φ) (opStx : AST.Op φ) (args : List (Σ (ty : MTy φ), Ctxt.Var Γ ty)) : 
    ReaderM φ (Σ ty, ICom (MOp φ) Γ ty) := 
  if opStx.name == "llvm.return"
  then match args with
  | ⟨ty, v⟩::[] => do
    return ⟨ty, ICom.ret v⟩
  | _ => throw <| .generic s!"Ill-formed return statement (wrong arity, expected 1, got {args.length})" 
  else throw <| .generic s!"Tried to build return out of non-return statement {opStx.name}"



instance : AST.TransformDialect (MOp φ) (MTy φ) φ where
  mkType    := mkType
  mkReturn  := mkReturn
  mkExpr    := mkExpr