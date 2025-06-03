import Cli
import SSA.Projects.InstCombine.LLVM.Parser
import SSA.Projects.LLVMRiscV.LLVMAndRiscv
import SSA.Projects.LLVMRiscV.Pipeline.InstructionLowering

open MLIR AST InstCombine
open LLVMRiscV
/-!
This file defines functions that are accessed via the Opt tool to parse input files into the hybrid
dialect. In the future, flags for the Opt tool that perform transformations in the hybrid dialect
will be modeled as function calls from Opt.lean to functions defined in this file. This file can be
seen as an extension of the Opt tool, specific to the LLVMAndRiscV dialect.
-/

/-- `regionTransform_LLVMRiscV` attempts to transform a region into a `Com` of type `LLVMAndRiscV`.
It throws an error if the transformation fails. -/
def regionTransform_LLVMRiscV (region : Region 0) : Except ParseError
  (Σ (Γ' : Ctxt LLVMPlusRiscV.Ty ) (eff : EffectKind)
  (ty : LLVMPlusRiscV.Ty ), Com LLVMPlusRiscV Γ' eff ty) :=
  let res := mkCom (d:= LLVMPlusRiscV) region
  match res with
  | Except.error e => Except.error s!"Error:\n{reprStr e}"
  | Except.ok res => Except.ok res

/-- `parseComFromFile_LLVMRiscV` parses a `Com` from the input file as a `Com` of type
`LLVMAndRiscV`. It uses the parsing infrastructure provided by the framework, which is
also used for parsing LLVM `Com`s. -/
def parseComFromFile_LLVMRiscV(fileName : String) :
 IO (Option (Σ (Γ' :  Ctxt LLVMPlusRiscV.Ty ) (eff : EffectKind)
 (ty :  LLVMPlusRiscV.Ty), Com LLVMPlusRiscV Γ' eff ty)) := do
 parseRegionFromFile fileName regionTransform_LLVMRiscV

<<<<<<< HEAD
=======
/-- This function parses a `Com` from the file with name `fileName` as a `Com` of type `LLVMAndRiscV`.
Next, it calls the instruction lowering function `selectionPipeFuelSafe` on the parsed `Com` and
prints it to standart output. If any of the steps fail ,we print an error message and return exit code 1  -/
>>>>>>> origin/main
def passriscv64 (fileName : String) : IO UInt32 := do
    let icom? ← parseComFromFile_LLVMRiscV fileName
    match icom? with
    | none => return 1
    | some (Sigma.mk _Γ ⟨eff, ⟨retTy, c⟩⟩) =>
      match eff with
      | EffectKind.pure =>
        match retTy with
        | Ty.llvm (.bitvec _w)  =>
<<<<<<< HEAD
          let lowered :=  selectionPipeFuelSafe c /- calls the instruction selector defined in `
=======
          let lowered := selectionPipeFuelSafe c /- calls the instruction selector defined in `
>>>>>>> origin/main
                                                  InstructionLowering`-/
          IO.println s!"{repr lowered}"
          return 0
        | _ =>
        IO.println s!" debug: WRONG RETURN TYPE : expected Ty.llvm (Ty.bitvec 64) "
        return 1
      | _ =>
      IO.println s!" debug: WRONG EFFECT KIND : expected pure program "
      return 1
