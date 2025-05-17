import Cli
import SSA.Projects.InstCombine.LLVM.Parser
import SSA.Projects.LLVMRiscV.LLVMAndRiscv

open MLIR AST InstCombine
open LLVMRiscV

def regionTransform_LLVMRiscV (region : Region 0) : Except ParseError
  (Σ (Γ' : Ctxt LLVMPlusRiscV.Ty ) (eff : EffectKind)
    (ty : LLVMPlusRiscV.Ty ), Com LLVMPlusRiscV Γ' eff ty) :=
    let res := mkCom (d:= LLVMPlusRiscV) region
    match res with
      | Except.error e => Except.error s!"Error:\n{reprStr e}"
      | Except.ok res => Except.ok res

-- parses it as a hybrid com, if want to parse as llvm instcombine the use parse1
def parseComFromFile_LLVMRiscV(fileName : String) :
 IO (Option (Σ (Γ' :  Ctxt LLVMPlusRiscV.Ty ) (eff : EffectKind)
  (ty :  LLVMPlusRiscV.Ty), Com LLVMPlusRiscV Γ' eff ty)) := do
 parseRegionFromFile fileName regionTransform_LLVMRiscV

def convert_llvm_to_riscv64 (fileName : String ) : IO UInt32 := do
  let icom? ← parseComFromFile_LLVMRiscV fileName
  match icom? with
  | none =>  return 1
  | some (Sigma.mk _Γ ⟨eff, ⟨retTy, c⟩⟩) =>
    match eff with
    | EffectKind.pure =>
      match retTy with
      | Ty.llvm _ =>
          -- Now that we matched eff and retTy, we can safely assert types.
        let lowered :=  c -- here we effectivly apply the lowering
          --let lowered1 :=  selectionPipeFuel100Safe c
          --IO.println s!"{lowered.denote  == lowered1.denote }"
        IO.println s!"{toString lowered}"
        return 0
      | _ =>
       IO.println s!" debug: WRONG RETURN TYPE : expected Ty.llvm (Ty.bitvec 64) "
       return 1
    | _ =>
      IO.println s!" debug: WRONG EFFECT KIND : expected pure program "
      return 1

def peephole_riscv64 (fileName : String) : IO UInt32 := do
    let icom? ← parseComFromFile_LLVMRiscV fileName -- parsing into the hybrid dialect
    match icom? with
    | none => return 1
    | some (Sigma.mk _Γ ⟨eff, ⟨retTy, c⟩⟩) =>
      match eff with
      | EffectKind.pure =>
        match retTy with
        | Ty.riscv _=> -- this indicates it is a riscv program based on the return type.
      -- Now that we matched eff and retTy, we can safely assert types.
          let peep_optimize :=  c -- here we effectivly apply the lowering & then call the peephole rewriter
          IO.println s!"{toString peep_optimize}"
          return 0
        | _ =>
        IO.println s!" debug: WRONG RETURN TYPE : expected Ty.riscv (Ty.bv) "
        return 1
      | _ =>
      IO.println s!" debug: WRONG EFFECT KIND : expected pure program "
      return 1
