import SSA.Projects.RISCV64.Pipeline.LLVMAndRiscv
import SSA.Projects.RISCV64.Pipeline.Refinement
import SSA.Projects.RISCV64.all

/-!
## Functionality
This file contains rewrites for the Peephole Rewriter to eliminate unrealized conversion cast.
The rewrites bellow are registered and similar to dead code elimination/ constant folding
unrealized conversion cast get eliminated.

An `unrealized conversion cast` in MLIR is an operation inserted during the lowering
from one dialect to another dialect to temporary guarantee compatible between type
systems. It is stating that an element should be casted to type B from type A.
The actual casting needs to be performed by a separate pass.
-/

/-
Rewrite to eliminate ` option bitvec ->  bitvec -> opt bitvec casts`.
The step `option bitvec -> bitvec ` requires a notion of refinement.
The current defintion can have some rethinking, but currently we define the refinement
of a `some x` to be `x` itself only, and `any value` refines `x`.
-/
open LLVMRiscV
open LLVM
open RV64Semantics


-- not even true, will never get rid of this cast, especially the last line
def cast_eliminiation_llvm : LLVMPeepholeRewriteRefine [Ty.llvm (.bitvec 64)] :=
  {lhs:=
    [LV| {
      ^entry (%lhs: i64): -- this is a refinement
      %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> !i64
      %addl = "builtin.unrealized_conversion_cast" (%lhsr) : (!i64) -> (i64)
      llvm.return %addl : i64  }],
    rhs:=
      [LV| {
      ^entry (%lhs: i64):
      llvm.return %lhs : i64  }],
      correct := by
       simp_peephole
       rintro (_|a) <;> sorry
    }

-- not sure if this will kick in because of the return and eliminate many rewrites
-- will run this in a loop to eliminate all the casts.
def cast_eliminiation_riscv : RiscVPeepholeRewriteRefine [Ty.riscv (.bv)] :=
  {lhs:=
    [LV| {
      ^entry (%lhs: !i64):
      %addl = "builtin.unrealized_conversion_cast" (%lhs) : (!i64) -> (i64)
      %lhsr = "builtin.unrealized_conversion_cast"(%addl) : (i64) -> !i64
      ret %lhsr : !i64  }],
    rhs:=  [LV| {
      ^entry (%lhs: !i64):
      ret %lhs : !i64  }]
     , correct := by
      simp_peephole
      intro e
      simp [liftM, builtin.unrealized_conversion_cast.LLVMToriscv,builtin.unrealized_conversion_cast.riscvToLLVM]
      }


def double_cast_elimination_LLVM_to_RISCV : LLVMPeepholeRewriteRefine [Ty.llvm (.bitvec 64)] :=
{lhs:=
    [LV| {
      ^entry (%lhs: i64): -- this is a refinement
      %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> !i64
      %lhsr1 = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> !i64
      %addl = "builtin.unrealized_conversion_cast" (%lhsr) : (!i64) -> (i64)
      llvm.return %addl : i64  }],
    rhs:=
      [LV| {
      ^entry (%lhs: i64):
      %lhsr = "builtin.unrealized_conversion_cast"(%lhs) : (i64) -> !i64
      %addl = "builtin.unrealized_conversion_cast" (%lhsr) : (!i64) -> (i64)
      llvm.return %addl : i64  }],
      correct := by
       simp_peephole
       intro e
       simp [builtin.unrealized_conversion_cast.LLVMToriscv, Option.getD_some]
    }



/-
def ADD_LLVM_flags :=
  [llvm(64)| {
^bb0(%X : i64, %Y : i64):
         %v1 = llvm.add %X, %Y overflow<nsw> : i64
           llvm.return %v1 : i64
  }].denote
-/

/-
These where the cast for the old dialect where we explictily modelled a hybrid LLLVM and RISC-V dialect
without reusing the existing one, which required a lot of manual work.

def cast_cast_eq_cast_out_llvm : RiscVPeepholeRewriteRefine ([Ty.opt64]) :=
  {lhs:=
    [_| {
    ^entry (%0: !i64 ):
    "return" (%0) : (!i64) -> ()
  }], rhs:=
    [_| {
    ^entry (%0: !i64 ):
    %1 = "builtin.unrealized_conversion_cast.LLVMToriscv" (%0) : (!i64) -> (!r64)
    %2 = "builtin.unrealized_conversion_cast.riscvToLLVM" (%1) : (!r64) -> (!i64)
    "return" (%2) : (!i64) -> ()
  }] ,
   correct:=
    by
    simp_peephole
    intro e'
    simp [riscv.semantics.builtin.unrealized_conversion_cast.LLVMToriscv, riscv.semantics.builtin.unrealized_conversion_cast.riscvToLLVM]
    cases e'
    . simp only [Option.getD_none, BitVec.Refinement.none_left]
    . simp only [Option.getD_some, BitVec.Refinement.refl]
    }

/-
rewrite to eliminate `bitvec -> opt bitvec -> bitvec casts`.
-/
def cast_cast_eq_cast_out_riscv : PeepholeRewrite llvm.riscv ([Ty.bv64]) .bv64 :=
  {lhs:=
    [_| {
    ^entry (%0: !r64 ):
    "return" (%0) : (!r64) -> ()
  }], rhs:=
    [_| {
    ^entry (%0: !r64 ):
    %1 = "builtin.unrealized_conversion_cast.riscvToLLVM" (%0) : (!r64) -> (!i64)
    %2 = "builtin.unrealized_conversion_cast.LLVMToriscv" (%1) : (!i64) -> (!r64)
    "return" (%2) : (!r64) -> ()
  }] ,
   correct:=
    by
    simp_peephole
    intro e'
    simp [riscv.semantics.builtin.unrealized_conversion_cast.LLVMToriscv, riscv.semantics.builtin.unrealized_conversion_cast.riscvToLLVM]
    }

-/
