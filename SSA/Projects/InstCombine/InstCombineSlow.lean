import SSA.Core.WellTypedFramework
import SSA.Core.Tactic
import SSA.Core.Util
import SSA.Projects.InstCombine.InstCombineBase
import SSA.Projects.InstCombine.InstCombineAliveStatements

open SSA InstCombine EDSL

set_option trace.profiler true

theorem alive_AddSub_1043 : forall (w : Nat) (Z C1 RHS : Nat), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (Z)) %v0
  dsl_ret %v1
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := unit: ;
  %v2 := unit: ;
  %v3 := unit: ;
  %v4 := unit: ;
  %v5 := unit: ;
  %v6 := unit: ;
  %v7 := unit: ;
  %v8 := unit: ;
  %v9 := unit: ;
  %v10 := unit: ;
  %v11 := unit: ;
  %v12 := unit: ;
  %v13 := unit: ;
  %v14 := unit: ;
  %v15 := unit: ;
  %v16 := unit: ;
  %v17 := unit: ;
  %v18 := unit: ;
  %v19 := unit: ;
  %v43 := op:const (Bitvec.ofInt w (RHS)) %v19
  dsl_ret %v43
  ]
  := by
      intros
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      rw [TSSA.eval]
      simp only [TSSA.eval]
      sorry
