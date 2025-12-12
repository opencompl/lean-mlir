import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.Pipeline.ReconcileCast
import SSA.Projects.LLVMRiscV.Pipeline.add
import SSA.Projects.LLVMRiscV.Pipeline.ashr
import SSA.Projects.LLVMRiscV.Pipeline.and
import SSA.Projects.LLVMRiscV.Pipeline.icmp
import SSA.Projects.LLVMRiscV.Pipeline.mul
import SSA.Projects.LLVMRiscV.Pipeline.or
import SSA.Projects.LLVMRiscV.Pipeline.rem
import SSA.Projects.LLVMRiscV.Pipeline.sdiv
import SSA.Projects.LLVMRiscV.Pipeline.sext
import SSA.Projects.LLVMRiscV.Pipeline.shl
import SSA.Projects.LLVMRiscV.Pipeline.srl
import SSA.Projects.LLVMRiscV.Pipeline.sub
import SSA.Projects.LLVMRiscV.Pipeline.trunc
import SSA.Projects.LLVMRiscV.Pipeline.udiv
import SSA.Projects.LLVMRiscV.Pipeline.urem
import SSA.Projects.LLVMRiscV.Pipeline.xor
import SSA.Projects.LLVMRiscV.Pipeline.zext
import SSA.Projects.LLVMRiscV.Pipeline.const
import SSA.Projects.LLVMRiscV.Pipeline.select
import SSA.Projects.LLVMRiscV.Pipeline.pseudo
import SSA.Projects.LLVMRiscV.Pipeline.freeze
import SSA.Projects.LLVMRiscV.Pipeline.Combiners
import SSA.Projects.LLVMRiscV.Pipeline.ConstantMatching
import SSA.Projects.LLVMRiscV.Pipeline.SelectionDAG

import LeanMLIR.Transforms.DCE
import LeanMLIR.Transforms.CSE

open LLVMRiscV
open LeanMLIR.SingleReturnCompat

/-!
  # Instruction selection

  This file contains the infrastructure for our verified instruction selection.
  We collect all the rewrite and instruction selection patterns into arrays and pass the arrays
  containing the rewrites to the rewriter.
  We wrap the rewrites in the `LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND` rewrite pattern,
  which is defined in `PeepholeRefine.lean`.

  To extend the current instruction selector, one must
  1. implement the lowering as a rewrite
  2. add an array containing the rewrite to a `rewritingPatterns*` array, where `*` serves to number
  the arrays in which we split our rewrites. We split our rewrites into multiple
  `rewritingPatterns*` array to avoid stack overflow.

-/

def rewritingPatterns0 :
  List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  List.flatten [
  add_match,
  and_match,
  ashr_match,
  icmp_match,
  mul_match,
  or_match,
  rem_match,
  sdiv_match, -- TODO: fix the casts
  sub_match,
  freeze_match
  ]

def rewritingPatterns1 :
  List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  List.flatten [
  sext_match,
  shl_match,
  srl_match,
  trunc_match,
  udiv_match,
  urem_match,
  xor_match,
  zext_match,
  select_matchbv64bv64
  ]
def enable_pseudo_instr_pass := pseudo_match

def reconcile_cast_pass : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  [⟨[Ty.riscv RISCV64.Ty.bv], [Ty.riscv RISCV64.Ty.bv], cast_eliminiation_riscv⟩]


/- We increase `maxRecDepth` to avoid the recursion depth error when using the peephole rewriter. -/
set_option maxRecDepth 10000000


/--
  Run the instruction selector on a given `Com`, by calling several times `multiRewritePeephole`
  with limited `fuel`.
  This means that at most 100 steps are performed per-program and per-rewrite-location.
  The limit ensure that there is no stack overflow.

  The structure of this instruction selection pipeline is as follows:
  - DCE
  - lowering instructions in `rewritingPatterns1`
  - lowering instructions in `rewritingPatterns2`
  - DCE (to remove LLVM instructions)
  - remove casting operations (`reconcile_casts`)
  - DCE (dead code due to casting removal)
