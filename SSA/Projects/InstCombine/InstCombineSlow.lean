import SSA.Core.WellTypedFramework
import SSA.Core.Tactic
import SSA.Core.Util
import SSA.Projects.InstCombine.InstCombineBase
import SSA.Projects.InstCombine.InstCombineAliveStatements

open SSA InstCombine EDSL

theorem alive_many_units : forall (w : Nat) (Z : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w Z) %v0
  dsl_ret %v1
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec w)))
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
  %v20 := unit: ;
  %v21 := unit: ;
  %v22 := unit: ;
  %v23 := unit: ;
  %v24 := unit: ;
  %v25 := unit: ;
  %v26 := unit: ;
  %v27 := unit: ;
  %v28 := unit: ;
  %v29 := unit: ;
  %v30 := unit: ;
  %v31 := unit: ;
  %v32 := unit: ;
  %v33 := unit: ;
  %v34 := unit: ;
  %v35 := unit: ;
  %v36 := unit: ;
  %v37 := unit: ;
  %v38 := unit: ;
  %v39 := unit: ;
  %v40 := unit: ;
  %v41 := unit: ;
  %v42 := unit: ;
  %v43 := unit: ;
  %v44 := unit: ;
  %v45 := unit: ;
  %v46 := unit: ;
  %v47 := unit: ;
  %v48 := unit: ;
  %v49 := unit: ;
  %v50 := unit: ;
  %v51 := unit: ;
  %v52 := unit: ;
  %v53 := unit: ;
  %v54 := unit: ;
  %v55 := unit: ;
  %v56 := unit: ;
  %v57 := unit: ;
  %v58 := unit: ;
  %v59 := unit: ;
  %v60 := unit: ;
  %v61 := unit: ;
  %v62 := unit: ;
  %v63 := unit: ;
  %v64 := unit: ;
  %v65 := unit: ;
  %v66 := unit: ;
  %v67 := unit: ;
  %v68 := unit: ;
  %v69 := unit: ;
  %v70 := unit: ;
  %v71 := unit: ;
  %v72 := unit: ;
  %v73 := unit: ;
  %v74 := unit: ;
  %v75 := unit: ;
  %v76 := unit: ;
  %v77 := unit: ;
  %v78 := unit: ;
  %v79 := unit: ;
  %v80 := unit: ;
  %v81 := unit: ;
  %v82 := unit: ;
  %v83 := unit: ;
  %v84 := unit: ;
  %v85 := unit: ;
  %v86 := unit: ;
  %v87 := unit: ;
  %v88 := unit: ;
  %v89 := unit: ;
  %v90 := unit: ;
  %v91 := unit: ;
  %v92 := unit: ;
  %v93 := unit: ;
  %v94 := unit: ;
  %v95 := unit: ;
  %v96 := unit: ;
  %v97 := unit: ;
  %v98 := unit: ;
  %v99 := unit: ;
  %v100 := op:const (Bitvec.ofInt w Z) %v 99
  dsl_ret %v100
  ]
  := by
      intros
      simp_mlir
      sorry
