/-
Released under Apache 2.0 license as described in the file LICENSE.
-/

import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Projects.InstCombine.Tactic
import SSA.Projects.InstCombine.TacticAuto

/-!
This file serves as a canary for when the performance of our elaborator becomes notably worse.
Tip: when you start getting time-outs, replace
```
set_option maxHeartbeats _ in
```
with
```
count_heartbeats in
```
to get a count of how many heartbeats are now needed.
-/

open MLIR AST

namespace LLVMScaling

set_option maxRecDepth 1100
set_option maxHeartbeats 400000

def and_sequence_10_lhs (w : Nat)   :=
[alive_icom ( w )| {
^bb0(%C1 : _, %Z : _):
  %v1 = "llvm.and" (%Z,%C1) : (_, _) -> (_)
  %v2 = "llvm.and" (%v1,%C1) : (_, _) -> (_)
  %v3 = "llvm.and" (%v2,%C1) : (_, _) -> (_)
  %v4 = "llvm.and" (%v3,%C1) : (_, _) -> (_)
  %v5 = "llvm.and" (%v4,%C1) : (_, _) -> (_)
  %v6 = "llvm.and" (%v5,%C1) : (_, _) -> (_)
  %v7 = "llvm.and" (%v6,%C1) : (_, _) -> (_)
  %v8 = "llvm.and" (%v7,%C1) : (_, _) -> (_)
  %v9 = "llvm.and" (%v8,%C1) : (_, _) -> (_)
  %v10 = "llvm.and" (%v9,%C1) : (_, _) -> (_)
  "llvm.return" (%v10) : (_) -> ()
}]

def and_sequence_10_rhs (w : Nat)  :=
[alive_icom ( w )| {
^bb0(%C1 : _, %Z : _):
  %v1 = "llvm.and" (%Z, %C1) : (_, _) -> (_)
  "llvm.return" (%v1) : (_) -> ()
}]

theorem and_sequence_10_eq (w : Nat) :
    and_sequence_10_lhs w  ⊑ and_sequence_10_rhs w := by
  unfold and_sequence_10_lhs and_sequence_10_rhs
  simp_alive_peephole
  alive_auto

def and_sequence_15_lhs (w : Nat)   :=
[alive_icom ( w )| {
^bb0(%C1 : _, %Z : _):
  %v1 = "llvm.and" (%Z,%C1) : (_, _) -> (_)
  %v2 = "llvm.and" (%v1,%C1) : (_, _) -> (_)
  %v3 = "llvm.and" (%v2,%C1) : (_, _) -> (_)
  %v4 = "llvm.and" (%v3,%C1) : (_, _) -> (_)
  %v5 = "llvm.and" (%v4,%C1) : (_, _) -> (_)
  %v6 = "llvm.and" (%v5,%C1) : (_, _) -> (_)
  %v7 = "llvm.and" (%v6,%C1) : (_, _) -> (_)
  %v8 = "llvm.and" (%v7,%C1) : (_, _) -> (_)
  %v9 = "llvm.and" (%v8,%C1) : (_, _) -> (_)
  %v10 = "llvm.and" (%v9,%C1) : (_, _) -> (_)
  %v11 = "llvm.and" (%v10,%C1) : (_, _) -> (_)
  %v12 = "llvm.and" (%v11,%C1) : (_, _) -> (_)
  %v13 = "llvm.and" (%v12,%C1) : (_, _) -> (_)
  "llvm.return" (%v13) : (_) -> ()
}]

def and_sequence_15_rhs (w : Nat)  :=
[alive_icom ( w )| {
^bb0(%C1 : _, %Z : _):
  %v1 = "llvm.and" (%Z, %C1) : (_, _) -> (_)
  "llvm.return" (%v1) : (_) -> ()
}]

theorem and_sequence_15_eq (w : Nat) :
    and_sequence_15_lhs w  ⊑ and_sequence_15_rhs w := by
  unfold and_sequence_15_lhs and_sequence_15_rhs
  simp_alive_peephole
  alive_auto

