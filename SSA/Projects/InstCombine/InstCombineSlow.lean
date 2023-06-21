import SSA.Core.WellTypedFramework
import SSA.Core.Tactic
import SSA.Core.Util
import SSA.Projects.InstCombine.InstCombineBase
import SSA.Projects.InstCombine.InstCombineAliveStatements

open SSA InstCombine EDSL

theorem alive_many_units : forall (w : Nat) (Z : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w Z) %v0
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
  %v100 := op:const (Bitvec.ofInt w Z) %v99
  dsl_ret %v100
  ]
  := by
      intros
      simp_mlir
      simp [Bitvec.Refinement.bothSome]


theorem alive_many_consts: forall (w : Nat) (Z : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w Z) %v0
  dsl_ret %v1
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w Z) %v0;
  %v2 := op:const (Bitvec.ofInt w Z) %v0;
  %v3 := op:const (Bitvec.ofInt w Z) %v0;
  %v4 := op:const (Bitvec.ofInt w Z) %v0;
  %v5 := op:const (Bitvec.ofInt w Z) %v0;
  %v6 := op:const (Bitvec.ofInt w Z) %v0;
  %v7 := op:const (Bitvec.ofInt w Z) %v0;
  %v8 := op:const (Bitvec.ofInt w Z) %v0;
  %v9 := op:const (Bitvec.ofInt w Z) %v0;
  %v10 := op:const (Bitvec.ofInt w Z) %v0;
  %v11 := op:const (Bitvec.ofInt w Z) %v0;
  %v12 := op:const (Bitvec.ofInt w Z) %v0;
  %v13 := op:const (Bitvec.ofInt w Z) %v0;
  %v14 := op:const (Bitvec.ofInt w Z) %v0;
  %v15 := op:const (Bitvec.ofInt w Z) %v0;
  %v16 := op:const (Bitvec.ofInt w Z) %v0;
  %v17 := op:const (Bitvec.ofInt w Z) %v0;
  %v18 := op:const (Bitvec.ofInt w Z) %v0;
  %v19 := op:const (Bitvec.ofInt w Z) %v0;
  %v20 := op:const (Bitvec.ofInt w Z) %v0;
  %v21 := op:const (Bitvec.ofInt w Z) %v0;
  %v22 := op:const (Bitvec.ofInt w Z) %v0;
  %v23 := op:const (Bitvec.ofInt w Z) %v0;
  %v24 := op:const (Bitvec.ofInt w Z) %v0;
  %v25 := op:const (Bitvec.ofInt w Z) %v0;
  %v26 := op:const (Bitvec.ofInt w Z) %v0;
  %v27 := op:const (Bitvec.ofInt w Z) %v0;
  %v28 := op:const (Bitvec.ofInt w Z) %v0;
  %v29 := op:const (Bitvec.ofInt w Z) %v0;
  %v30 := op:const (Bitvec.ofInt w Z) %v0;
  %v31 := op:const (Bitvec.ofInt w Z) %v0;
  %v32 := op:const (Bitvec.ofInt w Z) %v0;
  %v33 := op:const (Bitvec.ofInt w Z) %v0;
  %v34 := op:const (Bitvec.ofInt w Z) %v0;
  %v35 := op:const (Bitvec.ofInt w Z) %v0;
  %v36 := op:const (Bitvec.ofInt w Z) %v0;
  %v37 := op:const (Bitvec.ofInt w Z) %v0;
  %v38 := op:const (Bitvec.ofInt w Z) %v0;
  %v39 := op:const (Bitvec.ofInt w Z) %v0;
  %v40 := op:const (Bitvec.ofInt w Z) %v0;
  %v41 := op:const (Bitvec.ofInt w Z) %v0;
  %v42 := op:const (Bitvec.ofInt w Z) %v0;
  %v43 := op:const (Bitvec.ofInt w Z) %v0;
  %v44 := op:const (Bitvec.ofInt w Z) %v0;
  %v45 := op:const (Bitvec.ofInt w Z) %v0;
  %v46 := op:const (Bitvec.ofInt w Z) %v0;
  %v47 := op:const (Bitvec.ofInt w Z) %v0;
  %v48 := op:const (Bitvec.ofInt w Z) %v0;
  %v49 := op:const (Bitvec.ofInt w Z) %v0;
  %v50 := op:const (Bitvec.ofInt w Z) %v0;
  %v51 := op:const (Bitvec.ofInt w Z) %v0;
  %v52 := op:const (Bitvec.ofInt w Z) %v0;
  %v53 := op:const (Bitvec.ofInt w Z) %v0;
  %v54 := op:const (Bitvec.ofInt w Z) %v0;
  %v55 := op:const (Bitvec.ofInt w Z) %v0;
  %v56 := op:const (Bitvec.ofInt w Z) %v0;
  %v57 := op:const (Bitvec.ofInt w Z) %v0;
  %v58 := op:const (Bitvec.ofInt w Z) %v0;
  %v59 := op:const (Bitvec.ofInt w Z) %v0;
  %v60 := op:const (Bitvec.ofInt w Z) %v0;
  %v61 := op:const (Bitvec.ofInt w Z) %v0;
  %v62 := op:const (Bitvec.ofInt w Z) %v0;
  %v63 := op:const (Bitvec.ofInt w Z) %v0;
  %v64 := op:const (Bitvec.ofInt w Z) %v0;
  %v65 := op:const (Bitvec.ofInt w Z) %v0;
  %v66 := op:const (Bitvec.ofInt w Z) %v0;
  %v67 := op:const (Bitvec.ofInt w Z) %v0;
  %v68 := op:const (Bitvec.ofInt w Z) %v0;
  %v69 := op:const (Bitvec.ofInt w Z) %v0;
  %v70 := op:const (Bitvec.ofInt w Z) %v0;
  %v71 := op:const (Bitvec.ofInt w Z) %v0;
  %v72 := op:const (Bitvec.ofInt w Z) %v0;
  %v73 := op:const (Bitvec.ofInt w Z) %v0;
  %v74 := op:const (Bitvec.ofInt w Z) %v0;
  %v75 := op:const (Bitvec.ofInt w Z) %v0;
  %v76 := op:const (Bitvec.ofInt w Z) %v0;
  %v77 := op:const (Bitvec.ofInt w Z) %v0;
  %v78 := op:const (Bitvec.ofInt w Z) %v0;
  %v79 := op:const (Bitvec.ofInt w Z) %v0;
  %v80 := op:const (Bitvec.ofInt w Z) %v0;
  %v81 := op:const (Bitvec.ofInt w Z) %v0;
  %v82 := op:const (Bitvec.ofInt w Z) %v0;
  %v83 := op:const (Bitvec.ofInt w Z) %v0;
  %v84 := op:const (Bitvec.ofInt w Z) %v0;
  %v85 := op:const (Bitvec.ofInt w Z) %v0;
  %v86 := op:const (Bitvec.ofInt w Z) %v0;
  %v87 := op:const (Bitvec.ofInt w Z) %v0;
  %v88 := op:const (Bitvec.ofInt w Z) %v0;
  %v89 := op:const (Bitvec.ofInt w Z) %v0;
  %v90 := op:const (Bitvec.ofInt w Z) %v0;
  %v91 := op:const (Bitvec.ofInt w Z) %v0;
  %v92 := op:const (Bitvec.ofInt w Z) %v0;
  %v93 := op:const (Bitvec.ofInt w Z) %v0;
  %v94 := op:const (Bitvec.ofInt w Z) %v0;
  %v95 := op:const (Bitvec.ofInt w Z) %v0;
  %v96 := op:const (Bitvec.ofInt w Z) %v0;
  %v97 := op:const (Bitvec.ofInt w Z) %v0;
  %v98 := op:const (Bitvec.ofInt w Z) %v0;
  %v99 := op:const (Bitvec.ofInt w Z) %v0;
  %v100 := op:const (Bitvec.ofInt w Z) %v0
  dsl_ret %v100
  ]
  := by
      intros
      simp_mlir
      simp [Bitvec.Refinement.bothSome]
