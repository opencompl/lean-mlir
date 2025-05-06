
import SSA.Core.Tactic
import SSA.Core.ErasedContext
import SSA.Core.HVector
import SSA.Core.EffectKind
import SSA.Core.Util
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.Tactic
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.Base
import SSA.Projects.InstCombine.ForLean
import Lean
import SSA.Core.Framework
import SSA.Core.Tactic
import SSA.Core.Util
import SSA.Core.MLIRSyntax.GenericParser
import SSA.Core.MLIRSyntax.EDSL
import SSA.Projects.InstCombine.Tactic
import Mathlib.Tactic.Ring
import Mathlib.Logic.Function.Iterate
import SSA.Core.Framework
import SSA.Core.Tactic
import SSA.Core.Util
import SSA.Core.MLIRSyntax.GenericParser
import SSA.Core.MLIRSyntax.EDSL
import SSA.Projects.InstCombine.Tactic
import SSA.Projects.DCE.DCE
import Mathlib.Tactic.Ring
import SSA.Projects.RISCV64.Syntax
import SSA.Projects.RISCV64.Base
import SSA.Projects.RISCV64.Semantics
import SSA.Projects.RISCV64.PrettyEDSL
import SSA.Pipeline.Peephole_Rewrites.RiscVRefinement
open MLIR AST in

open DCE
open RISCV64 -- acceses the RISCV64 dialect.
open RISCVExpr -- acceses the RISCV64 version to simplify making expression.
-- additional lemmas introduced for the proofs.

--@[simp] --> to do: fix it
theorem get_cons_succ0 {A : α → Type*} {a : α} {as : List α}
  (e : A a) (vec : HVector A as) (i : Fin as.length) :
  (e::ₕvec).get i.succ = vec.get i := by rfl -- extracting the i succ elem is like extracting the i elem from the remaining list

--@[simp]
--theorem get_cons_succ {A : α → Type*} {a : α} {as : List α}
  --(e : A a) (vec : HVector A as) (i : Fin (as.length)):
  --((e::ₕvec)).get ((i + 1)) = ((vec) : HVector A (as)).get (i : Fin (as.length))  := by rfl -- extracting the i succ elem is like extracting the i elem from the remaining list

--@[simp]
theorem get_cons_1 {A : α → Type*} {a b: α} {as : List α}
  (e : A a) (f : A b) (vec : HVector A as)  :
--((e::ₕ (f ::ₕ vec)) : HVector A (a :: b :: as)).get ⟨1, by simp⟩ = f := by rfl -- extracting the i succ elem is like extracting the i elem from the remaining list
  ((e::ₕ (f ::ₕ vec)) : HVector A (a :: b :: as)).get (1 : Fin (as.length + 2)) = f := by rfl -- extracting the i succ elem is like extracting the i elem from the remaining list


def lhs_and0 : Com RV64 (Ctxt.ofList [.bv]) .pure .bv :=
  [RV64_com| {
  ^entry (%0: !i64 ):
    %1 = "const" () { val = 0 : !i64  } : ( !i64 ) -> (!i64)
    %2 = "and" (%0, %1) : ( !i64, !i64 ) -> (!i64)
    "ret" (%2) : ( !i64) -> ()
}]
def rhs_and0 : Com RV64 (Ctxt.ofList [.bv]) .pure .bv :=
  [RV64_com| {
  ^entry (%0 : !i64 ):
    %1 = "const" () { val = 0 : !i64  } : ( !i64 ) -> (!i64)
    "ret" (%1) : ( !i64 ) -> ()
}]
-- this theorem proofs that for every context if lhs and rhs are invoked with the same context the can be rewritten into eachother
theorem peephole01 : (rhs_and0  ⊑ᵣ lhs_and0) := by
  unfold lhs_and0 rhs_and0
  simp_alive_peephole
  simp
  unfold RV64Semantics.RTYPE_pure64_RISCV_AND
  simp
  unfold RiscvInstrSeqRefines
  rfl

-- defined a simple peephole rewrite for risc-v
def rewrite_and0 : PeepholeRewrite RV64 [.bv] .bv :=
  { lhs:= [RV64_com| {
  ^entry (%0: !i64 ):
    %1 = "const" () { val = 0 : !i64  } : ( !i64 ) -> (!i64)
    %2 = "and" (%0, %1) : ( !i64, !i64 ) -> (!i64)
    "ret" (%2) : ( !i64) -> ()
}] ,
    rhs:= [RV64_com| {
  ^entry (%0 : !i64 ):
    %1 = "const" () { val = 0 : !i64  } : ( !i64 ) -> (!i64)
    "ret" (%1) : ( !i64 ) -> ()
}],
    correct :=
    by
        funext Γv
        simp_peephole
        simp
        unfold RV64Semantics.RTYPE_pure64_RISCV_AND
        simp_peephole
        bv_decide
}
-- zero optimization
def ex1_rewritePeepholeAtO0 :
    Com RV64 (Ctxt.ofList [.bv]) .pure .bv := rewritePeepholeAt rewrite_and0 0 lhs_and0

