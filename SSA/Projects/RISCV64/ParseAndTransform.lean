import Cli
import SSA.Projects.InstCombine.LLVM.Parser
import SSA.Projects.RISCV64.Base
import SSA.Projects.LLVMRiscV.Pipeline.InstructionLowering

open MLIR AST InstCombine
open RISCV64
/-!
This file defines functions that are accessed via the Opt tool to parse input files into the hybrid
dialect. In the future, flags for the Opt tool that perform transformations in the hybrid dialect
will be modeled as function calls from Opt.lean to functions defined in this file. This file can be
seen as an extension of the Opt tool, specific to the LLVMAndRiscV dialect.
-/

/-- `regionTransform_RiscV` attempts to transform a region into a `Com` of type `RV64`.
It throws an error if the transformation fails. -/
def regionTransform_RISCV (region : Region 0) : Except ParseError
  (Σ (Γ' : Ctxt RISCV64.Ty ) (eff : EffectKind)
  (ty : RISCV64.Ty ), Com RV64 Γ' eff ty) :=
  let res := mkCom (d:= RV64) region
  match res with
  | Except.error e => Except.error s!"Error:\n{reprStr e}"
  | Except.ok res => Except.ok res

/-- `parseComFromFile_RiscV` parses a `Com` from the input file as a `Com` of type
`RiscV`. It uses the parsing infrastructure provided by the framework, which is
also used for parsing LLVM `Com`s. -/
def parseComFromFile_LLVMRISCV(fileName : String) :
 IO (Option (Σ (Γ' :  Ctxt RISCV64.Ty ) (eff : EffectKind)
 (ty :  RISCV64.Ty), Com RV64 Γ' eff ty)) := do
 parseRegionFromFile fileName regionTransform_RISCV

def parseAsRiscv (fileName : String ) : IO UInt32 := do
    let icom? ← parseComFromFile_LLVMRISCV fileName
    match icom? with
    | none => return 1
    | some (Sigma.mk _Γ ⟨_eff, ⟨_retTy, c⟩⟩) => do
      IO.println s!"{toString c}"
      return 0
private def test_simple := [RV64_com| {
  ^bb0(%e1 : !i64, %e2 : !i64 ):
  %1 = add %e1, %e2 : !i64
       ret %1 : !i64
}]

/--
info: {
  ^entry(%0 : RISCV64.Ty.bv, %1 : RISCV64.Ty.bv):
    %2 = RISCV64.Op.add(%0, %1) : (RISCV64.Ty.bv, RISCV64.Ty.bv) → (RISCV64.Ty.bv)
    return %2 : (RISCV64.Ty.bv) → ()
}
-/
#guard_msgs in #eval! test_simple
