import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
import SSA.Projects.InstCombine.TacticAuto

import SSA.Projects.DCE.DCE
import SSA.Projects.CSE.CSE

import SSA.Projects.PaperExamples.PaperExamples
import SSA.Projects.LLVMRiscV.LLVMAndRiscv


open PoisonOr
open Ctxt.Valuation (nil)
open InstCombine (LLVM)
open InstCombine.LLVM.Ty (bitvec)







/-!

# LeanMLIR

LeanMLIR is our framework for modelling the semantics of MLIR dialects, and
reasoning about MLIR programs in those dialects.

* Easy-to-use (for a theorem-prover based project)
  * Embedded DSL for MLIR programs
  * Proof automation & decision procedures

* The core is dialect-agnostic; we have projects for:
  * LLVM arithmetic instructions
  * hardware (`dc`, `comb`) (@luisacicolini)
  * instruction selection (@salinhkuhn)
  * Fully-homomorphic encryption proof-of-concept

-/





/-! ## LLVM Syntax -/

-- We can write MLIR directly in our Lean file
def addSelf := [llvm|{
  ^bb(%0 : i64):
    %1 = llvm.add %0, %0 : i64
    llvm.return %1 : i64
}]

-- Our semantics are executable!
/-- info: (value 0x0000000000000054#64) -/
#guard_msgs in #eval addSelf.denote (nil ::ᵥ value 42#64)
example :
    addSelf.denote (nil ::ᵥ value 42#64)
    = value 84#64 :=
  rfl





/-! ## Proving a Peephole Rewrite -/

def mulTwo := [llvm| {
  ^bb(%0 : i64):
    %c = llvm.mlir.constant(2) : i64
    %1 = llvm.mul %0, %c : i64
    llvm.return %1 : i64
}]

-- We can prove the correctness of this peephole automatically
def addSelf_eq_mulTwo : PeepholeRewrite LLVM [bitvec 64] (bitvec 64) where
  lhs := addSelf
  rhs := mulTwo
  correct := by
    unfold addSelf mulTwo
    simp_peephole
    -- ^^ First, we simplify the generic denotation
    --    machinery into LLVM semantic operations
    simp_alive_undef
    -- ^^ Then, we unfold those definitions
    simp_alive_case_bash
    simp_alive_split
    -- ^^ And do case analyses to eliminate
    --    trivial poison cases
    bv_decide
    -- ^^ Finally, we're left with a pure bitvector goal that bv_decide solves





/-! ## Applying a rewrite -/

def aLargerProgram := [llvm| {
  ^bb(%x : i64):
    %y = llvm.add %x, %x : i64
    %z = llvm.add %y, %y : i64
    %a = llvm.add %z, %z : i64
    llvm.return %a : i64
}]

-- We can apply the rewrite!
def postRewrite :=
  rewritePeephole 99 addSelf_eq_mulTwo aLargerProgram

#eval IO.println postRewrite

-- We have common-subexpression-elimination!
unsafe def postCSE := CSE.cse' postRewrite

-- And dead-code-elimination!
#eval do
  let ⟨_Γ, _, com, _⟩ := DCE.dce postCSE.1
  IO.println com





/-!
## Future Directions

We're currently working towards proper LLVM
side-effects (i.e., immediate UB and memory).
There are roughly two ways I can think of framing
this work:

* Alive-but-verified
* A modular toolkit for building verified compilers

-/




/-!
## Other things we can talk about
-/

-- A simple example of defining a dialect
#check ToyNoRegion.Simple
-- How LLVM's pretty syntax works
#check MLIR.EDSL.PrettyEDSL


-- LLVM / RiscV Hybrid Dialect
#check LLVMAndRi