-/
def selectionPipeFuelSafe {Γl : List LLVMPlusRiscV.Ty} (fuel : Nat) (prog : Com LLVMPlusRiscV
  (Ctxt.ofList Γl) .pure (.llvm (.bitvec w))) :=
  let rmInitialDeadCode :=  (DCE.dce' prog).val;
  let loweredConst := multiRewritePeephole fuel
    const_match rmInitialDeadCode;
  let lowerPart1 := multiRewritePeephole fuel
    rewritingPatterns1  loweredConst;
  let lowerPart2 := multiRewritePeephole fuel
    rewritingPatterns0 lowerPart1;
  let postLoweringDCE := (DCE.dce' lowerPart2).val;
  let postReconcileCast := multiRewritePeephole fuel (reconcile_cast_pass) postLoweringDCE;
  let remove_dead_Cast1 := (DCE.dce' postReconcileCast).val;
  let remove_dead_Cast2 := (DCE.dce' remove_dead_Cast1).val;
  remove_dead_Cast2

/--
  Run the instruction selector on a given `Com`, by calling several times `multiRewritePeephole`
  with limited `fuel`, concluding with CSE.
  This means that at most 100 steps are performed per-program and per-rewrite-location.
  The limit ensures that there is no stack overflow.

  The structure of this instruction selection pipeline is as follows:
  - DCE
  - lowering instructions in `rewritingPatterns1`
  - lowering instructions in `rewritingPatterns2`
  - DCE (to remove LLVM instructions)
  - remove casting operations (`reconcile_casts`)
  - DCE (dead code due to casting removal)
  - CSE
-/
def selectionPipeFuelWithCSE {Γl : List LLVMPlusRiscV.Ty} (fuel : Nat) (prog : Com LLVMPlusRiscV
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
  let lowerPart2 := multiRewritePeephole fuel
    rewritingPatterns0 lowerPart1;
  let postLoweringDCE := (DCE.repeatDce lowerPart2).val;
  let postReconcileCast := multiRewritePeephole fuel reconcile_cast_pass postLoweringDCE;
  let remove_dead_cast := (DCE.repeatDce postReconcileCast).val;
  let optimize_eq_cast := (CSE.cse' remove_dead_cast).val;
  let out := (DCE.repeatDce optimize_eq_cast).val;
  out

/--
  Run the instruction selector pipeline with optimizations, resulting in the following pipeline:
  - DCE
  - pre-legalization `O0` optimizations from globalISel (on LLVM)
  - post-legalization `O0` optimizations from globalISel (on LLVM)
  - lowering instructions in `rewritingPatterns1`
  - lowering instructions in `rewritingPatterns0`
  - DCE (to remove LLVM instructions)
  - remove casting operations (`reconcile_casts`)
  - DCE (dead code due to casting removal)
  - CSE
  - pre-legalization `O0` optimizations from globalISel (on RISCV assembly)
  - post-legalization `O0` optimizations from globalISel (on RISCV assembly)
-/
def selectionPipeFuelWithCSEWithOpt {Γl : List LLVMPlusRiscV.Ty} (fuel : Nat) (prog : Com LLVMPlusRiscV
    (Ctxt.ofList Γl) .pure (.llvm (.bitvec w))) (pseudo : Bool):=
  let rmInitialDeadCode :=  (DCE.repeatDce prog).val;
  let rmInitialDeadCode :=
    if pseudo then
      multiRewritePeephole fuel pseudo_match rmInitialDeadCode
    else
      rmInitialDeadCode
  let optimize_initial_1 := multiRewritePeephole fuel
    GLobalISelO0PreLegalizerCombiner rmInitialDeadCode;
  let optimize_initial_2 := multiRewritePeephole fuel
    GLobalISelPostLegalizerCombiner optimize_initial_1;
  let loweredConst := multiRewritePeephole fuel
    const_match optimize_initial_2;
  let lowerPart1 := multiRewritePeephole fuel
    rewritingPatterns1  loweredConst;
  let lowerPart2 := multiRewritePeephole fuel
    rewritingPatterns0 lowerPart1;
  let postLoweringDCE := (DCE.repeatDce lowerPart2).val;
  let postReconcileCast := multiRewritePeephole fuel (reconcile_cast_pass) postLoweringDCE;
  let remove_dead_cast := (DCE.repeatDce postReconcileCast).val;
  let optimize_eq_cast := (CSE.cse' remove_dead_cast).val;
  let out := (DCE.repeatDce optimize_eq_cast).val;
  let optimize_final_1 := multiRewritePeephole 100
    GLobalISelO0PreLegalizerCombiner out;
  let optimize_final_2 := multiRewritePeephole 100
    GLobalISelPostLegalizerCombiner optimize_final_1;
  let dce_final := (DCE.repeatDce optimize_final_2).val
  dce_final

/--
  Run the instruction selector pipeline including optimizations requiring constant matching, resulting in the following pipeline:
  - DCE
  - pre-legalization `O0` optimizations from globalISel (on LLVM)
  - pre-legalication optimizations with constant matching from globalISel (on LLVM)
  - post-legalization `O0` optimizations from globalISel (on LLVM)
  - lowering instructions in `rewritingPatterns1`
  - lowering instructions in `rewritingPatterns0`
  - DCE (to remove LLVM instructions)
  - remove casting operations (`reconcile_casts`)
  - DCE (dead code due to casting removal)
  - CSE
  - pre-legalization `O0` optimizations from globalISel (on RISCV assembly)
  - post-legalization `O0` optimizations from globalISel (on RISCV assembly)
-/
def selectionPipeFuelWithCSEWithOptConst {Γl : List LLVMPlusRiscV.Ty} (fuel : Nat) (prog : Com LLVMPlusRiscV
    (Ctxt.ofList Γl) .pure (.llvm (.bitvec w))) (pseudo : Bool):=
  let rmInitialDeadCode :=  (DCE.repeatDce  prog).val;
  let rmInitialDeadCode :=
    if pseudo then
      multiRewritePeephole fuel pseudo_match rmInitialDeadCode
    else
      rmInitialDeadCode
  let optimize_initial_1_const := multiRewritePeephole fuel
    GlobalISelPostLegalizerCombinerConstantFolding rmInitialDeadCode;
  let optimize_initial_1 := multiRewritePeephole fuel
    GLobalISelO0PreLegalizerCombiner optimize_initial_1_const;
  let optimize_initial_2 := multiRewritePeephole fuel
    GLobalISelPostLegalizerCombiner optimize_initial_1;
  let loweredConst := multiRewritePeephole fuel
    const_match optimize_initial_2;
  let lowerPart1 := multiRewritePeephole fuel
    rewritingPatterns1  loweredConst;
  let lowerPart2 := multiRewritePeephole fuel
    rewritingPatterns0 lowerPart1;
  let postLoweringDCE := (DCE.repeatDce  lowerPart2).val;
  let postReconcileCast := multiRewritePeephole fuel (reconcile_cast_pass) postLoweringDCE;
  let remove_dead_Cast1 := (DCE.repeatDce  postReconcileCast).val;
  let remove_dead_Cast2 := (DCE.repeatDce  remove_dead_Cast1).val;
  let optimize_eq_cast := (CSE.cse' remove_dead_Cast2).val;
  let out := (DCE.repeatDce  optimize_eq_cast).val;
  let out2 := (DCE.repeatDce  out).val;
  let optimize_final_1 := multiRewritePeephole 100
    GLobalISelO0PreLegalizerCombiner out2;
  let optimize_final_2 := multiRewritePeephole 100
    GLobalISelPostLegalizerCombiner optimize_final_1;
  let dce_final := (DCE.repeatDce optimize_final_2).val
  dce_final

/--
  Run the instruction selector pipeline with optimizations, resulting in the following pipeline:
  - DCE
  - Optimizations from SelectionDAG (on LLVM)
  - lowering instructions in `rewritingPatterns1`
  - lowering instructions in `rewritingPatterns0`
  - DCE (to remove LLVM instructions)
  - remove casting operations (`reconcile_casts`)
  - DCE (dead code due to casting removal)
  - CSE
  - Optimizations from SelectionDAG (on RISCV assembly)
-/
def selectionPipeWithSelectionDAG {Γl : List LLVMPlusRiscV.Ty} (fuel : Nat) (prog : Com LLVMPlusRiscV
    (Ctxt.ofList Γl) .pure (.llvm (.bitvec w))) (pseudo : Bool):=
  let rmInitialDeadCode :=  (DCE.repeatDce prog).val;
  let rmInitialDeadCode :=
    if pseudo then
      multiRewritePeephole fuel pseudo_match rmInitialDeadCode
    else
      rmInitialDeadCode
  let optimize_initial := multiRewritePeephole fuel
    SelectionDAGCombiner rmInitialDeadCode;
  let loweredConst := multiRewritePeephole fuel
    const_match optimize_initial;
  let lowerPart1 := multiRewritePeephole fuel
    rewritingPatterns1  loweredConst;
  let lowerPart2 := multiRewritePeephole fuel
    rewritingPatterns0 lowerPart1;
  let postLoweringDCE := (DCE.repeatDce lowerPart2).val;
  let postReconcileCast := multiRewritePeephole fuel (reconcile_cast_pass) postLoweringDCE;
  let remove_dead_cast := (DCE.repeatDce postReconcileCast).val;
  let optimize_eq_cast := (CSE.cse' remove_dead_cast).val;
  let out := (DCE.repeatDce optimize_eq_cast).val;
  let optimize_final := multiRewritePeephole 100
    SelectionDAGCombiner out;
  let dce_final := (DCE.repeatDce optimize_final).val
  dce_final