set_option maxHeartbeats 500000 in
def and_sequence_20_lhs (w : Nat)   :=
[alive_icom ( w )| {
^bb0(%C1 : _, %Z : _):
  %v1 = "llvm.and" (%Z,%C1) : (_, _) -> (_)
  %v2 = "llvm.and" (%v1,%C1) : (_, _) -> (_)
  %v3 = "llvm.and" (%v2,%C1) : (_, _) -> (_)
  %v4 = "llvm.and" (%v3,%C1) : (_, _) -> (_)
  %v5 = "llvm.and" (%v4,%C1) : (_, _) -> (_)
  %v6 = "llvm.and" (%v5,%C1) : (_, _) -> (_)
  %v7 = "llvm.and" (%v6,%C1) : (_, _) -> (_)
  %v8 = "llvm.and" (%v7,%C1) : (_, _) -> (_)
  %v9 = "llvm.and" (%v8,%C1) : (_, _) -> (_)
  %v10 = "llvm.and" (%v9,%C1) : (_, _) -> (_)
  %v11 = "llvm.and" (%v10,%C1) : (_, _) -> (_)
  %v12 = "llvm.and" (%v11,%C1) : (_, _) -> (_)
  %v13 = "llvm.and" (%v12,%C1) : (_, _) -> (_)
  %v14 = "llvm.and" (%v13,%C1) : (_, _) -> (_)
  %v15 = "llvm.and" (%v14,%C1) : (_, _) -> (_)
  %v16 = "llvm.and" (%v15,%C1) : (_, _) -> (_)
  %v17 = "llvm.and" (%v16,%C1) : (_, _) -> (_)
  %v18 = "llvm.and" (%v17,%C1) : (_, _) -> (_)
  %v19 = "llvm.and" (%v18,%C1) : (_, _) -> (_)
  %v20 = "llvm.and" (%v19,%C1) : (_, _) -> (_)
  "llvm.return" (%v20) : (_) -> ()
}]

def and_sequence_20_rhs (w : Nat)  :=
[alive_icom ( w )| {
^bb0(%C1 : _, %Z : _):
  %v1 = "llvm.and" (%Z, %C1) : (_, _) -> (_)
  "llvm.return" (%v1) : (_) -> ()
}]

theorem and_sequence_20_eq (w : Nat) :
    and_sequence_20_lhs w  ⊑ and_sequence_20_rhs w := by
  unfold and_sequence_20_lhs and_sequence_20_rhs
  simp_alive_peephole
  alive_auto

set_option maxHeartbeats 1700000 in
def and_sequence_30_lhs (w : Nat)   :=
[alive_icom ( w )| {
^bb0(%C1 : _, %Z : _):
  %v1 = "llvm.and" (%Z,%C1) : (_, _) -> (_)
  %v2 = "llvm.and" (%v1,%C1) : (_, _) -> (_)
  %v3 = "llvm.and" (%v2,%C1) : (_, _) -> (_)
  %v4 = "llvm.and" (%v3,%C1) : (_, _) -> (_)
  %v5 = "llvm.and" (%v4,%C1) : (_, _) -> (_)
  %v6 = "llvm.and" (%v5,%C1) : (_, _) -> (_)
  %v7 = "llvm.and" (%v6,%C1) : (_, _) -> (_)
  %v8 = "llvm.and" (%v7,%C1) : (_, _) -> (_)
  %v9 = "llvm.and" (%v8,%C1) : (_, _) -> (_)
  %v10 = "llvm.and" (%v9,%C1) : (_, _) -> (_)
  %v11 = "llvm.and" (%v10,%C1) : (_, _) -> (_)
  %v12 = "llvm.and" (%v11,%C1) : (_, _) -> (_)
  %v13 = "llvm.and" (%v12,%C1) : (_, _) -> (_)
  %v14 = "llvm.and" (%v13,%C1) : (_, _) -> (_)
  %v15 = "llvm.and" (%v14,%C1) : (_, _) -> (_)
  %v16 = "llvm.and" (%v15,%C1) : (_, _) -> (_)
  %v17 = "llvm.and" (%v16,%C1) : (_, _) -> (_)
  %v18 = "llvm.and" (%v17,%C1) : (_, _) -> (_)
  %v19 = "llvm.and" (%v18,%C1) : (_, _) -> (_)
  %v20 = "llvm.and" (%v19,%C1) : (_, _) -> (_)
  %v21 = "llvm.and" (%v20,%C1) : (_, _) -> (_)
  %v22 = "llvm.and" (%v21,%C1) : (_, _) -> (_)
  %v23 = "llvm.and" (%v22,%C1) : (_, _) -> (_)
  %v24 = "llvm.and" (%v23,%C1) : (_, _) -> (_)
  %v25 = "llvm.and" (%v24,%C1) : (_, _) -> (_)
  %v26 = "llvm.and" (%v25,%C1) : (_, _) -> (_)
  %v27 = "llvm.and" (%v26,%C1) : (_, _) -> (_)
  %v28 = "llvm.and" (%v27,%C1) : (_, _) -> (_)
  %v29 = "llvm.and" (%v28,%C1) : (_, _) -> (_)
  %v30 = "llvm.and" (%v29,%C1) : (_, _) -> (_)
  "llvm.return" (%v30) : (_) -> ()
}]

