
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
lowerings is a valid refinement.

For future extnsion how to add a new rewrite to the instruction selection pipeline.
1.) Implement your lowering as rewrite. See the `add` module for an example.
2.) Depending on the semantics either add it to a lexisting list in this file or create a new list
for your rewrite labellingthe list with the name of the instruction.
3.) Add the list to the final instruction selection array.
-/

def rewritting_patterns {_Γ : List LLVMPlusRiscV.Ty} {_t : LLVMPlusRiscV.Ty} :
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

def rewritting_patterns2 {_Γ : List LLVMPlusRiscV.Ty} {_t : LLVMPlusRiscV.Ty} :
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
    zext_match
  ]

def reconcile_cast_pass : List (Σ Γ, Σ ty, PeepholeRewrite LLVMPlusRiscV Γ ty)
  := List.cons ⟨[Ty.riscv RISCV64.Ty.bv], (Ty.riscv RISCV64.Ty.bv), cast_eliminiation_riscv⟩ <| List.nil

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
      %2 = llvm.sub %X, %X : i64 -- this instruction isn ot yet suppported but is in a PR.
      %3 = llvm.add %1, %Y : i64
      %4 = llvm.add %3, %Y : i64
      %5 = llvm.add %3, %4 : i64
      llvm.return %5 : i64
  }]

def llvm01:=
      [LV|{
      ^bb0(%X : i64, %Y : i64 ):
      %1 = llvm.icmp.ugt %X, %Y : i64
      %2 = llvm.sub %X, %X : i64 -- this instruction isn ot yet suppported but is in a PR.
      llvm.return %1 : i1
  }]

set_option maxRecDepth 10000000 -- we set this to avoid the recursion depth error when using the peephole rewriter 

/-- Calculates the amount of steps to be performed within the peephole rewriter for a
given compuation p-/
def fuel_def {d : Dialect} [DialectSignature d] {Γ : Ctxt d.Ty} {eff : EffectKind} {t : d.Ty}
  (p: Com d Γ eff t) : Nat := max (Com.size p) 10


/-
experiment 01:
obsereved best scheduling of the passes, pass ordering problem,
here I first rewriter the binarop operations using the same operand twice.
Then eliminate deadcode. Then apply the lowering pass and then the cast_elimination pass.  -/
def test_peep0_single :  Com LLVMPlusRiscV (Ctxt.ofList [.llvm (.bitvec 64),.llvm (.bitvec 64)]) .pure (.llvm (.bitvec 64)) :=
  multiRewritePeephole (fuel_def llvm00) (@rewritting_patterns (Ctxt.ofList [.llvm (.bitvec 64),.llvm (.bitvec 64)]) (.llvm (.bitvec 64))) llvm00

#eval! test_peep0_single
def test_pep0_dce:= (DCE.dce' test_peep0_single)
#eval! test_pep0_dce

 def selectionPipeFuelSafe {Γl : List LLVMPlusRiscV.Ty} (prog : Com LLVMPlusRiscV (Ctxt.ofList Γl) .pure (.llvm (.bitvec w))  ):=
  let initial_dead_code :=  (DCE.dce' prog).val; -- first we eliminate the inital inefficenices in the code.
  let lowerConst := (multiRewritePeephole (100) (@rewritting_patterns2 (Ctxt.ofList [.llvm (.bitvec 64),.llvm (.bitvec 64)]) (.llvm (.bitvec 64))) initial_dead_code);
  let lower_binOp_self := (multiRewritePeephole (100) (@rewritting_patterns (Ctxt.ofList [.llvm (.bitvec 64),.llvm (.bitvec 64)]) (.llvm (.bitvec 64))) lowerConst); --then we lower all single one operand instructions.
  let remove_llvm_instr := (DCE.dce' lower_binOp_self).val;
  let reconcile_Cast := multiRewritePeephole (100) (reconcile_cast_pass) remove_llvm_instr;
  let remove_dead_Cast := (DCE.dce' reconcile_Cast).val; -- to do think of whether this makes a diff.
  let minimal_cast := (DCE.dce' remove_dead_Cast).val; -- to do: unsrue why apply cast elimination twice
  --let optimize_eq_cast := (CSE.cse' minimal_cast).val; -- we do not use it atm since we get an error when trying to call an unsafe function with the opt tool
  --let out := (DCE.dce' optimize_eq_cast).val;
  --out
  minimal_cast

-- NEED TO CANCONOALIZE THE CASTS

#eval! (selectionPipeFuelSafe llvm00)
