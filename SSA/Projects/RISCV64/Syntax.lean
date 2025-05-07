import SSA.Core.MLIRSyntax.EDSL
import SSA.Projects.RISCV64.Base

open MLIR AST Ctxt
open RISCV64

namespace RISCVExpr
/-!
Defining functions to simplify Expression making for some of the RISC-V operations.
This helps in comparing output with expected ouput and
avoids writting huge `Expr`.

-/
def add {Γ : Ctxt _} (e₁ e₂: Ctxt.Var Γ .bv) : Expr RV64 Γ .pure .bv  :=
  Expr.mk
    (op := Op.add)
    (eff_le := by constructor)
    (ty_eq := rfl)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := HVector.nil)

def sub {Γ : Ctxt _} (e₁ e₂: Ctxt.Var Γ .bv) : Expr RV64 Γ .pure .bv  :=
  Expr.mk
    (op := Op.sub)
    (eff_le := by constructor)
    (ty_eq := rfl)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := HVector.nil)

def and {Γ : Ctxt _} (e₁ e₂: Ctxt.Var Γ .bv) : Expr RV64 Γ .pure .bv  :=
  Expr.mk
    (op := Op.and)
    (eff_le := by constructor)
    (ty_eq := rfl)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := HVector.nil)

def or {Γ : Ctxt _} (e₁ e₂: Ctxt.Var Γ .bv) : Expr RV64 Γ .pure .bv  :=
  Expr.mk
    (op := Op.or)
    (eff_le := by constructor)
    (ty_eq := by rfl)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := HVector.nil)

def xor  {Γ : Ctxt _} (e₁ e₂: Ctxt.Var Γ .bv) : Expr RV64 Γ .pure .bv  :=
  Expr.mk
    (op := Op.xor)
    (eff_le := by constructor)
    (ty_eq := by rfl)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := HVector.nil)

def sll  {Γ : Ctxt _} (e₁ e₂: Ctxt.Var Γ .bv) : Expr RV64 Γ .pure .bv  :=
  Expr.mk
    (op := Op.sll)
    (eff_le := by constructor)
    (ty_eq := by rfl)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := HVector.nil)

def sra  {Γ : Ctxt _} (e₁ e₂: Ctxt.Var Γ .bv) : Expr RV64 Γ .pure .bv  :=
  Expr.mk
    (op := Op.sll)
    (eff_le := by constructor)
    (ty_eq := by rfl)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := HVector.nil)

def mul {Γ : Ctxt _} (e₁ e₂: Ctxt.Var Γ .bv) : Expr RV64 Γ .pure .bv  :=
  Expr.mk
    (op := Op.mul)
    (eff_le := by constructor)
    (ty_eq := by rfl)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := HVector.nil)

def div {Γ : Ctxt _} (e₁ e₂: Ctxt.Var Γ .bv) : Expr RV64 Γ .pure .bv  :=
  Expr.mk
    (op := Op.div)
    (eff_le := by constructor)
    (ty_eq := by rfl)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := HVector.nil)

def divu {Γ : Ctxt _} (e₁ e₂: Ctxt.Var Γ .bv) : Expr RV64 Γ .pure .bv  :=
  Expr.mk
    (op := Op.divu)
    (eff_le := by constructor)
    (ty_eq := by rfl)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := HVector.nil)

def remu {Γ : Ctxt _} (e₁ e₂: Ctxt.Var Γ .bv) : Expr RV64 Γ .pure .bv  :=
  Expr.mk
    (op := Op.remu)
    (eff_le := by constructor)
    (ty_eq := by rfl)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := HVector.nil)

def rem {Γ : Ctxt _} (e₁ e₂: Ctxt.Var Γ .bv) : Expr RV64 Γ .pure .bv  :=
  Expr.mk
    (op := Op.rem)
    (eff_le := by constructor)
    (ty_eq := by rfl)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := HVector.nil)

end RISCVExpr

namespace RiscvMkExpr
-- string representation of MLIR type into corresponding RISCV type
def mkTy : MLIR.AST.MLIRType φ → MLIR.AST.ExceptM RV64 RV64.Ty
  | MLIR.AST.MLIRType.undefined s => do
    match s with
    | "i64" => return .bv
    | _ => throw .unsupportedType
  | _ => throw .unsupportedType

instance instTransformTy : MLIR.AST.TransformTy RV64 0 where
  mkTy := mkTy

