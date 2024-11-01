import SSA.Projects.InstCombine.tests.proofs.gsignhbithtesthviahrighthshiftinghallhotherhbits_proof
import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open LLVM
open BitVec

open MLIR AST
open Ctxt (Var)

set_option linter.deprecated false
set_option linter.unreachableTactic false
set_option linter.unusedTactic false
section gsignhbithtesthviahrighthshiftinghallhotherhbits_statements

def unsigned_sign_bit_extract_before := [llvm|
{
^0(%arg8 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.lshr %arg8, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def unsigned_sign_bit_extract_after := [llvm|
{
^0(%arg8 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "slt" %arg8, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem unsigned_sign_bit_extract_proof : unsigned_sign_bit_extract_before ⊑ unsigned_sign_bit_extract_after := by
  unfold unsigned_sign_bit_extract_before unsigned_sign_bit_extract_after
  simp_alive_peephole
  intros
  ---BEGIN unsigned_sign_bit_extract
  apply unsigned_sign_bit_extract_thm
  ---END unsigned_sign_bit_extract



def signed_sign_bit_extract_before := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(31 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.ashr %arg5, %0 : i32
  %3 = llvm.icmp "ne" %2, %1 : i32
  "llvm.return"(%3) : (i1) -> ()
}
]
def signed_sign_bit_extract_after := [llvm|
{
^0(%arg5 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "slt" %arg5, %0 : i32
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem signed_sign_bit_extract_proof : signed_sign_bit_extract_before ⊑ signed_sign_bit_extract_after := by
  unfold signed_sign_bit_extract_before signed_sign_bit_extract_after
  simp_alive_peephole
  intros
  ---BEGIN signed_sign_bit_extract
  apply signed_sign_bit_extract_thm
  ---END signed_sign_bit_extract



def unsigned_sign_bit_extract_with_trunc_before := [llvm|
{
^0(%arg3 : i64):
  %0 = llvm.mlir.constant(63) : i64
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.lshr %arg3, %0 : i64
  %3 = llvm.trunc %2 : i64 to i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def unsigned_sign_bit_extract_with_trunc_after := [llvm|
{
^0(%arg3 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.icmp "slt" %arg3, %0 : i64
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem unsigned_sign_bit_extract_with_trunc_proof : unsigned_sign_bit_extract_with_trunc_before ⊑ unsigned_sign_bit_extract_with_trunc_after := by
  unfold unsigned_sign_bit_extract_with_trunc_before unsigned_sign_bit_extract_with_trunc_after
  simp_alive_peephole
  intros
  ---BEGIN unsigned_sign_bit_extract_with_trunc
  apply unsigned_sign_bit_extract_with_trunc_thm
  ---END unsigned_sign_bit_extract_with_trunc



def signed_sign_bit_extract_trunc_before := [llvm|
{
^0(%arg1 : i64):
  %0 = llvm.mlir.constant(63) : i64
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = llvm.ashr %arg1, %0 : i64
  %3 = llvm.trunc %2 : i64 to i32
  %4 = llvm.icmp "ne" %3, %1 : i32
  "llvm.return"(%4) : (i1) -> ()
}
]
def signed_sign_bit_extract_trunc_after := [llvm|
{
^0(%arg1 : i64):
  %0 = llvm.mlir.constant(0) : i64
  %1 = llvm.icmp "slt" %arg1, %0 : i64
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem signed_sign_bit_extract_trunc_proof : signed_sign_bit_extract_trunc_before ⊑ signed_sign_bit_extract_trunc_after := by
  unfold signed_sign_bit_extract_trunc_before signed_sign_bit_extract_trunc_after
  simp_alive_peephole
  intros
  ---BEGIN signed_sign_bit_extract_trunc
  apply signed_sign_bit_extract_trunc_thm
  ---END signed_sign_bit_extract_trunc