#eval! ex1_rewritePeepholeAtO0
-- optimized code
def ex1_rewritePeepholeAtO1 :
    Com RV64 (Ctxt.ofList [.bv]) .pure .bv := rewritePeepholeAt rewrite_and0 1 lhs_and0


#eval ex1_rewritePeepholeAtO1

-- defined function to return eexpressio in RDialect
theorem ex1_rewritePeepholeAtExpectedOutcome :
  ex1_rewritePeepholeAtO0 =   Com.var (const 0) (
                                Com.var (and ⟨1, by simp[Ctxt.snoc]⟩ ⟨0, by simp[Ctxt.snoc]⟩) -- %out = %x + %c0
                                  (Com.ret ⟨0, by simp[Ctxt.snoc]⟩))
:= by
unfold ex1_rewritePeepholeAtO0
unfold rewritePeepholeAt
simp
unfold rewriteAt
simp_peephole
native_decide

-- important to remeber that rewrites insert to rhs at the last statement of the olhs and then we could run DCE
theorem ex1_rewritePeepholeAtExpectedOutcome1 :
  ex1_rewritePeepholeAtO1 =   Com.var (const 0) (
                                Com.var (and ⟨1, by simp[Ctxt.snoc]⟩ ⟨0, by simp[Ctxt.snoc]⟩) (
                                  (Com.var (const 0 ))
                                  (Com.ret ⟨0, by simp[Ctxt.snoc]⟩)))
    := by
    simp [ex1_rewritePeepholeAtO1]
    native_decide
-- found out that they will just insert the new code at the position of the last instr

-- proving that after executing the rewritePeepholeAt01 its not the same anymore
theorem rewriteDidSomething : ex1_rewritePeepholeAtO1 ≠  lhs_and0 := by
  simp [ex1_rewritePeepholeAtO1, lhs_and0]
  native_decide

-- prove that zero optimiztion is the identity
theorem rewriteDidSomethingDidNothing : ex1_rewritePeepholeAtO0 =  lhs_and0 := by
  simp [ex1_rewritePeepholeAtO1, lhs_and0]
  native_decide

-- had to give a default instance and not just list but ctxt of list
def ex12_rewritePeepholeRecrusivly :
  Com RV64 (Ctxt.ofList [.bv]) .pure .bv :=
    rewritePeepholeRecursively (fuel := 3) rewrite_and0 lhs_and0

theorem didRecursivlyDoSomething : ex12_rewritePeepholeRecrusivly ≠ lhs_and0 := by
  simp [ex12_rewritePeepholeRecrusivly, lhs_and0]
  native_decide
-- they actual code gets expanded
theorem expectedRecursionResult : ex12_rewritePeepholeRecrusivly = Com.var (const 0) (
                                Com.var (and ⟨1, by simp[Ctxt.snoc]⟩ ⟨0, by simp[Ctxt.snoc]⟩) (
                                  (Com.var (const 0 ))
                                  (Com.ret ⟨0, by simp[Ctxt.snoc]⟩)))
                                  := by
                                  simp [ex12_rewritePeepholeRecrusivly]
                                  native_decide

-- define the righthandside and the lefthandside
def lhs_add0 : Com RV64 [.bv] .pure .bv :=
  [RV64_com| {
  ^entry (%0: !i64 ):
    %1 = "const" () { val = 0 : !i64  } : ( !i64 ) -> (!i64)
    %2 = "add" (%0, %1) : ( !i64, !i64 ) -> (!i64)
    "ret" (%2) : ( !i64) -> ()
}]

def rhs_add0 : Com RV64 [.bv] .pure .bv :=
  [RV64_com| {
  ^entry (%0 : !i64 ):
    "ret" (%0) : ( !i64 ) -> ()
}]
-- proof that the rewrite holds, meaning that the rhs is a refinement of the lhs
theorem add0_peepholeRewrite : rhs_add0 ⊑ᵣ lhs_add0 := by
  unfold lhs_add0 rhs_add0
  simp_alive_peephole
  unfold RV64Semantics.RTYPE_pure64_RISCV_ADD
  unfold RiscvInstrSeqRefines
  bv_decide

