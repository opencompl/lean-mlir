import SSA.Projects.InstCombine.tests.proofs.gselecthsafehboolhtransforms_proof
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
section gselecthsafehboolhtransforms_statements

def land_land_left1_before := [llvm|
{
^0(%arg102 : i1, %arg103 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg102, %arg103, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = "llvm.select"(%1, %arg102, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def land_land_left1_after := [llvm|
{
^0(%arg102 : i1, %arg103 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg102, %arg103, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem land_land_left1_proof : land_land_left1_before ⊑ land_land_left1_after := by
  unfold land_land_left1_before land_land_left1_after
  simp_alive_peephole
  intros
  ---BEGIN land_land_left1
  apply land_land_left1_thm
  ---END land_land_left1



def land_land_left2_before := [llvm|
{
^0(%arg100 : i1, %arg101 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg101, %arg100, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = "llvm.select"(%1, %arg100, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def land_land_left2_after := [llvm|
{
^0(%arg100 : i1, %arg101 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg101, %arg100, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem land_land_left2_proof : land_land_left2_before ⊑ land_land_left2_after := by
  unfold land_land_left2_before land_land_left2_after
  simp_alive_peephole
  intros
  ---BEGIN land_land_left2
  apply land_land_left2_thm
  ---END land_land_left2



def land_band_left1_before := [llvm|
{
^0(%arg98 : i1, %arg99 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg98, %arg99, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = llvm.and %1, %arg98 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def land_band_left1_after := [llvm|
{
^0(%arg98 : i1, %arg99 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg98, %arg99, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem land_band_left1_proof : land_band_left1_before ⊑ land_band_left1_after := by
  unfold land_band_left1_before land_band_left1_after
  simp_alive_peephole
  intros
  ---BEGIN land_band_left1
  apply land_band_left1_thm
  ---END land_band_left1



def land_band_left2_before := [llvm|
{
^0(%arg96 : i1, %arg97 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg97, %arg96, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = llvm.and %1, %arg96 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def land_band_left2_after := [llvm|
{
^0(%arg96 : i1, %arg97 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg97, %arg96, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem land_band_left2_proof : land_band_left2_before ⊑ land_band_left2_after := by
  unfold land_band_left2_before land_band_left2_after
  simp_alive_peephole
  intros
  ---BEGIN land_band_left2
  apply land_band_left2_thm
  ---END land_band_left2



def land_lor_left1_before := [llvm|
{
^0(%arg94 : i1, %arg95 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg94, %arg95, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%2, %1, %arg94) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def land_lor_left1_after := [llvm|
{
^0(%arg94 : i1, %arg95 : i1):
  "llvm.return"(%arg94) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem land_lor_left1_proof : land_lor_left1_before ⊑ land_lor_left1_after := by
  unfold land_lor_left1_before land_lor_left1_after
  simp_alive_peephole
  intros
  ---BEGIN land_lor_left1
  apply land_lor_left1_thm
  ---END land_lor_left1



def land_lor_left2_before := [llvm|
{
^0(%arg92 : i1, %arg93 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg93, %arg92, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%2, %1, %arg92) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def land_lor_left2_after := [llvm|
{
^0(%arg92 : i1, %arg93 : i1):
  "llvm.return"(%arg92) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem land_lor_left2_proof : land_lor_left2_before ⊑ land_lor_left2_after := by
  unfold land_lor_left2_before land_lor_left2_after
  simp_alive_peephole
  intros
  ---BEGIN land_lor_left2
  apply land_lor_left2_thm
  ---END land_lor_left2



def land_bor_left1_before := [llvm|
{
^0(%arg90 : i1, %arg91 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg90, %arg91, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = llvm.or %1, %arg90 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def land_bor_left1_after := [llvm|
{
^0(%arg90 : i1, %arg91 : i1):
  "llvm.return"(%arg90) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem land_bor_left1_proof : land_bor_left1_before ⊑ land_bor_left1_after := by
  unfold land_bor_left1_before land_bor_left1_after
  simp_alive_peephole
  intros
  ---BEGIN land_bor_left1
  apply land_bor_left1_thm
  ---END land_bor_left1



def land_bor_left2_before := [llvm|
{
^0(%arg88 : i1, %arg89 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg89, %arg88, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = llvm.or %1, %arg88 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def land_bor_left2_after := [llvm|
{
^0(%arg88 : i1, %arg89 : i1):
  "llvm.return"(%arg88) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem land_bor_left2_proof : land_bor_left2_before ⊑ land_bor_left2_after := by
  unfold land_bor_left2_before land_bor_left2_after
  simp_alive_peephole
  intros
  ---BEGIN land_bor_left2
  apply land_bor_left2_thm
  ---END land_bor_left2



def band_land_left1_before := [llvm|
{
^0(%arg86 : i1, %arg87 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.and %arg86, %arg87 : i1
  %2 = "llvm.select"(%1, %arg86, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def band_land_left1_after := [llvm|
{
^0(%arg86 : i1, %arg87 : i1):
  %0 = llvm.and %arg86, %arg87 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem band_land_left1_proof : band_land_left1_before ⊑ band_land_left1_after := by
  unfold band_land_left1_before band_land_left1_after
  simp_alive_peephole
  intros
  ---BEGIN band_land_left1
  apply band_land_left1_thm
  ---END band_land_left1



def band_land_left2_before := [llvm|
{
^0(%arg84 : i1, %arg85 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.and %arg85, %arg84 : i1
  %2 = "llvm.select"(%1, %arg84, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def band_land_left2_after := [llvm|
{
^0(%arg84 : i1, %arg85 : i1):
  %0 = llvm.and %arg85, %arg84 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem band_land_left2_proof : band_land_left2_before ⊑ band_land_left2_after := by
  unfold band_land_left2_before band_land_left2_after
  simp_alive_peephole
  intros
  ---BEGIN band_land_left2
  apply band_land_left2_thm
  ---END band_land_left2



def band_lor_left1_before := [llvm|
{
^0(%arg82 : i1, %arg83 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.and %arg82, %arg83 : i1
  %2 = "llvm.select"(%1, %0, %arg82) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def band_lor_left1_after := [llvm|
{
^0(%arg82 : i1, %arg83 : i1):
  "llvm.return"(%arg82) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem band_lor_left1_proof : band_lor_left1_before ⊑ band_lor_left1_after := by
  unfold band_lor_left1_before band_lor_left1_after
  simp_alive_peephole
  intros
  ---BEGIN band_lor_left1
  apply band_lor_left1_thm
  ---END band_lor_left1



def band_lor_left2_before := [llvm|
{
^0(%arg80 : i1, %arg81 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.and %arg81, %arg80 : i1
  %2 = "llvm.select"(%1, %0, %arg80) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def band_lor_left2_after := [llvm|
{
^0(%arg80 : i1, %arg81 : i1):
  "llvm.return"(%arg80) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem band_lor_left2_proof : band_lor_left2_before ⊑ band_lor_left2_after := by
  unfold band_lor_left2_before band_lor_left2_after
  simp_alive_peephole
  intros
  ---BEGIN band_lor_left2
  apply band_lor_left2_thm
  ---END band_lor_left2



def lor_land_left1_before := [llvm|
{
^0(%arg78 : i1, %arg79 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = "llvm.select"(%arg78, %0, %arg79) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%2, %arg78, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def lor_land_left1_after := [llvm|
{
^0(%arg78 : i1, %arg79 : i1):
  "llvm.return"(%arg78) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lor_land_left1_proof : lor_land_left1_before ⊑ lor_land_left1_after := by
  unfold lor_land_left1_before lor_land_left1_after
  simp_alive_peephole
  intros
  ---BEGIN lor_land_left1
  apply lor_land_left1_thm
  ---END lor_land_left1



def lor_land_left2_before := [llvm|
{
^0(%arg76 : i1, %arg77 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = "llvm.select"(%arg77, %0, %arg76) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%2, %arg76, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def lor_land_left2_after := [llvm|
{
^0(%arg76 : i1, %arg77 : i1):
  "llvm.return"(%arg76) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lor_land_left2_proof : lor_land_left2_before ⊑ lor_land_left2_after := by
  unfold lor_land_left2_before lor_land_left2_after
  simp_alive_peephole
  intros
  ---BEGIN lor_land_left2
  apply lor_land_left2_thm
  ---END lor_land_left2



def lor_band_left1_before := [llvm|
{
^0(%arg74 : i1, %arg75 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg74, %0, %arg75) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = llvm.and %1, %arg74 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def lor_band_left1_after := [llvm|
{
^0(%arg74 : i1, %arg75 : i1):
  "llvm.return"(%arg74) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lor_band_left1_proof : lor_band_left1_before ⊑ lor_band_left1_after := by
  unfold lor_band_left1_before lor_band_left1_after
  simp_alive_peephole
  intros
  ---BEGIN lor_band_left1
  apply lor_band_left1_thm
  ---END lor_band_left1



def lor_band_left2_before := [llvm|
{
^0(%arg72 : i1, %arg73 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg73, %0, %arg72) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = llvm.and %1, %arg72 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def lor_band_left2_after := [llvm|
{
^0(%arg72 : i1, %arg73 : i1):
  "llvm.return"(%arg72) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lor_band_left2_proof : lor_band_left2_before ⊑ lor_band_left2_after := by
  unfold lor_band_left2_before lor_band_left2_after
  simp_alive_peephole
  intros
  ---BEGIN lor_band_left2
  apply lor_band_left2_thm
  ---END lor_band_left2



def lor_lor_left1_before := [llvm|
{
^0(%arg70 : i1, %arg71 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg70, %0, %arg71) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = "llvm.select"(%1, %0, %arg70) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def lor_lor_left1_after := [llvm|
{
^0(%arg70 : i1, %arg71 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg70, %0, %arg71) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lor_lor_left1_proof : lor_lor_left1_before ⊑ lor_lor_left1_after := by
  unfold lor_lor_left1_before lor_lor_left1_after
  simp_alive_peephole
  intros
  ---BEGIN lor_lor_left1
  apply lor_lor_left1_thm
  ---END lor_lor_left1



def lor_lor_left2_before := [llvm|
{
^0(%arg68 : i1, %arg69 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg69, %0, %arg68) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = "llvm.select"(%1, %0, %arg68) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def lor_lor_left2_after := [llvm|
{
^0(%arg68 : i1, %arg69 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg69, %0, %arg68) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lor_lor_left2_proof : lor_lor_left2_before ⊑ lor_lor_left2_after := by
  unfold lor_lor_left2_before lor_lor_left2_after
  simp_alive_peephole
  intros
  ---BEGIN lor_lor_left2
  apply lor_lor_left2_thm
  ---END lor_lor_left2



def lor_bor_left1_before := [llvm|
{
^0(%arg66 : i1, %arg67 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg66, %0, %arg67) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = llvm.or %1, %arg66 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def lor_bor_left1_after := [llvm|
{
^0(%arg66 : i1, %arg67 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg66, %0, %arg67) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lor_bor_left1_proof : lor_bor_left1_before ⊑ lor_bor_left1_after := by
  unfold lor_bor_left1_before lor_bor_left1_after
  simp_alive_peephole
  intros
  ---BEGIN lor_bor_left1
  apply lor_bor_left1_thm
  ---END lor_bor_left1



def lor_bor_left2_before := [llvm|
{
^0(%arg64 : i1, %arg65 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg65, %0, %arg64) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = llvm.or %1, %arg64 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def lor_bor_left2_after := [llvm|
{
^0(%arg64 : i1, %arg65 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg65, %0, %arg64) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lor_bor_left2_proof : lor_bor_left2_before ⊑ lor_bor_left2_after := by
  unfold lor_bor_left2_before lor_bor_left2_after
  simp_alive_peephole
  intros
  ---BEGIN lor_bor_left2
  apply lor_bor_left2_thm
  ---END lor_bor_left2



def bor_land_left1_before := [llvm|
{
^0(%arg62 : i1, %arg63 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.or %arg62, %arg63 : i1
  %2 = "llvm.select"(%1, %arg62, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def bor_land_left1_after := [llvm|
{
^0(%arg62 : i1, %arg63 : i1):
  "llvm.return"(%arg62) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bor_land_left1_proof : bor_land_left1_before ⊑ bor_land_left1_after := by
  unfold bor_land_left1_before bor_land_left1_after
  simp_alive_peephole
  intros
  ---BEGIN bor_land_left1
  apply bor_land_left1_thm
  ---END bor_land_left1



def bor_land_left2_before := [llvm|
{
^0(%arg60 : i1, %arg61 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.or %arg61, %arg60 : i1
  %2 = "llvm.select"(%1, %arg60, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def bor_land_left2_after := [llvm|
{
^0(%arg60 : i1, %arg61 : i1):
  "llvm.return"(%arg60) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bor_land_left2_proof : bor_land_left2_before ⊑ bor_land_left2_after := by
  unfold bor_land_left2_before bor_land_left2_after
  simp_alive_peephole
  intros
  ---BEGIN bor_land_left2
  apply bor_land_left2_thm
  ---END bor_land_left2



def bor_lor_left1_before := [llvm|
{
^0(%arg58 : i1, %arg59 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.or %arg58, %arg59 : i1
  %2 = "llvm.select"(%1, %0, %arg58) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def bor_lor_left1_after := [llvm|
{
^0(%arg58 : i1, %arg59 : i1):
  %0 = llvm.or %arg58, %arg59 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bor_lor_left1_proof : bor_lor_left1_before ⊑ bor_lor_left1_after := by
  unfold bor_lor_left1_before bor_lor_left1_after
  simp_alive_peephole
  intros
  ---BEGIN bor_lor_left1
  apply bor_lor_left1_thm
  ---END bor_lor_left1



def bor_lor_left2_before := [llvm|
{
^0(%arg56 : i1, %arg57 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.or %arg57, %arg56 : i1
  %2 = "llvm.select"(%1, %0, %arg56) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def bor_lor_left2_after := [llvm|
{
^0(%arg56 : i1, %arg57 : i1):
  %0 = llvm.or %arg57, %arg56 : i1
  "llvm.return"(%0) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bor_lor_left2_proof : bor_lor_left2_before ⊑ bor_lor_left2_after := by
  unfold bor_lor_left2_before bor_lor_left2_after
  simp_alive_peephole
  intros
  ---BEGIN bor_lor_left2
  apply bor_lor_left2_thm
  ---END bor_lor_left2



def land_land_right1_before := [llvm|
{
^0(%arg54 : i1, %arg55 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg54, %arg55, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = "llvm.select"(%arg54, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def land_land_right1_after := [llvm|
{
^0(%arg54 : i1, %arg55 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg54, %arg55, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem land_land_right1_proof : land_land_right1_before ⊑ land_land_right1_after := by
  unfold land_land_right1_before land_land_right1_after
  simp_alive_peephole
  intros
  ---BEGIN land_land_right1
  apply land_land_right1_thm
  ---END land_land_right1



def land_land_right2_before := [llvm|
{
^0(%arg52 : i1, %arg53 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg53, %arg52, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = "llvm.select"(%arg52, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def land_land_right2_after := [llvm|
{
^0(%arg52 : i1, %arg53 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg52, %arg53, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem land_land_right2_proof : land_land_right2_before ⊑ land_land_right2_after := by
  unfold land_land_right2_before land_land_right2_after
  simp_alive_peephole
  intros
  ---BEGIN land_land_right2
  apply land_land_right2_thm
  ---END land_land_right2



def land_band_right1_before := [llvm|
{
^0(%arg50 : i1, %arg51 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg50, %arg51, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = llvm.and %arg50, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def land_band_right1_after := [llvm|
{
^0(%arg50 : i1, %arg51 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg50, %arg51, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem land_band_right1_proof : land_band_right1_before ⊑ land_band_right1_after := by
  unfold land_band_right1_before land_band_right1_after
  simp_alive_peephole
  intros
  ---BEGIN land_band_right1
  apply land_band_right1_thm
  ---END land_band_right1



def land_band_right2_before := [llvm|
{
^0(%arg48 : i1, %arg49 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg49, %arg48, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = llvm.and %arg48, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def land_band_right2_after := [llvm|
{
^0(%arg48 : i1, %arg49 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg49, %arg48, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem land_band_right2_proof : land_band_right2_before ⊑ land_band_right2_after := by
  unfold land_band_right2_before land_band_right2_after
  simp_alive_peephole
  intros
  ---BEGIN land_band_right2
  apply land_band_right2_thm
  ---END land_band_right2



def land_lor_right1_before := [llvm|
{
^0(%arg46 : i1, %arg47 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg46, %arg47, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg46, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def land_lor_right1_after := [llvm|
{
^0(%arg46 : i1, %arg47 : i1):
  "llvm.return"(%arg46) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem land_lor_right1_proof : land_lor_right1_before ⊑ land_lor_right1_after := by
  unfold land_lor_right1_before land_lor_right1_after
  simp_alive_peephole
  intros
  ---BEGIN land_lor_right1
  apply land_lor_right1_thm
  ---END land_lor_right1



def land_lor_right2_before := [llvm|
{
^0(%arg44 : i1, %arg45 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.mlir.constant(true) : i1
  %2 = "llvm.select"(%arg45, %arg44, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg44, %1, %2) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def land_lor_right2_after := [llvm|
{
^0(%arg44 : i1, %arg45 : i1):
  "llvm.return"(%arg44) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem land_lor_right2_proof : land_lor_right2_before ⊑ land_lor_right2_after := by
  unfold land_lor_right2_before land_lor_right2_after
  simp_alive_peephole
  intros
  ---BEGIN land_lor_right2
  apply land_lor_right2_thm
  ---END land_lor_right2



def land_bor_right1_before := [llvm|
{
^0(%arg38 : i1, %arg39 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg38, %arg39, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = llvm.or %arg38, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def land_bor_right1_after := [llvm|
{
^0(%arg38 : i1, %arg39 : i1):
  "llvm.return"(%arg38) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem land_bor_right1_proof : land_bor_right1_before ⊑ land_bor_right1_after := by
  unfold land_bor_right1_before land_bor_right1_after
  simp_alive_peephole
  intros
  ---BEGIN land_bor_right1
  apply land_bor_right1_thm
  ---END land_bor_right1



def land_bor_right2_before := [llvm|
{
^0(%arg36 : i1, %arg37 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg37, %arg36, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = llvm.or %arg36, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def land_bor_right2_after := [llvm|
{
^0(%arg36 : i1, %arg37 : i1):
  "llvm.return"(%arg36) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem land_bor_right2_proof : land_bor_right2_before ⊑ land_bor_right2_after := by
  unfold land_bor_right2_before land_bor_right2_after
  simp_alive_peephole
  intros
  ---BEGIN land_bor_right2
  apply land_bor_right2_thm
  ---END land_bor_right2



def band_land_right1_before := [llvm|
{
^0(%arg34 : i1, %arg35 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.and %arg34, %arg35 : i1
  %2 = "llvm.select"(%arg34, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def band_land_right1_after := [llvm|
{
^0(%arg34 : i1, %arg35 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg34, %arg35, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem band_land_right1_proof : band_land_right1_before ⊑ band_land_right1_after := by
  unfold band_land_right1_before band_land_right1_after
  simp_alive_peephole
  intros
  ---BEGIN band_land_right1
  apply band_land_right1_thm
  ---END band_land_right1



def band_land_right2_before := [llvm|
{
^0(%arg32 : i1, %arg33 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.and %arg33, %arg32 : i1
  %2 = "llvm.select"(%arg32, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def band_land_right2_after := [llvm|
{
^0(%arg32 : i1, %arg33 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = "llvm.select"(%arg32, %arg33, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem band_land_right2_proof : band_land_right2_before ⊑ band_land_right2_after := by
  unfold band_land_right2_before band_land_right2_after
  simp_alive_peephole
  intros
  ---BEGIN band_land_right2
  apply band_land_right2_thm
  ---END band_land_right2



def band_lor_right1_before := [llvm|
{
^0(%arg30 : i1, %arg31 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.and %arg30, %arg31 : i1
  %2 = "llvm.select"(%arg30, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def band_lor_right1_after := [llvm|
{
^0(%arg30 : i1, %arg31 : i1):
  "llvm.return"(%arg30) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem band_lor_right1_proof : band_lor_right1_before ⊑ band_lor_right1_after := by
  unfold band_lor_right1_before band_lor_right1_after
  simp_alive_peephole
  intros
  ---BEGIN band_lor_right1
  apply band_lor_right1_thm
  ---END band_lor_right1



def band_lor_right2_before := [llvm|
{
^0(%arg28 : i1, %arg29 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.and %arg29, %arg28 : i1
  %2 = "llvm.select"(%arg28, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def band_lor_right2_after := [llvm|
{
^0(%arg28 : i1, %arg29 : i1):
  "llvm.return"(%arg28) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem band_lor_right2_proof : band_lor_right2_before ⊑ band_lor_right2_after := by
  unfold band_lor_right2_before band_lor_right2_after
  simp_alive_peephole
  intros
  ---BEGIN band_lor_right2
  apply band_lor_right2_thm
  ---END band_lor_right2



def lor_land_right1_before := [llvm|
{
^0(%arg26 : i1, %arg27 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = "llvm.select"(%arg26, %0, %arg27) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg26, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def lor_land_right1_after := [llvm|
{
^0(%arg26 : i1, %arg27 : i1):
  "llvm.return"(%arg26) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lor_land_right1_proof : lor_land_right1_before ⊑ lor_land_right1_after := by
  unfold lor_land_right1_before lor_land_right1_after
  simp_alive_peephole
  intros
  ---BEGIN lor_land_right1
  apply lor_land_right1_thm
  ---END lor_land_right1



def lor_land_right2_before := [llvm|
{
^0(%arg24 : i1, %arg25 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.mlir.constant(false) : i1
  %2 = "llvm.select"(%arg25, %0, %arg24) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %3 = "llvm.select"(%arg24, %2, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%3) : (i1) -> ()
}
]
def lor_land_right2_after := [llvm|
{
^0(%arg24 : i1, %arg25 : i1):
  "llvm.return"(%arg24) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lor_land_right2_proof : lor_land_right2_before ⊑ lor_land_right2_after := by
  unfold lor_land_right2_before lor_land_right2_after
  simp_alive_peephole
  intros
  ---BEGIN lor_land_right2
  apply lor_land_right2_thm
  ---END lor_land_right2



def lor_band_right1_before := [llvm|
{
^0(%arg22 : i1, %arg23 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg22, %0, %arg23) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = llvm.and %arg22, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def lor_band_right1_after := [llvm|
{
^0(%arg22 : i1, %arg23 : i1):
  "llvm.return"(%arg22) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lor_band_right1_proof : lor_band_right1_before ⊑ lor_band_right1_after := by
  unfold lor_band_right1_before lor_band_right1_after
  simp_alive_peephole
  intros
  ---BEGIN lor_band_right1
  apply lor_band_right1_thm
  ---END lor_band_right1



def lor_band_right2_before := [llvm|
{
^0(%arg20 : i1, %arg21 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg21, %0, %arg20) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = llvm.and %arg20, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def lor_band_right2_after := [llvm|
{
^0(%arg20 : i1, %arg21 : i1):
  "llvm.return"(%arg20) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lor_band_right2_proof : lor_band_right2_before ⊑ lor_band_right2_after := by
  unfold lor_band_right2_before lor_band_right2_after
  simp_alive_peephole
  intros
  ---BEGIN lor_band_right2
  apply lor_band_right2_thm
  ---END lor_band_right2



def lor_lor_right1_before := [llvm|
{
^0(%arg18 : i1, %arg19 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg18, %0, %arg19) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = "llvm.select"(%arg18, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def lor_lor_right1_after := [llvm|
{
^0(%arg18 : i1, %arg19 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg18, %0, %arg19) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lor_lor_right1_proof : lor_lor_right1_before ⊑ lor_lor_right1_after := by
  unfold lor_lor_right1_before lor_lor_right1_after
  simp_alive_peephole
  intros
  ---BEGIN lor_lor_right1
  apply lor_lor_right1_thm
  ---END lor_lor_right1



def lor_lor_right2_before := [llvm|
{
^0(%arg16 : i1, %arg17 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg17, %0, %arg16) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = "llvm.select"(%arg16, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def lor_lor_right2_after := [llvm|
{
^0(%arg16 : i1, %arg17 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg16, %0, %arg17) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lor_lor_right2_proof : lor_lor_right2_before ⊑ lor_lor_right2_after := by
  unfold lor_lor_right2_before lor_lor_right2_after
  simp_alive_peephole
  intros
  ---BEGIN lor_lor_right2
  apply lor_lor_right2_thm
  ---END lor_lor_right2



def lor_bor_right1_before := [llvm|
{
^0(%arg14 : i1, %arg15 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg14, %0, %arg15) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = llvm.or %arg14, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def lor_bor_right1_after := [llvm|
{
^0(%arg14 : i1, %arg15 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg14, %0, %arg15) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lor_bor_right1_proof : lor_bor_right1_before ⊑ lor_bor_right1_after := by
  unfold lor_bor_right1_before lor_bor_right1_after
  simp_alive_peephole
  intros
  ---BEGIN lor_bor_right1
  apply lor_bor_right1_thm
  ---END lor_bor_right1



def lor_bor_right2_before := [llvm|
{
^0(%arg12 : i1, %arg13 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg13, %0, %arg12) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  %2 = llvm.or %arg12, %1 : i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def lor_bor_right2_after := [llvm|
{
^0(%arg12 : i1, %arg13 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg13, %0, %arg12) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem lor_bor_right2_proof : lor_bor_right2_before ⊑ lor_bor_right2_after := by
  unfold lor_bor_right2_before lor_bor_right2_after
  simp_alive_peephole
  intros
  ---BEGIN lor_bor_right2
  apply lor_bor_right2_thm
  ---END lor_bor_right2



def bor_land_right1_before := [llvm|
{
^0(%arg10 : i1, %arg11 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.or %arg10, %arg11 : i1
  %2 = "llvm.select"(%arg10, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def bor_land_right1_after := [llvm|
{
^0(%arg10 : i1, %arg11 : i1):
  "llvm.return"(%arg10) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bor_land_right1_proof : bor_land_right1_before ⊑ bor_land_right1_after := by
  unfold bor_land_right1_before bor_land_right1_after
  simp_alive_peephole
  intros
  ---BEGIN bor_land_right1
  apply bor_land_right1_thm
  ---END bor_land_right1



def bor_land_right2_before := [llvm|
{
^0(%arg8 : i1, %arg9 : i1):
  %0 = llvm.mlir.constant(false) : i1
  %1 = llvm.or %arg9, %arg8 : i1
  %2 = "llvm.select"(%arg8, %1, %0) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def bor_land_right2_after := [llvm|
{
^0(%arg8 : i1, %arg9 : i1):
  "llvm.return"(%arg8) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bor_land_right2_proof : bor_land_right2_before ⊑ bor_land_right2_after := by
  unfold bor_land_right2_before bor_land_right2_after
  simp_alive_peephole
  intros
  ---BEGIN bor_land_right2
  apply bor_land_right2_thm
  ---END bor_land_right2



def bor_lor_right1_before := [llvm|
{
^0(%arg6 : i1, %arg7 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.or %arg6, %arg7 : i1
  %2 = "llvm.select"(%arg6, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def bor_lor_right1_after := [llvm|
{
^0(%arg6 : i1, %arg7 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg6, %0, %arg7) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bor_lor_right1_proof : bor_lor_right1_before ⊑ bor_lor_right1_after := by
  unfold bor_lor_right1_before bor_lor_right1_after
  simp_alive_peephole
  intros
  ---BEGIN bor_lor_right1
  apply bor_lor_right1_thm
  ---END bor_lor_right1



def bor_lor_right2_before := [llvm|
{
^0(%arg4 : i1, %arg5 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = llvm.or %arg5, %arg4 : i1
  %2 = "llvm.select"(%arg4, %0, %1) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%2) : (i1) -> ()
}
]
def bor_lor_right2_after := [llvm|
{
^0(%arg4 : i1, %arg5 : i1):
  %0 = llvm.mlir.constant(true) : i1
  %1 = "llvm.select"(%arg4, %0, %arg5) <{"fastmathFlags" = #llvm.fastmath<none>}> : (i1, i1, i1) -> i1
  "llvm.return"(%1) : (i1) -> ()
}
]
set_option debug.skipKernelTC true in
theorem bor_lor_right2_proof : bor_lor_right2_before ⊑ bor_lor_right2_after := by
  unfold bor_lor_right2_before bor_lor_right2_after
  simp_alive_peephole
  intros
  ---BEGIN bor_lor_right2
  apply bor_lor_right2_thm
  ---END bor_lor_right2


