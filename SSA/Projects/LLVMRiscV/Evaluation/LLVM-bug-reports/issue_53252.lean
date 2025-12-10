import SSA.Projects.RISCV64.PrettyEDSL
import LeanMLIR.Framework
import SSA.Projects.LLVMRiscV.PeepholeRefine
import SSA.Projects.LLVMRiscV.Simpproc
import SSA.Projects.RISCV64.Tactic.SimpRiscV
import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite

/-!
  Bug reported in https://github.com/llvm/llvm-project/issues/53252
  and fixed in https://github.com/llvm/llvm-project/commit/4041c44853588c1e4918ec4a160c053cf08432b5
-/

namespace BitVec
open LLVMRiscV

@[simp_denote]
def original := [LV| {
  ^entry (%x : i32, %replacement_low : i32, %replacement_high : i32):
  %0 = llvm.mlir.constant (0) : i32
  %t0 = llvm.icmp.slt %x, %0 : i32
  %t1 = llvm.select %t0, %replacement_low, %replacement_high : i32
  %65536 = llvm.mlir.constant (65536) : i32
  %t2 = llvm.icmp.ult %x, %65536 : i32
  %true = llvm.mlir.constant (true) : i1
  %1 = llvm.xor %t2, %true : i1
  %r = llvm.select %1, %x, %t1 : i32
  llvm.return %r : i32
}]

@[simp_denote]
def optimized_incorrect := [LV| {
  ^entry (%x : i32, %replacement_low : i32, %replacement_high : i32):
  %0 = llvm.mlir.constant (0) : i32
  %1 = llvm.icmp.slt %x, %0 : i32
  %65535 = llvm.mlir.constant (65535) : i32
  %2 = llvm.icmp.sgt %x, %65535 : i32
  %3 = llvm.select %1, %replacement_low, %x : i32
  %4 = llvm.select %2, %replacement_high, %3 : i32
  llvm.return %4 : i32
  }]

def bug : LLVMPeepholeRewriteRefine 32 [Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32), Ty.llvm (.bitvec 32)] where
  lhs:= original
  rhs:= optimized_incorrect
  correct := by
    simp_lowering
    <;> sorry