def mkExpr (Γ : Ctxt _) (opStx : MLIR.AST.Op 0) :
  MLIR.AST.ReaderM (RV64) (Σ eff ty, Expr (RV64) Γ eff ty) := do
    match opStx.args with
    | []  => do
        match opStx.name with
        | "li" => do
            let some att := opStx.attrs.getAttr "imm"
              | throw <| .unsupportedOp s!"no attribute in li, need to specify immediate {repr opStx}"
            match att with
              | .int val ty =>
                let opTy@(.bv) ← mkTy ty
                return ⟨.pure, opTy, ⟨
                  .li (val),
                  by
                  simp[DialectSignature.outTy, signature]
                ,
                  by constructor,
                  .nil,
                  .nil
                ⟩⟩
              | _ => throw <| .unsupportedOp s!"unsupported attribute in li while parsing {repr opStx}"
        | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
    | v₁Stx::[] =>
       let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
        match ty₁, opStx.name with
        | .bv, "srai" => do
          let some att := opStx.attrs.getAttr "shamt"
             | throw <| .unsupportedOp s!"no attribute in srai {repr opStx}"
          match att with
          | .int val ty =>
            let opTy@(.bv) ← mkTy ty
            return ⟨.pure, opTy, ⟨
              .srai (BitVec.ofInt 6 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
              .nil
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "bclri" => do
          let some att := opStx.attrs.getAttr "imm"
            | throw <| .unsupportedOp s!"no attribute in bclri {repr opStx}"
          match att with
          | .int val ty =>
            let opTy@(.bv) ← mkTy ty
            return ⟨.pure, opTy, ⟨
              .bclri (BitVec.ofInt 6 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
              .nil
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "bexti" => do
          let some att := opStx.attrs.getAttr "imm"
            | throw <| .unsupportedOp s!"no attribute in bexti {repr opStx}"
          match att with
          | .int val ty =>
            let opTy@(.bv) ← mkTy ty
            return ⟨.pure, opTy, ⟨
              .bexti (BitVec.ofInt 6 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
              .nil
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "bseti" => do
          let some att := opStx.attrs.getAttr "imm"
            | throw <| .unsupportedOp s!"no attribute in bseti {repr opStx}"
          match att with
          | .int val ty =>
            let opTy@(.bv) ← mkTy ty
            return ⟨.pure, opTy, ⟨
              .bseti (BitVec.ofInt 6 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
              .nil
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "binvi" => do
          let some att := opStx.attrs.getAttr "imm"
            | throw <| .unsupportedOp s!"no attribute in binvi {repr opStx}"
          match att with
          | .int val ty =>
            let opTy@(.bv) ← mkTy ty
            return ⟨.pure, opTy, ⟨
              .binvi (BitVec.ofInt 6 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
              .nil
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "addiw" => do
          let some att := opStx.attrs.getAttr "imm"
            | throw <| .unsupportedOp s!"no attribute in addiw {repr opStx}"
          match att with
          | .int val ty =>
            let opTy@(.bv) ← mkTy ty
            return ⟨.pure, opTy, ⟨
              .addiw (BitVec.ofInt 12 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
              .nil
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "lui" => do
          let some att := opStx.attrs.getAttr "imm"
            | throw <| .unsupportedOp s!"no attribute in lui {repr opStx}"
          match att with
          | .int val ty =>
            let opTy@(.bv) ← mkTy ty
            return ⟨.pure, opTy, ⟨
              .lui (BitVec.ofInt 20 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
              .nil
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "auipc" => do
          let some att := opStx.attrs.getAttr "imm"
            | throw <| .unsupportedOp s!"no attribute in auipc {repr opStx}"
          match att with
          | .int val ty =>
            let opTy@(.bv) ← mkTy ty
            return ⟨.pure, opTy, ⟨
              .auipc (BitVec.ofInt 20 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
              .nil
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "slliw" => do
          let some att := opStx.attrs.getAttr "shamt"
            | throw <| .unsupportedOp s!"no attribute in slliw {repr opStx}"
          match att with
          | .int val ty =>
            let opTy@(.bv) ← mkTy ty
            return ⟨.pure, opTy, ⟨
              .slliw (BitVec.ofInt 5 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
              .nil
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "srliw" => do
          let some att := opStx.attrs.getAttr "shamt"
            | throw <| .unsupportedOp s!"no attribute in srliw {repr opStx}"
          match att with
          | .int val ty =>
            let opTy@(.bv) ← mkTy ty
            return ⟨.pure, opTy, ⟨
              .srliw (BitVec.ofInt 5 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
              .nil
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "sraiw" => do
          let some att := opStx.attrs.getAttr "shamt"
            | throw <| .unsupportedOp s!"no attribute in sraiw {repr opStx}"
          match att with
          | .int val ty =>
            let opTy@(.bv) ← mkTy ty
            return ⟨.pure, opTy, ⟨
              .sraiw (BitVec.ofInt 5 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
              .nil
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "slli" => do
          let some att := opStx.attrs.getAttr "shamt"
            | throw <| .unsupportedOp s!"no attribute in slli{repr opStx}"
          match att with
          | .int val ty =>
            let opTy@(.bv) ← mkTy ty
            return ⟨.pure, opTy, ⟨
              .slli (BitVec.ofInt 6 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
              .nil
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "srli" => do
          let some att := opStx.attrs.getAttr "shamt"
            | throw <| .unsupportedOp s!"no attribute in srli {repr opStx}"
          match att with
          | .int val ty =>
            let opTy@(.bv) ← mkTy ty
            return ⟨.pure, opTy, ⟨
              .srli (BitVec.ofInt 6 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
              .nil
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "addi" => do
          let some att := opStx.attrs.getAttr "imm"
            | throw <| .unsupportedOp s!"no attribute in addi {repr opStx}"
          match att with
          | .int val ty =>
            let opTy@(.bv) ← mkTy ty
            return ⟨.pure, opTy, ⟨
              .addi (BitVec.ofInt 12 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
              .nil
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "slti" => do
          let some att := opStx.attrs.getAttr "imm"
            | throw <| .unsupportedOp s!"no attribute in slti {repr opStx}"
          match att with
          | .int val ty =>
            let opTy@(.bv) ← mkTy ty
            return ⟨.pure, opTy, ⟨
              .slti (BitVec.ofInt 12 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
              .nil
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "sltiu" => do
          let some att := opStx.attrs.getAttr "imm"
            | throw <| .unsupportedOp s!"no attribute in sltiu {repr opStx}"
          match att with
          | .int val ty =>
            let opTy@(.bv) ← mkTy ty
            return ⟨.pure, opTy, ⟨
              .sltiu (BitVec.ofInt 12 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
              .nil
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "andi" => do
          let some att := opStx.attrs.getAttr "imm"
            | throw <| .unsupportedOp s!"no attribute in andi {repr opStx}"
          match att with
          | .int val ty =>
            let opTy@(.bv) ← mkTy ty
            return ⟨.pure, opTy, ⟨
              .andi (BitVec.ofInt 12 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
              .nil
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "ori" => do
          let some att := opStx.attrs.getAttr "imm"
            | throw <| .unsupportedOp s!"no attribute in ori {repr opStx}"
          match att with
          | .int val ty =>
            let opTy@(.bv) ← mkTy ty
            return ⟨.pure, opTy, ⟨
              .ori (BitVec.ofInt 12 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
              .nil
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "xori" => do
          let some att := opStx.attrs.getAttr "imm"
            | throw <| .unsupportedOp s!"no attribute in xori {repr opStx}"
          match att with
          | .int val ty =>
            let opTy@(.bv) ← mkTy ty
            return ⟨.pure, opTy, ⟨
              .xori (BitVec.ofInt 12 val),
              by
              simp[DialectSignature.outTy, signature]
             ,
              by constructor,
              .cons v₁ <| .nil,
              .nil
            ⟩⟩
          | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
        | .bv, "sext.b" =>
            return ⟨ .pure, .bv ,⟨ .sext.b, by rfl, by constructor,
               .cons v₁ <| .nil,
                .nil⟩⟩
        | .bv, "sext.h" =>
            return ⟨ .pure, .bv ,⟨ .sext.h, by rfl, by constructor,
               .cons v₁ <| .nil,
                .nil⟩⟩
        | .bv, "zext.h" =>
            return ⟨ .pure, .bv ,⟨ .zext.h, by rfl, by constructor,
               .cons v₁ <| .nil,
                .nil⟩⟩
        |_ , _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
    | v₁Stx::v₂Stx:: [] =>
        let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
        let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
        match ty₁, ty₂, opStx.name with
        | .bv, .bv, "rem" =>
          return ⟨.pure, .bv ,⟨ .rem, by rfl ,by constructor,
             .cons v₁ <| .cons v₂ <| .nil,
              .nil ⟩⟩
        | .bv, .bv, "ror" =>
          return ⟨.pure, .bv ,⟨ .ror, by rfl ,by constructor,
             .cons v₁ <| .cons v₂ <| .nil,
              .nil ⟩⟩
        | .bv, .bv, "rol" =>
          return ⟨.pure, .bv ,⟨ .rol, by rfl ,by constructor,
             .cons v₁ <| .cons v₂ <| .nil,
              .nil ⟩⟩
        | .bv, .bv, "remu" =>
          return ⟨.pure, .bv ,⟨ .remu, by rfl ,by constructor,
             .cons v₁ <| .cons v₂ <| .nil,
              .nil ⟩⟩
        | .bv, .bv, "sra" =>
          return ⟨.pure, .bv ,⟨ .sra, by rfl ,by constructor,
             .cons v₁ <| .cons v₂ <| .nil,
              .nil ⟩⟩
        | .bv, .bv, "addw" =>
          return ⟨.pure, .bv ,⟨ .addw, by rfl ,by constructor,
             .cons v₁ <| .cons v₂ <| .nil,
              .nil ⟩⟩
        | .bv , .bv , "subw" =>
              return ⟨ .pure, .bv ,⟨ .subw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "sllw" =>
              return ⟨ .pure, .bv ,⟨ .sllw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "srlw" =>
              return ⟨ .pure, .bv ,⟨ .srlw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "sraw" =>
              return ⟨ .pure, .bv ,⟨ .sraw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "add" =>
              return ⟨ .pure, .bv ,⟨ .add, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "or" =>
              return ⟨ .pure, .bv ,⟨ .or, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "xor" =>
              return ⟨ .pure, .bv ,⟨ .xor, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "sll" =>
              return ⟨ .pure, .bv ,⟨ .sll, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "srl" =>
              return ⟨ .pure, .bv ,⟨ .srl, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "sub" =>
              return ⟨ .pure, .bv ,⟨ .sub, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "slt" =>
              return ⟨ .pure, .bv ,⟨ .slt, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "sltu" =>
              return ⟨ .pure, .bv ,⟨ .sltu, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "and" =>
              return ⟨ .pure, .bv ,⟨ .and, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "czero.eqz" =>
              return ⟨ .pure, .bv ,⟨ .czero.eqz, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "czero.nez" =>
              return ⟨ .pure, .bv ,⟨ .czero.nez, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "bclr" =>
              return ⟨ .pure, .bv ,⟨ .bclr, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "bext" =>
              return ⟨ .pure, .bv ,⟨ .bext, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "binv" =>
              return ⟨ .pure, .bv ,⟨ .binv, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "bset" =>
              return ⟨ .pure, .bv ,⟨ .bset, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "rolw" =>
              return ⟨ .pure, .bv ,⟨ .rolw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "rorw" =>
              return ⟨ .pure, .bv ,⟨ .rorw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "mul" =>
            return ⟨ .pure, .bv ,⟨ .mul, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "mulu" =>
            return ⟨ .pure, .bv ,⟨ .mulu, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "mulh" =>
            return ⟨ .pure, .bv ,⟨ .mulh, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "mulhu" =>
            return ⟨ .pure, .bv ,⟨ .mulhu, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "mulhsu" =>
            return ⟨ .pure, .bv ,⟨ .mulhsu, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv , .bv , "mulw" => do
          return ⟨ .pure, .bv ,⟨ .mulw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv, .bv, "divw" =>
          return ⟨ .pure, .bv ,⟨ .divw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv, .bv, "divwu" =>
            return ⟨ .pure, .bv ,⟨ .divwu, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv, .bv, "div" =>
            return ⟨ .pure, .bv ,⟨ .div, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv, .bv, "divu" =>
            return ⟨ .pure, .bv ,⟨ .divu, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv, .bv, "remw" =>
            return ⟨ .pure, .bv ,⟨ .remw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv, .bv, "remwu" =>
            return ⟨ .pure, .bv ,⟨ .remwu, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv, .bv, "add.uw" =>
            return ⟨ .pure, .bv ,⟨ .add.uw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv, .bv, "sh1add.uw" =>
            return ⟨ .pure, .bv ,⟨ .sh1add.uw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv, .bv, "sh2add.uw" =>
            return ⟨ .pure, .bv ,⟨ .sh2add.uw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv, .bv, "sh3add.uw" =>
            return ⟨ .pure, .bv ,⟨ .sh3add.uw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv, .bv, "sh1add" =>
            return ⟨ .pure, .bv ,⟨ .sh1add, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv, .bv, "sh2add" =>
            return ⟨ .pure, .bv ,⟨ .sh2add, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | .bv, .bv, "sh3add" =>
            return ⟨ .pure, .bv ,⟨ .sh3add, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
        | _, _ , _ => throw <| .unsupportedOp s!"type mismatch  for 2 reg operation  {repr opStx}"
    | _ => throw <| .unsupportedOp s!"wrong number of arguments, more than 2 arguemnts  {repr opStx}"

instance : MLIR.AST.TransformExpr (RV64) 0 where
  mkExpr := mkExpr

def mkReturn (Γ : Ctxt _) (opStx : MLIR.AST.Op 0) : MLIR.AST.ReaderM (RV64)
    (Σ eff ty, Com RV64 Γ eff ty) :=
  if opStx.name == "ret"
  then match opStx.args with
  | vStx::[] => do
    let ⟨ty, v⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ vStx
    return ⟨.pure, ty, Com.ret v⟩
  | _ => throw <| .generic s!"Ill-formed return statement (wrong arity, expected 1, got {opStx.args.length})"
  else throw <| .generic s!"Tried to build return out of non-return statement {opStx.name}"

instance : MLIR.AST.TransformReturn (RV64) 0 where
  mkReturn := mkReturn

open Qq MLIR AST Lean Elab Term Meta in
elab "[RV64_com| " reg:mlir_region "]" : term => do
  SSA.elabIntoCom reg q(RV64)
end RiscvMkExpr
