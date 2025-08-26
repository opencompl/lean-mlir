import Cli
import SSA.Projects.InstCombine.LLVM.Parser
import SSA.Projects.LLVMRiscV.LLVMAndRiscv
import SSA.Projects.LLVMRiscV.Pipeline.InstructionLowering

open MLIR AST InstCombine
open LLVMRiscV
/-!
  This file extends the `opt` tool, to specifically support the `LLVMPlusRiscV` dialect.
-/

/-- `regionTransform_LLVMRiscV` attempts to transform a region into a `Com` of type `LLVMAndRiscV`.
  It throws an error if the transformation fails. -/
def regionTransform_LLVMRiscV (region : Region 0) : Except ParseError
  (Σ (Γ' : Ctxt LLVMPlusRiscV.Ty ) (eff : EffectKind)
  (ty : List LLVMPlusRiscV.Ty ), Com LLVMPlusRiscV Γ' eff ty) :=
  let res := mkCom (d:= LLVMPlusRiscV) region
  match res with
  | Except.error e => Except.error s!"Error:\n{reprStr e}"
  | Except.ok res => Except.ok res

/-- `parseComFromFile_LLVMRiscV` parses a `Com` from the input file as a `Com` of type
  `LLVMAndRiscV`. It uses the parsing infrastructure provided by the framework, which is
  also used for parsing LLVM `Com`s. -/
def parseComFromFile_LLVMRiscV(fileName : String) :
 IO (Option (Σ (Γ' :  Ctxt LLVMPlusRiscV.Ty ) (eff : EffectKind)
 (ty : List LLVMPlusRiscV.Ty), Com LLVMPlusRiscV Γ' eff ty)) := do
 parseRegionFromFile fileName regionTransform_LLVMRiscV

/-- `passriscv64` parses a `Com` from the file with name `fileName` as a `Com` of type `LLVMAndRiscV`.
  Next, it calls the instruction lowering function `selectionPipeFuelSafe` on the parsed `Com` and
  prints it to standart output.
  If any of the steps fails, we print an error message and return exit code 1. -/
def passriscv64 (fileName : String) : IO UInt32 := do
    let icom? ← parseComFromFile_LLVMRiscV fileName
    match icom? with
    | none => return 1
    | some (Sigma.mk _Γ ⟨eff, ⟨retTy, c⟩⟩) =>
      match eff with
      | EffectKind.pure =>
        match retTy with
        | [Ty.llvm (.bitvec _w)]  =>
          /- calls to the instruction selector defined in `InstructionLowering`,
            `true` indicates pseudo variable lowering, `fuel` is 150-/
          let lowered := selectionPipeFuelWithCSE 150 c true

          IO.println s!"{Com.toPrint (lowered) }"
          return 0
        | _ =>
        IO.println s!" debug: WRONG RETURN TYPE : expected Ty.llvm (Ty.bitvec 64) "
        return 1
      | _ =>
      IO.println s!" debug: WRONG EFFECT KIND : expected pure program "
      return 1

/-- `passriscv64_optimized` parses a `Com` from the file with name `fileName` as a `Com` of type
  `LLVMAndRiscV`. Next, it calls the optimized instruction selection lowering function
  `selectionPipeFuelWithCSEWithOpt` on the parsed `Com` and prints it to standart output.
  This pass applies the optimization patterns from `GlobalISel` on both LLVM and RISCV.
  If any of the steps fails, we print an error message and return exit code 1. -/
def passriscv64_optimized (fileName : String) : IO UInt32 := do
    let icom? ← parseComFromFile_LLVMRiscV fileName
    match icom? with
    | none => return 1
    | some (Sigma.mk _Γ ⟨eff, ⟨retTy, c⟩⟩) =>
      match eff with
      | EffectKind.pure =>
        match retTy with
        | Ty.llvm (.bitvec _w)  =>
          /- calls to the optimized instruction selector defined in `InstructionLowering`,
          `true` indicates pseudo variable lowering, `fuel` is 150 -/
          let lowered := selectionPipeFuelWithCSEWithOpt 150 c true
          IO.println s!"{Com.toPrint (lowered) }"
          return 0
        | _ =>
        IO.println s!" debug: WRONG RETURN TYPE : expected Ty.llvm (Ty.bitvec 64) "
        return 1
      | _ =>
      IO.println s!" debug: WRONG EFFECT KIND : expected pure program "
      return 1
