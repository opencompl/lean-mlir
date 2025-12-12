import LeanMLIR.MLIRSyntax.EDSL
import SSA.Projects.RISCV64.Base

open MLIR AST Ctxt
open RISCV64

namespace RiscvMkExpr

/-- `mkTy` returns a RISCV type given the string representation of MLIR type -/
def mkTy : MLIR.AST.MLIRType φ → MLIR.AST.ExceptM RV64 RV64.Ty
  | MLIR.AST.MLIRType.undefined "i64" => do return bv64
  | MLIR.AST.MLIRType.undefined "riscv.reg" => do return bv64
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
          | throw <| .generic s!"no attribute in li, need to specify immediate {repr opStx}"
      match att with
      | .int val ty =>
        let opTy@(bv64) ← mkTy ty
                return ⟨.pure, [opTy], ⟨
                  .li (val),
                  rfl,
                  by constructor,
                  .nil,
                  .nil
                ⟩⟩
      | _ => throw <| .generic s!"unsupported attribute in li while parsing {repr opStx}"
    | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
  | v₁Stx::[] =>
     let ⟨ty₁, v₁⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₁Stx
      match ty₁, opStx.name with
      -- parsing pseudo ops
      | bv64, "mv" => do
        return ⟨.pure, [bv64], ⟨
                  .mv,
                  rfl,
                  by constructor,
                   .cons v₁ <| .nil,
                  .nil
                ⟩⟩
      | bv64, "not" => do
        return ⟨.pure, [bv64], ⟨
                  .not,
                  rfl,
                  by constructor,
                   .cons v₁ <| .nil,
                  .nil
                ⟩⟩
      | bv64, "neg" => do
        return ⟨.pure, [bv64], ⟨
                  .neg,
                  rfl,
                  by constructor,
                   .cons v₁ <| .nil,
                  .nil
                ⟩⟩
      | bv64, "negw" => do
        return ⟨.pure, [bv64], ⟨
                  .negw,
                  rfl,
                  by constructor,
                   .cons v₁ <| .nil,
                  .nil
                ⟩⟩
      | bv64, "sext.w" => do
        return ⟨.pure, [bv64], ⟨
                  .sextw,
                  rfl,
                  by constructor,
                   .cons v₁ <| .nil,
                  .nil
                ⟩⟩
      | bv64, "zext.b" => do
        return ⟨.pure, [bv64], ⟨
                  .zextb,
                  rfl,
                  by constructor,
                   .cons v₁ <| .nil,
                  .nil
                ⟩⟩
      | bv64, "zext.w" => do
        return ⟨.pure, [bv64], ⟨
                  .zextw,
                  rfl,
                  by constructor,
                   .cons v₁ <| .nil,
                  .nil
                ⟩⟩
      | bv64, "seqz" => do
        return ⟨.pure, [bv64], ⟨
                  .seqz,
                  rfl,
                  by constructor,
                   .cons v₁ <| .nil,
                  .nil
                ⟩⟩
      | bv64, "snez" => do
        return ⟨.pure, [bv64], ⟨
                  .snez,
                  rfl,
                  by constructor,
                   .cons v₁ <| .nil,
                  .nil
                ⟩⟩
      | bv64, "sltz" => do
        return ⟨.pure, [bv64], ⟨
                  .sltz,
                  rfl,
                  by constructor,
                   .cons v₁ <| .nil,
                  .nil
                ⟩⟩
      | bv64, "sgtz" => do
        return ⟨.pure, [.bv], ⟨
                  .sgtz,
                  rfl,
                  by constructor,
                   .bv64s v₁ <| .nil,
                  .nil
                ⟩⟩
      | .bv, "srai" => do
        let some att := opStx.attrs.getAttr "shamt"
            | throw <| .generic s!"no attribute in srai {repr opStx}"
        match att with
        | .int val ty =>
          let opTy@(.bv) ← mkTy ty
        bv64 return ⟨.pure, [opTy], ⟨
              .srai (BitVec.ofInt 6 val),
              rfl,
              by constructor,
              .cons v₁ <| .nil,
              .nilbv64
            ⟩⟩
        | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
      | .bv, "bclri" => do
        let some att := opStx.attrs.getAttr "imm"
            | throw <| .generic s!"no attribute in bclri {repr opStx}"
        match att with
        | .int val ty =>
            let opTy@(.bv) ← mkTy ty
        bv64 return ⟨.pure, [opTy], ⟨
              .bclri (BitVec.ofInt 6 val),
              by rfl,
              by constructor,
              .cons v₁ <| .nil,
              .nilbv64
            ⟩⟩
        | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
      | .bv, "bexti" => do
        let some att := opStx.attrs.getAttr "imm"
            | throw <| .generic s!"no attribute in bexti {repr opStx}"
        match att with
        | .int val ty =>
            let opTy@(.bv) ← mkTy ty
        bv64 return ⟨.pure, [opTy], ⟨
              .bexti (BitVec.ofInt 6 val),
              rfl,
              by constructor,
              .cons v₁ <| .nil,
              .nilbv64
            ⟩⟩
        | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
      | .bv, "bseti" => do
        let some att := opStx.attrs.getAttr "imm"
            | throw <| .generic s!"no attribute in bseti {repr opStx}"
        match att with
        | .int val ty =>
            let opTy@(.bv) ← mkTy ty
        bv64 return ⟨.pure, [opTy], ⟨
              .bseti (BitVec.ofInt 6 val),
              rfl,
              by constructor,
              .cons v₁ <| .nil,
              .nilbv64
            ⟩⟩
        | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
      | .bv, "binvi" => do
        let some att := opStx.attrs.getAttr "imm"
            | throw <| .generic s!"no attribute in binvi {repr opStx}"
        match att with
        | .int val ty =>
            let opTy@(.bv) ← mkTy ty
        bv64 return ⟨.pure, [opTy], ⟨
              .binvi (BitVec.ofInt 6 val),
              rfl,
              by constructor,
              .cons v₁ <| .nil,
              .nilbv64
            ⟩⟩
        | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
      | .bv, "addiw" => do
        let some att := opStx.attrs.getAttr "imm"
            | throw <| .generic s!"no attribute in addiw {repr opStx}"
        match att with
        | .int val ty =>
            let opTy@(.bv) ← mkTy ty
        bv64 return ⟨.pure, [opTy], ⟨
              .addiw (BitVec.ofInt 12 val),
              rfl,
              by constructor,
              .cons v₁ <| .nil,
              .nilbv64
            ⟩⟩
        | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
      | .bv, "lui" => do
        let some att := opStx.attrs.getAttr "imm"
            | throw <| .generic s!"no attribute in lui {repr opStx}"
        match att with
        | .int val ty =>
            let opTy@(.bv) ← mkTy ty
        bv64 return ⟨.pure, [opTy], ⟨
              .lui (BitVec.ofInt 20 val),
              rfl,
              by constructor,
              .cons v₁ <| .nil,
              .nilbv64
            ⟩⟩
        | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
      | .bv, "auipc" => do
        let some att := opStx.attrs.getAttr "imm"
            | throw <| .generic s!"no attribute in auipc {repr opStx}"
        match att with
        | .int val ty =>
            let opTy@(.bv) ← mkTy ty
        bv64 return ⟨.pure, [opTy], ⟨
              .auipc (BitVec.ofInt 20 val),
              rfl,
              by constructor,
              .cons v₁ <| .nil,
              .nilbv64
            ⟩⟩
        | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
      | .bv, "slliw" => do
        let some att := opStx.attrs.getAttr "shamt"
            | throw <| .generic s!"no attribute in slliw {repr opStx}"
        match att with
        | .int val ty =>
            let opTy@(.bv) ← mkTy ty
        bv64 return ⟨.pure, [opTy], ⟨
              .slliw (BitVec.ofInt 5 val),
              rfl,
              by constructor,
              .cons v₁ <| .nil,
              .nilbv64
            ⟩⟩
        | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
      | .bv, "srliw" => do
        let some att := opStx.attrs.getAttr "shamt"
            | throw <| .generic s!"no attribute in srliw {repr opStx}"
        match att with
        | .int val ty =>
            let opTy@(.bv) ← mkTy ty
        bv64 return ⟨.pure, [opTy], ⟨
              .srliw (BitVec.ofInt 5 val),
              rfl,
              by constructor,
              .cons v₁ <| .nil,
              .nilbv64
            ⟩⟩
        | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
      | .bv, "sraiw" => do
        let some att := opStx.attrs.getAttr "shamt"
            | throw <| .generic s!"no attribute in sraiw {repr opStx}"
        match att with
        | .int val ty =>
            let opTy@(.bv) ← mkTy ty
        bv64 return ⟨.pure, [opTy], ⟨
              .sraiw (BitVec.ofInt 5 val),
              rfl,
              by constructor,
              .cons v₁ <| .nil,
              .nilbv64
            ⟩⟩
        | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
      | .bv, "slli" => do
        let some att := opStx.attrs.getAttr "shamt"
            | throw <|.generic s!"no attribute in slli{repr opStx}"
        match att with
        | .int val ty =>
            let opTy@(.bv) ← mkTy ty
        bv64 return ⟨.pure, [opTy], ⟨
              .slli (BitVec.ofInt 6 val),
              rfl,
              by constructor,
              .cons v₁ <| .nil,
              .nilbv64
            ⟩⟩
        | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
      | .bv, "srli" => do
        let some att := opStx.attrs.getAttr "shamt"
            | throw <| .generic s!"no attribute in srli {repr opStx}"
        match att with
        | .int val ty =>
            let opTy@(.bv) ← mkTy ty
        bv64 return ⟨.pure, [opTy], ⟨
              .srli (BitVec.ofInt 6 val),
              rfl,
              by constructor,
              .cons v₁ <| .nil,
              .nilbv64
            ⟩⟩
        | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
      | .bv, "addi" => do
        let some att := opStx.attrs.getAttr "imm"
            | throw <| .generic s!"no attribute in addi {repr opStx}"
        match att with
        | .int val ty =>
            let opTy@(.bv) ← mkTy ty
        bv64 return ⟨.pure, [opTy], ⟨
              .addi (BitVec.ofInt 12 val),
              rfl,
              by constructor,
              .cons v₁ <| .nil,
              .nilbv64
            ⟩⟩
        | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
      | .bv, "slti" => do
        let some att := opStx.attrs.getAttr "imm"
            | throw <| .generic s!"no attribute in slti {repr opStx}"
        match att with
        | .int val ty =>
            let opTy@(.bv) ← mkTy ty
        bv64 return ⟨.pure, [opTy], ⟨
              .slti (BitVec.ofInt 12 val),
              rfl,
              by constructor,
              .cons v₁ <| .nil,
              .nilbv64
            ⟩⟩
        | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
      | .bv, "sltiu" => do
        let some att := opStx.attrs.getAttr "imm"
            | throw <| .generic s!"no attribute in sltiu {repr opStx}"
        match att with
        | .int val ty =>
            let opTy@(.bv) ← mkTy ty
        bv64 return ⟨.pure, [opTy], ⟨
              .sltiu (BitVec.ofInt 12 val),
              rfl,
              by constructor,
              .cons v₁ <| .nil,
              .nilbv64
            ⟩⟩
        | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
      | .bv, "andi" => do
        let some att := opStx.attrs.getAttr "imm"
            | throw <| .generic s!"no attribute in andi {repr opStx}"
        match att with
        | .int val ty =>
            let opTy@(.bv) ← mkTy ty
        bv64 return ⟨.pure, [opTy], ⟨
              .andi (BitVec.ofInt 12 val),
              rfl,
              by constructor,
              .cons v₁ <| .nil,
              .nilbv64
            ⟩⟩
        | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
      | .bv, "ori" => do
        let some att := opStx.attrs.getAttr "imm"
            | throw <| .generic s!"no attribute in ori {repr opStx}"
        match att with
        | .int val ty =>
            let opTy@(.bv) ← mkTy ty
        bv64 return ⟨.pure, [opTy], ⟨
              .ori (BitVec.ofInt 12 val),
              rfl,
              by constructor,
              .cons v₁ <| .nil,
              .nilbv64
            ⟩⟩
        | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
      | .bv, "xori" => do
        let some att := opStx.attrs.getAttr "imm"
            | throw <| .generic s!"no attribute in xori {repr opStx}"
        match att with
        | .int val ty =>
            let opTy@(.bv) ← mkTy ty
        bv64 return ⟨.pure, [opTy], ⟨
              .xori (BitVec.obv64t 12 val),
              rfl,
              by constructor,
        bv64   .cons v₁ <| .nil,
              .nilbv64
            ⟩⟩
        | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
      | bv64, "sext.b" =>
            return ⟨ .pure, [bv64], ⟨ .sextb, by rfl, by constructor,
               .cons v₁ <| .nil,
                .nil⟩⟩
      | bv64, "sext.h" =>
            return ⟨ .pure, [.bv], ⟨ .sexth, by rfl, by constructor,
               .cons v₁ <| .nil,
                .nil⟩⟩
      | .bv, "zext.h" =>
            return ⟨ .bv64e, [.bv], ⟨ .zexth, by rfl, by constructor,
               .cons v₁ <| .nil,
                .nil⟩⟩
      | .bv, "roriw" => do
        let some att := opStx.attrs.getAttr "imm"
            | throw <| .generic s!"no attribute in roriw {repr opStx}"
        match att with
        | .int val ty =>
            let opTy@(.bv) ← mkTy ty
        bv64 return ⟨.pure, [opTy], ⟨
              .roriw (BitVec.ofInt 5 val),
              rfl,
              by constructor,
              .cons v₁ <| .nil,
              .nilbv64
            ⟩⟩
        | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
      | .bv, "rori" => do
        let some att := opStx.attrs.getAttr "imm"
            | throw <| .generic s!"no attribute in roriw {repr opStx}"
        match att with
        | .int val ty =>
            let opTy@(.bv) ← mkTy ty
        bv64 return ⟨.pure, [opTy], ⟨
              .rori (BitVec.ofInt 6 val),
              rfl,
              by constructor,
              .cons v₁ <| .nil,
              .nilbv64
            ⟩⟩
        | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
      | .bv, "slli.uw" => do
        let some att := opStx.attrs.getAttr "imm"
            | throw <| .generic s!"no attribute in roriw {repr opStx}"
        match att with
        | .int val ty =>
            let opTy@(.bv) ← mkTy ty
            return ⟨.pure, [opTy], ⟨
              .slliuw (BitVec.ofInt 6 val),
              rfl,
              by constructor,
              .cons v₁ <| .nil,
        bv64  bv64il
            ⟩⟩bv64
        | _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
      |_ , _ => throw <| .unsupportedOp s!"unsupported operation {repr opStx}"
  | v₁Stbv64v₂bv64:: [] =>
      let ⟨ty₁, v₁⟩ ← MLIRbv64T.TypedSSAVal.mkVal Γ v₁Stx
      let ⟨ty₂, v₂⟩ ← MLIR.AST.TypedSSAVal.mkVal Γ v₂Stx
      match ty₁, ty₂, opStx.name with
      | bv64, bv64, "rem" =>
          return ⟨.pure, [bv64], ⟨ .rem, by rfl ,by constructor,
             .cons v₁ <| .cons v₂ <| .nil,
              .nil ⟩⟩
      | bv64, bv64, "ror" =>
          return ⟨.pure, [bv64], ⟨ .ror, by rfl ,by constructor,
             .cons v₁ <| .cons v₂ <| .nil,
              .nil ⟩⟩
      | bv64, bv64, "rol" =>
          return ⟨.pure, [bv64], ⟨ .rol, by rfl ,by constructor,
             .cons v₁ <| .cons v₂ <| .nil,
              .nil ⟩⟩
      | bv64, bv64, "remu" =>
          return ⟨.pure, [bv64], ⟨ .remu, by rfl ,by constructor,
             .cons v₁ <| .cons v₂ <| .nil,
              .nil ⟩⟩
      | bv64, .bv64 "sra" =>
          return ⟨.pure, [.bv],bv64.sra, by rfl ,by constructor,
             .cons v₁ <| .cons v₂ <| .nil,
              .nil ⟩⟩
      | bv64, .bv64 "addw" =>
          return ⟨.pure, [.bv],bv64.addw, by rfl ,by constructor,
             .cons v₁ <| .cons v₂ <| .nil,
              .nil ⟩⟩
      | bv64 , bv64 , "subw" =>
              return ⟨ .pure, [bv64], ⟨ .subw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64 , bv64 , "sllw" =>
              return ⟨ .pure, [bv64], ⟨ .sllw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64 , bv64 , "srlw" =>
              return ⟨ .pure, [bv64], ⟨ .srlw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64 , bv64 , "sraw" =>
              return ⟨ .pure, [bv64], ⟨ .sraw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64 , bv64 , "add" =>
              return ⟨ .pure, [bv64], ⟨ .add, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64 , bv64 , "or" =>
              return ⟨ .pure, [bv64], ⟨ .or, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64 , bv64 , "xor" =>
              return ⟨ .pure, [bv64], ⟨ .xor, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64 , bv64 , "sll" =>
              return ⟨ .pure, [bv64], ⟨ .sll, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64 , bv64 , "srl" =>
              return ⟨ .pure, [bv64], ⟨ .srl, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64 , bv64 , "sub" =>
              return ⟨ .pure, [bv64], ⟨ .sub, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64 , bv64 , "slt" =>
              return ⟨ .pure, [bv64], ⟨ .slt, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64 , bv64 , "sltu" =>
              return ⟨ .pure, [bv64], ⟨ .sltu, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64 , bv64 , "and" =>
              return ⟨ .pure, [bv64], ⟨ .and, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64 , bv64 , "bclr" =>
              return ⟨ .pure, [bv64], ⟨ .bclr, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64 , bv64 , "bext" =>
              return ⟨ .pure, [bv64], ⟨ .bext, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64 , bv64 , "binv" =>
              return ⟨ .pure, [bv64], ⟨ .binv, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64 , bv64 , "bset" =>
              return ⟨ .pure, [bv64], ⟨ .bset, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64 , bv64 , "rolw" =>
              return ⟨ .pure, [bv64], ⟨ .rolw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64 , bv64 , "rorw" =>
              return ⟨ .pure, [bv64], ⟨ .rorw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64 , bv64 , "mul" =>
            return ⟨ .pure, [bv64], ⟨ .mul, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64 , bv64 , "mulh" =>
            return ⟨ .pure, [bv64], ⟨ .mulh, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64 , bv64 , "mulhu" =>
            return ⟨ .pure, [bv64], ⟨ .mulhu, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64 , bv64 , "mulhsu" =>
            return ⟨ .pure, [bv64], ⟨ .mulhsu, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64 , bv64 , "mulw" => do
          return ⟨ .pure, [bv64], ⟨ .mulw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64, bv64, "divw" =>
          return ⟨ .pure, [bv64], ⟨ .divw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64, bv64, "divuw" =>
            return ⟨ .pure, [bv64], ⟨ .divuw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64, bv64, "div" =>
            return ⟨ .pure, [bv64], ⟨ .div, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64, bv64, "divu" =>
            return ⟨ .pure, [bv64], ⟨ .divu, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64, bv64, "remw" =>
            return ⟨ .pure, [bv64], ⟨ .remw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64, bv64, "remuw" =>
            return ⟨ .pure, [bv64], ⟨ .remuw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64, bv64, "add.uw" =>
            return ⟨ .pure, [bv64], ⟨ .adduw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64, bv64, "sh1add.uw" =>
            return ⟨ .pure, [bv64], ⟨ .sh1adduw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64, bv64, "sh2add.uw" =>
            return ⟨ .pure, [bv64], ⟨ .sh2adduw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64, bv64, "sh3add.uw" =>
            return ⟨ .pure, [bv64], ⟨ .sh3adduw, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64, bv64, "sh1add" =>
            return ⟨ .pure, [bv64], ⟨ .sh1add, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64, bv64, "sh2add" =>
            return ⟨ .pure, [bv64], ⟨ .sh2add, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64, bv64, "sh3add" =>
            return ⟨ .pure, [bv64], ⟨ .sh3add, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64 , bv64 , "xnor" =>
              return ⟨ .pure, [bv64], ⟨ .xnor, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64 , bv64 , "orn" =>
              return ⟨ .pure, [bv64], ⟨ .xnor, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64 , bv64 , "andn" =>
              return ⟨ .pure, [bv64], ⟨ .andn, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64 , bv64 , "min" =>
              return ⟨ .pure, [bv64], ⟨ .min, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64 , bv64 , "minu" =>
              return ⟨ .pure, [bv64], ⟨ .minu, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64 , bv64 , "maxu" =>
              return ⟨ .pure, [bv64], ⟨ .maxu, by rfl, by constructor,
               .cons v₁ <| .cons v₂ <| .nil,
                .nil⟩⟩
      | bv64 , bv64 , "max" =>
              return ⟨ .pure, [bv64], ⟨ .max, by rfl, by constructor,
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
    return ⟨.pure, [ty], Com.ret v⟩
  | _ => throw <| .generic s!"Ill-formed return statement (wrong arity, expected 1, got {opStx.args.length})"
  else throw <| .generic s!"Tried to build return out of non-return statement {opStx.name}"

