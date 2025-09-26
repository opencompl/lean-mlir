import Cli
import SSA.Projects.InstCombine.LLVM.Parser
import SSA.Projects.RISCV64.Base
import SSA.Projects.LLVMRiscV.Pipeline.InstructionLowering

open MLIR AST InstCombine
open RISCV64
open LeanMLIR.SingleReturnCompat
/-!
This file defines functions that are accessed via the Opt tool to parse input files into the hybrid
dialect. In the future, flags for the Opt tool that perform transformations in the hybrid dialect
will be modeled as function calls from Opt.lean to functions defined in this file. This file can be
seen as an extension of the Opt tool, specific to the LLVMAndRiscV dialect.
-/

def parseAsRiscv (fileName : String ) : IO UInt32 := do
  let icom? ← Com.parseFromFile RV64 fileName
  match icom? with
  | none => return 1
  | some (Sigma.mk _Γ ⟨_eff, ⟨_retTy, c⟩⟩) => do
    IO.println c.printModule
    return 0

/--
info:
riscv_func.func @f(%0 : !riscv.reg, %1 : !riscv.reg):
  %2 = "riscv.add"(%0, %1) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  "riscv.ret"(%2) : (!riscv.reg) -> ()
-/
#guard_msgs in #eval Com.print [RV64_com| {
  ^bb0(%0 : !i64, %1 : !i64 ):
    %2 = add %0, %1 : !i64
    ret %2 : !i64
}]
