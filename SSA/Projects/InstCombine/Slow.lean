/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import LeanMLIR.WellTypedFramework
import LeanMLIR.Tactic
import LeanMLIR.Util
import SSA.Projects.InstCombine.Tactic
import SSA.Projects.InstCombine.Base

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
      simp_alive
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
      simp_alive
      simp [Bitvec.Refinement.bothSome]


-- This is getting very slow with larger bitwidths.
-- AKA: This runs in a compute out when replacing 8 by 16.
theorem alive_fixed_size_integer: TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 8)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 8 4) %v0
  dsl_ret %v1
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 8)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 8 4) %v0
  dsl_ret %v1
  ]
  := by
      intros
      simp [TSSA.eval, Function.comp, id.def, TypedUserSemantics,
        TypedUserSemantics.eval, Context.Var,
        TypedUserSemantics.outUserType, TypedUserSemantics.argUserType,
        UserType.mkPair, UserType.mkTriple]

theorem alive_constant_fold_1: forall (w : Nat), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (0)) %v0
  dsl_ret %v1
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v000 := unit: ;
  %v001 := op:const (Bitvec.ofInt w (0)) %v000;
  %v100 := pair:%v001 %v001;
  %v101 := op:add w %v100
  dsl_ret %v101
  ]
  := by
      intros
      simp_mlir
      simp_alive
      sorry


theorem alive_constant_fold_10: forall (w : Nat), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (0)) %v0
  dsl_ret %v1
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v000 := unit: ;
  %v001 := op:const (Bitvec.ofInt w (0)) %v000;
  %v100 := pair:%v001 %v001;
  %v101 := op:add w %v100;
  %v110 := pair:%v101 %v001;
  %v111 := op:add w %v110;
  %v120 := pair:%v111 %v001;
  %v121 := op:add w %v120;
  %v130 := pair:%v121 %v001;
  %v131 := op:add w %v130;
  %v140 := pair:%v131 %v001;
  %v141 := op:add w %v140;
  %v150 := pair:%v141 %v001;
  %v151 := op:add w %v150;
  %v160 := pair:%v151 %v001;
  %v161 := op:add w %v160;
  %v170 := pair:%v161 %v001;
  %v171 := op:add w %v170;
  %v180 := pair:%v171 %v001;
  %v181 := op:add w %v180;
  %v190 := pair:%v181 %v001;
  %v191 := op:add w %v190
  dsl_ret %v191
  ]
  := by
      intros
      simp_mlir
      simp_alive
      sorry


