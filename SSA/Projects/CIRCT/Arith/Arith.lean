import SSA.Core.MLIRSyntax.EDSL


namespace Arith

-- arith supports comparisons among ints, vects, tensors
-- we should eventually add new defs for heterogeneous (in)equalities and
-- potentially a new type to do so. as a first step, I am only focusing on ints.


def const (v : Int) : Int :=
  v

/-
    equal (mnemonic: "eq"; integer value: 0)
    not equal (mnemonic: "ne"; integer value: 1)
    signed less than (mnemonic: "slt"; integer value: 2)
    signed less than or equal (mnemonic: "sle"; integer value: 3)
    signed greater than (mnemonic: "sgt"; integer value: 4)
    signed greater than or equal (mnemonic: "sge"; integer value: 5)
    unsigned less than (mnemonic: "ult"; integer value: 6)
    unsigned less than or equal (mnemonic: "ule"; integer value: 7)
    unsigned greater than (mnemonic: "ugt"; integer value: 8)
    unsigned greater than or equal (mnemonic: "uge"; integer value: 9)
-/
def cmpi (x y op : Int) : Bool :=
  match op with
  | 0 => x == y
  | 1 => x != y
  | 2 => x < y
  | 3 => x ≤ y
  | 4 => x > y
  | 5 => x ≥ y
  | 6 => x < y
  | 7 => x ≤ y
  | 8 => x > y
  | 9 => x ≥ y
  | _ => false -- unsure this is the best default case. may be better to raise an error.


-- model poison as 'none' (seems the way to go, afaiu from lean-mlir paper)
def select (cond : Option Bool) (x y : Int) : Option Int :=
  match cond with
  | none => none
  | some true => x
  | some false => y

end Arith

namespace MLIR2Arith

section Dialect

inductive Ty
  | int : Ty
  | float : Ty
  | bool : Ty
deriving Inhabited, DecidableEq, Repr

inductive Op
  | const
  | cmpi
  | select
deriving Inhabited, DecidableEq, Repr

instance : TyDenote Ty where
  toType := fun
  | Ty.int => Int
  | Ty.bool => Bool
  | Ty.float => Float

abbrev Arith : Dialect where
  Op := Op
  Ty := Ty

open TyDenote (toType)

-- arg type CONF
@[simp, reducible]
def Op.sig : Op → List Ty
  | .const => [Ty.int]
  | .cmpi =>  [Ty.int, Ty.int, Ty.bool]
  | .select => [Ty.bool, Ty.int, Ty.int]
  -- select should digest any α (int, vect, tensor),
  -- luisa would like to create a new type for these three and define all the (in)eqs
  -- same for the option bool argument (type denotation fails bc. it's not atomic, unclear how to solve that)

-- return type CONF
@[simp, reducible]
def Op.outTy : Op → Ty
  | .const => Ty.int
  | .cmpi => Ty.bool
  | .select => Ty.int

@[simp, reducible]
def Op.signature : Op → Signature (Ty) :=
  fun o => {sig := Op.sig o, outTy := Op.outTy o, regSig := []}

instance : DialectSignature Arith := ⟨Op.signature⟩

@[simp]
instance : DialectDenote (Arith) where
  denote
  | .const, arg, _ => Arith.const (arg.getN 0 (by simp [DialectSignature.sig, signature]))
  | .select, arg, _ => Arith.select (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature])) (arg.getN 2 (by simp [DialectSignature.sig, signature]))
  | .cmpi, arg, _ => Arith.cmpi (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))

