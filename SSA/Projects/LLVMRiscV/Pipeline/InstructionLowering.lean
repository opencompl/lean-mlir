
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
import SSA.Projects.DCE.DCE
import SSA.Projects.CSE.CSE

open LLVMRiscV
/-! # Instruction selection-/
/- In this file, the actual instruction selection infrastructure is set up.
We collect all the rewrite and instruction selection patterns into arrays and
pass the arrays containing the rewrites to the rewriter.

We wrap them in `LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND`,
which is a rewrite pattern accepted by the rewriter and defined in `PeepholeRefine.lean`.

For future extensions on how to add a new rewrite to the instruction selection pipeline:
1.) Implement your lowering as a rewrite. See the `add` module for an example.
2.) Add your array containing your rewrite to the `rewritingPatterns` or `rewritingPatterns2`
     array. We split it into multiple arrays to avoid stack overflow issues. If you encounter
     such an issue, add your rewrite to a new array.
-/

/- Array containing the first batch of rewrites-/
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
    sdiv_match]

/- Array containing the second batch of rewrites. We split it up in tw oarrays to avoid a stackoverflow, when
invoking the rewriter with large size arrays.-/
def rewritingPatterns1 :
    List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty) :=
  List.flatten [
    sext_match,
    shl_match,
    srl_match,
    sub_match,
    trunc_match,
    udiv_match,
    urem_match,
    xor_match,
    zext_match,
    select_match
  ]

/-- Defines an array containing only the rewrite pattern which eliminates cast.-/
def reconcile_cast_pass : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty)
  := List.cons ⟨[Ty.riscv RISCV64.Ty.bv], [Ty.riscv RISCV64.Ty.bv], cast_eliminiation_riscv⟩ <| List.nil

def const_match : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty)
  := List.map (fun x => mkRewrite (LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND x)) all_const_llvm_const_lower_riscv_li
/-
Pipeline structure:
 DCE (avoid lowering unnecessary instructions)
  ->
    lowerPart1 (lowering instruction of contained in the first array `rewritingPatterns0`)
        ->
          lowerPart2 (lowering instruction of contained in the array `rewritingPatterns1`)
              ->
                DCE (to remove the llvm instructions)
                    ->
                      reconcile casts (to remove cast operations)
                        ->
                          DCE ( remove the dead code due to removing the casts)
                            (-> CSE ( in the future we might want to run CSE here to eliminate
                                 redundant instructions, currently CSE is not used since it is declared as
                                 unsafe and therefore cannot be called in the opt tool))
-/
set_option maxRecDepth 10000000 -- we set this to avoid the recursion depth error when using the peephole rewriter


/-- This function runs the instruction selector on a given `Com`. The functions makes several calls
to `multiRewritePeephole` and limits the fuel to 100. This means per program and potential rewrite location,
a maximal of 100 steps is performed. Currently we need to set this limit to avoid a stackoverflow in LeanMLIR.
-/
 def selectionPipeFuelSafe {Γl : List LLVMPlusRiscV.Ty} (prog : Com LLVMPlusRiscV
    (Ctxt.ofList Γl) .pure [.llvm (.bitvec w)]):=
  let rmInitialDeadCode :=  (DCE.dce' prog).val; -- First we eliminate the inital inefficenices in the code.
  let loweredConst := multiRewritePeephole 100
    const_match rmInitialDeadCode; -- Lower the instructions in the first array.
  let lowerPart1 := multiRewritePeephole 100
    rewritingPatterns1  loweredConst;
  let lowerPart2 := multiRewritePeephole 100
    rewritingPatterns0 lowerPart1;
  let postLoweringDCE := (DCE.dce' lowerPart2).val;
  let postReconcileCast := multiRewritePeephole 100 (reconcile_cast_pass) postLoweringDCE;
  let remove_dead_Cast1 := (DCE.dce' postReconcileCast).val;
  let remove_dead_Cast2 := (DCE.dce' remove_dead_Cast1).val; -- Rerun it to ensure that all dead code is removed.
  /-
  let optimize_eq_cast := (CSE.cse' remove_dead_Cast2).val;
  We do not use it atm since we get an error when
   trying to call an unsafe function with the opt tool
  let out := (DCE.dce' optimize_eq_cast).val;
  out -/
  remove_dead_Cast2

/- Below are two example programs to test our instruction selector.-/
def llvm00:=
  [LV|{
    ^bb0(%X : i64, %Y : i64 ):
    %1 = llvm.add %X, %Y : i64
    %2 = llvm.sub %X, %X : i64
    %3 = llvm.add %1, %Y : i64
    %4 = llvm.add %3, %Y : i64
    %5 = llvm.add %3, %4 : i64
    llvm.return %5 : i64
  }]
def llvm01:=
  [LV|{
    ^bb0(%X : i64, %Y : i64 ):
    %1 = llvm.icmp.ugt %X, %Y : i64
    %2 = llvm.sub %X, %X : i64
    llvm.return %1 : i1
  }]


--#eval! (selectionPipeFuelSafe llvm00)