instance : MLIR.AST.TransformReturn (RV64) 0 where
  mkReturn := mkReturn

open Qq MLIR AST Lean Elab Term Meta in
elab "[RV64_com| " reg:mlir_region "]" : term => do
  SSA.elabIntoCom reg q(RV64)
end RiscvMkExpr

namespace RISCVExpr
/-!
The section below defines functions to simplify Expression making for some of the RISC-V operations.
This helps in comparing output with expected ouput and
avoids writting huge `Expr`.
-/
def add {Γ : Ctxt _} (e₁ e₂: Ctxt.Var Γ bv64) : Expr RV64 Γ .pure [bv64]  :=
  Expr.mk
    (op := Op.add)
    (eff_le := by constructor)
    (ty_eq := rfl)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := HVector.nil)

def sub {Γ : Ctxt _} (e₁ e₂: Ctxt.Var Γ bv64) : Expr RV64 Γ .pure [bv64]  :=
  Expr.mk
    (op := Op.sub)
    (eff_le := by constructor)
    (ty_eq := rfl)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := HVector.nil)

def and {Γ : Ctxt _} (e₁ e₂: Ctxt.Var Γ bv64) : Expr RV64 Γ .pure [bv64]  :=
  Expr.mk
    (op := Op.and)
    (eff_le := by constructor)
    (ty_eq := rfl)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := HVector.nil)