-- @[simp]
-- instance : DialectDenote (DC) where
--     denote
--     | .fst, arg, _ => (arg.getN 0 (by simp [DialectSignature.sig, signature])).fst
--     | .snd, arg, _ => (arg.getN 0 (by simp [DialectSignature.sig, signature])).snd
--     | .fstVal _, arg, _ => (arg.getN 0 (by simp [DialectSignature.sig, signature])).fst
--     | .sndVal _, arg, _ => (arg.getN 0 (by simp [DialectSignature.sig, signature]) ).snd
--     | .pair _, arg, _ => (arg.getN 0 (by simp [DialectSignature.sig, signature]), arg.getN 1 (by simp [DialectSignature.sig, signature]))
--     | .unpack _, arg, _ => CIRCTStream.DC.unpack (arg.getN 0 (by simp [DialectSignature.sig, signature]))
--     | .pack _, arg, _  => CIRCTStream.DC.pack (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
--     | .branch, arg, _  => CIRCTStream.DC.branch (arg.getN 0 (by simp [DialectSignature.sig, signature]))
--     | .fork, arg, _  => CIRCTStream.DC.fork (arg.getN 0 (by simp [DialectSignature.sig, signature]))
--     | .join, arg, _  => CIRCTStream.DC.join (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
--     | .merge, arg, _  => CIRCTStream.DC.merge (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature]))
--     | .select, arg, _  => CIRCTStream.DC.select (arg.getN 0 (by simp [DialectSignature.sig, signature])) (arg.getN 1 (by simp [DialectSignature.sig, signature])) (arg.getN 2 (by simp [DialectSignature.sig, signature]))
--     | .sink, arg, _  => CIRCTStream.DC.sink (arg.getN 0 (by simp [DialectSignature.sig, signature]))
--     | .source, _, _  => CIRCTStream.DC.source

end Dialect



-- def mkTy2 : String → MLIR.AST.ExceptM (DC) Ty2
--   | "Int" => return (.int)
--   | "Bool" => return (.bool)
--   | _ => throw .unsupportedType

-- def mkTy : MLIR.AST.MLIRType φ → MLIR.AST.ExceptM DC DC.Ty
--   | MLIR.AST.MLIRType.undefined s => do
--     match s.splitOn "_" with
--     | ["TokenStream"] =>
--       return .tokenstream
--     | ["TokenStream2"] =>
--       return .tokenstream2
--     | ["ValueStream", r] =>
--       return .valuestream (← mkTy2 r)
--     | ["ValueStream2", r] =>
--       return .valuestream2 (← mkTy2 r)
--     | ["ValueTokenStream", r] =>
--       return .valuetokenstream (← mkTy2 r)
--     | _ => throw .unsupportedType
--   | _ => throw .unsupportedType

-- instance instTransformTy : MLIR.AST.TransformTy DC 0 where
--   mkTy := mkTy

-- def source : Expr (DC) Γ .pure (.tokenstream) :=
--   Expr.mk
--     (op := .source)
--     (ty_eq := rfl)
--     (eff_le := by constructor)
--     (args := .nil)
--     (regArgs := .nil)

-- def sink {Γ : Ctxt _} (a : Γ.Var (.tokenstream)) : Expr (DC) Γ .pure (.tokenstream) :=
--   Expr.mk
--     (op := .sink)
--     (ty_eq := rfl)
--     (eff_le := by constructor)
--     (args := .cons a <| .nil)
--     (regArgs := .nil)

-- def unpack {r} {Γ : Ctxt _} (a : Γ.Var (.valuestream r)) : Expr (DC) Γ .pure (.valuetokenstream r) :=
--   Expr.mk
--     (op := .unpack r)
--     (ty_eq := rfl)
--     (eff_le := by constructor)
--     (args := .cons a <| .nil)
--     (regArgs := .nil)

-- def pack {r} {Γ : Ctxt _} (a : Γ.Var (.valuestream r)) (b : Γ.Var (.tokenstream)) : Expr (DC) Γ .pure (.valuestream r) :=
--   Expr.mk
--     (op := .pack r)
--     (ty_eq := rfl)
--     (eff_le := by constructor)
--     (args := .cons a <| .cons b <| .nil)
--     (regArgs := .nil)

-- def branch {Γ : Ctxt _} (a : Γ.Var (.valuestream .bool)) : Expr (DC) Γ .pure (.tokenstream2) :=
--   Expr.mk
--     (op := .branch)
--     (ty_eq := rfl)
--     (eff_le := by constructor)
--     (args := .cons a <| .nil)
--     (regArgs := .nil)