theorem alive_constant_fold_100: forall (w : Nat), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (0)) %v0
  dsl_ret %v1
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v000 := unit: ;
  %v001 := op:const (Bitvec.ofInt w (0)) %v000;
  %v100 := pair:%v001 %v001;
  %v101 := op:add w %v100;
  %v110 := pair:%v101 %v001;
  %v111 := op:add w %v110;
  %v120 := pair:%v111 %v001;
  %v121 := op:add w %v120;
  %v130 := pair:%v121 %v001;
  %v131 := op:add w %v130;
  %v140 := pair:%v131 %v001;
  %v141 := op:add w %v140;
  %v150 := pair:%v141 %v001;
  %v151 := op:add w %v150;
  %v160 := pair:%v151 %v001;
  %v161 := op:add w %v160;
  %v170 := pair:%v161 %v001;
  %v171 := op:add w %v170;
  %v180 := pair:%v171 %v001;
  %v181 := op:add w %v180;
  %v190 := pair:%v181 %v001;
  %v191 := op:add w %v190;
  %v200 := pair:%v191 %v001;
  %v201 := op:add w %v200;
  %v210 := pair:%v201 %v001;
  %v211 := op:add w %v210;
  %v220 := pair:%v211 %v001;
  %v221 := op:add w %v220;
  %v230 := pair:%v221 %v001;
  %v231 := op:add w %v230;
  %v240 := pair:%v231 %v001;
  %v241 := op:add w %v240;
  %v250 := pair:%v241 %v001;
  %v251 := op:add w %v250;
  %v260 := pair:%v251 %v001;
  %v261 := op:add w %v260;
  %v270 := pair:%v261 %v001;
  %v271 := op:add w %v270;
  %v280 := pair:%v271 %v001;
  %v281 := op:add w %v280;
  %v290 := pair:%v281 %v001;
  %v291 := op:add w %v290;
  %v300 := pair:%v291 %v001;
  %v301 := op:add w %v300;
  %v310 := pair:%v301 %v001;
  %v311 := op:add w %v310;
  %v320 := pair:%v311 %v001;
  %v321 := op:add w %v320;
  %v330 := pair:%v321 %v001;
  %v331 := op:add w %v330;
  %v340 := pair:%v331 %v001;
  %v341 := op:add w %v340;
  %v350 := pair:%v341 %v001;
  %v351 := op:add w %v350;
  %v360 := pair:%v351 %v001;
  %v361 := op:add w %v360;
  %v370 := pair:%v361 %v001;
  %v371 := op:add w %v370;
  %v380 := pair:%v371 %v001;
  %v381 := op:add w %v380;
  %v390 := pair:%v381 %v001;
  %v391 := op:add w %v390;
  %v400 := pair:%v391 %v001;
  %v401 := op:add w %v400;
  %v410 := pair:%v401 %v001;
  %v411 := op:add w %v410;
  %v420 := pair:%v411 %v001;
  %v421 := op:add w %v420;
  %v430 := pair:%v421 %v001;
  %v431 := op:add w %v430;
  %v440 := pair:%v431 %v001;
  %v441 := op:add w %v440;
  %v450 := pair:%v441 %v001;
  %v451 := op:add w %v450;
  %v460 := pair:%v451 %v001;
  %v461 := op:add w %v460;
  %v470 := pair:%v461 %v001;
  %v471 := op:add w %v470;
  %v480 := pair:%v471 %v001;
  %v481 := op:add w %v480;
  %v490 := pair:%v481 %v001;
  %v491 := op:add w %v490;
  %v500 := pair:%v491 %v001;
  %v501 := op:add w %v500;
  %v510 := pair:%v501 %v001;
  %v511 := op:add w %v510;
  %v520 := pair:%v511 %v001;
  %v521 := op:add w %v520;
  %v530 := pair:%v521 %v001;
  %v531 := op:add w %v530;
  %v540 := pair:%v531 %v001;
  %v541 := op:add w %v540;
  %v550 := pair:%v541 %v001;
  %v551 := op:add w %v550;
  %v560 := pair:%v551 %v001;
  %v561 := op:add w %v560;
  %v570 := pair:%v561 %v001;
  %v571 := op:add w %v570;
  %v580 := pair:%v571 %v001;
  %v581 := op:add w %v580;
  %v590 := pair:%v581 %v001;
  %v591 := op:add w %v590;
  %v600 := pair:%v591 %v001;
  %v601 := op:add w %v600;
  %v610 := pair:%v601 %v001;
  %v611 := op:add w %v610;
  %v620 := pair:%v611 %v001;
  %v621 := op:add w %v620;
  %v630 := pair:%v621 %v001;
  %v631 := op:add w %v630;
  %v640 := pair:%v631 %v001;
  %v641 := op:add w %v640;
  %v650 := pair:%v641 %v001;
  %v651 := op:add w %v650;
  %v660 := pair:%v651 %v001;
  %v661 := op:add w %v660;
  %v670 := pair:%v661 %v001;
  %v671 := op:add w %v670;
  %v680 := pair:%v671 %v001;
  %v681 := op:add w %v680;
  %v690 := pair:%v681 %v001;
  %v691 := op:add w %v690;
  %v700 := pair:%v691 %v001;
  %v701 := op:add w %v700;
  %v710 := pair:%v701 %v001;
  %v711 := op:add w %v710;
  %v720 := pair:%v711 %v001;
  %v721 := op:add w %v720;
  %v730 := pair:%v721 %v001;
  %v731 := op:add w %v730;
  %v740 := pair:%v731 %v001;
  %v741 := op:add w %v740;
  %v750 := pair:%v741 %v001;
  %v751 := op:add w %v750;
  %v760 := pair:%v751 %v001;
  %v761 := op:add w %v760;
  %v770 := pair:%v761 %v001;
  %v771 := op:add w %v770;
  %v780 := pair:%v771 %v001;
  %v781 := op:add w %v780;
  %v790 := pair:%v781 %v001;
  %v791 := op:add w %v790;
  %v800 := pair:%v791 %v001;
  %v801 := op:add w %v800;
  %v810 := pair:%v801 %v001;
  %v811 := op:add w %v810;
  %v820 := pair:%v811 %v001;
  %v821 := op:add w %v820;
  %v830 := pair:%v821 %v001;
  %v831 := op:add w %v830;
  %v840 := pair:%v831 %v001;
  %v841 := op:add w %v840;
  %v850 := pair:%v841 %v001;
  %v851 := op:add w %v850;
  %v860 := pair:%v851 %v001;
  %v861 := op:add w %v860;
  %v870 := pair:%v861 %v001;
  %v871 := op:add w %v870;
  %v880 := pair:%v871 %v001;
  %v881 := op:add w %v880;
  %v890 := pair:%v881 %v001;
  %v891 := op:add w %v890;
  %v900 := pair:%v891 %v001;
  %v901 := op:add w %v900;
  %v910 := pair:%v901 %v001;
  %v911 := op:add w %v910;
  %v920 := pair:%v911 %v001;
  %v921 := op:add w %v920;
  %v930 := pair:%v921 %v001;
  %v931 := op:add w %v930;
  %v940 := pair:%v931 %v001;
  %v941 := op:add w %v940;
  %v950 := pair:%v941 %v001;
  %v951 := op:add w %v950;
  %v960 := pair:%v951 %v001;
  %v961 := op:add w %v960;
  %v970 := pair:%v961 %v001;
  %v971 := op:add w %v970;
  %v980 := pair:%v971 %v001;
  %v981 := op:add w %v980;
  %v990 := pair:%v981 %v001;
  %v991 := op:add w %v990
  dsl_ret %v991
  ]
  := by
      intros
      simp_mlir
      simp_alive
      sorry
