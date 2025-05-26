
import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.Pipeline.ReconcileCast
import SSA.Projects.LLVMRiscV.Pipeline.add
import SSA.Projects.LLVMRiscV.Pipeline.ashr
import SSA.Projects.LLVMRiscV.Pipeline.and
import SSA.Projects.LLVMRiscV.Pipeline.icmp
import SSA.Projects.LLVMRiscV.Pipeline.mul
import SSA.Projects.LLVMRiscV.Pipeline.or
import SSA.Projects.LLVMRiscV.Pipeline.rem

import SSA.Projects.DCE.DCE
import SSA.Projects.CSE.CSE


open LLVMRiscV
/-! # Instruction selection-/
/- In this file the actual instruction selection infrastructure is set up.
We collect all the rewrite and instruction selection patterns in an array and
pass the array containing the rewrites to the rewriter.

We wrap in the a `LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND`
which is a rewrite pattern for the rewriter. Since the rewriter requires
equality proofs the apply the rewrites and in our case we work with refinements, we must proivde a
`sorry` as a temporary proof there. As soon as the peephole rewriter is extended to work with refine-
ment, this sorry can easily be replaced. However this won't affect our correctness statement
since we have our own `LLVMPeepholeRewriteRefine` structure which contains the proof, that our
lowerings is a valid refinement.   -/

def add_match := List.map LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND
  [llvm_add_lower_riscv_noflags,llvm_add_lower_riscv_nsw_flag, llvm_add_lower_riscv_nuw_flag,
    llvm_add_lower_riscv_nuw_nsw_flag]

def and_match := List.map LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND [llvm_and_lower_riscv]

def ashr_match := List.map LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND
    [llvm_ashr_lower_riscv_no_flag,llvm_ashr_lower_riscv_flag]

def mul_match := List.map LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND
    [llvm_mul_lower_riscv_noflag, llvm_mul_lower_riscv_flags, llvm_mul_lower_riscv_nsw_flag,
      llvm_mul_lower_riscv_nuw_flag]

def or_match := List.map LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND
    [llvm_or_lower_riscv1_noflag, llvm_or_lower_riscv_disjoint]

def rem_match := List.map LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND [llvm_rem_lower_riscv]

def icmp_match_64 := List.map  LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND
  [icmp_ugt_riscv_eq_icmp_ugt_llvm_i64, icmp_uge_riscv_eq_icmp_uge_llvm_i64, icmp_sle_riscv_eq_icmp_sle_llvm_i64]

def icmp_match_32 := List.map  LLVMToRiscvPeepholeRewriteRefine.toPeepholeUNSOUND
  [icmp_uge_riscv_eq_icmp_uge_llvm_i32, icmp_slt_riscv_eq_icmp_slt_llvm_i32, icmp_sle_riscv_eq_icmp_sle_llvm_i32]

-- to do: find a way to combine the list indepednet of input and outpt types.
def loweringPass_simple:=
  List.flatten [
    add_match,
    and_match,
    ashr_match,
    mul_match,
    or_match,
    rem_match,
  ]
def loweringPass_64 :=
  List.flatten [
    icmp_match_64
  ]
def loweringPass_32 :=
  List.flatten [
    icmp_match_32
  ]

def reconcile_cast_pass :=  List.cons cast_eliminiation_riscv <| List.nil

/-
Pipeline structure:
 DCE (avoid lowering unnecessary instructions, proven to be correct)
  ->
    lowerPassSingle (to lower instruction of the form, add X X )
        ->
          lowerPassFull (to lower any other instruction using two diffrent SSA variable inputs)
              ->
                DCE (to remove the llvm instructions)
                    ->
                      CSE (to remove cast when operand is used multiple times)
                        ->
                          DCE (to remove dead code introduced by the CSE)
                            ->
                              (next in my dreams: register allocation or removing the casts)
-/

def llvm00:=
      [LV|{
      ^bb0(%X : i64, %Y : i64 ):
      %1 = llvm.add %X, %Y : i64
      --%2 = llvm.sub %X, %X : i64 -- this instruction isn ot yet suppported but is in a PR.
      %3 = llvm.add %1, %Y : i64
      %4 = llvm.add %3, %Y : i64
      %5 = llvm.add %3, %4 : i64
      llvm.return %5 : i64
  }]

def llvm01:=
      [LV|{
      ^bb0(%X : i64, %Y : i64 ):
      %1 = llvm.icmp.ugt %X, %Y : i64
      --%2 = llvm.sub %X, %X : i64 -- this instruction isn ot yet suppported but is in a PR.
      llvm.return %1 : i1
  }]

set_option maxRecDepth 10000000

def fuel_def {d : Dialect} [DialectSignature d] {Γ : Ctxt d.Ty} {eff : EffectKind} {t : d.Ty}
  (p: Com d Γ eff t) : Nat := max (Com.size p) 10
  -- should be com size times the number of rewrite patterns

/-
experiment 01:
obsereved best scheduling of the passes, pass ordering problem,
here I first rewriter the binarop operations using the same operand twice.
Then eliminate deadcode. Then apply the lowering pass and then the cast_elimination pass.  -/
def test_peep0_single :  Com LLVMPlusRiscV (Ctxt.ofList [.llvm (.bitvec 64),.llvm (.bitvec 64)]) .pure (.llvm (.bitvec 64)) :=
  multiRewritePeephole (fuel_def llvm00)  (loweringPass_simple) llvm00

#eval! test_peep0_single
def test_pep0_dce:= (DCE.dce' test_peep0_single)
#eval! test_pep0_dce

 def selectionPipeFuel100Safe {Γl : List LLVMPlusRiscV.Ty} (prog : Com LLVMPlusRiscV (Ctxt.ofList Γl) .pure (.llvm (.bitvec w))  ):=
  let initial_dead_code :=  (DCE.dce' prog).val; -- first we eliminate the inital inefficenices in the code.
  let lowerConst := (multiRewritePeephole (100) (loweringPass_simple) initial_dead_code);
  let lower_binOp_self := (multiRewritePeephole (100) (loweringPass_simple) lowerConst); --then we lower all single one operand instructions.
  let remove_binOp_self_llvm := (DCE.dce' lower_binOp_self).val; -- then we eliminate first dead-code introdcued by the lowring the prev instructions.
  let lowering_all_simple :=  multiRewritePeephole (100) (loweringPass_simple) remove_binOp_self_llvm;
  let lowering_all_64 :=  multiRewritePeephole (100) (loweringPass_64) lowering_all_simple;
  let lowering_all_32 :=  multiRewritePeephole (100) (loweringPass_32) lowering_all_64;
  let remove_llvm_instr := (DCE.dce' lowering_all_32).val;
  let reconcile_Cast := multiRewritePeephole (100) (reconcile_cast_pass) remove_llvm_instr;
  let remove_dead_Cast := (DCE.dce' reconcile_Cast).val; -- to do think of whether this makes a diff.
  let minimal_cast := (DCE.dce' remove_dead_Cast).val; -- to do: unsrue why apply cast elimination twice
  --let optimize_eq_cast := (CSE.cse' minimal_cast).val; -- this simplifies when an operand gets casted multiple times.
  --let out := (DCE.dce' optimize_eq_cast).val;
  --out
  minimal_cast

-- NEED TO CANCONOALIZE THE CASTS
#eval! toString (selectionPipeFuel100Safe llvm01)