-- define the peephole rewrite
def rewrite_add0 : PeepholeRewrite RV64 [.bv] .bv :=
  { lhs:= [RV64_com| {
  ^entry (%0: !i64 ):
    %1 = "const" () { val = 0 : !i64  } : ( !i64 ) -> (!i64)
    %2 = "add" (%0, %1) : ( !i64, !i64 ) -> (!i64)
    "ret" (%2) : ( !i64) -> ()
}],
    rhs:= [RV64_com| {
  ^entry (%0 : !i64 ):
    "ret" (%0) : ( !i64 ) -> ()
}],
    correct :=
    by
        --funext Γv
        simp_peephole --using Γv
        simp
        unfold RV64Semantics.RTYPE_pure64_RISCV_ADD
        bv_decide
}




-- important to remeber : are DeBruijn indices thus the first varible added to the context will have the last index then
-- applying the peephole rewrite
def runRewriteExplicitOnce : Com RV64 [.bv] .pure .bv := rewritePeepholeAt rewrite_add0 1 lhs_add0
def runRewriteExplicitNone : Com RV64 [.bv] .pure .bv := rewritePeepholeAt rewrite_add0 0 lhs_add0 -- any index not equal to one should work

#eval runRewriteExplicitOnce

def expectedOptimization0 : runRewriteExplicitNone = lhs_add0 := by native_decide

def expectedOptimization01 : runRewriteExplicitOnce ≠ lhs_add0 := by native_decide

theorem  expectedOptimization01Program : runRewriteExplicitOnce =
Com.var (const 0) (
  Com.var (add ⟨1, by simp[Ctxt.snoc]⟩ ⟨0, by simp[Ctxt.snoc]⟩) -- x + 0
      (Com.ret ⟨2, by simp[Ctxt.snoc]⟩)) -- 0 where 2 refers to variable x
   := by native_decide

theorem  expectedOptimization00Program : runRewriteExplicitNone =
Com.var (const 0) (
  Com.var (add ⟨1, by simp[Ctxt.snoc]⟩ ⟨0, by simp[Ctxt.snoc]⟩) -- x + 0
      (Com.ret ⟨0, by simp[Ctxt.snoc]⟩)) -- 0 where 0 refers to variable x+0
   := by
  unfold runRewriteExplicitNone rewritePeepholeAt
  unfold rewriteAt
  simp_peephole
  native_decide

