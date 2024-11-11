
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
section gxorhashr_statements

def testi8i8_before := [llvm|
{
^0(%arg10 : i8):
  %0 = llvm.mlir.constant(7 : i8) : i8
  %1 = llvm.mlir.constant(127 : i8) : i8
  %2 = llvm.ashr %arg10, %0 : i8
  %3 = llvm.xor %2, %1 : i8
  "llvm.return"(%3) : (i8) -> ()
}
]
def testi8i8_after := [llvm|
{
^0(%arg10 : i8):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(127 : i8) : i8
  %2 = llvm.mlir.constant(-128 : i8) : i8
  %3 = llvm.icmp "sgt" %arg10, %0 : i8
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem testi8i8_proof : testi8i8_before ⊑ testi8i8_after := by
  unfold testi8i8_before testi8i8_after
  simp_alive_peephole
  intros
  ---BEGIN testi8i8
  all_goals (try extract_goal ; sorry)
  ---END testi8i8



def testi16i8_before := [llvm|
{
^0(%arg9 : i16):
  %0 = llvm.mlir.constant(15 : i16) : i16
  %1 = llvm.mlir.constant(27 : i8) : i8
  %2 = llvm.ashr %arg9, %0 : i16
  %3 = llvm.trunc %2 : i16 to i8
  %4 = llvm.xor %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def testi16i8_after := [llvm|
{
^0(%arg9 : i16):
  %0 = llvm.mlir.constant(-1 : i16) : i16
  %1 = llvm.mlir.constant(27 : i8) : i8
  %2 = llvm.mlir.constant(-28 : i8) : i8
  %3 = llvm.icmp "sgt" %arg9, %0 : i16
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem testi16i8_proof : testi16i8_before ⊑ testi16i8_after := by
  unfold testi16i8_before testi16i8_after
  simp_alive_peephole
  intros
  ---BEGIN testi16i8
  all_goals (try extract_goal ; sorry)
  ---END testi16i8



def testi64i32_before := [llvm|
{
^0(%arg8 : i64):
  %0 = llvm.mlir.constant(63) : i64
  %1 = llvm.mlir.constant(127 : i32) : i32
  %2 = llvm.ashr %arg8, %0 : i64
  %3 = llvm.trunc %2 : i64 to i32
  %4 = llvm.xor %3, %1 : i32
  "llvm.return"(%4) : (i32) -> ()
}
]
def testi64i32_after := [llvm|
{
^0(%arg8 : i64):
  %0 = llvm.mlir.constant(-1) : i64
  %1 = llvm.mlir.constant(127 : i32) : i32
  %2 = llvm.mlir.constant(-128 : i32) : i32
  %3 = llvm.icmp "sgt" %arg8, %0 : i64
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem testi64i32_proof : testi64i32_before ⊑ testi64i32_after := by
  unfold testi64i32_before testi64i32_after
  simp_alive_peephole
  intros
  ---BEGIN testi64i32
  all_goals (try extract_goal ; sorry)
  ---END testi64i32



def testi128i128_before := [llvm|
{
^0(%arg7 : i128):
  %0 = llvm.mlir.constant(127 : i128) : i128
  %1 = llvm.mlir.constant(27 : i128) : i128
  %2 = llvm.ashr %arg7, %0 : i128
  %3 = llvm.xor %2, %1 : i128
  "llvm.return"(%3) : (i128) -> ()
}
]
def testi128i128_after := [llvm|
{
^0(%arg7 : i128):
  %0 = llvm.mlir.constant(-1 : i128) : i128
  %1 = llvm.mlir.constant(27 : i128) : i128
  %2 = llvm.mlir.constant(-28 : i128) : i128
  %3 = llvm.icmp "sgt" %arg7, %0 : i128
  %4 = "llvm.select"(%3, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i128, i128) -> i128
  "llvm.return"(%4) : (i128) -> ()
}
]
set_option debug.skipKernelTC true in
theorem testi128i128_proof : testi128i128_before ⊑ testi128i128_after := by
  unfold testi128i128_before testi128i128_after
  simp_alive_peephole
  intros
  ---BEGIN testi128i128
  all_goals (try extract_goal ; sorry)
  ---END testi128i128



def wrongimm_before := [llvm|
{
^0(%arg4 : i16):
  %0 = llvm.mlir.constant(14 : i16) : i16
  %1 = llvm.mlir.constant(27 : i8) : i8
  %2 = llvm.ashr %arg4, %0 : i16
  %3 = llvm.trunc %2 : i16 to i8
  %4 = llvm.xor %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
def wrongimm_after := [llvm|
{
^0(%arg4 : i16):
  %0 = llvm.mlir.constant(14 : i16) : i16
  %1 = llvm.mlir.constant(27 : i8) : i8
  %2 = llvm.ashr %arg4, %0 : i16
  %3 = llvm.trunc %2 overflow<nsw> : i16 to i8
  %4 = llvm.xor %3, %1 : i8
  "llvm.return"(%4) : (i8) -> ()
}
]
set_option debug.skipKernelTC true in
theorem wrongimm_proof : wrongimm_before ⊑ wrongimm_after := by
  unfold wrongimm_before wrongimm_after
  simp_alive_peephole
  intros
  ---BEGIN wrongimm
  all_goals (try extract_goal ; sorry)
  ---END wrongimm


