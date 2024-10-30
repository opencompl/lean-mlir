import SSA.Projects.InstCombine.tests.proofs.glshr_proof
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
section glshr_statements

def lshr_exact_before := [llvm|
{
^0(%arg183 : i8):
  %0 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 4 : i8}> : () -> i8
  %2 = llvm.shl %arg183, %0 : i8
  %3 = llvm.add %2, %1 : i8
  %4 = llvm.lshr %3, %0 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def lshr_exact_after := [llvm|
{
^0(%arg183 : i8):
  %0 = "llvm.mlir.constant"() <{value = 1 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 63 : i8}> : () -> i8
  %2 = llvm.add %arg183, %0 : i8
  %3 = llvm.and %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
theorem lshr_exact_proof : lshr_exact_before ⊑ lshr_exact_after := by
  unfold lshr_exact_before lshr_exact_after
  simp_alive_peephole
  ---BEGIN lshr_exact
  apply lshr_exact_thm
  ---END lshr_exact



def shl_add_before := [llvm|
{
^0(%arg179 : i8, %arg180 : i8):
  %0 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %1 = llvm.shl %arg179, %0 : i8
  %2 = llvm.add %1, %arg180 : i8
  %3 = llvm.lshr %2, %0 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def shl_add_after := [llvm|
{
^0(%arg179 : i8, %arg180 : i8):
  %0 = "llvm.mlir.constant"() <{value = 2 : i8}> : () -> i8
  %1 = "llvm.mlir.constant"() <{value = 63 : i8}> : () -> i8
  %2 = llvm.lshr %arg180, %0 : i8
  %3 = llvm.add %2, %arg179 : i8
  %4 = llvm.and %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
theorem shl_add_proof : shl_add_before ⊑ shl_add_after := by
  unfold shl_add_before shl_add_after
  simp_alive_peephole
  ---BEGIN shl_add
  apply shl_add_thm
  ---END shl_add



def mul_splat_fold_before := [llvm|
{
^0(%arg161 : i32):
  %0 = "llvm.mlir.constant"() <{value = 65537 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 16 : i32}> : () -> i32
  %2 = llvm.mul %arg161, %0 : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def mul_splat_fold_after := [llvm|
{
^0(%arg161 : i32):
  %0 = "llvm.mlir.constant"() <{value = 65535 : i32}> : () -> i32
  %1 = llvm.and %arg161, %0 : i32
  "llvm.return"(%1) : (i32) -> ()
}
]
theorem mul_splat_fold_proof : mul_splat_fold_before ⊑ mul_splat_fold_after := by
  unfold mul_splat_fold_before mul_splat_fold_after
  simp_alive_peephole
  ---BEGIN mul_splat_fold
  apply mul_splat_fold_thm
  ---END mul_splat_fold



def shl_or_lshr_comm_before := [llvm|
{
^0(%arg106 : i32, %arg107 : i32, %arg108 : i32):
  %0 = llvm.shl %arg106, %arg107 : i32
  %1 = llvm.or %arg108, %0 : i32
  %2 = llvm.lshr %1, %arg107 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_or_lshr_comm_after := [llvm|
{
^0(%arg106 : i32, %arg107 : i32, %arg108 : i32):
  %0 = llvm.shl %arg106, %arg107 : i32
  %1 = llvm.or %0, %arg108 : i32
  %2 = llvm.lshr %1, %arg107 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem shl_or_lshr_comm_proof : shl_or_lshr_comm_before ⊑ shl_or_lshr_comm_after := by
  unfold shl_or_lshr_comm_before shl_or_lshr_comm_after
  simp_alive_peephole
  ---BEGIN shl_or_lshr_comm
  apply shl_or_lshr_comm_thm
  ---END shl_or_lshr_comm



def shl_or_disjoint_lshr_comm_before := [llvm|
{
^0(%arg103 : i32, %arg104 : i32, %arg105 : i32):
  %0 = llvm.shl %arg103, %arg104 : i32
  %1 = llvm.or %arg105, %0 : i32
  %2 = llvm.lshr %1, %arg104 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_or_disjoint_lshr_comm_after := [llvm|
{
^0(%arg103 : i32, %arg104 : i32, %arg105 : i32):
  %0 = llvm.shl %arg103, %arg104 : i32
  %1 = llvm.or %0, %arg105 : i32
  %2 = llvm.lshr %1, %arg104 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem shl_or_disjoint_lshr_comm_proof : shl_or_disjoint_lshr_comm_before ⊑ shl_or_disjoint_lshr_comm_after := by
  unfold shl_or_disjoint_lshr_comm_before shl_or_disjoint_lshr_comm_after
  simp_alive_peephole
  ---BEGIN shl_or_disjoint_lshr_comm
  apply shl_or_disjoint_lshr_comm_thm
  ---END shl_or_disjoint_lshr_comm



def shl_xor_lshr_comm_before := [llvm|
{
^0(%arg97 : i32, %arg98 : i32, %arg99 : i32):
  %0 = llvm.shl %arg97, %arg98 : i32
  %1 = llvm.xor %arg99, %0 : i32
  %2 = llvm.lshr %1, %arg98 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_xor_lshr_comm_after := [llvm|
{
^0(%arg97 : i32, %arg98 : i32, %arg99 : i32):
  %0 = llvm.shl %arg97, %arg98 : i32
  %1 = llvm.xor %0, %arg99 : i32
  %2 = llvm.lshr %1, %arg98 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem shl_xor_lshr_comm_proof : shl_xor_lshr_comm_before ⊑ shl_xor_lshr_comm_after := by
  unfold shl_xor_lshr_comm_before shl_xor_lshr_comm_after
  simp_alive_peephole
  ---BEGIN shl_xor_lshr_comm
  apply shl_xor_lshr_comm_thm
  ---END shl_xor_lshr_comm



def shl_and_lshr_comm_before := [llvm|
{
^0(%arg91 : i32, %arg92 : i32, %arg93 : i32):
  %0 = llvm.shl %arg91, %arg92 : i32
  %1 = llvm.and %arg93, %0 : i32
  %2 = llvm.lshr %1, %arg92 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def shl_and_lshr_comm_after := [llvm|
{
^0(%arg91 : i32, %arg92 : i32, %arg93 : i32):
  %0 = llvm.shl %arg91, %arg92 : i32
  %1 = llvm.and %0, %arg93 : i32
  %2 = llvm.lshr %1, %arg92 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem shl_and_lshr_comm_proof : shl_and_lshr_comm_before ⊑ shl_and_lshr_comm_after := by
  unfold shl_and_lshr_comm_before shl_and_lshr_comm_after
  simp_alive_peephole
  ---BEGIN shl_and_lshr_comm
  apply shl_and_lshr_comm_thm
  ---END shl_and_lshr_comm



def mul_splat_fold_too_narrow_before := [llvm|
{
^0(%arg77 : i2):
  %0 = "llvm.mlir.constant"() <{value = -2 : i2}> : () -> i2
  %1 = "llvm.mlir.constant"() <{value = 1 : i2}> : () -> i2
  %2 = llvm.mul %arg77, %0 : i2
  %3 = llvm.lshr %2, %1 : i2
  "llvm.return"(%3) : (i2) -> ()
}
]
def mul_splat_fold_too_narrow_after := [llvm|
{
^0(%arg77 : i2):
  "llvm.return"(%arg77) : (i2) -> ()
}
]
theorem mul_splat_fold_too_narrow_proof : mul_splat_fold_too_narrow_before ⊑ mul_splat_fold_too_narrow_after := by
  unfold mul_splat_fold_too_narrow_before mul_splat_fold_too_narrow_after
  simp_alive_peephole
  ---BEGIN mul_splat_fold_too_narrow
  apply mul_splat_fold_too_narrow_thm
  ---END mul_splat_fold_too_narrow



def negative_and_odd_before := [llvm|
{
^0(%arg76 : i32):
  %0 = "llvm.mlir.constant"() <{value = 2 : i32}> : () -> i32
  %1 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
  %2 = llvm.srem %arg76, %0 : i32
  %3 = llvm.lshr %2, %1 : i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def negative_and_odd_after := [llvm|
{
^0(%arg76 : i32):
  %0 = "llvm.mlir.constant"() <{value = 31 : i32}> : () -> i32
  %1 = llvm.lshr %arg76, %0 : i32
  %2 = llvm.and %1, %arg76 : i32
  "llvm.return"(%2) : (i32) -> ()
}
]
theorem negative_and_odd_proof : negative_and_odd_before ⊑ negative_and_odd_after := by
  unfold negative_and_odd_before negative_and_odd_after
  simp_alive_peephole
  ---BEGIN negative_and_odd
  apply negative_and_odd_thm
  ---END negative_and_odd