-- def fork (a : Γ.Var (.tokenstream)) : Expr (DC) Γ .pure (.tokenstream2) :=
--   Expr.mk
--     (op := .fork)
--     (ty_eq := rfl)
--     (eff_le := by constructor)
--     (args := .cons a <| .nil)
--     (regArgs := .nil)

-- def join {Γ : Ctxt _} (a b : Γ.Var (.tokenstream)) : Expr (DC) Γ .pure (.tokenstream) :=
--   Expr.mk
--     (op := .join)
--     (ty_eq := rfl)
--     (eff_le := by constructor)
--     (args := .cons a <| .cons b <| .nil)
--     (regArgs := .nil)

-- def merge {Γ : Ctxt _} (a b : Γ.Var (.tokenstream)) : Expr (DC) Γ .pure (.valuestream .bool) :=
--   Expr.mk
--     (op := .merge)
--     (ty_eq := rfl)
--     (eff_le := by constructor)
--     (args := .cons a <| .cons b <| .nil)
--     (regArgs := .nil)

-- def select {Γ : Ctxt _} (a b : Γ.Var (.tokenstream)) (c : Γ.Var (.valuestream .bool)) : Expr (DC) Γ .pure (.tokenstream) :=
--   Expr.mk
--     (op := .select)
--     (ty_eq := rfl)
--     (eff_le := by constructor)
--     (args := .cons a <| .cons b <| .cons c <| .nil)
--     (regArgs := .nil)

-- def fst {Γ : Ctxt _} (a : Γ.Var (.tokenstream2)) : Expr (DC) Γ .pure (.tokenstream)  :=
--   Expr.mk
--     (op := .fst)
--     (ty_eq := rfl)
--     (eff_le := by constructor)
--     (args := .cons a <| .nil)
--     (regArgs := .nil)

-- def fstVal {r} {Γ : Ctxt _} (a : Γ.Var (.valuetokenstream r))  : Expr (DC) Γ .pure (.valuestream r)  :=
--   Expr.mk
--     (op := .fstVal r)
--     (ty_eq := rfl)
--     (eff_le := by constructor)
--     (args := .cons a <| .nil)
--     (regArgs := .nil)

-- def sndVal {r} {Γ : Ctxt _} (a : Γ.Var (.valuetokenstream r))  : Expr (DC) Γ .pure (.tokenstream)  :=
--   Expr.mk
--     (op := .sndVal r)
--     (ty_eq := rfl)
--     (eff_le := by constructor)
--     (args := .cons a <| .nil)
--     (regArgs := .nil)

-- def snd {Γ : Ctxt _} (a : Γ.Var (.tokenstream2)) : Expr (DC) Γ .pure (.tokenstream)  :=
--   Expr.mk
--     (op := .snd)
--     (ty_eq := rfl)
--     (eff_le := by constructor)
--     (args := .cons a <| .nil)
--     (regArgs := .nil)

-- def pair {r} {Γ : Ctxt _} (a b: Γ.Var (.valuestream r)) : Expr (DC) Γ .pure (.valuestream2 r)  :=
--   Expr.mk
--     (op := .pair r)
--     (ty_eq := rfl)
--     (eff_le := by constructor)
--     (args := .cons a <| .cons b <| .nil)
--     (regArgs := .nil)