def and_sequence_30_rhs (w : Nat)  :=
[alive_icom ( w )| {
^bb0(%C1 : _, %Z : _):
  %v1 = "llvm.and" (%Z, %C1) : (_, _) -> (_)
  "llvm.return" (%v1) : (_) -> ()
}]

theorem and_sequence_30_eq (w : Nat) :
    and_sequence_30_lhs w  ⊑ and_sequence_30_rhs w := by
  unfold and_sequence_30_lhs and_sequence_30_rhs
  simp_alive_peephole
  alive_auto

set_option maxHeartbeats 3800000 in
set_option maxRecDepth 1500 in
def and_sequence_40_lhs (w : Nat)   :=
[alive_icom ( w )| {
^bb0(%C1 : _, %Z : _):
  %v1 = "llvm.and" (%Z,%C1) : (_, _) -> (_)
  %v2 = "llvm.and" (%v1,%C1) : (_, _) -> (_)
  %v3 = "llvm.and" (%v2,%C1) : (_, _) -> (_)
  %v4 = "llvm.and" (%v3,%C1) : (_, _) -> (_)
  %v5 = "llvm.and" (%v4,%C1) : (_, _) -> (_)
  %v6 = "llvm.and" (%v5,%C1) : (_, _) -> (_)
  %v7 = "llvm.and" (%v6,%C1) : (_, _) -> (_)
  %v8 = "llvm.and" (%v7,%C1) : (_, _) -> (_)
  %v9 = "llvm.and" (%v8,%C1) : (_, _) -> (_)
  %v10 = "llvm.and" (%v9,%C1) : (_, _) -> (_)
  %v11 = "llvm.and" (%v10,%C1) : (_, _) -> (_)
  %v12 = "llvm.and" (%v11,%C1) : (_, _) -> (_)
  %v13 = "llvm.and" (%v12,%C1) : (_, _) -> (_)
  %v14 = "llvm.and" (%v13,%C1) : (_, _) -> (_)
  %v15 = "llvm.and" (%v14,%C1) : (_, _) -> (_)
  %v16 = "llvm.and" (%v15,%C1) : (_, _) -> (_)
  %v17 = "llvm.and" (%v16,%C1) : (_, _) -> (_)
  %v18 = "llvm.and" (%v17,%C1) : (_, _) -> (_)
  %v19 = "llvm.and" (%v18,%C1) : (_, _) -> (_)
  %v20 = "llvm.and" (%v19,%C1) : (_, _) -> (_)
  %v21 = "llvm.and" (%v20,%C1) : (_, _) -> (_)
  %v22 = "llvm.and" (%v21,%C1) : (_, _) -> (_)
  %v23 = "llvm.and" (%v22,%C1) : (_, _) -> (_)
  %v24 = "llvm.and" (%v23,%C1) : (_, _) -> (_)
  %v25 = "llvm.and" (%v24,%C1) : (_, _) -> (_)
  %v26 = "llvm.and" (%v25,%C1) : (_, _) -> (_)
  %v27 = "llvm.and" (%v26,%C1) : (_, _) -> (_)
  %v28 = "llvm.and" (%v27,%C1) : (_, _) -> (_)
  %v29 = "llvm.and" (%v28,%C1) : (_, _) -> (_)
  %v30 = "llvm.and" (%v29,%C1) : (_, _) -> (_)
  %v31 = "llvm.and" (%v30,%C1) : (_, _) -> (_)
  %v32 = "llvm.and" (%v31,%C1) : (_, _) -> (_)
  %v33 = "llvm.and" (%v32,%C1) : (_, _) -> (_)
  %v34 = "llvm.and" (%v33,%C1) : (_, _) -> (_)
  %v35 = "llvm.and" (%v34,%C1) : (_, _) -> (_)
  %v36 = "llvm.and" (%v35,%C1) : (_, _) -> (_)
  %v37 = "llvm.and" (%v36,%C1) : (_, _) -> (_)
  %v38 = "llvm.and" (%v37,%C1) : (_, _) -> (_)
  %v39 = "llvm.and" (%v38,%C1) : (_, _) -> (_)
  %v40 = "llvm.and" (%v39,%C1) : (_, _) -> (_)
  "llvm.return" (%v40) : (_) -> ()
}]

def and_sequence_40_rhs (w : Nat)  :=
[alive_icom ( w )| {
^bb0(%C1 : _, %Z : _):
  %v1 = "llvm.and" (%Z, %C1) : (_, _) -> (_)
  "llvm.return" (%v1) : (_) -> ()
}]

set_option maxHeartbeats 800000 in
theorem and_sequence_40_eq (w : Nat) :
    and_sequence_40_lhs w  ⊑ and_sequence_40_rhs w := by
  unfold and_sequence_40_lhs and_sequence_40_rhs
  simp_alive_peephole
  alive_auto
