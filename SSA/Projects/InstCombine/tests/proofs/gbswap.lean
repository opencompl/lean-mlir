import SSA.Projects.InstCombine.tests.proofs.gbswap_proof
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
section gbswap_statements

def PR39793_bswap_u64_as_u16_trunc_before := [llvm|
{
^0(%arg27 : i64):
  %0 = "llvm.mlir.constant"() <{value = 8 : i64}> : () -> i64
  %1 = "llvm.mlir.constant"() <{value = 255 : i64}> : () -> i64
  %2 = "llvm.mlir.constant"() <{value = 65280 : i64}> : () -> i64
  %3 = llvm.lshr %arg27, %0 : i64
  %4 = llvm.and %3, %1 : i64
  %5 = llvm.shl %arg27, %0 : i64
  %6 = llvm.and %5, %2 : i64
  %7 = llvm.or %4, %6 : i64
  %8 = llvm.trunc %7 : i64 to i8
  "llvm.return"(%8) : (i8) -> ()
}
]
def PR39793_bswap_u64_as_u16_trunc_after := [llvm|
{
^0(%arg27 : i64):
  %0 = "llvm.mlir.constant"() <{value = 8 : i64}> : () -> i64
  %1 = llvm.lshr %arg27, %0 : i64
  %2 = llvm.trunc %1 : i64 to i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem PR39793_bswap_u64_as_u16_trunc_proof : PR39793_bswap_u64_as_u16_trunc_before ⊑ PR39793_bswap_u64_as_u16_trunc_after := by
  unfold PR39793_bswap_u64_as_u16_trunc_before PR39793_bswap_u64_as_u16_trunc_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN PR39793_bswap_u64_as_u16_trunc
  apply PR39793_bswap_u64_as_u16_trunc_thm
  ---END PR39793_bswap_u64_as_u16_trunc



def PR39793_bswap_u32_as_u16_trunc_before := [llvm|
{
^0(%arg24 : i32):
  %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 255 : i32}> : () -> i32
  %2 = "llvm.mlir.constant"() <{value = 65280 : i32}> : () -> i32
  %3 = llvm.lshr %arg24, %0 : i32
  %4 = llvm.and %3, %1 : i32
  %5 = llvm.shl %arg24, %0 : i32
  %6 = llvm.and %5, %2 : i32
  %7 = llvm.or %4, %6 : i32
  %8 = llvm.trunc %7 : i32 to i8
  "llvm.return"(%8) : (i8) -> ()
}
]
def PR39793_bswap_u32_as_u16_trunc_after := [llvm|
{
^0(%arg24 : i32):
  %0 = "llvm.mlir.constant"() <{value = 8 : i32}> : () -> i32
  %1 = llvm.lshr %arg24, %0 : i32
  %2 = llvm.trunc %1 : i32 to i8
  "llvm.return"(%2) : (i8) -> ()
}
]
theorem PR39793_bswap_u32_as_u16_trunc_proof : PR39793_bswap_u32_as_u16_trunc_before ⊑ PR39793_bswap_u32_as_u16_trunc_after := by
  unfold PR39793_bswap_u32_as_u16_trunc_before PR39793_bswap_u32_as_u16_trunc_after
  simp_alive_peephole
  simp_alive_undef
  simp_alive_ops
  try simp
  simp_alive_case_bash
  try intros
  try simp
  ---BEGIN PR39793_bswap_u32_as_u16_trunc
  apply PR39793_bswap_u32_as_u16_trunc_thm
  ---END PR39793_bswap_u32_as_u16_trunc