def or {Γ : Ctxt _} (e₁ e₂: Ctxt.Var Γ bv64) : Expr RV64 Γ .pure [bv64]  :=
  Expr.mk
    (op := Op.or)
    (eff_le := by constructor)
    (ty_eq := by rfl)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := HVector.nil)

def xor  {Γ : Ctxt _} (e₁ e₂: Ctxt.Var Γ bv64) : Expr RV64 Γ .pure [bv64]  :=
  Expr.mk
    (op := Op.xor)
    (eff_le := by constructor)
    (ty_eq := by rfl)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := HVector.nil)

def sll  {Γ : Ctxt _} (e₁ e₂: Ctxt.Var Γ bv64) : Expr RV64 Γ .pure [bv64]  :=
  Expr.mk
    (op := Op.sll)
    (eff_le := by constructor)
    (ty_eq := by rfl)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := HVector.nil)

def sra  {Γ : Ctxt _} (e₁ e₂: Ctxt.Var Γ bv64) : Expr RV64 Γ .pure [bv64]  :=
  Expr.mk
    (op := Op.sll)
    (eff_le := by constructor)
    (ty_eq := by rfl)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := HVector.nil)

def mul {Γ : Ctxt _} (e₁ e₂: Ctxt.Var Γ bv64) : Expr RV64 Γ .pure [bv64]  :=
  Expr.mk
    (op := Op.mul)
    (eff_le := by constructor)
    (ty_eq := by rfl)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := HVector.nil)

def div {Γ : Ctxt _} (e₁ e₂: Ctxt.Var Γ bv64) : Expr RV64 Γ .pure [bv64]  :=
  Expr.mk
    (op := Op.div)
    (eff_le := by constructor)
    (ty_eq := by rfl)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := HVector.nil)

def divu {Γ : Ctxt _} (e₁ e₂: Ctxt.Var Γ bv64) : Expr RV64 Γ .pure [bv64]  :=
  Expr.mk
    (op := Op.divu)
    (eff_le := by constructor)
    (ty_eq := by rfl)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := HVector.nil)

def remu {Γ : Ctxt _} (e₁ e₂: Ctxt.Var Γ bv64) : Expr RV64 Γ .pure [bv64]  :=
  Expr.mk
    (op := Op.remu)
    (eff_le := by constructor)
    (ty_eq := by rfl)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := HVector.nil)

def rem {Γ : Ctxt _} (e₁ e₂: Ctxt.Var Γ bv64) : Expr RV64 Γ .pure [bv64]  :=
  Expr.mk
    (op := Op.rem)
    (eff_le := by constructor)
    (ty_eq := by rfl)
    (args := .cons e₁ <| .cons e₂ .nil)
    (regArgs := HVector.nil)

end RISCVExpr