def applyDCE1 : Com RV64 [.bv] .pure .bv :=
  (DCE.dce' runRewriteExplicitOnce)

#eval applyDCE1

def applyDCE2 : Com RV64 [.bv] .pure .bv :=
  (DCE.dce' runRewriteExplicitNone)

#eval applyDCE2

-- applies dead code elimination once and now can apply a second time until reach a fixed point ?
-- this eliminated the first add
theorem expectedDCECorrect : applyDCE1 = Com.var (const 0) (Com.ret (⟨1, by simp [Ctxt.snoc] ⟩ )) :=
  by native_decide

def dceCode : Com RV64 [.bv] .pure .bv := Com.var (const 0) (Com.ret (⟨1, by simp [Ctxt.snoc] ⟩ ))



def comSize{Γ : List Ty} (com: Com RV64 Γ .pure .bv ) : Nat :=
  match com with
  |Com.ret _ => 1
  |Com.var _ c' => 1 + comSize c'

-- make type annotations for Lean
-- after running dce twice
theorem runDCEagain : DCE.dce' dceCode  =( Com.ret ⟨0 , by simp [Ctxt.snoc]⟩ : Com RV64 [.bv] .pure .bv ) := by native_decide

def recRunner (current : Com RV64 [.bv] .pure .bv) (before : Com RV64 [.bv] .pure .bv) (fuel : Nat) : Com RV64 [.bv] .pure .bv :=
  if h : (current == before) ∨ (fuel ≤ 0) then current
  else
    let newCode := (DCE.dce' current).val
    recRunner newCode current (fuel-1)

-- DCE applier
def  exhaustivlyDCE (comBefore :  Com RV64 [.bv] .pure .bv ) : Com RV64 [.bv] .pure .bv :=
  recRunner (comBefore ) ((DCE.dce' comBefore).val)  (comSize comBefore) -- run DCE size of Com step bc at max we eliminate all lines



def appliedDCE : Com RV64 [.bv] .pure .bv := exhaustivlyDCE runRewriteExplicitOnce

#eval appliedDCE

theorem dce_runner_applied_exhaustivly : appliedDCE =  Com.ret (⟨0, by simp [Ctxt.snoc] ⟩ )
:= by native_decide -- worked aka dead code elimination was applied recurisvly

-- test to check wether the DCE works
def redunantCom : Com RV64 [.bv] .pure .bv :=
Com.var (const 5) (Com.var (const 4) (Com.var (const 3) (Com.var (const 2) (Com.ret ⟨0, by simp [Ctxt.snoc] ⟩ ))))

theorem applyDCE3 :
  (exhaustivlyDCE redunantCom) =  (Com.var (const 2) (Com.ret ⟨0, by simp [Ctxt.snoc] ⟩ )) := by native_decide



-- this will run the dce until it reaches a fixed point
theorem DCEonUnoptimizedCode : applyDCE2 = Com.var (const 0) (
  Com.var (add ⟨1, by simp[Ctxt.snoc]⟩ ⟨0, by simp[Ctxt.snoc]⟩) -- x + 0
      (Com.ret ⟨0, by simp[Ctxt.snoc]⟩)) := by native_decide


-- try to fully optimize this code
def egLhs : Com RV64 [.bv] .pure .bv :=
  [RV64_com| {
  ^entry (%0: !i64 ):
    %1 = "const" () { val = 0 : !i64  } : ( !i64 ) -> (!i64)
    %2 = "add" (%0, %1) : ( !i64, !i64 ) -> (!i64)
    %4 = "const" () { val = 0 : !i64  } : ( !i64 ) -> (!i64)
    %5 = "and" (%0, %4) : ( !i64, !i64 ) -> (!i64)
    "ret" (%5) : ( !i64) -> ()
}]


def egLhs2 : Com RV64 [.bv] .pure .bv :=
  [RV64_com| {
  ^entry (%0: !i64 ):
    --%1 = "RV64.const" () { val = 0 : !i64  } : ( !i64 ) -> (!i64)
   -- %2 = "RV64.add" (%0, %0) : ( !i64, !i64 ) -> (!i64)
    %4 = "const" () { val = 0 : !i64  } : ( !i64 ) -> (!i64)
    %5 = "and" (%0, %4) : ( !i64, !i64 ) -> (!i64)
    "ret" (%5) : ( !i64) -> ()
}]
def egLhs_rewritePeepholeRecrusivly :
  Com RV64 [.bv] .pure .bv :=
    rewritePeepholeRecursively (fuel := 100) rewrite_and0 egLhs

def egLhs_rewritePeepholeRecrusivly2 :
  Com RV64 [.bv] .pure .bv :=
    rewritePeepholeRecursively (fuel := 1000) rewrite_and0 egLhs2


-- TO DO








/-
-- ASK how the patter matcher works bc I think its exactly mathes the patterns linear and cannot cope with an instruction in between
def checkRewriteWasAsExpectedRec2 : egLhs_rewritePeepholeRecrusivly =Com.var (add ⟨0, by simp[Ctxt.snoc]⟩ ⟨0, by simp[Ctxt.snoc]⟩) (Com.var (const 0 ) (Com.var (and ⟨2, by simp[Ctxt.snoc]⟩ ⟨0, by simp[Ctxt.snoc]⟩ ) (Com.var (const 0) (Com.ret ⟨0, by simp[Ctxt.snoc]⟩))))
:= by native_decide
-/

def checkRewriteWasAsExpectedRec : egLhs_rewritePeepholeRecrusivly2 =   (Com.var (const 0 ) (Com.var (and ⟨1, by simp[Ctxt.snoc]⟩ ⟨0, by simp[Ctxt.snoc]⟩ ) (Com.var (const 0) (Com.ret ⟨0, by simp[Ctxt.snoc]⟩))))
:= by native_decide

-- works when we explcitly state the position to rewrite
def egLhs_rewritePeepholeRecrusivly3 :
  Com RV64 [.bv] .pure .bv :=
    rewritePeepholeAt rewrite_and0 2 egLhs2
def egLhs_rewritePeepholeRecrusivly4 :
  Com RV64 [.bv] .pure .bv :=
    rewritePeepholeAt  rewrite_and0 3 egLhs

/-
-- these cases work where we explicitly state where to rewrite, when calling recurison the optimization doesnt work yet.
def checkRewriteWasAsExpected2 : egLhs_rewritePeepholeRecrusivly3 =Com.var (add ⟨0, by simp[Ctxt.snoc]⟩ ⟨0, by simp[Ctxt.snoc]⟩) (Com.var (const 0 ) (Com.var (and ⟨2, by simp[Ctxt.snoc]⟩ ⟨0, by simp[Ctxt.snoc]⟩ ) (Com.var (const 0) (Com.ret ⟨0, by simp[Ctxt.snoc]⟩))))
:= by native_decide


def runDCEonTop :  exhaustivlyDCE egLhs_rewritePeepholeRecrusivly3 = (Com.var (const 0) (Com.ret ⟨0, by simp[Ctxt.snoc]⟩)) := by native_decide

-/
def checkRewriteWasAsExpected : egLhs_rewritePeepholeRecrusivly4 = Com.var  (const 0) ((Com.var (add ⟨1, by simp[Ctxt.snoc]⟩ ⟨0, by simp[Ctxt.snoc]⟩) (Com.var (const 0 ) (Com.var (and ⟨3, by simp[Ctxt.snoc]⟩ ⟨0, by simp[Ctxt.snoc]⟩ ) (Com.var (const 0) (Com.ret ⟨0, by simp[Ctxt.snoc]⟩))))))
:= by native_decide






@[simp_denote] lemma toType_bv :
  TyDenote.toType (.bv : RV64.Ty) = BitVec 64 := rfl


-- add rd rs1 rs1 <-> slli rd rs1 $1
theorem peephole02 :
  [RV64_com| {
  ^entry (%0 : !i64 ):
    %1 = "RV64.slli" (%0) { shamt = 1 : !i64 } : (!i64) -> (!i64)
    "return" (%1) : (!i64 ) -> ()
  }]
  ⊑ᵣ
  [RV64_com| {
    ^entry (%0: !i64 ):
    %1 = "RV64.add" (%0, %0) : (!i64, !i64) -> (!i64)
    "return" (%1) : (!i64) -> ()
    }] := by
    simp_alive_peephole
    simp only [BitVec.ofInt_ofNat]
    unfold RV64Semantics.SHIFTIOP_pure64_RISCV_SLLI RV64Semantics.RTYPE_pure64_RISCV_ADD
    unfold RiscvInstrSeqRefines
    bv_decide

def rewrite_02 : PeepholeRewrite RV64 [.bv] .bv :=
  { lhs:= [RV64_com| {
  ^entry (%0 : !i64 ):
    %1 = "RV64.slli" (%0) { shamt = 1 : !i64 } : (!i64) -> (!i64)
    "return" (%1) : (!i64 ) -> ()
  }],
    rhs:= [RV64_com| {
    ^entry (%0: !i64 ):
    %1 = "RV64.add" (%0, %0) : (!i64, !i64) -> (!i64)
    "return" (%1) : (!i64) -> ()
    }],
    correct :=
    by
        --funext Γv
        simp_peephole --using Γv
        simp
        unfold RV64Semantics.SHIFTIOP_pure64_RISCV_SLLI RV64Semantics.RTYPE_pure64_RISCV_ADD
        bv_decide
}

-- conitue writting the peephole optimizations

/-  add rd rs1 rs1
    add rd rd rd
    ==
    slli rd rs1 $2
-/

def rewrite_03 : PeepholeRewrite RV64 [.bv] .bv :=
{ lhs:=[RV64_com| {
    ^entry (%0: !i64 ):
    %1 = "RV64.add" (%0, %0) : (!i64, !i64) -> (!i64)
    %2 = "RV64.add" (%1, %1) : (!i64, !i64) -> (!i64)
    "return" (%2) : (!i64) -> ()
    }],
    rhs:= [RV64_com| {
    ^entry (%0 : !i64 ):
      %1 = "RV64.slli" (%0) { shamt = 2 : !i64 } : ( !i64) -> (!i64)
      "return" (%1) : ( !i64 ) -> ()
  }],
    correct :=
    by
        -- funext Γv
        simp_peephole --using Γv depending on branch the new tactic is avaible or not.
        simp
        unfold RV64Semantics.RTYPE_pure64_RISCV_ADD  RV64Semantics.SHIFTIOP_pure64_RISCV_SLLI
        simp
        intro someE
        have : 4 * someE = someE + someE + (someE + someE)  := by bv_decide
        simp [← this]
        bv_decide
}

  theorem addFourth_eq_shiftLeftTwice :
    [RV64_com| {
    ^entry (%0: !i64 ):
    %1 = "RV64.add" (%0, %0) : (!i64, !i64) -> (!i64)
    %2 = "RV64.add" (%1, %1) : (!i64, !i64) -> (!i64)
    "return" (%2) : (!i64) -> ()
    }].denote =
    [RV64_com| {
    ^entry (%0 : !i64 ):
      %1 = "RV64.slli" (%0) { shamt = 2 : !i64 } : ( !i64) -> (!i64)
      "return" (%1) : ( !i64 ) -> ()
  }].denote := by
    -- funext Γv
    simp_peephole --using Γv
    simp
    unfold RV64Semantics.RTYPE_pure64_RISCV_ADD RV64Semantics.SHIFTIOP_pure64_RISCV_SLLI
    simp [BitVec.add_eq, BitVec.toNat_ofNat, Nat.reducePow, Nat.reduceMod, BitVec.shiftLeft_eq]
    intro e
    show @Eq (BitVec _) (e + e + (e + e)) (e <<< 2) -- used to help Lean to discover the type of the operation
    --show (e + e + (e + e)) = (e <<< 2) also works
    bv_decide

/-  and rd rs1 $0
    ==
    $0
-/
  theorem andZero_eq_zero :
    [RV64_com| {
    ^entry (%0: !i64 ):
      %1 = "RV64.const" () { val = 0 : !i64  } : ( !i64 ) -> (!i64)
      %2 = "RV64.and" (%0, %1) : ( !i64, !i64 ) -> (!i64)
      "return" (%2) : ( !i64) -> ()
  }].denote =
    [RV64_com| {
    ^entry (%0 : !i64 ):
      %1 = "RV64.const" () { val = 0 : !i64  } : ( !i64 ) -> (!i64)
      "return" (%1) : ( !i64 ) -> ()
  }].denote := by
      -- funext Γv
      simp_peephole --  using Γv
      simp
      unfold RV64Semantics.RTYPE_pure64_RISCV_AND
      bv_decide

/-  mul rd rs1 $1
    ==
    slli rd rs1 $0
-/
  theorem mulOne_eq_shiftZero :
    [RV64_com| {
    ^entry (%0: !i64 ):
      %1 = "RV64.const" () { val = 1 : !i64  } : (!i64) -> (!i64)
      %2 = "RV64.mulu" (%0, %1) : ( !i64, !i64 ) -> (!i64)
      "return" (%2) : ( !i64 ) -> ()
  }].denote =
    [RV64_com| {
    ^entry (%0 : !i64 ):
      %1 = "RV64.slli" (%0) { shamt = 0 : !i64 } : ( !i64) -> (!i64)
      "return" (%1) : ( !i64 ) -> ()
  }].denote := by
      -- funext Γv
      simp_peephole -- using Γv
      simp
      unfold RV64Semantics.MUL_pure64_fff RV64Semantics.SHIFTIOP_pure64_RISCV_SLLI
      intro e
      show @Eq (BitVec _) _ _
      simp [get_cons_1]
      bv_decide

/-
    sub rd rs1 rs1
    xor rd rd rs2
    return rd
    ==
    return rs2
-/
  theorem xor_sub : -- taken from the peephole rewrite
    [RV64_com| {
      ^entry (%r1: !i64, %r2: !i64 ) :
        %0 = "RV64.sub" (%r1, %r1) : (!i64,!i64 ) -> (!i64)
        %1 = "RV64.xor" (%0,%r2) : (!i64,!i64 ) -> (!i64)
      "return" (%1) : (!i64 ) -> ()
    }].denote =
    [RV64_com| {
      ^entry (%r1: !i64, %r2: !i64 ) :
       "return" (%r2) : (!i64 ) -> ()
      }].denote := by
      -- funext Γv
      simp_peephole -- using Γv
      unfold RV64Semantics.RTYPE_pure64_RISCV_XOR RV64Semantics.RTYPE_pure64_RISCV_SUB
      intros e1 e2
      show @Eq (BitVec 64) _ _
      --show @Eq (BitVec 64) ((s.sub s).xor e) e
      bv_decide


/-  xor rd x1 x1
    return rd
    ==
    return $0
-/
def RISCVEg1 := [RV64_com| {
  ^entry (%x1: !i64):
    %1 = "RV64.xor" (%x1, %x1) : (!i64, !i64) -> (!i64)
    "return" (%1) : (!i64) -> ()
}].denote

def RISCVZero := [RV64_com| {
  ^entry (%x1: !i64):
    %1 =  "RV64.const" () { val = 0 : !i64  } : (!i64) -> (!i64)
    "return" (%1) : (!i64) -> ()
}].denote

theorem xor_eq_zero :
  RISCVEg1 = RISCVZero := by
  unfold RISCVEg1 RISCVZero
  -- funext Γv
  simp_peephole -- using Γv
  intro e
  unfold RV64Semantics.RTYPE_pure64_RISCV_XOR
  -- rw[HVector.cons_get_zero]
  show @Eq (BitVec 64) _ _
  bv_decide


/-
-/
def RISCVEg25 := [RV64_com| {
  ^entry (%0: !i64 ):
    %1 = "RV64.const" () { val = 2 : !i64  } : ( !i64 ) -> (!i64)
    %2 = "RV64.mulu" (%0, %1)  : ( !i64, !i64 ) -> (!i64)
    "return" (%2) : ( !i64, !i64 ) -> ()
}].denote

def RISCVEg26 := [RV64_com| {
  ^entry (%0: !i64, %1: !i64 ):
    %2 = "RV64.mulu" (%0, %1)  : ( !i64, !i64 ) -> (!i64)
    "return" (%2) : ( !i64, !i64 ) -> ()
}].denote



-- section where I start to rewrite things from alive

/-  add rd rs1 rs1
    ==
    slli rd rs1 1
-/
def RISCVE_AddSub_src := [RV64_com| {
  ^entry (%0: !i64 ):
    %v1 = "RV64.add" (%0, %0) : ( !i64, !i64 ) -> (!i64)
    "return" (%v1) : ( !i64, !i64 ) -> ()
}].denote

def RISCVE_AddSub_opt := [RV64_com| {
  ^entry (%0: !i64 ):
    %v1 = "RV64.slli" (%0) { shamt = 1 : !i64 } : ( !i64) -> (!i64)
    "return" (%v1) : ( !i64, !i64 ) -> ()
}].denote

theorem RISCV64_AddSub : RISCVE_AddSub_src = RISCVE_AddSub_opt := by
  unfold RISCVE_AddSub_src RISCVE_AddSub_opt
  --funext Γv
  simp_peephole --  using Γv
  -- intro e
  unfold RV64Semantics.RTYPE_pure64_RISCV_ADD RV64Semantics.SHIFTIOP_pure64_RISCV_SLLI
  -- rw [HVector.cons_get_zero, HVector.cons_get_zero]
  bv_decide


def RISCVE_AddSub1164_src := [RV64_com| {
  ^entry (%a: !i64, %b: !i64 ):
    %v1 = "RV64.const" () { val = 0 : !i64  } : ( !i64 ) -> (!i64)
    %v2 = "RV64.sub" (%a, %v1 ) : ( !i64, !i64 ) -> (!i64)
    %v3 = "RV64.add" (%v2 , %b ) : ( !i64, !i64 ) -> (!i64)
    "return" (%v3) : (!i64, !i64) -> ()
}].denote

def RISCVE_AddSub1164_opt := [RV64_com| {
  ^entry (%a: !i64, %b: !i64 ):
    %v1 = "RV64.add" (%a, %b) : ( !i64, !i64 ) -> (!i64)
    "return" (%v1) : (!i64, !i64) -> ()
}].denote

theorem RISCV64_AddSub1164 :
  RISCVE_AddSub1164_src = RISCVE_AddSub1164_opt := by
  unfold RISCVE_AddSub1164_opt RISCVE_AddSub1164_src
  -- funext Γv
  simp_peephole --  using Γv
  intro e1 e2
  unfold RV64Semantics.RTYPE_pure64_RISCV_ADD RV64Semantics.RTYPE_pure64_RISCV_SUB
  -- simp [HVector.cons_get_zero]
  bv_decide

/-  sub rd1 v1 $0 -- -a
    add rd2 rd1 b -- (-a) + b
    return rd2 -- (-a) + b
    ==
    sub rd b v1
-/
def RISCVE_AddSub1164_src2 := [RV64_com| {
  ^entry (%a: !i64, %b: !i64 ):
    %v1 = "RV64.const" () { val = 0 : !i64  } : ( !i64 ) -> (!i64)
    %v2 = "RV64.sub" ( %v1, %a ) : ( !i64, !i64 ) -> (!i64) -- 0-a
    %v3 = "RV64.add" (%b, %v2 ) : ( !i64, !i64 ) -> (!i64) -- b - a
    "return" (%v3) : (!i64, !i64) -> ()
}].denote


def RISCVE_AddSub1164_opt2 := [RV64_com| {
  ^entry (%a: !i64, %b: !i64 ):
    %v1 = "RV64.const" () { val = 0 : !i64  } : ( !i64 ) -> (!i64) -- 0
    %v2 = "RV64.sub" (%v1, %a ) : ( !i64, !i64 ) -> (!i64) -- 0 - a basically dead code
    %v3 = "RV64.sub" (  %b, %a ) : ( !i64, !i64 ) -> (!i64) -- b- a
    "return" (%v3) : (!i64, !i64) -> ()
}].denote

theorem RISCV64_AddSub1164_2 :
  RISCVE_AddSub1164_src2 = RISCVE_AddSub1164_opt2 := by
  unfold RISCVE_AddSub1164_opt2 RISCVE_AddSub1164_src2
  -- funext Γv
  simp_peephole --  using Γv
  intro e1 e2
  unfold RV64Semantics.RTYPE_pure64_RISCV_SUB RV64Semantics.RTYPE_pure64_RISCV_ADD
  simp [HVector.cons_get_zero]
  show @Eq (BitVec 64) _ _
  bv_decide

def RV64_DivRemOfSelect_src := [RV64_com| {
  ^entry (%c: !i64, %y: !i64, %x: !i64):
    %c0 = "RV64.const" () { val = 0 : !i64  } : ( !i64 ) -> (!i64) -- 0
    %v1 = "RV64.czero.nez" (%y,  %c0 ) : ( !i64, !i64 ) -> (!i64) -- if c0 is zero then y else 0 --> fixed to y
    %v2 = "RV64.divu" (%x,  %v1 ) : ( !i64, !i64 ) -> (!i64) -- x / v1
    "return" (%v2) : (!i64, !i64,!i64 ) -> ()
}].denote

def RV64_DivRemOfSelect_opt := [RV64_com| {
  ^entry (%c: !i64, %y: !i64, %x: !i64):
    %v1 = "RV64.divu" ( %x, %y)  : ( !i64, !i64 ) -> (!i64) -- x / y
    "return" (%v1) : (!i64) -> ()
}].denote

theorem RV64_DivRemOfSelect :
 RV64_DivRemOfSelect_src = RV64_DivRemOfSelect_opt :=
  by
  unfold RV64_DivRemOfSelect_src RV64_DivRemOfSelect_opt
  -- funext Γv
  simp_peephole -- using Γv
  intro e1 e2
  unfold RV64Semantics.ZICOND_RTYPE_pure64_RISCV_RISCV_CZERO_NEZ RV64Semantics.DIV_pure64_unsigned
  simp only [BitVec.ofInt_ofNat, BitVec.zero_eq, ↓reduceIte, Int.ofNat_eq_coe, Int.natCast_eq_zero,
    Int.reduceNeg, implies_true]

def RISCVEgDCE_src := [RV64_com| {
  ^entry (%x1: !i64):
    %0 = "RV64.add" (%x1, %x1) : (!i64, !i64) -> (!i64) -- dead code not used
    %1 = "RV64.add" (%x1, %x1) : (!i64, !i64) -> (!i64)
    "return" (%1) : (!i64) -> ()
}].denote

def RISCVDCE_opt := [RV64_com| {
  ^entry (%x1: !i64):
    %0 = "RV64.add" (%x1, %x1) : (!i64, !i64) -> (!i64)
    "return" (%0) : (!i64) -> ()
}].denote

theorem DCE1 :
  RISCVEgDCE_src = RISCVDCE_opt := by
    unfold RISCVEgDCE_src RISCVDCE_opt
    funext Γv
    simp_peephole -- using Γv



/-
%r = sdiv 1, %X
  =>
%inc = add %X, 1
%c = icmp ult %inc, 3
%r = select %c, %X, 0
-/


/-
def alive_DivRemOfSelect_src (w : Nat) :=
  [llvm(w)| {
  ^bb0(%c: i1, %y : _, %x : _):
    %c0 = llvm.mlir.constant(0) : _
    %v1 = llvm.select %c, %y, %c0
    %v2 = llvm.udiv %x,  %v1
    llvm.return %v2
  }]
def alive_DivRemOfSelect_tgt (w : Nat) :=
  [llvm(w)| {
  ^bb0(%c: i1, %y : _, %x : _):
    %v1 = llvm.udiv %x, %y
    llvm.return %v1
  }]
-/

/-
%r = sdiv 1, %X
  =>
%inc = add %X, 1
%c = icmp ult %inc, 3
%r = select %c, %X, 0
-/


/-
  ^entry(%0 : ToyRegion.Ty.int):
    %1 = ToyRegion.Op.const 0 : () → (ToyRegion.Ty.int)
    %2 = ToyRegion.Op.add (%1, %0) : (ToyRegion.Ty.int, ToyRegion.Ty.int) → (ToyRegion.Ty.int)
    %3 = ToyRegion.Op.iterate 0 (%2) ({
      ^entry(%0 : ToyRegion.Ty.int):
        %1 = ToyRegion.Op.const 0 : () → (ToyRegion.Ty.int)
        %2 = ToyRegion.Op.add (%1, %0) : (ToyRegion.Ty.int, ToyRegion.Ty.int) → (ToyRegion.Ty.int)
        return %2 : (ToyRegion.Ty.int) → ()
    }) : (ToyRegion.Ty.int) → (ToyRegion.Ty.int)
    return %3 : (ToyRegion.Ty.int) → ()
}
-/