-- def mkExpr (Γ : Ctxt _) (opStx : MLIR.AST.Op 0) :
--     MLIR.AST.ReaderM (DC) (Σ eff ty, Expr (DC) Γ eff ty) := do
--   match opStx.name with
--   | op@"DC.source" =>
--     if opStx.args.length > 0 then
--       throw <| .generic s!"expected one operand for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
--     else
--       return ⟨_, .tokenstream, source⟩
--   | op@"DC.sink" | op@"DC.unpack" | op@"DC.fork" | op@"DC.branch" | op@"DC.fst" | op@"DC.snd" | op@"DC.fstVal" | op@"DC.sndVal" =>
--     match opStx.args with
--     | v₁Stx::[] =>
--       let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
--       match ty₁, op with
--       | .tokenstream2, "DC.fst" => return ⟨_, .tokenstream, fst v₁⟩
--       | .tokenstream2, "DC.snd"  => return ⟨_, .tokenstream, snd v₁⟩
--       | .valuetokenstream r, "DC.fstVal" => return ⟨_, .valuestream r, fstVal v₁⟩
--       | .valuetokenstream r, "DC.sndVal"  => return ⟨_, .tokenstream, sndVal v₁⟩
--       | .tokenstream, "DC.sink" => return ⟨_, .tokenstream, sink v₁⟩
--       | .valuestream r, "DC.unpack"  => return ⟨_, .valuetokenstream r, unpack v₁⟩
--       | .tokenstream, "DC.fork"  => return ⟨_, .tokenstream2, fork v₁⟩
--       | .valuestream .bool, "DC.branch"  => return ⟨_, .tokenstream2, branch v₁⟩
--       | _, _ => throw <| .generic s!"type mismatch"
--     | _ => throw <| .generic s!"expected one operand for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
--   | op@"DC.merge" | op@"DC.join" | op@"DC.pack" | op@"DC.pair"  =>
--     match opStx.args with
--     | v₁Stx::v₂Stx::[] =>
--       let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
--       let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
--       match ty₁, ty₂, op with
--       | .tokenstream, .tokenstream, "DC.merge" => return ⟨_, .valuestream .bool, merge v₁ v₂⟩
--       | .valuestream r, .valuestream r', "DC.pair" =>
--         if h: r = r' then return ⟨_, .valuestream2 r, pair v₁ (by subst r ; exact v₂)⟩
--         else throw <| .generic s!"type mismatch"
--       | .tokenstream, .tokenstream, "DC.join"  => return ⟨_, .tokenstream, join v₁ v₂⟩
--       | .valuestream r, .tokenstream, "DC.pack"  => return ⟨_, .valuestream r, pack v₁ v₂⟩
--       | _, _, _ => throw <| .generic s!"type mismatch"
--     | _ => throw <| .generic s!"expected two operands for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
--   | op@"DC.select" =>
--     match opStx.args with
--     | v₁Stx::v₂Stx::v₃Stx::[] =>
--       let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
--       let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
--       let ⟨ty₃, v₃⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₃Stx
--       match ty₁, ty₂, ty₃, op with
--       | .tokenstream, .tokenstream, .valuestream .bool, "DC.select" => return ⟨_, .tokenstream, select v₁ v₂ v₃⟩
--       | _, _, _, _=> throw <| .generic s!"type mismatch"
--     | _ => throw <| .generic s!"expected three operands for `monomial`, found #'{opStx.args.length}' in '{repr opStx.args}'"
--   | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"

-- instance : MLIR.AST.TransformExpr (DC) 0 where
--   mkExpr := mkExpr

-- def mkReturn (Γ : Ctxt _) (opStx : MLIR.AST.Op 0) : MLIR.AST.ReaderM (DC)
--     (Σ eff ty, Com DC Γ eff ty) :=
--   if opStx.name == "return"
--   then match opStx.args with
--   | vStx::[] => do
--     let ⟨ty, v⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ vStx
--     return ⟨.pure, ty, Com.ret v⟩
--   | _ => throw <| .generic s!"Ill-formed return statement (wrong arity, expected 1, got {opStx.args.length})"
--   else throw <| .generic s!"Tried to build return out of non-return statement {opStx.name}"

-- instance : MLIR.AST.TransformReturn (DC) 0 where
--   mkReturn := mkReturn

-- open Qq MLIR AST Lean Elab Term Meta in
-- elab "[DC_com| " reg:mlir_region "]" : term => do
--   SSA.elabIntoCom reg q(DC)

-- end MLIR2DC
