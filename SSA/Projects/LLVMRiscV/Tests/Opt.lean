import SSA.Projects.LLVMRiscV.ParseAndTransform

/--
error: Error parsing SSA/Projects/LLVMRiscV/Tests/Parsing/input.mlir:
Error:
Type mismatch: expected '"i1"', but 'name' has type '"i64"'
-/
#guard_msgs in
#eval! passriscv64 ("SSA/Projects/LLVMRiscV/Tests/Parsing/input.mlir")

open MLIR AST InstCombine
open LLVMRiscV

open LeanMLIR.SingleReturnCompat

def selectionPipeFuelWithCSE' {Γl : List LLVMPlusRiscV.Ty} (fuel : Nat) (prog : Com LLVMPlusRiscV
  (Ctxt.ofList Γl) .pure (.llvm (.bitvec w))) (pseudo : Bool):=
  let rmInitialDeadCode :=  (DCE.repeatDce prog).val;
  let rmInitialDeadCode :=
  if pseudo then
    multiRewritePeephole fuel pseudo_match rmInitialDeadCode
  else
    rmInitialDeadCode
  let loweredConst := multiRewritePeephole fuel
    const_match rmInitialDeadCode;
  let lowerPart1 := multiRewritePeephole fuel
    rewritingPatterns1  loweredConst;
  -- let lowerPart2 := multiRewritePeephole fuel
  --   rewritingPatterns0 lowerPart1;
  -- let postLoweringDCE := (DCE.repeatDce lowerPart2).val;
  -- let postReconcileCast := multiRewritePeephole fuel reconcile_cast_pass postLoweringDCE;
  -- let remove_dead_cast := (DCE.repeatDce postReconcileCast).val;
  -- let optimize_eq_cast := (CSE.cse' remove_dead_cast).val;
  -- let out := (DCE.repeatDce optimize_eq_cast).val;
  lowerPart1
  -- out


def passriscv64' (fileName : String) (fuel : Nat) : IO UInt32 := do
    let icom? ← Com.parseFromFile LLVMPlusRiscV fileName
    match icom? with
    | none => return 1
    | some (Sigma.mk _Γ ⟨eff, ⟨retTy, c⟩⟩) =>
      match eff with
      | EffectKind.pure =>
        match retTy with
        | [Ty.llvm (.bitvec _w)]  =>
          /- calls to the instruction selector defined in `InstructionLowering`,
            `true` indicates pseudo variable lowering, `fuel` is 150-/
          let lowered := selectionPipeFuelWithCSE' fuel c true

          IO.println <| lowered.printModule
          return 0
        | _ =>
        IO.println s!" debug: WRONG RETURN TYPE : expected Ty.llvm (Ty.bitvec 64) "
        return 1
      | _ =>
      IO.println s!" debug: WRONG EFFECT KIND : expected pure program "
      return 1

#eval! passriscv64' ("SSA/Projects/LLVMRiscV/Tests/Parsing/non_opt_test.mlir") 10
#eval! passriscv64' ("SSA/Projects/LLVMRiscV/Tests/Parsing/non_opt_test.mlir") 20
#eval! passriscv64' ("SSA/Projects/LLVMRiscV/Tests/Parsing/non_opt_test.mlir") 30
#eval! passriscv64 ("SSA/Projects/LLVMRiscV/Tests/Parsing/non_opt_test.mlir")
