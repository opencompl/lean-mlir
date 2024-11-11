
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
section gselecthbitext_statements

def sel_sext_constants_before := [llvm|
{
^0(%arg97 : i1):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(42 : i8) : i8
  %2 = "llvm.select"(%arg97, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.sext %2 : i8 to i16
  "llvm.return"(%3) : (i16) -> ()
}
]
def sel_sext_constants_after := [llvm|
{
^0(%arg97 : i1):
  %0 = llvm.mlir.constant(-1 : i16) : i16
  %1 = llvm.mlir.constant(42 : i16) : i16
  %2 = "llvm.select"(%arg97, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i16, i16) -> i16
  "llvm.return"(%2) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sel_sext_constants_proof : sel_sext_constants_before ⊑ sel_sext_constants_after := by
  unfold sel_sext_constants_before sel_sext_constants_after
  simp_alive_peephole
  intros
  ---BEGIN sel_sext_constants
  all_goals (try extract_goal ; sorry)
  ---END sel_sext_constants



def sel_zext_constants_before := [llvm|
{
^0(%arg96 : i1):
  %0 = llvm.mlir.constant(-1 : i8) : i8
  %1 = llvm.mlir.constant(42 : i8) : i8
  %2 = "llvm.select"(%arg96, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i8, i8) -> i8
  %3 = llvm.zext %2 : i8 to i16
  "llvm.return"(%3) : (i16) -> ()
}
]
def sel_zext_constants_after := [llvm|
{
^0(%arg96 : i1):
  %0 = llvm.mlir.constant(255 : i16) : i16
  %1 = llvm.mlir.constant(42 : i16) : i16
  %2 = "llvm.select"(%arg96, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i16, i16) -> i16
  "llvm.return"(%2) : (i16) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sel_zext_constants_proof : sel_zext_constants_before ⊑ sel_zext_constants_after := by
  unfold sel_zext_constants_before sel_zext_constants_after
  simp_alive_peephole
  intros
  ---BEGIN sel_zext_constants
  all_goals (try extract_goal ; sorry)
  ---END sel_zext_constants



def sel_sext_before := [llvm|
{
^0(%arg93 : i32, %arg94 : i1):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = "llvm.select"(%arg94, %arg93, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.sext %1 : i32 to i64
  "llvm.return"(%2) : (i64) -> ()
}
]
def sel_sext_after := [llvm|
{
^0(%arg93 : i32, %arg94 : i1):
  %0 = llvm.mlir.constant(42) : i64
  %1 = llvm.sext %arg93 : i32 to i64
  %2 = "llvm.select"(%arg94, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%2) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sel_sext_proof : sel_sext_before ⊑ sel_sext_after := by
  unfold sel_sext_before sel_sext_after
  simp_alive_peephole
  intros
  ---BEGIN sel_sext
  all_goals (try extract_goal ; sorry)
  ---END sel_sext



def sel_zext_before := [llvm|
{
^0(%arg89 : i32, %arg90 : i1):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = "llvm.select"(%arg90, %arg89, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %2 = llvm.zext %1 : i32 to i64
  "llvm.return"(%2) : (i64) -> ()
}
]
def sel_zext_after := [llvm|
{
^0(%arg89 : i32, %arg90 : i1):
  %0 = llvm.mlir.constant(42) : i64
  %1 = llvm.zext %arg89 : i32 to i64
  %2 = "llvm.select"(%arg90, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%2) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sel_zext_proof : sel_zext_before ⊑ sel_zext_after := by
  unfold sel_zext_before sel_zext_after
  simp_alive_peephole
  intros
  ---BEGIN sel_zext
  all_goals (try extract_goal ; sorry)
  ---END sel_zext



def trunc_sel_larger_sext_before := [llvm|
{
^0(%arg85 : i32, %arg86 : i1):
  %0 = llvm.mlir.constant(42 : i16) : i16
  %1 = llvm.trunc %arg85 : i32 to i16
  %2 = "llvm.select"(%arg86, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i16, i16) -> i16
  %3 = llvm.sext %2 : i16 to i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def trunc_sel_larger_sext_after := [llvm|
{
^0(%arg85 : i32, %arg86 : i1):
  %0 = llvm.mlir.constant(42) : i64
  %1 = llvm.trunc %arg85 : i32 to i16
  %2 = llvm.sext %1 : i16 to i64
  %3 = "llvm.select"(%arg86, %2, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%3) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_sel_larger_sext_proof : trunc_sel_larger_sext_before ⊑ trunc_sel_larger_sext_after := by
  unfold trunc_sel_larger_sext_before trunc_sel_larger_sext_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_sel_larger_sext
  all_goals (try extract_goal ; sorry)
  ---END trunc_sel_larger_sext



def trunc_sel_smaller_sext_before := [llvm|
{
^0(%arg81 : i64, %arg82 : i1):
  %0 = llvm.mlir.constant(42 : i16) : i16
  %1 = llvm.trunc %arg81 : i64 to i16
  %2 = "llvm.select"(%arg82, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i16, i16) -> i16
  %3 = llvm.sext %2 : i16 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def trunc_sel_smaller_sext_after := [llvm|
{
^0(%arg81 : i64, %arg82 : i1):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.trunc %arg81 : i64 to i16
  %2 = llvm.sext %1 : i16 to i32
  %3 = "llvm.select"(%arg82, %2, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_sel_smaller_sext_proof : trunc_sel_smaller_sext_before ⊑ trunc_sel_smaller_sext_after := by
  unfold trunc_sel_smaller_sext_before trunc_sel_smaller_sext_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_sel_smaller_sext
  all_goals (try extract_goal ; sorry)
  ---END trunc_sel_smaller_sext



def trunc_sel_equal_sext_before := [llvm|
{
^0(%arg77 : i32, %arg78 : i1):
  %0 = llvm.mlir.constant(42 : i16) : i16
  %1 = llvm.trunc %arg77 : i32 to i16
  %2 = "llvm.select"(%arg78, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i16, i16) -> i16
  %3 = llvm.sext %2 : i16 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def trunc_sel_equal_sext_after := [llvm|
{
^0(%arg77 : i32, %arg78 : i1):
  %0 = llvm.mlir.constant(16 : i32) : i32
  %1 = llvm.mlir.constant(42 : i32) : i32
  %2 = llvm.shl %arg77, %0 : i32
  %3 = llvm.ashr exact %2, %0 : i32
  %4 = "llvm.select"(%arg78, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_sel_equal_sext_proof : trunc_sel_equal_sext_before ⊑ trunc_sel_equal_sext_after := by
  unfold trunc_sel_equal_sext_before trunc_sel_equal_sext_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_sel_equal_sext
  all_goals (try extract_goal ; sorry)
  ---END trunc_sel_equal_sext



def trunc_sel_larger_zext_before := [llvm|
{
^0(%arg73 : i32, %arg74 : i1):
  %0 = llvm.mlir.constant(42 : i16) : i16
  %1 = llvm.trunc %arg73 : i32 to i16
  %2 = "llvm.select"(%arg74, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i16, i16) -> i16
  %3 = llvm.zext %2 : i16 to i64
  "llvm.return"(%3) : (i64) -> ()
}
]
def trunc_sel_larger_zext_after := [llvm|
{
^0(%arg73 : i32, %arg74 : i1):
  %0 = llvm.mlir.constant(65535 : i32) : i32
  %1 = llvm.mlir.constant(42) : i64
  %2 = llvm.and %arg73, %0 : i32
  %3 = llvm.zext nneg %2 : i32 to i64
  %4 = "llvm.select"(%arg74, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
  "llvm.return"(%4) : (i64) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_sel_larger_zext_proof : trunc_sel_larger_zext_before ⊑ trunc_sel_larger_zext_after := by
  unfold trunc_sel_larger_zext_before trunc_sel_larger_zext_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_sel_larger_zext
  all_goals (try extract_goal ; sorry)
  ---END trunc_sel_larger_zext



def trunc_sel_smaller_zext_before := [llvm|
{
^0(%arg69 : i64, %arg70 : i1):
  %0 = llvm.mlir.constant(42 : i16) : i16
  %1 = llvm.trunc %arg69 : i64 to i16
  %2 = "llvm.select"(%arg70, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i16, i16) -> i16
  %3 = llvm.zext %2 : i16 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def trunc_sel_smaller_zext_after := [llvm|
{
^0(%arg69 : i64, %arg70 : i1):
  %0 = llvm.mlir.constant(65535 : i32) : i32
  %1 = llvm.mlir.constant(42 : i32) : i32
  %2 = llvm.trunc %arg69 : i64 to i32
  %3 = llvm.and %2, %0 : i32
  %4 = "llvm.select"(%arg70, %3, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_sel_smaller_zext_proof : trunc_sel_smaller_zext_before ⊑ trunc_sel_smaller_zext_after := by
  unfold trunc_sel_smaller_zext_before trunc_sel_smaller_zext_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_sel_smaller_zext
  all_goals (try extract_goal ; sorry)
  ---END trunc_sel_smaller_zext



def trunc_sel_equal_zext_before := [llvm|
{
^0(%arg65 : i32, %arg66 : i1):
  %0 = llvm.mlir.constant(42 : i16) : i16
  %1 = llvm.trunc %arg65 : i32 to i16
  %2 = "llvm.select"(%arg66, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i16, i16) -> i16
  %3 = llvm.zext %2 : i16 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
def trunc_sel_equal_zext_after := [llvm|
{
^0(%arg65 : i32, %arg66 : i1):
  %0 = llvm.mlir.constant(65535 : i32) : i32
  %1 = llvm.mlir.constant(42 : i32) : i32
  %2 = llvm.and %arg65, %0 : i32
  %3 = "llvm.select"(%arg66, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem trunc_sel_equal_zext_proof : trunc_sel_equal_zext_before ⊑ trunc_sel_equal_zext_after := by
  unfold trunc_sel_equal_zext_before trunc_sel_equal_zext_after
  simp_alive_peephole
  intros
  ---BEGIN trunc_sel_equal_zext
  all_goals (try extract_goal ; sorry)
  ---END trunc_sel_equal_zext



def test_sext1_before := [llvm|
{
^0(%arg49 : i1, %arg50 : i1):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.sext %arg49 : i1 to i32
  %2 = "llvm.select"(%arg50, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test_sext1_after := [llvm|
{
^0(%arg49 : i1, %arg50 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg50, %arg49, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = llvm.sext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_sext1_proof : test_sext1_before ⊑ test_sext1_after := by
  unfold test_sext1_before test_sext1_after
  simp_alive_peephole
  intros
  ---BEGIN test_sext1
  all_goals (try extract_goal ; sorry)
  ---END test_sext1



def test_sext2_before := [llvm|
{
^0(%arg47 : i1, %arg48 : i1):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.sext %arg47 : i1 to i32
  %2 = "llvm.select"(%arg48, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test_sext2_after := [llvm|
{
^0(%arg47 : i1, %arg48 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg48, %0, %arg47) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = llvm.sext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_sext2_proof : test_sext2_before ⊑ test_sext2_after := by
  unfold test_sext2_before test_sext2_after
  simp_alive_peephole
  intros
  ---BEGIN test_sext2
  all_goals (try extract_goal ; sorry)
  ---END test_sext2



def test_sext3_before := [llvm|
{
^0(%arg45 : i1, %arg46 : i1):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.sext %arg45 : i1 to i32
  %2 = "llvm.select"(%arg46, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test_sext3_after := [llvm|
{
^0(%arg45 : i1, %arg46 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg46, %0 : i1
  %3 = "llvm.select"(%2, %arg45, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = llvm.sext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_sext3_proof : test_sext3_before ⊑ test_sext3_after := by
  unfold test_sext3_before test_sext3_after
  simp_alive_peephole
  intros
  ---BEGIN test_sext3
  all_goals (try extract_goal ; sorry)
  ---END test_sext3



def test_sext4_before := [llvm|
{
^0(%arg43 : i1, %arg44 : i1):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.sext %arg43 : i1 to i32
  %2 = "llvm.select"(%arg44, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test_sext4_after := [llvm|
{
^0(%arg43 : i1, %arg44 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg44, %0 : i1
  %2 = "llvm.select"(%1, %0, %arg43) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = llvm.sext %2 : i1 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_sext4_proof : test_sext4_before ⊑ test_sext4_after := by
  unfold test_sext4_before test_sext4_after
  simp_alive_peephole
  intros
  ---BEGIN test_sext4
  all_goals (try extract_goal ; sorry)
  ---END test_sext4



def test_zext1_before := [llvm|
{
^0(%arg41 : i1, %arg42 : i1):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.zext %arg41 : i1 to i32
  %2 = "llvm.select"(%arg42, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test_zext1_after := [llvm|
{
^0(%arg41 : i1, %arg42 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg42, %arg41, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = llvm.zext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_zext1_proof : test_zext1_before ⊑ test_zext1_after := by
  unfold test_zext1_before test_zext1_after
  simp_alive_peephole
  intros
  ---BEGIN test_zext1
  all_goals (try extract_goal ; sorry)
  ---END test_zext1



def test_zext2_before := [llvm|
{
^0(%arg39 : i1, %arg40 : i1):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.zext %arg39 : i1 to i32
  %2 = "llvm.select"(%arg40, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test_zext2_after := [llvm|
{
^0(%arg39 : i1, %arg40 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg40, %0, %arg39) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = llvm.zext %1 : i1 to i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_zext2_proof : test_zext2_before ⊑ test_zext2_after := by
  unfold test_zext2_before test_zext2_after
  simp_alive_peephole
  intros
  ---BEGIN test_zext2
  all_goals (try extract_goal ; sorry)
  ---END test_zext2



def test_zext3_before := [llvm|
{
^0(%arg37 : i1, %arg38 : i1):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.zext %arg37 : i1 to i32
  %2 = "llvm.select"(%arg38, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test_zext3_after := [llvm|
{
^0(%arg37 : i1, %arg38 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = llvm.xor %arg38, %0 : i1
  %3 = "llvm.select"(%2, %arg37, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %4 = llvm.zext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_zext3_proof : test_zext3_before ⊑ test_zext3_after := by
  unfold test_zext3_before test_zext3_after
  simp_alive_peephole
  intros
  ---BEGIN test_zext3
  all_goals (try extract_goal ; sorry)
  ---END test_zext3



def test_zext4_before := [llvm|
{
^0(%arg35 : i1, %arg36 : i1):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.zext %arg35 : i1 to i32
  %2 = "llvm.select"(%arg36, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def test_zext4_after := [llvm|
{
^0(%arg35 : i1, %arg36 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.xor %arg36, %0 : i1
  %2 = "llvm.select"(%1, %0, %arg35) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = llvm.zext %2 : i1 to i32
  "llvm.return"(%3) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_zext4_proof : test_zext4_before ⊑ test_zext4_after := by
  unfold test_zext4_before test_zext4_after
  simp_alive_peephole
  intros
  ---BEGIN test_zext4
  all_goals (try extract_goal ; sorry)
  ---END test_zext4



def test_op_op_before := [llvm|
{
^0(%arg20 : i32, %arg21 : i32, %arg22 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "sgt" %arg20, %0 : i32
  %2 = llvm.sext %1 : i1 to i32
  %3 = llvm.icmp "sgt" %arg21, %0 : i32
  %4 = llvm.sext %3 : i1 to i32
  %5 = llvm.icmp "sgt" %arg22, %0 : i32
  %6 = "llvm.select"(%5, %2, %4) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%6) : (i32) -> ()
}
]
def test_op_op_after := [llvm|
{
^0(%arg20 : i32, %arg21 : i32, %arg22 : i32):
  %0 = llvm.mlir.constant(0 : i32) : i32
  %1 = llvm.icmp "sgt" %arg22, %0 : i32
  %2 = "llvm.select"(%1, %arg20, %arg21) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  %3 = llvm.icmp "sgt" %2, %0 : i32
  %4 = llvm.sext %3 : i1 to i32
  "llvm.return"(%4) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem test_op_op_proof : test_op_op_before ⊑ test_op_op_after := by
  unfold test_op_op_before test_op_op_after
  simp_alive_peephole
  intros
  ---BEGIN test_op_op
  all_goals (try extract_goal ; sorry)
  ---END test_op_op



def sext_true_val_must_be_all_ones_before := [llvm|
{
^0(%arg7 : i1):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.sext %arg7 : i1 to i32
  %2 = "llvm.select"(%arg7, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def sext_true_val_must_be_all_ones_after := [llvm|
{
^0(%arg7 : i1):
  %0 = llvm.mlir.constant(-1 : i32) : i32
  %1 = llvm.mlir.constant(42 : i32) : i32
  %2 = "llvm.select"(%arg7, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_true_val_must_be_all_ones_proof : sext_true_val_must_be_all_ones_before ⊑ sext_true_val_must_be_all_ones_after := by
  unfold sext_true_val_must_be_all_ones_before sext_true_val_must_be_all_ones_after
  simp_alive_peephole
  intros
  ---BEGIN sext_true_val_must_be_all_ones
  all_goals (try extract_goal ; sorry)
  ---END sext_true_val_must_be_all_ones



def zext_true_val_must_be_one_before := [llvm|
{
^0(%arg5 : i1):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.zext %arg5 : i1 to i32
  %2 = "llvm.select"(%arg5, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def zext_true_val_must_be_one_after := [llvm|
{
^0(%arg5 : i1):
  %0 = llvm.mlir.constant(1 : i32) : i32
  %1 = llvm.mlir.constant(42 : i32) : i32
  %2 = "llvm.select"(%arg5, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_true_val_must_be_one_proof : zext_true_val_must_be_one_before ⊑ zext_true_val_must_be_one_after := by
  unfold zext_true_val_must_be_one_before zext_true_val_must_be_one_after
  simp_alive_peephole
  intros
  ---BEGIN zext_true_val_must_be_one
  all_goals (try extract_goal ; sorry)
  ---END zext_true_val_must_be_one



def sext_false_val_must_be_zero_before := [llvm|
{
^0(%arg3 : i1):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.sext %arg3 : i1 to i32
  %2 = "llvm.select"(%arg3, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def sext_false_val_must_be_zero_after := [llvm|
{
^0(%arg3 : i1):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = "llvm.select"(%arg3, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem sext_false_val_must_be_zero_proof : sext_false_val_must_be_zero_before ⊑ sext_false_val_must_be_zero_after := by
  unfold sext_false_val_must_be_zero_before sext_false_val_must_be_zero_after
  simp_alive_peephole
  intros
  ---BEGIN sext_false_val_must_be_zero
  all_goals (try extract_goal ; sorry)
  ---END sext_false_val_must_be_zero



def zext_false_val_must_be_zero_before := [llvm|
{
^0(%arg1 : i1):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.zext %arg1 : i1 to i32
  %2 = "llvm.select"(%arg1, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
def zext_false_val_must_be_zero_after := [llvm|
{
^0(%arg1 : i1):
  %0 = llvm.mlir.constant(42 : i32) : i32
  %1 = llvm.mlir.constant(0 : i32) : i32
  %2 = "llvm.select"(%arg1, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
  "llvm.return"(%2) : (i32) -> ()
}
]
set_option debug.skipKernelTC true in
theorem zext_false_val_must_be_zero_proof : zext_false_val_must_be_zero_before ⊑ zext_false_val_must_be_zero_after := by
  unfold zext_false_val_must_be_zero_before zext_false_val_must_be_zero_after
  simp_alive_peephole
  intros
  ---BEGIN zext_false_val_must_be_zero
  all_goals (try extract_goal ; sorry)
  ---END zext_false_val_must_be_zero


