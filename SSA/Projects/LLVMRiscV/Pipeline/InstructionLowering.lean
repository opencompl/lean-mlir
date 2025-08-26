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
import SSA.Projects.LLVMRiscV.Pipeline.Combiners
import SSA.Projects.DCE.DCE
import SSA.Projects.CSE.CSE

open LLVMRiscV


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
  sub_match
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
  select_match
  ]
def enable_pseudo_instr_pass := pseudo_match

def reconcile_cast_pass : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
    List.cons ⟨[Ty.riscv RISCV64.Ty.bv], (Ty.riscv RISCV64.Ty.bv), cast_eliminiation_riscv⟩
  <| List.cons ⟨[Ty.llvm _], (Ty.llvm _), cast_eq_cast_cast_eliminiation_riscv⟩ <| List.nil

/- We increase `maxRecDepth` to avoid the recursion depth error when using the peephole rewriter. -/
set_option maxRecDepth 10000000


/--
  Run the instruction selector on a given `Com`, by calling several times `multiRewritePeephole`
  with limited fuel (100).
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
def selectionPipeFuelSafe {Γl : List LLVMPlusRiscV.Ty} (prog : Com LLVMPlusRiscV
  (Ctxt.ofList Γl) .pure (.llvm (.bitvec w))) :=
  let rmInitialDeadCode :=  (DCE.dce' prog).val;
  let loweredConst := multiRewritePeephole 100
    const_match rmInitialDeadCode;
  let lowerPart1 := multiRewritePeephole 100
    rewritingPatterns1  loweredConst;
  let lowerPart2 := multiRewritePeephole 100
    rewritingPatterns0 lowerPart1;
  let postLoweringDCE := (DCE.dce' lowerPart2).val;
  let postReconcileCast := multiRewritePeephole 100 (reconcile_cast_pass) postLoweringDCE;
  let remove_dead_Cast1 := (DCE.dce' postReconcileCast).val;
  let remove_dead_Cast2 := (DCE.dce' remove_dead_Cast1).val;
  remove_dead_Cast2

/--
  Run the instruction selector on a given `Com`, by calling several times `multiRewritePeephole`
  with limited fuel (100), concluding with CSE.
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
def selectionPipeFuelWithCSE {Γl : List LLVMPlusRiscV.Ty} (prog : Com LLVMPlusRiscV
  (Ctxt.ofList Γl) .pure (.llvm (.bitvec w))) (pseudo : Bool):=
  let rmInitialDeadCode :=  (DCE.dce' prog).val;
  let rmInitialDeadCode :=
  if pseudo then
    multiRewritePeephole 100 pseudo_match rmInitialDeadCode
  else
    rmInitialDeadCode
  let loweredConst := multiRewritePeephole 100
    const_match rmInitialDeadCode;
  let lowerPart1 := multiRewritePeephole 100
    rewritingPatterns1  loweredConst;
  let lowerPart2 := multiRewritePeephole 100
    rewritingPatterns0 lowerPart1;
  let postLoweringDCE := (DCE.dce' lowerPart2).val;
  let postReconcileCast := multiRewritePeephole 100 (reconcile_cast_pass) postLoweringDCE;
  let remove_dead_Cast1 := (DCE.dce' postReconcileCast).val;
  let remove_dead_Cast2 := (DCE.dce' remove_dead_Cast1).val;
  let optimize_eq_cast := (CSE.cse' remove_dead_Cast2).val;
  let out := (DCE.dce' optimize_eq_cast).val;
  let out2 := (DCE.dce' out).val;
  out2

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
def selectionPipeFuelWithCSEWithOpt {Γl : List LLVMPlusRiscV.Ty} (prog : Com LLVMPlusRiscV
    (Ctxt.ofList Γl) .pure (.llvm (.bitvec w))) (pseudo : Bool):=
  let rmInitialDeadCode :=  (DCE.dce' prog).val;
  let rmInitialDeadCode :=
    if pseudo then
      multiRewritePeephole 100 pseudo_match rmInitialDeadCode
    else
      rmInitialDeadCode
  let optimize_initial_1 := multiRewritePeephole 150
    GLobalISelO0PreLegalizerCombiner rmInitialDeadCode;
  let optimize_initial_2 := multiRewritePeephole 150
    GLobalISelPostLegalizerCombiner optimize_initial_1;
  let loweredConst := multiRewritePeephole 100
    const_match optimize_initial_2;
  let lowerPart1 := multiRewritePeephole 100
    rewritingPatterns1  loweredConst;
  let lowerPart2 := multiRewritePeephole 100
    rewritingPatterns0 lowerPart1;
  let postLoweringDCE := (DCE.dce' lowerPart2).val;
  let postReconcileCast := multiRewritePeephole 100 (reconcile_cast_pass) postLoweringDCE;
  let remove_dead_Cast1 := (DCE.dce' postReconcileCast).val;
  let remove_dead_Cast2 := (DCE.dce' remove_dead_Cast1).val;
  let optimize_eq_cast := (CSE.cse' remove_dead_Cast2).val;
  let out := (DCE.dce' optimize_eq_cast).val;
  let out2 := (DCE.dce' out).val;
  let optimize_final_1 := multiRewritePeephole 100
    GLobalISelO0PreLegalizerCombiner out2;
  let optimize_final_2 := multiRewritePeephole 100
    GLobalISelPostLegalizerCombiner optimize_final_1;
  optimize_final_2
