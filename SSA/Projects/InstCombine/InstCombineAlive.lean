import SSA.Core.WellTypedFramework
import SSA.Core.Tactic
import SSA.Projects.InstCombine.InstCombineBase
import SSA.Projects.InstCombine.InstCombineAliveStatements

open SSA InstCombine EDSL


-- Name:AddSub:1043
-- precondition: true
/-
  %Y = and %Z, C1
  %X = xor %Y, C1
  %LHS = add %X, 1
  %r = add %LHS, %RHS

=>
  %or = or %Z, ~C1
  %Y = and %Z, C1
  %X = xor %Y, C1
  %LHS = add %X, 1
  %r = sub %RHS, %or

-/
theorem alive_AddSub_1043 : forall (w : Nat) (Z C1 RHS : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (Z)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:and w %v3;
  %v5 := pair:%v4 %v2;
  %v6 := op:xor w %v5;
  %v7 := op:const (Bitvec.ofInt w (1)) %v0;
  %v8 := pair:%v6 %v7;
  %v9 := op:add w %v8;
  %v10 := op:const (Bitvec.ofInt w (RHS)) %v0;
  %v11 := pair:%v9 %v10;
  %v12 := op:add w %v11
  dsl_ret %v12
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (Z)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C1)) %v0;
  %v3 := op:not w %v2;
  %v4 := pair:%v1 %v3;
  %v5 := op:or w %v4;
  %v6 := pair:%v1 %v2;
  %v7 := op:and w %v6;
  %v8 := pair:%v7 %v2;
  %v9 := op:xor w %v8;
  %v10 := op:const (Bitvec.ofInt w (1)) %v0;
  %v11 := pair:%v9 %v10;
  %v12 := op:add w %v11;
  %v13 := op:const (Bitvec.ofInt w (RHS)) %v0;
  %v14 := pair:%v13 %v5;
  %v15 := op:sub w %v14
  dsl_ret %v15
  ]
  := by
     simp_mlir
     apply bitvec_AddSub_1043 

-- Name:AddSub:1152
-- precondition: true
/-
  %r = add i1 %x, %y

=>
  %r = xor %x, %y

-/
theorem alive_AddSub_1152: forall (x y : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 1 (x)) %v0;
  %v2 := op:const (Bitvec.ofInt 1 (y)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:add 1 %v3
  dsl_ret %v4
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 1 (x)) %v0;
  %v2 := op:const (Bitvec.ofInt 1 (y)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor 1 %v3
  dsl_ret %v4
  ]
  := by
     simp_mlir
     apply bitvec_AddSub_1152

-- Name:AddSub:1156
-- precondition: true
/-
  %a = add %b, %b

=>
  %a = shl %b, 1

-/
theorem alive_AddSub_1156 : forall (w : Nat) (b : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (b)) %v0;
  %v2 := pair:%v1 %v1;
  %v3 := op:add w %v2
  dsl_ret %v3
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (b)) %v0;
  %v2 := op:const (Bitvec.ofInt w (1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:shl w %v3
  dsl_ret %v4
  ]
  := by
     simp_mlir
     apply bitvec_AddSub_1156 

-- Name:AddSub:1156-2
-- precondition: true
/-
  %a = add nsw %b, %b

=>
  %a = shl nsw %b, 1

-/
theorem alive_AddSub_1156_2 : forall (w : Nat) (b : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (b)) %v0;
  %v2 := pair:%v1 %v1;
  %v3 := op:add w %v2
  dsl_ret %v3
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (b)) %v0;
  %v2 := op:const (Bitvec.ofInt w (1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:shl w %v3
  dsl_ret %v4
  ]
  := by
     simp_mlir
     apply bitvec_AddSub_1156_2 

-- Name:AddSub:1156-3
-- precondition: true
/-
  %a = add nuw %b, %b

=>
  %a = shl nuw %b, 1

-/
theorem alive_AddSub_1156_3 : forall (w : Nat) (b : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (b)) %v0;
  %v2 := pair:%v1 %v1;
  %v3 := op:add w %v2
  dsl_ret %v3
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (b)) %v0;
  %v2 := op:const (Bitvec.ofInt w (1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:shl w %v3
  dsl_ret %v4
  ]
  := by
     simp_mlir
     apply bitvec_AddSub_1156_3 

-- Name:AddSub:1164
-- precondition: true
/-
  %na = sub 0, %a
  %c = add %na, %b

=>
  %na = sub 0, %a
  %c = sub %b, %a

-/
theorem alive_AddSub_1164 : forall (w : Nat) (a b : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (0)) %v0;
  %v2 := op:const (Bitvec.ofInt w (a)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sub w %v3;
  %v5 := op:const (Bitvec.ofInt w (b)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:add w %v6
  dsl_ret %v7
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (0)) %v0;
  %v2 := op:const (Bitvec.ofInt w (a)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sub w %v3;
  %v5 := op:const (Bitvec.ofInt w (b)) %v0;
  %v6 := pair:%v5 %v2;
  %v7 := op:sub w %v6
  dsl_ret %v7
  ]
  := by
     simp_mlir
     apply bitvec_AddSub_1164 

-- Name:AddSub:1165
-- precondition: true
/-
  %na = sub 0, %a
  %nb = sub 0, %b
  %c = add %na, %nb

=>
  %ab = add %a, %b
  %na = sub 0, %a
  %nb = sub 0, %b
  %c = sub 0, %ab

-/
theorem alive_AddSub_1165 : forall (w : Nat) (a b : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (0)) %v0;
  %v2 := op:const (Bitvec.ofInt w (a)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sub w %v3;
  %v5 := op:const (Bitvec.ofInt w (0)) %v0;
  %v6 := op:const (Bitvec.ofInt w (b)) %v0;
  %v7 := pair:%v5 %v6;
  %v8 := op:sub w %v7;
  %v9 := pair:%v4 %v8;
  %v10 := op:add w %v9
  dsl_ret %v10
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:add w %v3;
  %v5 := op:const (Bitvec.ofInt w (0)) %v0;
  %v6 := pair:%v5 %v1;
  %v7 := op:sub w %v6;
  %v8 := op:const (Bitvec.ofInt w (0)) %v0;
  %v9 := pair:%v8 %v2;
  %v10 := op:sub w %v9;
  %v11 := op:const (Bitvec.ofInt w (0)) %v0;
  %v12 := pair:%v11 %v4;
  %v13 := op:sub w %v12
  dsl_ret %v13
  ]
  := by
     simp_mlir
     apply bitvec_AddSub_1165 

-- Name:AddSub:1176
-- precondition: true
/-
  %nb = sub 0, %b
  %c = add %a, %nb

=>
  %nb = sub 0, %b
  %c = sub %a, %b

-/
theorem alive_AddSub_1176 : forall (w : Nat) (b a : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (0)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sub w %v3;
  %v5 := op:const (Bitvec.ofInt w (a)) %v0;
  %v6 := pair:%v5 %v4;
  %v7 := op:add w %v6
  dsl_ret %v7
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (0)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sub w %v3;
  %v5 := op:const (Bitvec.ofInt w (a)) %v0;
  %v6 := pair:%v5 %v2;
  %v7 := op:sub w %v6
  dsl_ret %v7
  ]
  := by
     simp_mlir
     apply bitvec_AddSub_1176 

-- Name:AddSub:1202
-- precondition: true
/-
  %nx = xor %x, -1
  %r = add %nx, C

=>
  %nx = xor %x, -1
  %r = sub (C - 1), %x

-/
theorem alive_AddSub_1202 : forall (w : Nat) (x C : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (x)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (C)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:add w %v6
  dsl_ret %v7
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (x)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (C)) %v0;
  %v6 := op:const (Bitvec.ofInt w (1)) %v0;
  %v7 := pair:%v5 %v6;
  %v8 := op:sub w %v7;
  %v9 := pair:%v8 %v1;
  %v10 := op:sub w %v9
  dsl_ret %v10
  ]
  := by
     simp_mlir
     apply bitvec_AddSub_1202 

-- Name:AddSub:1295
-- precondition: true
/-
  %aab = and %a, %b
  %aob = xor %a, %b
  %c = add %aab, %aob

=>
  %aab = and %a, %b
  %aob = xor %a, %b
  %c = or %a, %b

-/
theorem alive_AddSub_1295 : forall (w : Nat) (a b : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:and w %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:xor w %v5;
  %v7 := pair:%v4 %v6;
  %v8 := op:add w %v7
  dsl_ret %v8
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:and w %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:xor w %v5;
  %v7 := pair:%v1 %v2;
  %v8 := op:or w %v7
  dsl_ret %v8
  ]
  := by
     simp_mlir
     apply bitvec_AddSub_1295 

-- Name:AddSub:1309
-- precondition: true
/-
  %lhs = and %a, %b
  %rhs = or %a, %b
  %c = add %lhs, %rhs

=>
  %lhs = and %a, %b
  %rhs = or %a, %b
  %c = add %a, %b

-/
theorem alive_AddSub_1309 : forall (w : Nat) (a b : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:and w %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:or w %v5;
  %v7 := pair:%v4 %v6;
  %v8 := op:add w %v7
  dsl_ret %v8
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:and w %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:or w %v5;
  %v7 := pair:%v1 %v2;
  %v8 := op:add w %v7
  dsl_ret %v8
  ]
  := by
     simp_mlir
     apply bitvec_AddSub_1309 

-- Name:AddSub:1309-2
-- precondition: true
/-
  %lhs = and %a, %b
  %rhs = or %a, %b
  %c = add nsw %lhs, %rhs

=>
  %lhs = and %a, %b
  %rhs = or %a, %b
  %c = add nsw %a, %b

-/
theorem alive_AddSub_1309_2 : forall (w : Nat) (a b : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:and w %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:or w %v5;
  %v7 := pair:%v4 %v6;
  %v8 := op:add w %v7
  dsl_ret %v8
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:and w %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:or w %v5;
  %v7 := pair:%v1 %v2;
  %v8 := op:add w %v7
  dsl_ret %v8
  ]
  := by
     simp_mlir
     apply bitvec_AddSub_1309_2 

-- Name:AddSub:1309-3
-- precondition: true
/-
  %lhs = and %a, %b
  %rhs = or %a, %b
  %c = add nuw %lhs, %rhs

=>
  %lhs = and %a, %b
  %rhs = or %a, %b
  %c = add nuw %a, %b

-/
theorem alive_AddSub_1309_3 : forall (w : Nat) (a b : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:and w %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:or w %v5;
  %v7 := pair:%v4 %v6;
  %v8 := op:add w %v7
  dsl_ret %v8
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:and w %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:or w %v5;
  %v7 := pair:%v1 %v2;
  %v8 := op:add w %v7
  dsl_ret %v8
  ]
  := by
     simp_mlir
     apply bitvec_AddSub_1309_3 

-- Name:AddSub:1539
-- precondition: true
/-
  %na = sub 0, %a
  %r = sub %x, %na

=>
  %na = sub 0, %a
  %r = add %x, %a

-/
theorem alive_AddSub_1539 : forall (w : Nat) (a x : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (0)) %v0;
  %v2 := op:const (Bitvec.ofInt w (a)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sub w %v3;
  %v5 := op:const (Bitvec.ofInt w (x)) %v0;
  %v6 := pair:%v5 %v4;
  %v7 := op:sub w %v6
  dsl_ret %v7
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (0)) %v0;
  %v2 := op:const (Bitvec.ofInt w (a)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sub w %v3;
  %v5 := op:const (Bitvec.ofInt w (x)) %v0;
  %v6 := pair:%v5 %v2;
  %v7 := op:add w %v6
  dsl_ret %v7
  ]
  := by
     simp_mlir
     apply bitvec_AddSub_1539 

-- Name:AddSub:1539-2
-- precondition: true
/-
  %r = sub %x, C

=>
  %r = add %x, -C

-/
theorem alive_AddSub_1539_2 : forall (w : Nat) (x C : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (x)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sub w %v3
  dsl_ret %v4
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (x)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C)) %v0;
  %v3 := op:neg w %v2;
  %v4 := pair:%v1 %v3;
  %v5 := op:add w %v4
  dsl_ret %v5
  ]
  := by
     simp_mlir
     apply bitvec_AddSub_1539_2 

-- Name:AddSub:1546
-- precondition: true
/-
  %na = sub nsw 0, %a
  %r = sub nsw %x, %na

=>
  %na = sub nsw 0, %a
  %r = add nsw %x, %a

-/
theorem alive_AddSub_1546 : forall (w : Nat) (a x : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (0)) %v0;
  %v2 := op:const (Bitvec.ofInt w (a)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sub w %v3;
  %v5 := op:const (Bitvec.ofInt w (x)) %v0;
  %v6 := pair:%v5 %v4;
  %v7 := op:sub w %v6
  dsl_ret %v7
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (0)) %v0;
  %v2 := op:const (Bitvec.ofInt w (a)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sub w %v3;
  %v5 := op:const (Bitvec.ofInt w (x)) %v0;
  %v6 := pair:%v5 %v2;
  %v7 := op:add w %v6
  dsl_ret %v7
  ]
  := by
     simp_mlir
     apply bitvec_AddSub_1546 

-- Name:AddSub:1556
-- precondition: true
/-
  %r = sub i1 %x, %y

=>
  %r = xor %x, %y

-/
theorem alive_AddSub_1556: forall (x y : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 1 (x)) %v0;
  %v2 := op:const (Bitvec.ofInt 1 (y)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sub 1 %v3
  dsl_ret %v4
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 1 (x)) %v0;
  %v2 := op:const (Bitvec.ofInt 1 (y)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor 1 %v3
  dsl_ret %v4
  ]
  := by
     simp_mlir
     apply bitvec_AddSub_1556

-- Name:AddSub:1560
-- precondition: true
/-
  %r = sub -1, %a

=>
  %r = xor %a, -1

-/
theorem alive_AddSub_1560 : forall (w : Nat) (a : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v2 := op:const (Bitvec.ofInt w (a)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sub w %v3
  dsl_ret %v4
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3
  dsl_ret %v4
  ]
  := by
     simp_mlir
     apply bitvec_AddSub_1560 

-- Name:AddSub:1564
-- precondition: true
/-
  %nx = xor %x, -1
  %r = sub C, %nx

=>
  %nx = xor %x, -1
  %r = add %x, (C + 1)

-/
theorem alive_AddSub_1564 : forall (w : Nat) (x C : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (x)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (C)) %v0;
  %v6 := pair:%v5 %v4;
  %v7 := op:sub w %v6
  dsl_ret %v7
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (x)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (C)) %v0;
  %v6 := op:const (Bitvec.ofInt w (1)) %v0;
  %v7 := pair:%v5 %v6;
  %v8 := op:add w %v7;
  %v9 := pair:%v1 %v8;
  %v10 := op:add w %v9
  dsl_ret %v10
  ]
  := by
     simp_mlir
     apply bitvec_AddSub_1564 

-- Name:AddSub:1574
-- precondition: true
/-
  %rhs = add %X, C2
  %r = sub C, %rhs

=>
  %rhs = add %X, C2
  %r = sub (C - C2), %X

-/
theorem alive_AddSub_1574 : forall (w : Nat) (X C2 C : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C2)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:add w %v3;
  %v5 := op:const (Bitvec.ofInt w (C)) %v0;
  %v6 := pair:%v5 %v4;
  %v7 := op:sub w %v6
  dsl_ret %v7
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C2)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:add w %v3;
  %v5 := op:const (Bitvec.ofInt w (C)) %v0;
  %v6 := pair:%v5 %v2;
  %v7 := op:sub w %v6;
  %v8 := pair:%v7 %v1;
  %v9 := op:sub w %v8
  dsl_ret %v9
  ]
  := by
     simp_mlir
     apply bitvec_AddSub_1574 

-- Name:AddSub:1614
-- precondition: true
/-
  %Op1 = add %X, %Y
  %r = sub %X, %Op1

=>
  %Op1 = add %X, %Y
  %r = sub 0, %Y

-/
theorem alive_AddSub_1614 : forall (w : Nat) (X Y : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (Y)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:add w %v3;
  %v5 := pair:%v1 %v4;
  %v6 := op:sub w %v5
  dsl_ret %v6
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (Y)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:add w %v3;
  %v5 := op:const (Bitvec.ofInt w (0)) %v0;
  %v6 := pair:%v5 %v2;
  %v7 := op:sub w %v6
  dsl_ret %v7
  ]
  := by
     simp_mlir
     apply bitvec_AddSub_1614 

-- Name:AddSub:1619
-- precondition: true
/-
  %Op0 = sub %X, %Y
  %r = sub %Op0, %X

=>
  %Op0 = sub %X, %Y
  %r = sub 0, %Y

-/
theorem alive_AddSub_1619 : forall (w : Nat) (X Y : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (Y)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sub w %v3;
  %v5 := pair:%v4 %v1;
  %v6 := op:sub w %v5
  dsl_ret %v6
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (Y)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sub w %v3;
  %v5 := op:const (Bitvec.ofInt w (0)) %v0;
  %v6 := pair:%v5 %v2;
  %v7 := op:sub w %v6
  dsl_ret %v7
  ]
  := by
     simp_mlir
     apply bitvec_AddSub_1619 

-- Name:AddSub:1624
-- precondition: true
/-
  %Op0 = or %A, %B
  %Op1 = xor %A, %B
  %r = sub %Op0, %Op1

=>
  %Op0 = or %A, %B
  %Op1 = xor %A, %B
  %r = and %A, %B

-/
theorem alive_AddSub_1624 : forall (w : Nat) (A B : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (B)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:or w %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:xor w %v5;
  %v7 := pair:%v4 %v6;
  %v8 := op:sub w %v7
  dsl_ret %v8
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (B)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:or w %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:xor w %v5;
  %v7 := pair:%v1 %v2;
  %v8 := op:and w %v7
  dsl_ret %v8
  ]
  := by
     simp_mlir
     apply bitvec_AddSub_1624 

-- Name:AndOrXor:135
-- precondition: true
/-
  %op = xor %X, C1
  %r = and %op, C2

=>
  %a = and %X, C2
  %op = xor %X, C1
  %r = xor %a, (C1 & C2)

-/
theorem alive_AndOrXor_135 : forall (w : Nat) (X C1 C2 : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (C2)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:and w %v6
  dsl_ret %v7
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C2)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:and w %v3;
  %v5 := op:const (Bitvec.ofInt w (C1)) %v0;
  %v6 := pair:%v1 %v5;
  %v7 := op:xor w %v6;
  %v8 := pair:%v5 %v2;
  %v9 := op:and w %v8;
  %v10 := pair:%v4 %v9;
  %v11 := op:xor w %v10
  dsl_ret %v11
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_135 

-- Name:AndOrXor:144
-- precondition: true
/-
  %op = or %X, C1
  %r = and %op, C2

=>
  %o = or %X, (C1 & C2)
  %op = or %X, C1
  %r = and %o, C2

-/
theorem alive_AndOrXor_144 : forall (w : Nat) (X C1 C2 : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:or w %v3;
  %v5 := op:const (Bitvec.ofInt w (C2)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:and w %v6
  dsl_ret %v7
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C1)) %v0;
  %v3 := op:const (Bitvec.ofInt w (C2)) %v0;
  %v4 := pair:%v2 %v3;
  %v5 := op:and w %v4;
  %v6 := pair:%v1 %v5;
  %v7 := op:or w %v6;
  %v8 := pair:%v1 %v2;
  %v9 := op:or w %v8;
  %v10 := pair:%v7 %v3;
  %v11 := op:and w %v10
  dsl_ret %v11
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_144 


-- Name:AndOrXor:1230  ~A & ~B -> ~(A | B)
-- precondition: true
/-
  %op0 = xor %notOp0, -1
  %op1 = xor %notOp1, -1
  %r = and %op0, %op1

=>
  %or = or %notOp0, %notOp1
  %op0 = xor %notOp0, -1
  %op1 = xor %notOp1, -1
  %r = xor %or, -1

-/
theorem alive_AndOrXor_1230__A__B___A__B : forall (w : Nat) (notOp0 notOp1 : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (notOp0)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (notOp1)) %v0;
  %v6 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v7 := pair:%v5 %v6;
  %v8 := op:xor w %v7;
  %v9 := pair:%v4 %v8;
  %v10 := op:and w %v9
  dsl_ret %v10
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (notOp0)) %v0;
  %v2 := op:const (Bitvec.ofInt w (notOp1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:or w %v3;
  %v5 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v6 := pair:%v1 %v5;
  %v7 := op:xor w %v6;
  %v8 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v9 := pair:%v2 %v8;
  %v10 := op:xor w %v9;
  %v11 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v12 := pair:%v4 %v11;
  %v13 := op:xor w %v12
  dsl_ret %v13
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_1230__A__B___A__B 

-- Name:AndOrXor:1241 (A|B) & ~(A&B) => A^B
-- precondition: true
/-
  %op0 = or %A, %B
  %notOp1 = and %A, %B
  %op1 = xor %notOp1, -1
  %r = and %op0, %op1

=>
  %op0 = or %A, %B
  %notOp1 = and %A, %B
  %op1 = xor %notOp1, -1
  %r = xor %A, %B

-/
theorem alive_AndOrXor_1241_AB__AB__AB : forall (w : Nat) (A B : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (B)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:or w %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:and w %v5;
  %v7 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v8 := pair:%v6 %v7;
  %v9 := op:xor w %v8;
  %v10 := pair:%v4 %v9;
  %v11 := op:and w %v10
  dsl_ret %v11
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (B)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:or w %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:and w %v5;
  %v7 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v8 := pair:%v6 %v7;
  %v9 := op:xor w %v8;
  %v10 := pair:%v1 %v2;
  %v11 := op:xor w %v10
  dsl_ret %v11
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_1241_AB__AB__AB 

-- Name:AndOrXor:1247 ~(A&B) & (A|B) => A^B
-- precondition: true
/-
  %notOp0 = and %A, %B
  %op0 = xor %notOp0, -1
  %op1 = or %A, %B
  %r = and %op0, %op1

=>
  %notOp0 = and %A, %B
  %op0 = xor %notOp0, -1
  %op1 = or %A, %B
  %r = xor %A, %B

-/
theorem alive_AndOrXor_1247_AB__AB__AB : forall (w : Nat) (A B : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (B)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:and w %v3;
  %v5 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:xor w %v6;
  %v8 := pair:%v1 %v2;
  %v9 := op:or w %v8;
  %v10 := pair:%v7 %v9;
  %v11 := op:and w %v10
  dsl_ret %v11
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (B)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:and w %v3;
  %v5 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:xor w %v6;
  %v8 := pair:%v1 %v2;
  %v9 := op:or w %v8;
  %v10 := pair:%v1 %v2;
  %v11 := op:xor w %v10
  dsl_ret %v11
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_1247_AB__AB__AB 

-- Name:AndOrXor:1253 A & (A^B) -> A & ~B
-- precondition: true
/-
  %op0 = xor %A, %B
  %r = and %op0, %A

=>
  %notB = xor %B, -1
  %op0 = xor %A, %B
  %r = and %A, %notB

-/
theorem alive_AndOrXor_1253_A__AB___A__B : forall (w : Nat) (A B : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (B)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := pair:%v4 %v1;
  %v6 := op:and w %v5
  dsl_ret %v6
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (B)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (A)) %v0;
  %v6 := pair:%v5 %v1;
  %v7 := op:xor w %v6;
  %v8 := pair:%v5 %v4;
  %v9 := op:and w %v8
  dsl_ret %v9
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_1253_A__AB___A__B 

-- Name:AndOrXor:1280 (~A|B)&A -> A&B
-- precondition: true
/-
  %nA = xor %A, -1
  %op0 = or %nA, %B
  %r = and %op0, %A

=>
  %nA = xor %A, -1
  %op0 = or %nA, %B
  %r = and %A, %B

-/
theorem alive_AndOrXor_1280_ABA___AB : forall (w : Nat) (A B : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (B)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:or w %v6;
  %v8 := pair:%v7 %v1;
  %v9 := op:and w %v8
  dsl_ret %v9
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (B)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:or w %v6;
  %v8 := pair:%v1 %v5;
  %v9 := op:and w %v8
  dsl_ret %v9
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_1280_ABA___AB 

-- Name:AndOrXor:1288 (A ^ B) & ((B ^ C) ^ A) -> (A ^ B) & ~C
-- precondition: true
/-
  %op0 = xor %A, %B
  %x = xor %B, %C
  %op1 = xor %x, %A
  %r = and %op0, %op1

=>
  %op0 = xor %A, %B
  %negC = xor %C, -1
  %x = xor %B, %C
  %op1 = xor %x, %A
  %r = and %op0, %negC

-/
theorem alive_AndOrXor_1288_A__B__B__C__A___A__B__C : forall (w : Nat) (A B C : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (B)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (C)) %v0;
  %v6 := pair:%v2 %v5;
  %v7 := op:xor w %v6;
  %v8 := pair:%v7 %v1;
  %v9 := op:xor w %v8;
  %v10 := pair:%v4 %v9;
  %v11 := op:and w %v10
  dsl_ret %v11
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (B)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (C)) %v0;
  %v6 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v7 := pair:%v5 %v6;
  %v8 := op:xor w %v7;
  %v9 := pair:%v2 %v5;
  %v10 := op:xor w %v9;
  %v11 := pair:%v10 %v1;
  %v12 := op:xor w %v11;
  %v13 := pair:%v4 %v8;
  %v14 := op:and w %v13
  dsl_ret %v14
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_1288_A__B__B__C__A___A__B__C 

-- Name:AndOrXor:1294 (A | B) & ((~A) ^ B) -> (A & B)
-- precondition: true
/-
  %op0 = or %A, %B
  %x = xor %A, -1
  %op1 = xor %x, %B
  %r = and %op0, %op1

=>
  %op0 = or %A, %B
  %x = xor %A, -1
  %op1 = xor %x, %B
  %r = and %A, %B

-/
theorem alive_AndOrXor_1294_A__B__A__B___A__B : forall (w : Nat) (A B : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (B)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:or w %v3;
  %v5 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v6 := pair:%v1 %v5;
  %v7 := op:xor w %v6;
  %v8 := pair:%v7 %v2;
  %v9 := op:xor w %v8;
  %v10 := pair:%v4 %v9;
  %v11 := op:and w %v10
  dsl_ret %v11
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (B)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:or w %v3;
  %v5 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v6 := pair:%v1 %v5;
  %v7 := op:xor w %v6;
  %v8 := pair:%v7 %v2;
  %v9 := op:xor w %v8;
  %v10 := pair:%v1 %v2;
  %v11 := op:and w %v10
  dsl_ret %v11
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_1294_A__B__A__B___A__B 



--
-- Name:AndOrXor:2063  (X ^ C1) | C2 --> (X | C2) ^ (C1 & ~C2)
-- precondition: true
/-
  %op0 = xor %x, C1
  %r = or %op0, C

=>
  %or = or %x, C
  %op0 = xor %x, C1
  %r = xor %or, (C1 & ~C)

-/
theorem alive_AndOrXor_2063__X__C1__C2____X__C2__C1__C2 : forall (w : Nat) (x C1 C : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (x)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (C)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:or w %v6
  dsl_ret %v7
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (x)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:or w %v3;
  %v5 := op:const (Bitvec.ofInt w (C1)) %v0;
  %v6 := pair:%v1 %v5;
  %v7 := op:xor w %v6;
  %v8 := op:not w %v2;
  %v9 := pair:%v5 %v8;
  %v10 := op:and w %v9;
  %v11 := pair:%v4 %v10;
  %v12 := op:xor w %v11
  dsl_ret %v12
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_2063__X__C1__C2____X__C2__C1__C2 

-- Name:AndOrXor:2113   ((~A & B) | A) -> (A | B)
-- precondition: true
/-
  %negA = xor %A, -1
  %op0 = and %negA, %B
  %r = or %op0, %A

=>
  %negA = xor %A, -1
  %op0 = and %negA, %B
  %r = or %A, %B

-/
theorem alive_AndOrXor_2113___A__B__A___A__B : forall (w : Nat) (A B : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (B)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:and w %v6;
  %v8 := pair:%v7 %v1;
  %v9 := op:or w %v8
  dsl_ret %v9
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (B)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:and w %v6;
  %v8 := pair:%v1 %v5;
  %v9 := op:or w %v8
  dsl_ret %v9
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_2113___A__B__A___A__B 

-- Name:AndOrXor:2118   ((A & B) | ~A) -> (~A | B)
-- precondition: true
/-
  %negA = xor %A, -1
  %op0 = and %A, %B
  %r = or %op0, %negA

=>
  %negA = xor %A, -1
  %op0 = and %A, %B
  %r = or %negA, %B

-/
theorem alive_AndOrXor_2118___A__B__A___A__B : forall (w : Nat) (A B : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (B)) %v0;
  %v6 := pair:%v1 %v5;
  %v7 := op:and w %v6;
  %v8 := pair:%v7 %v4;
  %v9 := op:or w %v8
  dsl_ret %v9
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (B)) %v0;
  %v6 := pair:%v1 %v5;
  %v7 := op:and w %v6;
  %v8 := pair:%v4 %v5;
  %v9 := op:or w %v8
  dsl_ret %v9
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_2118___A__B__A___A__B 

-- Name:AndOrXor:2123   (A & (~B)) | (A ^ B) -> (A ^ B)
-- precondition: true
/-
  %negB = xor %B, -1
  %op0 = and %A, %negB
  %op1 = xor %A, %B
  %r = or %op0, %op1

=>
  %negB = xor %B, -1
  %op0 = and %A, %negB
  %op1 = xor %A, %B
  %r = xor %A, %B

-/
theorem alive_AndOrXor_2123___A__B__A__B___A__B : forall (w : Nat) (B A : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (B)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (A)) %v0;
  %v6 := pair:%v5 %v4;
  %v7 := op:and w %v6;
  %v8 := pair:%v5 %v1;
  %v9 := op:xor w %v8;
  %v10 := pair:%v7 %v9;
  %v11 := op:or w %v10
  dsl_ret %v11
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (B)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (A)) %v0;
  %v6 := pair:%v5 %v4;
  %v7 := op:and w %v6;
  %v8 := pair:%v5 %v1;
  %v9 := op:xor w %v8;
  %v10 := pair:%v5 %v1;
  %v11 := op:xor w %v10
  dsl_ret %v11
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_2123___A__B__A__B___A__B 

-- Name:AndOrXor:2188
-- precondition: true
/-
  %C = xor %D, -1
  %B = xor %A, -1
  %op0 = and %A, %C
  %op1 = and %B, %D
  %r = or %op0, %op1

=>
  %C = xor %D, -1
  %B = xor %A, -1
  %op0 = and %A, %C
  %op1 = and %B, %D
  %r = xor %A, %D

-/
theorem alive_AndOrXor_2188 : forall (w : Nat) (D A : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (D)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (A)) %v0;
  %v6 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v7 := pair:%v5 %v6;
  %v8 := op:xor w %v7;
  %v9 := pair:%v5 %v4;
  %v10 := op:and w %v9;
  %v11 := pair:%v8 %v1;
  %v12 := op:and w %v11;
  %v13 := pair:%v10 %v12;
  %v14 := op:or w %v13
  dsl_ret %v14
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (D)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (A)) %v0;
  %v6 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v7 := pair:%v5 %v6;
  %v8 := op:xor w %v7;
  %v9 := pair:%v5 %v4;
  %v10 := op:and w %v9;
  %v11 := pair:%v8 %v1;
  %v12 := op:and w %v11;
  %v13 := pair:%v5 %v1;
  %v14 := op:xor w %v13
  dsl_ret %v14
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_2188 

-- Name:AndOrXor:2231  (A ^ B) | ((B ^ C) ^ A) -> (A ^ B) | C
-- precondition: true
/-
  %op0 = xor %A, %B
  %x = xor %B, %C
  %op1 = xor %x, %A
  %r = or %op0, %op1

=>
  %op0 = xor %A, %B
  %x = xor %B, %C
  %op1 = xor %x, %A
  %r = or %op0, %C

-/
theorem alive_AndOrXor_2231__A__B__B__C__A___A__B__C : forall (w : Nat) (A B C : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (B)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (C)) %v0;
  %v6 := pair:%v2 %v5;
  %v7 := op:xor w %v6;
  %v8 := pair:%v7 %v1;
  %v9 := op:xor w %v8;
  %v10 := pair:%v4 %v9;
  %v11 := op:or w %v10
  dsl_ret %v11
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (B)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (C)) %v0;
  %v6 := pair:%v2 %v5;
  %v7 := op:xor w %v6;
  %v8 := pair:%v7 %v1;
  %v9 := op:xor w %v8;
  %v10 := pair:%v4 %v5;
  %v11 := op:or w %v10
  dsl_ret %v11
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_2231__A__B__B__C__A___A__B__C 

-- Name:AndOrXor:2243  ((B | C) & A) | B -> B | (A & C)
-- precondition: true
/-
  %o = or %B, %C
  %op0 = and %o, %A
  %r = or %op0, %B

=>
  %a = and %A, %C
  %o = or %B, %C
  %op0 = and %o, %A
  %r = or %B, %a

-/
theorem alive_AndOrXor_2243__B__C__A__B___B__A__C : forall (w : Nat) (B C A : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (B)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:or w %v3;
  %v5 := op:const (Bitvec.ofInt w (A)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:and w %v6;
  %v8 := pair:%v7 %v1;
  %v9 := op:or w %v8
  dsl_ret %v9
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:and w %v3;
  %v5 := op:const (Bitvec.ofInt w (B)) %v0;
  %v6 := pair:%v5 %v2;
  %v7 := op:or w %v6;
  %v8 := pair:%v7 %v1;
  %v9 := op:and w %v8;
  %v10 := pair:%v5 %v4;
  %v11 := op:or w %v10
  dsl_ret %v11
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_2243__B__C__A__B___B__A__C 

-- Name:AndOrXor:2247  (~A | ~B) == (~(A & B))
-- precondition: true
/-
  %na = xor %A, -1
  %nb = xor %B, -1
  %r = or %na, %nb

=>
  %a = and %A, %B
  %na = xor %A, -1
  %nb = xor %B, -1
  %r = xor %a, -1

-/
theorem alive_AndOrXor_2247__A__B__A__B : forall (w : Nat) (A B : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (B)) %v0;
  %v6 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v7 := pair:%v5 %v6;
  %v8 := op:xor w %v7;
  %v9 := pair:%v4 %v8;
  %v10 := op:or w %v9
  dsl_ret %v10
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (B)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:and w %v3;
  %v5 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v6 := pair:%v1 %v5;
  %v7 := op:xor w %v6;
  %v8 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v9 := pair:%v2 %v8;
  %v10 := op:xor w %v9;
  %v11 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v12 := pair:%v4 %v11;
  %v13 := op:xor w %v12
  dsl_ret %v13
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_2247__A__B__A__B 

-- Name:AndOrXor:2263
-- precondition: true
/-
  %op1 = xor %op0, %B
  %r = or %op0, %op1

=>
  %op1 = xor %op0, %B
  %r = or %op0, %B

-/
theorem alive_AndOrXor_2263 : forall (w : Nat) (op0 B : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (op0)) %v0;
  %v2 := op:const (Bitvec.ofInt w (B)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := pair:%v1 %v4;
  %v6 := op:or w %v5
  dsl_ret %v6
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (op0)) %v0;
  %v2 := op:const (Bitvec.ofInt w (B)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:or w %v5
  dsl_ret %v6
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_2263 

-- Name:AndOrXor:2264
-- precondition: true
/-
  %na = xor %A, -1
  %op1 = xor %na, %B
  %r = or %A, %op1

=>
  %nb = xor %B, -1
  %na = xor %A, -1
  %op1 = xor %na, %B
  %r = or %A, %nb

-/
theorem alive_AndOrXor_2264 : forall (w : Nat) (A B : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (B)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:xor w %v6;
  %v8 := pair:%v1 %v7;
  %v9 := op:or w %v8
  dsl_ret %v9
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (B)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (A)) %v0;
  %v6 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v7 := pair:%v5 %v6;
  %v8 := op:xor w %v7;
  %v9 := pair:%v8 %v1;
  %v10 := op:xor w %v9;
  %v11 := pair:%v5 %v4;
  %v12 := op:or w %v11
  dsl_ret %v12
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_2264 

-- Name:AndOrXor:2265
-- precondition: true
/-
  %op0 = and %A, %B
  %op1 = xor %A, %B
  %r = or %op0, %op1

=>
  %op0 = and %A, %B
  %op1 = xor %A, %B
  %r = or %A, %B

-/
theorem alive_AndOrXor_2265 : forall (w : Nat) (A B : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (B)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:and w %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:xor w %v5;
  %v7 := pair:%v4 %v6;
  %v8 := op:or w %v7
  dsl_ret %v8
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (B)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:and w %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:xor w %v5;
  %v7 := pair:%v1 %v2;
  %v8 := op:or w %v7
  dsl_ret %v8
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_2265 

-- Name:AndOrXor:2284
-- precondition: true
/-
  %o = or %A, %B
  %op1 = xor %o, -1
  %r = or %A, %op1

=>
  %not = xor %B, -1
  %o = or %A, %B
  %op1 = xor %o, -1
  %r = or %A, %not

-/
theorem alive_AndOrXor_2284 : forall (w : Nat) (A B : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (B)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:or w %v3;
  %v5 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:xor w %v6;
  %v8 := pair:%v1 %v7;
  %v9 := op:or w %v8
  dsl_ret %v9
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (B)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (A)) %v0;
  %v6 := pair:%v5 %v1;
  %v7 := op:or w %v6;
  %v8 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v9 := pair:%v7 %v8;
  %v10 := op:xor w %v9;
  %v11 := pair:%v5 %v4;
  %v12 := op:or w %v11
  dsl_ret %v12
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_2284 

-- Name:AndOrXor:2285
-- precondition: true
/-
  %o = xor %A, %B
  %op1 = xor %o, -1
  %r = or %A, %op1

=>
  %not = xor %B, -1
  %o = xor %A, %B
  %op1 = xor %o, -1
  %r = or %A, %not

-/
theorem alive_AndOrXor_2285 : forall (w : Nat) (A B : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (B)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:xor w %v6;
  %v8 := pair:%v1 %v7;
  %v9 := op:or w %v8
  dsl_ret %v9
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (B)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (A)) %v0;
  %v6 := pair:%v5 %v1;
  %v7 := op:xor w %v6;
  %v8 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v9 := pair:%v7 %v8;
  %v10 := op:xor w %v9;
  %v11 := pair:%v5 %v4;
  %v12 := op:or w %v11
  dsl_ret %v12
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_2285 

-- Name:AndOrXor:2297
-- precondition: true
/-
  %op0 = and %A, %B
  %na = xor %A, -1
  %op1 = xor %na, %B
  %r = or %op0, %op1

=>
  %na = xor %A, -1
  %op0 = and %A, %B
  %op1 = xor %na, %B
  %r = xor %na, %B

-/
theorem alive_AndOrXor_2297 : forall (w : Nat) (A B : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (B)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:and w %v3;
  %v5 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v6 := pair:%v1 %v5;
  %v7 := op:xor w %v6;
  %v8 := pair:%v7 %v2;
  %v9 := op:xor w %v8;
  %v10 := pair:%v4 %v9;
  %v11 := op:or w %v10
  dsl_ret %v11
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (B)) %v0;
  %v6 := pair:%v1 %v5;
  %v7 := op:and w %v6;
  %v8 := pair:%v4 %v5;
  %v9 := op:xor w %v8;
  %v10 := pair:%v4 %v5;
  %v11 := op:xor w %v10
  dsl_ret %v11
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_2297 

-- Name:AndOrXor:2367
-- precondition: true
/-
  %op0 = or %A, C1
  %r = or %op0, %op1

=>
  %i = or %A, %op1
  %op0 = or %A, C1
  %r = or %i, C1

-/
theorem alive_AndOrXor_2367 : forall (w : Nat) (A C1 op1 : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:or w %v3;
  %v5 := op:const (Bitvec.ofInt w (op1)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:or w %v6
  dsl_ret %v7
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (op1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:or w %v3;
  %v5 := op:const (Bitvec.ofInt w (C1)) %v0;
  %v6 := pair:%v1 %v5;
  %v7 := op:or w %v6;
  %v8 := pair:%v4 %v5;
  %v9 := op:or w %v8
  dsl_ret %v9
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_2367 

-- Name:AndOrXor:2375
-- precondition: true
/-
  %op0 = select i1 %x, %A, %B
  %op1 = select i1 %x, %C, %D
  %r = or %op0, %op1

=>
  %t = or %A, %C
  %f = or %B, %D
  %op0 = select i1 %x, %A, %B
  %op1 = select i1 %x, %C, %D
  %r = select i1 %x, %t, %f

-/
theorem alive_AndOrXor_2375 : forall (w : Nat) (x A B C D : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 1 (x)) %v0;
  %v2 := op:const (Bitvec.ofInt w (A)) %v0;
  %v3 := op:const (Bitvec.ofInt w (B)) %v0;
  %v4 := triple:%v1 %v2 %v3;
  %v5 := op:select w %v4;
  %v6 := op:const (Bitvec.ofInt w (C)) %v0;
  %v7 := op:const (Bitvec.ofInt w (D)) %v0;
  %v8 := triple:%v1 %v6 %v7;
  %v9 := op:select w %v8;
  %v10 := pair:%v5 %v9;
  %v11 := op:or w %v10
  dsl_ret %v11
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:or w %v3;
  %v5 := op:const (Bitvec.ofInt w (B)) %v0;
  %v6 := op:const (Bitvec.ofInt w (D)) %v0;
  %v7 := pair:%v5 %v6;
  %v8 := op:or w %v7;
  %v9 := op:const (Bitvec.ofInt 1 (x)) %v0;
  %v10 := triple:%v9 %v1 %v5;
  %v11 := op:select w %v10;
  %v12 := triple:%v9 %v2 %v6;
  %v13 := op:select w %v12;
  %v14 := triple:%v9 %v4 %v8;
  %v15 := op:select w %v14
  dsl_ret %v15
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_2375 

-- Name:AndOrXor:2416
-- precondition: true
/-
  %x = xor %nx, -1
  %op0 = and %x, %y
  %r = xor %op0, -1

=>
  %ny = xor %y, -1
  %x = xor %nx, -1
  %op0 = and %x, %y
  %r = or %nx, %ny

-/
theorem alive_AndOrXor_2416 : forall (w : Nat) (nx y : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (nx)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (y)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:and w %v6;
  %v8 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v9 := pair:%v7 %v8;
  %v10 := op:xor w %v9
  dsl_ret %v10
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (y)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (nx)) %v0;
  %v6 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v7 := pair:%v5 %v6;
  %v8 := op:xor w %v7;
  %v9 := pair:%v8 %v1;
  %v10 := op:and w %v9;
  %v11 := pair:%v5 %v4;
  %v12 := op:or w %v11
  dsl_ret %v12
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_2416 

-- Name:AndOrXor:2417
-- precondition: true
/-
  %x = xor %nx, -1
  %op0 = or %x, %y
  %r = xor %op0, -1

=>
  %ny = xor %y, -1
  %x = xor %nx, -1
  %op0 = or %x, %y
  %r = and %nx, %ny

-/
theorem alive_AndOrXor_2417 : forall (w : Nat) (nx y : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (nx)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (y)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:or w %v6;
  %v8 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v9 := pair:%v7 %v8;
  %v10 := op:xor w %v9
  dsl_ret %v10
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (y)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (nx)) %v0;
  %v6 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v7 := pair:%v5 %v6;
  %v8 := op:xor w %v7;
  %v9 := pair:%v8 %v1;
  %v10 := op:or w %v9;
  %v11 := pair:%v5 %v4;
  %v12 := op:and w %v11
  dsl_ret %v12
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_2417 

-- Name:AndOrXor:2429
-- precondition: true
/-
  %op0 = and %x, %y
  %r = xor %op0, -1

=>
  %nx = xor %x, -1
  %ny = xor %y, -1
  %op0 = and %x, %y
  %r = or %nx, %ny

-/
theorem alive_AndOrXor_2429 : forall (w : Nat) (x y : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (x)) %v0;
  %v2 := op:const (Bitvec.ofInt w (y)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:and w %v3;
  %v5 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:xor w %v6
  dsl_ret %v7
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (x)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (y)) %v0;
  %v6 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v7 := pair:%v5 %v6;
  %v8 := op:xor w %v7;
  %v9 := pair:%v1 %v5;
  %v10 := op:and w %v9;
  %v11 := pair:%v4 %v8;
  %v12 := op:or w %v11
  dsl_ret %v12
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_2429 

-- Name:AndOrXor:2430
-- precondition: true
/-
  %op0 = or %x, %y
  %r = xor %op0, -1

=>
  %nx = xor %x, -1
  %ny = xor %y, -1
  %op0 = or %x, %y
  %r = and %nx, %ny

-/
theorem alive_AndOrXor_2430 : forall (w : Nat) (x y : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (x)) %v0;
  %v2 := op:const (Bitvec.ofInt w (y)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:or w %v3;
  %v5 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:xor w %v6
  dsl_ret %v7
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (x)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (y)) %v0;
  %v6 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v7 := pair:%v5 %v6;
  %v8 := op:xor w %v7;
  %v9 := pair:%v1 %v5;
  %v10 := op:or w %v9;
  %v11 := pair:%v4 %v8;
  %v12 := op:and w %v11
  dsl_ret %v12
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_2430 

-- Name:AndOrXor:2443
-- precondition: true
/-
  %nx = xor %x, -1
  %op0 = ashr %nx, %y
  %r = xor %op0, -1

=>
  %nx = xor %x, -1
  %op0 = ashr %nx, %y
  %r = ashr %x, %y

-/
theorem alive_AndOrXor_2443 : forall (w : Nat) (x y : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (x)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (y)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:ashr w %v6;
  %v8 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v9 := pair:%v7 %v8;
  %v10 := op:xor w %v9
  dsl_ret %v10
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (x)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (y)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:ashr w %v6;
  %v8 := pair:%v1 %v5;
  %v9 := op:ashr w %v8
  dsl_ret %v9
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_2443 


-- Name:AndOrXor:2475
-- precondition: true
/-
  %op0 = sub C, %x
  %r = xor %op0, -1

=>
  %op0 = sub C, %x
  %r = add %x, (-1 - C)

-/
theorem alive_AndOrXor_2475 : forall (w : Nat) (C x : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (C)) %v0;
  %v2 := op:const (Bitvec.ofInt w (x)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sub w %v3;
  %v5 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:xor w %v6
  dsl_ret %v7
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (C)) %v0;
  %v2 := op:const (Bitvec.ofInt w (x)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sub w %v3;
  %v5 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v6 := pair:%v5 %v1;
  %v7 := op:sub w %v6;
  %v8 := pair:%v2 %v7;
  %v9 := op:add w %v8
  dsl_ret %v9
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_2475 

-- Name:AndOrXor:2486
-- precondition: true
/-
  %op0 = add %x, C
  %r = xor %op0, -1

=>
  %op0 = add %x, C
  %r = sub (-1 - C), %x

-/
theorem alive_AndOrXor_2486 : forall (w : Nat) (x C : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (x)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:add w %v3;
  %v5 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:xor w %v6
  dsl_ret %v7
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (x)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:add w %v3;
  %v5 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v6 := pair:%v5 %v2;
  %v7 := op:sub w %v6;
  %v8 := pair:%v7 %v1;
  %v9 := op:sub w %v8
  dsl_ret %v9
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_2486 

-- Name:AndOrXor:2581  (B|A)^B -> A & ~B
-- precondition: true
/-
  %op0 = or %a, %op1
  %r = xor %op0, %op1

=>
  %nop1 = xor %op1, -1
  %op0 = or %a, %op1
  %r = and %a, %nop1

-/
theorem alive_AndOrXor_2581__BAB___A__B : forall (w : Nat) (a op1 : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (op1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:or w %v3;
  %v5 := pair:%v4 %v2;
  %v6 := op:xor w %v5
  dsl_ret %v6
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (op1)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (a)) %v0;
  %v6 := pair:%v5 %v1;
  %v7 := op:or w %v6;
  %v8 := pair:%v5 %v4;
  %v9 := op:and w %v8
  dsl_ret %v9
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_2581__BAB___A__B 

-- Name:AndOrXor:2587  (B&A)^A -> ~B & A
-- precondition: true
/-
  %op0 = and %a, %op1
  %r = xor %op0, %op1

=>
  %na = xor %a, -1
  %op0 = and %a, %op1
  %r = and %na, %op1

-/
theorem alive_AndOrXor_2587__BAA___B__A : forall (w : Nat) (a op1 : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (op1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:and w %v3;
  %v5 := pair:%v4 %v2;
  %v6 := op:xor w %v5
  dsl_ret %v6
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (op1)) %v0;
  %v6 := pair:%v1 %v5;
  %v7 := op:and w %v6;
  %v8 := pair:%v4 %v5;
  %v9 := op:and w %v8
  dsl_ret %v9
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_2587__BAA___B__A 

-- Name:AndOrXor:2595
-- precondition: true
/-
  %op0 = and %a, %b
  %op1 = or %a, %b
  %r = xor %op0, %op1

=>
  %op0 = and %a, %b
  %op1 = or %a, %b
  %r = xor %a, %b

-/
theorem alive_AndOrXor_2595 : forall (w : Nat) (a b : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:and w %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:or w %v5;
  %v7 := pair:%v4 %v6;
  %v8 := op:xor w %v7
  dsl_ret %v8
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:and w %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:or w %v5;
  %v7 := pair:%v1 %v2;
  %v8 := op:xor w %v7
  dsl_ret %v8
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_2595 

-- Name:AndOrXor:2607
-- precondition: true
/-
  %na = xor %a, -1
  %nb = xor %b, -1
  %op0 = or %a, %nb
  %op1 = or %na, %b
  %r = xor %op0, %op1

=>
  %na = xor %a, -1
  %nb = xor %b, -1
  %op0 = or %a, %nb
  %op1 = or %na, %b
  %r = xor %a, %b

-/
theorem alive_AndOrXor_2607 : forall (w : Nat) (a b : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (b)) %v0;
  %v6 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v7 := pair:%v5 %v6;
  %v8 := op:xor w %v7;
  %v9 := pair:%v1 %v8;
  %v10 := op:or w %v9;
  %v11 := pair:%v4 %v5;
  %v12 := op:or w %v11;
  %v13 := pair:%v10 %v12;
  %v14 := op:xor w %v13
  dsl_ret %v14
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (b)) %v0;
  %v6 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v7 := pair:%v5 %v6;
  %v8 := op:xor w %v7;
  %v9 := pair:%v1 %v8;
  %v10 := op:or w %v9;
  %v11 := pair:%v4 %v5;
  %v12 := op:or w %v11;
  %v13 := pair:%v1 %v5;
  %v14 := op:xor w %v13
  dsl_ret %v14
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_2607 

-- Name:AndOrXor:2617
-- precondition: true
/-
  %na = xor %a, -1
  %nb = xor %b, -1
  %op0 = and %a, %nb
  %op1 = and %na, %b
  %r = xor %op0, %op1

=>
  %na = xor %a, -1
  %nb = xor %b, -1
  %op0 = and %a, %nb
  %op1 = and %na, %b
  %r = xor %a, %b

-/
theorem alive_AndOrXor_2617 : forall (w : Nat) (a b : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (b)) %v0;
  %v6 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v7 := pair:%v5 %v6;
  %v8 := op:xor w %v7;
  %v9 := pair:%v1 %v8;
  %v10 := op:and w %v9;
  %v11 := pair:%v4 %v5;
  %v12 := op:and w %v11;
  %v13 := pair:%v10 %v12;
  %v14 := op:xor w %v13
  dsl_ret %v14
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (b)) %v0;
  %v6 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v7 := pair:%v5 %v6;
  %v8 := op:xor w %v7;
  %v9 := pair:%v1 %v8;
  %v10 := op:and w %v9;
  %v11 := pair:%v4 %v5;
  %v12 := op:and w %v11;
  %v13 := pair:%v1 %v5;
  %v14 := op:xor w %v13
  dsl_ret %v14
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_2617 

-- Name:AndOrXor:2627
-- precondition: true
/-
  %op0 = xor %a, %c
  %op1 = or %a, %b
  %r = xor %op0, %op1

=>
  %na = xor %a, -1
  %and = and %na, %b
  %op0 = xor %a, %c
  %op1 = or %a, %b
  %r = xor %and, %c

-/
theorem alive_AndOrXor_2627 : forall (w : Nat) (a c b : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (c)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (b)) %v0;
  %v6 := pair:%v1 %v5;
  %v7 := op:or w %v6;
  %v8 := pair:%v4 %v7;
  %v9 := op:xor w %v8
  dsl_ret %v9
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (b)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:and w %v6;
  %v8 := op:const (Bitvec.ofInt w (c)) %v0;
  %v9 := pair:%v1 %v8;
  %v10 := op:xor w %v9;
  %v11 := pair:%v1 %v5;
  %v12 := op:or w %v11;
  %v13 := pair:%v7 %v8;
  %v14 := op:xor w %v13
  dsl_ret %v14
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_2627 

-- Name:AndOrXor:2647
-- precondition: true
/-
  %op0 = and %a, %b
  %op1 = xor %a, %b
  %r = xor %op0, %op1

=>
  %op0 = and %a, %b
  %op1 = xor %a, %b
  %r = or %a, %b

-/
theorem alive_AndOrXor_2647 : forall (w : Nat) (a b : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:and w %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:xor w %v5;
  %v7 := pair:%v4 %v6;
  %v8 := op:xor w %v7
  dsl_ret %v8
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:and w %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:xor w %v5;
  %v7 := pair:%v1 %v2;
  %v8 := op:or w %v7
  dsl_ret %v8
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_2647 

-- Name:AndOrXor:2658
-- precondition: true
/-
  %nb = xor %b, -1
  %op0 = and %a, %nb
  %na = xor %a, -1
  %r = xor %op0, %na

=>
  %and = and %a, %b
  %nb = xor %b, -1
  %op0 = and %a, %nb
  %na = xor %a, -1
  %r = xor %and, -1

-/
theorem alive_AndOrXor_2658 : forall (w : Nat) (b a : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (b)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (a)) %v0;
  %v6 := pair:%v5 %v4;
  %v7 := op:and w %v6;
  %v8 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v9 := pair:%v5 %v8;
  %v10 := op:xor w %v9;
  %v11 := pair:%v7 %v10;
  %v12 := op:xor w %v11
  dsl_ret %v12
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:and w %v3;
  %v5 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v6 := pair:%v2 %v5;
  %v7 := op:xor w %v6;
  %v8 := pair:%v1 %v7;
  %v9 := op:and w %v8;
  %v10 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v11 := pair:%v1 %v10;
  %v12 := op:xor w %v11;
  %v13 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v14 := pair:%v4 %v13;
  %v15 := op:xor w %v14
  dsl_ret %v15
  ]
  := by
     simp_mlir
     apply bitvec_AndOrXor_2658 


-- Name:152
-- precondition: true
/-
  %r = mul %x, -1

=>
  %r = sub 0, %x

-/
theorem alive_152 : forall (w : Nat) (x : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (x)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:mul w %v3
  dsl_ret %v4
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (0)) %v0;
  %v2 := op:const (Bitvec.ofInt w (x)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sub w %v3
  dsl_ret %v4
  ]
  := by
     simp_mlir
     apply bitvec_152 

-- Name:160
-- precondition: true
/-
  %sh = shl i7 %x, C2
  %r = mul %sh, C1

=>
  %sh = shl i7 %x, C2
  %r = mul %x, (C1 << C2)

-/
theorem alive_160: forall (x C2 C1 : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 7)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 7 (x)) %v0;
  %v2 := op:const (Bitvec.ofInt 7 (C2)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:shl 7 %v3;
  %v5 := op:const (Bitvec.ofInt 7 (C1)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:mul 7 %v6
  dsl_ret %v7
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 7)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 7 (x)) %v0;
  %v2 := op:const (Bitvec.ofInt 7 (C2)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:shl 7 %v3;
  %v5 := op:const (Bitvec.ofInt 7 (C1)) %v0;
  %v6 := pair:%v5 %v2;
  %v7 := op:shl 7 %v6;
  %v8 := pair:%v1 %v7;
  %v9 := op:mul 7 %v8
  dsl_ret %v9
  ]
  := by
     simp_mlir
     apply bitvec_160

-- Name:229
-- precondition: true
/-
  %Op0 = add %X, C1
  %r = mul %Op0, %Op1

=>
  %mul = mul C1, %Op1
  %tmp = mul %X, %Op1
  %Op0 = add %X, C1
  %r = add %tmp, %mul

-/
theorem alive_229 : forall (w : Nat) (X C1 Op1 : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:add w %v3;
  %v5 := op:const (Bitvec.ofInt w (Op1)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:mul w %v6
  dsl_ret %v7
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (C1)) %v0;
  %v2 := op:const (Bitvec.ofInt w (Op1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:mul w %v3;
  %v5 := op:const (Bitvec.ofInt w (X)) %v0;
  %v6 := pair:%v5 %v2;
  %v7 := op:mul w %v6;
  %v8 := pair:%v5 %v1;
  %v9 := op:add w %v8;
  %v10 := pair:%v7 %v4;
  %v11 := op:add w %v10
  dsl_ret %v11
  ]
  := by
     simp_mlir
     apply bitvec_229 

-- Name:239
-- precondition: true
/-
  %a = sub 0, %X
  %b = sub 0, %Y
  %r = mul %a, %b

=>
  %a = sub 0, %X
  %b = sub 0, %Y
  %r = mul %X, %Y

-/
theorem alive_239 : forall (w : Nat) (X Y : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (0)) %v0;
  %v2 := op:const (Bitvec.ofInt w (X)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sub w %v3;
  %v5 := op:const (Bitvec.ofInt w (0)) %v0;
  %v6 := op:const (Bitvec.ofInt w (Y)) %v0;
  %v7 := pair:%v5 %v6;
  %v8 := op:sub w %v7;
  %v9 := pair:%v4 %v8;
  %v10 := op:mul w %v9
  dsl_ret %v10
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (0)) %v0;
  %v2 := op:const (Bitvec.ofInt w (X)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sub w %v3;
  %v5 := op:const (Bitvec.ofInt w (0)) %v0;
  %v6 := op:const (Bitvec.ofInt w (Y)) %v0;
  %v7 := pair:%v5 %v6;
  %v8 := op:sub w %v7;
  %v9 := pair:%v2 %v6;
  %v10 := op:mul w %v9
  dsl_ret %v10
  ]
  := by
     simp_mlir
     apply bitvec_239 

-- Name:265
-- precondition: true
/-
  %div = udiv exact %X, %Y
  %r = mul %div, %Y

=>
  %div = udiv exact %X, %Y
  %r = %X

-/
theorem alive_265 : forall (w : Nat) (X Y : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (Y)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:udiv w %v3;
  %v5 := pair:%v4 %v2;
  %v6 := op:mul w %v5
  dsl_ret %v6
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (Y)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:udiv w %v3;
  %v5 := op:copy w %v1
  dsl_ret %v5
  ]
  := by
     simp_mlir
     apply bitvec_265 

-- Name:265-2
-- precondition: true
/-
  %div = sdiv exact %X, %Y
  %r = mul %div, %Y

=>
  %div = sdiv exact %X, %Y
  %r = %X

-/
theorem alive_265_2 : forall (w : Nat) (X Y : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (Y)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sdiv w %v3;
  %v5 := pair:%v4 %v2;
  %v6 := op:mul w %v5
  dsl_ret %v6
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (Y)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sdiv w %v3;
  %v5 := op:copy w %v1
  dsl_ret %v5
  ]
  := by
     simp_mlir
     apply bitvec_265_2 

-- Name:266
-- precondition: true
/-
  %div = udiv exact %X, %Y
  %negY = sub 0, %Y
  %r = mul %div, %negY

=>
  %div = udiv exact %X, %Y
  %negY = sub 0, %Y
  %r = sub 0, %X

-/
theorem alive_266 : forall (w : Nat) (X Y : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (Y)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:udiv w %v3;
  %v5 := op:const (Bitvec.ofInt w (0)) %v0;
  %v6 := pair:%v5 %v2;
  %v7 := op:sub w %v6;
  %v8 := pair:%v4 %v7;
  %v9 := op:mul w %v8
  dsl_ret %v9
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (Y)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:udiv w %v3;
  %v5 := op:const (Bitvec.ofInt w (0)) %v0;
  %v6 := pair:%v5 %v2;
  %v7 := op:sub w %v6;
  %v8 := op:const (Bitvec.ofInt w (0)) %v0;
  %v9 := pair:%v8 %v1;
  %v10 := op:sub w %v9
  dsl_ret %v10
  ]
  := by
     simp_mlir
     apply bitvec_266 

-- Name:266-2
-- precondition: true
/-
  %div = sdiv exact %X, %Y
  %negY = sub 0, %Y
  %r = mul %div, %negY

=>
  %div = sdiv exact %X, %Y
  %negY = sub 0, %Y
  %r = sub 0, %X

-/
theorem alive_266_2 : forall (w : Nat) (X Y : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (Y)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sdiv w %v3;
  %v5 := op:const (Bitvec.ofInt w (0)) %v0;
  %v6 := pair:%v5 %v2;
  %v7 := op:sub w %v6;
  %v8 := pair:%v4 %v7;
  %v9 := op:mul w %v8
  dsl_ret %v9
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (Y)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sdiv w %v3;
  %v5 := op:const (Bitvec.ofInt w (0)) %v0;
  %v6 := pair:%v5 %v2;
  %v7 := op:sub w %v6;
  %v8 := op:const (Bitvec.ofInt w (0)) %v0;
  %v9 := pair:%v8 %v1;
  %v10 := op:sub w %v9
  dsl_ret %v10
  ]
  := by
     simp_mlir
     apply bitvec_266_2 

-- Name:275
-- precondition: true
/-
  %div = udiv i5 %X, %Y
  %r = mul %div, %Y

=>
  %rem = urem %X, %Y
  %div = udiv i5 %X, %Y
  %r = sub %X, %rem

-/
theorem alive_275: forall (X Y : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 5)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 5 (X)) %v0;
  %v2 := op:const (Bitvec.ofInt 5 (Y)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:udiv 5 %v3;
  %v5 := pair:%v4 %v2;
  %v6 := op:mul 5 %v5
  dsl_ret %v6
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 5)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 5 (X)) %v0;
  %v2 := op:const (Bitvec.ofInt 5 (Y)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:urem 5 %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:udiv 5 %v5;
  %v7 := pair:%v1 %v4;
  %v8 := op:sub 5 %v7
  dsl_ret %v8
  ]
  := by
     simp_mlir
     apply bitvec_275

-- Name:275-2
-- precondition: true
/-
  %div = sdiv i5 %X, %Y
  %r = mul %div, %Y

=>
  %rem = srem %X, %Y
  %div = sdiv i5 %X, %Y
  %r = sub %X, %rem

-/
theorem alive_275_2: forall (X Y : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 5)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 5 (X)) %v0;
  %v2 := op:const (Bitvec.ofInt 5 (Y)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sdiv 5 %v3;
  %v5 := pair:%v4 %v2;
  %v6 := op:mul 5 %v5
  dsl_ret %v6
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 5)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 5 (X)) %v0;
  %v2 := op:const (Bitvec.ofInt 5 (Y)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:srem 5 %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:sdiv 5 %v5;
  %v7 := pair:%v1 %v4;
  %v8 := op:sub 5 %v7
  dsl_ret %v8
  ]
  := by
     simp_mlir
     apply bitvec_275_2

-- Name:276
-- precondition: true
/-
  %div = sdiv i5 %X, %Y
  %negY = sub 0, %Y
  %r = mul %div, %negY

=>
  %rem = srem %X, %Y
  %div = sdiv i5 %X, %Y
  %negY = sub 0, %Y
  %r = sub %rem, %X

-/
theorem alive_276: forall (X Y : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 5)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 5 (X)) %v0;
  %v2 := op:const (Bitvec.ofInt 5 (Y)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sdiv 5 %v3;
  %v5 := op:const (Bitvec.ofInt 5 (0)) %v0;
  %v6 := pair:%v5 %v2;
  %v7 := op:sub 5 %v6;
  %v8 := pair:%v4 %v7;
  %v9 := op:mul 5 %v8
  dsl_ret %v9
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 5)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 5 (X)) %v0;
  %v2 := op:const (Bitvec.ofInt 5 (Y)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:srem 5 %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:sdiv 5 %v5;
  %v7 := op:const (Bitvec.ofInt 5 (0)) %v0;
  %v8 := pair:%v7 %v2;
  %v9 := op:sub 5 %v8;
  %v10 := pair:%v4 %v1;
  %v11 := op:sub 5 %v10
  dsl_ret %v11
  ]
  := by
     simp_mlir
     apply bitvec_276

-- Name:276-2
-- precondition: true
/-
  %div = udiv i5 %X, %Y
  %negY = sub 0, %Y
  %r = mul %div, %negY

=>
  %rem = urem %X, %Y
  %div = udiv i5 %X, %Y
  %negY = sub 0, %Y
  %r = sub %rem, %X

-/
theorem alive_276_2: forall (X Y : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 5)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 5 (X)) %v0;
  %v2 := op:const (Bitvec.ofInt 5 (Y)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:udiv 5 %v3;
  %v5 := op:const (Bitvec.ofInt 5 (0)) %v0;
  %v6 := pair:%v5 %v2;
  %v7 := op:sub 5 %v6;
  %v8 := pair:%v4 %v7;
  %v9 := op:mul 5 %v8
  dsl_ret %v9
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 5)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 5 (X)) %v0;
  %v2 := op:const (Bitvec.ofInt 5 (Y)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:urem 5 %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:udiv 5 %v5;
  %v7 := op:const (Bitvec.ofInt 5 (0)) %v0;
  %v8 := pair:%v7 %v2;
  %v9 := op:sub 5 %v8;
  %v10 := pair:%v4 %v1;
  %v11 := op:sub 5 %v10
  dsl_ret %v11
  ]
  := by
     simp_mlir
     apply bitvec_276_2

-- Name:283
-- precondition: true
/-
  %r = mul i1 %X, %Y

=>
  %r = and %X, %Y

-/
theorem alive_283: forall (X Y : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 1 (X)) %v0;
  %v2 := op:const (Bitvec.ofInt 1 (Y)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:mul 1 %v3
  dsl_ret %v4
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 1 (X)) %v0;
  %v2 := op:const (Bitvec.ofInt 1 (Y)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:and 1 %v3
  dsl_ret %v4
  ]
  := by
     simp_mlir
     apply bitvec_283

-- Name:290 & 292
-- precondition: true
/-
  %Op0 = shl 1, %Y
  %r = mul %Op0, %Op1

=>
  %Op0 = shl 1, %Y
  %r = shl %Op1, %Y

-/
theorem alive_290__292 : forall (w : Nat) (Y Op1 : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (1)) %v0;
  %v2 := op:const (Bitvec.ofInt w (Y)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:shl w %v3;
  %v5 := op:const (Bitvec.ofInt w (Op1)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:mul w %v6
  dsl_ret %v7
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (1)) %v0;
  %v2 := op:const (Bitvec.ofInt w (Y)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:shl w %v3;
  %v5 := op:const (Bitvec.ofInt w (Op1)) %v0;
  %v6 := pair:%v5 %v2;
  %v7 := op:shl w %v6
  dsl_ret %v7
  ]
  := by
     simp_mlir
     apply bitvec_290__292 

-- Name:SimplifyDivRemOfSelect
-- precondition: true
/-
  %sel = select i1 %c, %Y, 0
  %r = udiv %X, %sel

=>
  %sel = select i1 %c, %Y, 0
  %r = udiv %X, %Y

-/
theorem alive_SimplifyDivRemOfSelect : forall (w : Nat) (c Y X : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 1 (c)) %v0;
  %v2 := op:const (Bitvec.ofInt w (Y)) %v0;
  %v3 := op:const (Bitvec.ofInt w (0)) %v0;
  %v4 := triple:%v1 %v2 %v3;
  %v5 := op:select w %v4;
  %v6 := op:const (Bitvec.ofInt w (X)) %v0;
  %v7 := pair:%v6 %v5;
  %v8 := op:udiv w %v7
  dsl_ret %v8
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 1 (c)) %v0;
  %v2 := op:const (Bitvec.ofInt w (Y)) %v0;
  %v3 := op:const (Bitvec.ofInt w (0)) %v0;
  %v4 := triple:%v1 %v2 %v3;
  %v5 := op:select w %v4;
  %v6 := op:const (Bitvec.ofInt w (X)) %v0;
  %v7 := pair:%v6 %v2;
  %v8 := op:udiv w %v7
  dsl_ret %v8
  ]
  := by
     simp_mlir
     apply bitvec_SimplifyDivRemOfSelect 

-- Name:805
-- precondition: true
/-
  %r = sdiv 1, %X

=>
  %inc = add %X, 1
  %c = icmp ult %inc, 3
  %r = select i1 %c, %X, 0

-/
theorem alive_805 : forall (w : Nat) (X : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (1)) %v0;
  %v2 := op:const (Bitvec.ofInt w (X)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sdiv w %v3
  dsl_ret %v4
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:add w %v3;
  %v5 := op:const (Bitvec.ofInt w (3)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:icmp ult  w %v6;
  %v8 := op:const (Bitvec.ofInt w (0)) %v0;
  %v9 := triple:%v7 %v1 %v8;
  %v10 := op:select w %v9
  dsl_ret %v10
  ]
  := by
     simp_mlir
     apply bitvec_805 

-- Name:820
-- precondition: true
/-
  %Z = srem i9 %X, %Op1
  %Op0 = sub %X, %Z
  %r = sdiv %Op0, %Op1

=>
  %Z = srem i9 %X, %Op1
  %Op0 = sub %X, %Z
  %r = sdiv %X, %Op1

-/
theorem alive_820: forall (X Op1 : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 9)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 9 (X)) %v0;
  %v2 := op:const (Bitvec.ofInt 9 (Op1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:srem 9 %v3;
  %v5 := pair:%v1 %v4;
  %v6 := op:sub 9 %v5;
  %v7 := pair:%v6 %v2;
  %v8 := op:sdiv 9 %v7
  dsl_ret %v8
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 9)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 9 (X)) %v0;
  %v2 := op:const (Bitvec.ofInt 9 (Op1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:srem 9 %v3;
  %v5 := pair:%v1 %v4;
  %v6 := op:sub 9 %v5;
  %v7 := pair:%v1 %v2;
  %v8 := op:sdiv 9 %v7
  dsl_ret %v8
  ]
  := by
     simp_mlir
     apply bitvec_820

-- Name:820'
-- precondition: true
/-
  %Z = urem i9 %X, %Op1
  %Op0 = sub %X, %Z
  %r = udiv %Op0, %Op1

=>
  %Z = urem i9 %X, %Op1
  %Op0 = sub %X, %Z
  %r = udiv %X, %Op1

-/
theorem alive_820': forall (X Op1 : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 9)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 9 (X)) %v0;
  %v2 := op:const (Bitvec.ofInt 9 (Op1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:urem 9 %v3;
  %v5 := pair:%v1 %v4;
  %v6 := op:sub 9 %v5;
  %v7 := pair:%v6 %v2;
  %v8 := op:udiv 9 %v7
  dsl_ret %v8
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 9)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 9 (X)) %v0;
  %v2 := op:const (Bitvec.ofInt 9 (Op1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:urem 9 %v3;
  %v5 := pair:%v1 %v4;
  %v6 := op:sub 9 %v5;
  %v7 := pair:%v1 %v2;
  %v8 := op:udiv 9 %v7
  dsl_ret %v8
  ]
  := by
     simp_mlir
     apply bitvec_820'

-- Name:891
-- precondition: true
/-
  %s = shl i13 1, %N
  %r = udiv %x, %s

=>
  %s = shl i13 1, %N
  %r = lshr %x, %N

-/
theorem alive_891: forall (N x : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 13)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 13 (1)) %v0;
  %v2 := op:const (Bitvec.ofInt 13 (N)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:shl 13 %v3;
  %v5 := op:const (Bitvec.ofInt 13 (x)) %v0;
  %v6 := pair:%v5 %v4;
  %v7 := op:udiv 13 %v6
  dsl_ret %v7
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 13)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 13 (1)) %v0;
  %v2 := op:const (Bitvec.ofInt 13 (N)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:shl 13 %v3;
  %v5 := op:const (Bitvec.ofInt 13 (x)) %v0;
  %v6 := pair:%v5 %v2;
  %v7 := op:lshr 13 %v6
  dsl_ret %v7
  ]
  := by
     simp_mlir
     apply bitvec_891

-- Name:891-exact
-- precondition: true
/-
  %s = shl i13 1, %N
  %r = udiv exact %x, %s

=>
  %s = shl i13 1, %N
  %r = lshr exact %x, %N

-/
theorem alive_891_exact: forall (N x : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 13)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 13 (1)) %v0;
  %v2 := op:const (Bitvec.ofInt 13 (N)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:shl 13 %v3;
  %v5 := op:const (Bitvec.ofInt 13 (x)) %v0;
  %v6 := pair:%v5 %v4;
  %v7 := op:udiv 13 %v6
  dsl_ret %v7
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 13)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 13 (1)) %v0;
  %v2 := op:const (Bitvec.ofInt 13 (N)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:shl 13 %v3;
  %v5 := op:const (Bitvec.ofInt 13 (x)) %v0;
  %v6 := pair:%v5 %v2;
  %v7 := op:lshr 13 %v6
  dsl_ret %v7
  ]
  := by
     simp_mlir
     apply bitvec_891_exact

-- Name:1030
-- precondition: true
/-
  %r = sdiv %X, -1

=>
  %r = sub 0, %X

-/
theorem alive_1030 : forall (w : Nat) (X : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sdiv w %v3
  dsl_ret %v4
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (0)) %v0;
  %v2 := op:const (Bitvec.ofInt w (X)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sub w %v3
  dsl_ret %v4
  ]
  := by
     simp_mlir
     apply bitvec_1030 


-- Name:Select:485-2
-- precondition: true
/-
  %c = icmp ult i32 %x, 0
  %r = select i1 %c, %A, %B

=>
  %c = icmp ult i32 %x, 0
  %r = %B

-/
theorem alive_Select_485_2 : forall (w : Nat) (x A B : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 32 (x)) %v0;
  %v2 := op:const (Bitvec.ofInt 32 (0)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp ult  32 %v3;
  %v5 := op:const (Bitvec.ofInt w (A)) %v0;
  %v6 := op:const (Bitvec.ofInt w (B)) %v0;
  %v7 := triple:%v4 %v5 %v6;
  %v8 := op:select w %v7
  dsl_ret %v8
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 32 (x)) %v0;
  %v2 := op:const (Bitvec.ofInt 32 (0)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp ult  32 %v3;
  %v5 := op:const (Bitvec.ofInt w (B)) %v0;
  %v6 := op:copy w %v5
  dsl_ret %v6
  ]
  := by
     simp_mlir
     apply bitvec_Select_485_2 

-- Name:Select:489-2
-- precondition: true
/-
  %c = icmp ugt i32 %x, -1
  %r = select i1 %c, %A, %B

=>
  %c = icmp ugt i32 %x, -1
  %r = %B

-/
theorem alive_Select_489_2 : forall (w : Nat) (x A B : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 32 (x)) %v0;
  %v2 := op:const (Bitvec.ofInt 32 (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp ugt  32 %v3;
  %v5 := op:const (Bitvec.ofInt w (A)) %v0;
  %v6 := op:const (Bitvec.ofInt w (B)) %v0;
  %v7 := triple:%v4 %v5 %v6;
  %v8 := op:select w %v7
  dsl_ret %v8
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 32 (x)) %v0;
  %v2 := op:const (Bitvec.ofInt 32 (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp ugt  32 %v3;
  %v5 := op:const (Bitvec.ofInt w (B)) %v0;
  %v6 := op:copy w %v5
  dsl_ret %v6
  ]
  := by
     simp_mlir
     apply bitvec_Select_489_2 

-- Name:Select:637
-- precondition: true
/-
  %c = icmp eq %X, C
  %r = select i1 %c, %X, %Y

=>
  %c = icmp eq %X, C
  %r = select i1 %c, C, %Y

-/
theorem alive_Select_637 : forall (w : Nat) (X C Y : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp eq  w %v3;
  %v5 := op:const (Bitvec.ofInt w (Y)) %v0;
  %v6 := triple:%v4 %v1 %v5;
  %v7 := op:select w %v6
  dsl_ret %v7
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp eq  w %v3;
  %v5 := op:const (Bitvec.ofInt w (Y)) %v0;
  %v6 := triple:%v4 %v2 %v5;
  %v7 := op:select w %v6
  dsl_ret %v7
  ]
  := by
     simp_mlir
     apply bitvec_Select_637 

-- Name:Select:641
-- precondition: true
/-
  %c = icmp ne %X, C
  %r = select i1 %c, %Y, %X

=>
  %c = icmp ne %X, C
  %r = select i1 %c, %Y, C

-/
theorem alive_Select_641 : forall (w : Nat) (X C Y : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp ne  w %v3;
  %v5 := op:const (Bitvec.ofInt w (Y)) %v0;
  %v6 := triple:%v4 %v5 %v1;
  %v7 := op:select w %v6
  dsl_ret %v7
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp ne  w %v3;
  %v5 := op:const (Bitvec.ofInt w (Y)) %v0;
  %v6 := triple:%v4 %v5 %v2;
  %v7 := op:select w %v6
  dsl_ret %v7
  ]
  := by
     simp_mlir
     apply bitvec_Select_641 

-- Name:Select:699
-- precondition: true
/-
  %c = icmp uge %A, %B
  %umax = select i1 %c, %A, %B
  %c2 = icmp uge %umax, %B
  %umax2 = select i1 %c2, %umax, %B

=>
  %c = icmp uge %A, %B
  %umax = select i1 %c, %A, %B
  %c2 = icmp uge %umax, %B
  %umax2 = select i1 %c, %A, %B

-/
theorem alive_Select_699 : forall (w : Nat) (A B : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (B)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp uge  w %v3;
  %v5 := triple:%v4 %v1 %v2;
  %v6 := op:select w %v5;
  %v7 := pair:%v6 %v2;
  %v8 := op:icmp uge  w %v7;
  %v9 := triple:%v8 %v6 %v2;
  %v10 := op:select w %v9
  dsl_ret %v10
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (B)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp uge  w %v3;
  %v5 := triple:%v4 %v1 %v2;
  %v6 := op:select w %v5;
  %v7 := pair:%v6 %v2;
  %v8 := op:icmp uge  w %v7;
  %v9 := triple:%v4 %v1 %v2;
  %v10 := op:select w %v9
  dsl_ret %v10
  ]
  := by
     simp_mlir
     apply bitvec_Select_699 

-- Name:Select:700
-- precondition: true
/-
  %c = icmp slt %A, %B
  %smin = select i1 %c, %A, %B
  %c2 = icmp slt %smin, %B
  %smin2 = select i1 %c2, %smin, %B

=>
  %c = icmp slt %A, %B
  %smin = select i1 %c, %A, %B
  %c2 = icmp slt %smin, %B
  %smin2 = select i1 %c, %A, %B

-/
theorem alive_Select_700 : forall (w : Nat) (A B : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (B)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp slt  w %v3;
  %v5 := triple:%v4 %v1 %v2;
  %v6 := op:select w %v5;
  %v7 := pair:%v6 %v2;
  %v8 := op:icmp slt  w %v7;
  %v9 := triple:%v8 %v6 %v2;
  %v10 := op:select w %v9
  dsl_ret %v10
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (B)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp slt  w %v3;
  %v5 := triple:%v4 %v1 %v2;
  %v6 := op:select w %v5;
  %v7 := pair:%v6 %v2;
  %v8 := op:icmp slt  w %v7;
  %v9 := triple:%v4 %v1 %v2;
  %v10 := op:select w %v9
  dsl_ret %v10
  ]
  := by
     simp_mlir
     apply bitvec_Select_700 

-- Name:Select:704
-- precondition: true
/-
  %c = icmp slt %A, %B
  %smin = select i1 %c, %A, %B
  %c2 = icmp sge %smin, %A
  %smax = select i1 %c2, %smin, %A

=>
  %c = icmp slt %A, %B
  %smin = select i1 %c, %A, %B
  %c2 = icmp sge %smin, %A
  %smax = %A

-/
theorem alive_Select_704 : forall (w : Nat) (A B : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (B)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp slt  w %v3;
  %v5 := triple:%v4 %v1 %v2;
  %v6 := op:select w %v5;
  %v7 := pair:%v6 %v1;
  %v8 := op:icmp sge  w %v7;
  %v9 := triple:%v8 %v6 %v1;
  %v10 := op:select w %v9
  dsl_ret %v10
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (B)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp slt  w %v3;
  %v5 := triple:%v4 %v1 %v2;
  %v6 := op:select w %v5;
  %v7 := pair:%v6 %v1;
  %v8 := op:icmp sge  w %v7;
  %v9 := op:copy w %v1
  dsl_ret %v9
  ]
  := by
     simp_mlir
     apply bitvec_Select_704 

-- Name:Select:705
-- precondition: true
/-
  %c = icmp sge %A, %B
  %umax = select i1 %c, %A, %B
  %c2 = icmp slt %umax, %A
  %umin = select i1 %c2, %umax, %A

=>
  %c = icmp sge %A, %B
  %umax = select i1 %c, %A, %B
  %c2 = icmp slt %umax, %A
  %umin = %A

-/
theorem alive_Select_705 : forall (w : Nat) (A B : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (B)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp sge  w %v3;
  %v5 := triple:%v4 %v1 %v2;
  %v6 := op:select w %v5;
  %v7 := pair:%v6 %v1;
  %v8 := op:icmp slt  w %v7;
  %v9 := triple:%v8 %v6 %v1;
  %v10 := op:select w %v9
  dsl_ret %v10
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (B)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp sge  w %v3;
  %v5 := triple:%v4 %v1 %v2;
  %v6 := op:select w %v5;
  %v7 := pair:%v6 %v1;
  %v8 := op:icmp slt  w %v7;
  %v9 := op:copy w %v1
  dsl_ret %v9
  ]
  := by
     simp_mlir
     apply bitvec_Select_705 

-- Name:Select:740
-- precondition: true
/-
  %c = icmp sgt %A, 0
  %minus = sub 0, %A
  %abs = select i1 %c, %A, %minus
  %c2 = icmp sgt %abs, -1
  %minus2 = sub 0, %abs
  %abs2 = select i1 %c2, %abs, %minus2

=>
  %c = icmp sgt %A, 0
  %minus = sub 0, %A
  %abs = select i1 %c, %A, %minus
  %c2 = icmp sgt %abs, -1
  %minus2 = sub 0, %abs
  %abs2 = select i1 %c, %A, %minus

-/
theorem alive_Select_740 : forall (w : Nat) (A : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (0)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp sgt  w %v3;
  %v5 := op:const (Bitvec.ofInt w (0)) %v0;
  %v6 := pair:%v5 %v1;
  %v7 := op:sub w %v6;
  %v8 := triple:%v4 %v1 %v7;
  %v9 := op:select w %v8;
  %v10 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v11 := pair:%v9 %v10;
  %v12 := op:icmp sgt  w %v11;
  %v13 := op:const (Bitvec.ofInt w (0)) %v0;
  %v14 := pair:%v13 %v9;
  %v15 := op:sub w %v14;
  %v16 := triple:%v12 %v9 %v15;
  %v17 := op:select w %v16
  dsl_ret %v17
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (0)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp sgt  w %v3;
  %v5 := op:const (Bitvec.ofInt w (0)) %v0;
  %v6 := pair:%v5 %v1;
  %v7 := op:sub w %v6;
  %v8 := triple:%v4 %v1 %v7;
  %v9 := op:select w %v8;
  %v10 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v11 := pair:%v9 %v10;
  %v12 := op:icmp sgt  w %v11;
  %v13 := op:const (Bitvec.ofInt w (0)) %v0;
  %v14 := pair:%v13 %v9;
  %v15 := op:sub w %v14;
  %v16 := triple:%v4 %v1 %v7;
  %v17 := op:select w %v16
  dsl_ret %v17
  ]
  := by
     simp_mlir
     apply bitvec_Select_740 

-- Name:Select:741
-- precondition: true
/-
  %c = icmp sgt %A, 0
  %minus = sub 0, %A
  %abs = select i1 %c, %minus, %A
  %c2 = icmp sgt %abs, -1
  %minus2 = sub 0, %abs
  %abs2 = select i1 %c2, %minus2, %abs

=>
  %c = icmp sgt %A, 0
  %minus = sub 0, %A
  %abs = select i1 %c, %minus, %A
  %c2 = icmp sgt %abs, -1
  %minus2 = sub 0, %abs
  %abs2 = select i1 %c, %minus, %A

-/
theorem alive_Select_741 : forall (w : Nat) (A : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (0)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp sgt  w %v3;
  %v5 := op:const (Bitvec.ofInt w (0)) %v0;
  %v6 := pair:%v5 %v1;
  %v7 := op:sub w %v6;
  %v8 := triple:%v4 %v7 %v1;
  %v9 := op:select w %v8;
  %v10 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v11 := pair:%v9 %v10;
  %v12 := op:icmp sgt  w %v11;
  %v13 := op:const (Bitvec.ofInt w (0)) %v0;
  %v14 := pair:%v13 %v9;
  %v15 := op:sub w %v14;
  %v16 := triple:%v12 %v15 %v9;
  %v17 := op:select w %v16
  dsl_ret %v17
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (0)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp sgt  w %v3;
  %v5 := op:const (Bitvec.ofInt w (0)) %v0;
  %v6 := pair:%v5 %v1;
  %v7 := op:sub w %v6;
  %v8 := triple:%v4 %v7 %v1;
  %v9 := op:select w %v8;
  %v10 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v11 := pair:%v9 %v10;
  %v12 := op:icmp sgt  w %v11;
  %v13 := op:const (Bitvec.ofInt w (0)) %v0;
  %v14 := pair:%v13 %v9;
  %v15 := op:sub w %v14;
  %v16 := triple:%v4 %v7 %v1;
  %v17 := op:select w %v16
  dsl_ret %v17
  ]
  := by
     simp_mlir
     apply bitvec_Select_741 

-- Name:Select:746
-- precondition: true
/-
  %c = icmp slt %A, 0
  %minus = sub 0, %A
  %abs = select i1 %c, %A, %minus
  %c2 = icmp sgt %abs, 0
  %minus2 = sub 0, %abs
  %abs2 = select i1 %c2, %abs, %minus2

=>
  %minus = sub 0, %A
  %c3 = icmp sgt %A, 0
  %c = icmp slt %A, 0
  %abs = select i1 %c, %A, %minus
  %c2 = icmp sgt %abs, 0
  %minus2 = sub 0, %abs
  %abs2 = select i1 %c3, %A, %minus

-/
theorem alive_Select_746 : forall (w : Nat) (A : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (0)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp slt  w %v3;
  %v5 := op:const (Bitvec.ofInt w (0)) %v0;
  %v6 := pair:%v5 %v1;
  %v7 := op:sub w %v6;
  %v8 := triple:%v4 %v1 %v7;
  %v9 := op:select w %v8;
  %v10 := op:const (Bitvec.ofInt w (0)) %v0;
  %v11 := pair:%v9 %v10;
  %v12 := op:icmp sgt  w %v11;
  %v13 := op:const (Bitvec.ofInt w (0)) %v0;
  %v14 := pair:%v13 %v9;
  %v15 := op:sub w %v14;
  %v16 := triple:%v12 %v9 %v15;
  %v17 := op:select w %v16
  dsl_ret %v17
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (0)) %v0;
  %v2 := op:const (Bitvec.ofInt w (A)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sub w %v3;
  %v5 := op:const (Bitvec.ofInt w (0)) %v0;
  %v6 := pair:%v2 %v5;
  %v7 := op:icmp sgt  w %v6;
  %v8 := op:const (Bitvec.ofInt w (0)) %v0;
  %v9 := pair:%v2 %v8;
  %v10 := op:icmp slt  w %v9;
  %v11 := triple:%v10 %v2 %v4;
  %v12 := op:select w %v11;
  %v13 := op:const (Bitvec.ofInt w (0)) %v0;
  %v14 := pair:%v12 %v13;
  %v15 := op:icmp sgt  w %v14;
  %v16 := op:const (Bitvec.ofInt w (0)) %v0;
  %v17 := pair:%v16 %v12;
  %v18 := op:sub w %v17;
  %v19 := triple:%v7 %v2 %v4;
  %v20 := op:select w %v19
  dsl_ret %v20
  ]
  := by
     simp_mlir
     apply bitvec_Select_746 

-- Name:Select:747
-- precondition: true
/-
  %c = icmp sgt %A, 0
  %minus = sub 0, %A
  %abs = select i1 %c, %A, %minus
  %c2 = icmp slt %abs, 0
  %minus2 = sub 0, %abs
  %abs2 = select i1 %c2, %abs, %minus2

=>
  %minus = sub 0, %A
  %c3 = icmp slt %A, 0
  %c = icmp sgt %A, 0
  %abs = select i1 %c, %A, %minus
  %c2 = icmp slt %abs, 0
  %minus2 = sub 0, %abs
  %abs2 = select i1 %c3, %A, %minus

-/
theorem alive_Select_747 : forall (w : Nat) (A : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (0)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp sgt  w %v3;
  %v5 := op:const (Bitvec.ofInt w (0)) %v0;
  %v6 := pair:%v5 %v1;
  %v7 := op:sub w %v6;
  %v8 := triple:%v4 %v1 %v7;
  %v9 := op:select w %v8;
  %v10 := op:const (Bitvec.ofInt w (0)) %v0;
  %v11 := pair:%v9 %v10;
  %v12 := op:icmp slt  w %v11;
  %v13 := op:const (Bitvec.ofInt w (0)) %v0;
  %v14 := pair:%v13 %v9;
  %v15 := op:sub w %v14;
  %v16 := triple:%v12 %v9 %v15;
  %v17 := op:select w %v16
  dsl_ret %v17
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (0)) %v0;
  %v2 := op:const (Bitvec.ofInt w (A)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sub w %v3;
  %v5 := op:const (Bitvec.ofInt w (0)) %v0;
  %v6 := pair:%v2 %v5;
  %v7 := op:icmp slt  w %v6;
  %v8 := op:const (Bitvec.ofInt w (0)) %v0;
  %v9 := pair:%v2 %v8;
  %v10 := op:icmp sgt  w %v9;
  %v11 := triple:%v10 %v2 %v4;
  %v12 := op:select w %v11;
  %v13 := op:const (Bitvec.ofInt w (0)) %v0;
  %v14 := pair:%v12 %v13;
  %v15 := op:icmp slt  w %v14;
  %v16 := op:const (Bitvec.ofInt w (0)) %v0;
  %v17 := pair:%v16 %v12;
  %v18 := op:sub w %v17;
  %v19 := triple:%v7 %v2 %v4;
  %v20 := op:select w %v19
  dsl_ret %v20
  ]
  := by
     simp_mlir
     apply bitvec_Select_747 



-- Name:Select:962
-- precondition: true
/-
  %s1 = add %x, %y
  %s2 = add %x, %z
  %r = select i1 %c, %s1, %s2

=>
  %yz = select i1 %c, %y, %z
  %s1 = add %x, %y
  %s2 = add %x, %z
  %r = add %x, %yz

-/
theorem alive_Select_962 : forall (w : Nat) (x y z c : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (x)) %v0;
  %v2 := op:const (Bitvec.ofInt w (y)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:add w %v3;
  %v5 := op:const (Bitvec.ofInt w (z)) %v0;
  %v6 := pair:%v1 %v5;
  %v7 := op:add w %v6;
  %v8 := op:const (Bitvec.ofInt 1 (c)) %v0;
  %v9 := triple:%v8 %v4 %v7;
  %v10 := op:select w %v9
  dsl_ret %v10
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 1 (c)) %v0;
  %v2 := op:const (Bitvec.ofInt w (y)) %v0;
  %v3 := op:const (Bitvec.ofInt w (z)) %v0;
  %v4 := triple:%v1 %v2 %v3;
  %v5 := op:select w %v4;
  %v6 := op:const (Bitvec.ofInt w (x)) %v0;
  %v7 := pair:%v6 %v2;
  %v8 := op:add w %v7;
  %v9 := pair:%v6 %v3;
  %v10 := op:add w %v9;
  %v11 := pair:%v6 %v5;
  %v12 := op:add w %v11
  dsl_ret %v12
  ]
  := by
     simp_mlir
     apply bitvec_Select_962 

-- Name:Select:967a
-- precondition: true
/-
  %sum = add i9 %x, %y
  %dif = sub %x, %y
  %r = select i1 %c, %sum, %dif

=>
  %neg = sub 0, %y
  %sel = select i1 %c, %y, %neg
  %sum = add i9 %x, %y
  %dif = sub %x, %y
  %r = add %x, %sel

-/
theorem alive_Select_967a: forall (x y c : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 9)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 9 (x)) %v0;
  %v2 := op:const (Bitvec.ofInt 9 (y)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:add 9 %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:sub 9 %v5;
  %v7 := op:const (Bitvec.ofInt 1 (c)) %v0;
  %v8 := triple:%v7 %v4 %v6;
  %v9 := op:select 9 %v8
  dsl_ret %v9
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 9)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 9 (0)) %v0;
  %v2 := op:const (Bitvec.ofInt 9 (y)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sub 9 %v3;
  %v5 := op:const (Bitvec.ofInt 1 (c)) %v0;
  %v6 := triple:%v5 %v2 %v4;
  %v7 := op:select 9 %v6;
  %v8 := op:const (Bitvec.ofInt 9 (x)) %v0;
  %v9 := pair:%v8 %v2;
  %v10 := op:add 9 %v9;
  %v11 := pair:%v8 %v2;
  %v12 := op:sub 9 %v11;
  %v13 := pair:%v8 %v7;
  %v14 := op:add 9 %v13
  dsl_ret %v14
  ]
  := by
     simp_mlir
     apply bitvec_Select_967a

-- Name:Select:967b
-- precondition: true
/-
  %sum = sub i9 %x, %y
  %dif = add %x, %y
  %r = select i1 %c, %sum, %dif

=>
  %neg = sub 0, %y
  %sel = select i1 %c, %neg, %y
  %sum = sub i9 %x, %y
  %dif = add %x, %y
  %r = add %x, %sel

-/
theorem alive_Select_967b: forall (x y c : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 9)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 9 (x)) %v0;
  %v2 := op:const (Bitvec.ofInt 9 (y)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sub 9 %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:add 9 %v5;
  %v7 := op:const (Bitvec.ofInt 1 (c)) %v0;
  %v8 := triple:%v7 %v4 %v6;
  %v9 := op:select 9 %v8
  dsl_ret %v9
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 9)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 9 (0)) %v0;
  %v2 := op:const (Bitvec.ofInt 9 (y)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sub 9 %v3;
  %v5 := op:const (Bitvec.ofInt 1 (c)) %v0;
  %v6 := triple:%v5 %v4 %v2;
  %v7 := op:select 9 %v6;
  %v8 := op:const (Bitvec.ofInt 9 (x)) %v0;
  %v9 := pair:%v8 %v2;
  %v10 := op:sub 9 %v9;
  %v11 := pair:%v8 %v2;
  %v12 := op:add 9 %v11;
  %v13 := pair:%v8 %v7;
  %v14 := op:add 9 %v13
  dsl_ret %v14
  ]
  := by
     simp_mlir
     apply bitvec_Select_967b

-- Name:Select:1070
-- precondition: true
/-
  %X = select i1 %c, %W, %Z
  %r = select i1 %c, %X, %Y

=>
  %X = select i1 %c, %W, %Z
  %r = select i1 %c, %W, %Y

-/
theorem alive_Select_1070 : forall (w : Nat) (c W Z Y : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 1 (c)) %v0;
  %v2 := op:const (Bitvec.ofInt w (W)) %v0;
  %v3 := op:const (Bitvec.ofInt w (Z)) %v0;
  %v4 := triple:%v1 %v2 %v3;
  %v5 := op:select w %v4;
  %v6 := op:const (Bitvec.ofInt w (Y)) %v0;
  %v7 := triple:%v1 %v5 %v6;
  %v8 := op:select w %v7
  dsl_ret %v8
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 1 (c)) %v0;
  %v2 := op:const (Bitvec.ofInt w (W)) %v0;
  %v3 := op:const (Bitvec.ofInt w (Z)) %v0;
  %v4 := triple:%v1 %v2 %v3;
  %v5 := op:select w %v4;
  %v6 := op:const (Bitvec.ofInt w (Y)) %v0;
  %v7 := triple:%v1 %v2 %v6;
  %v8 := op:select w %v7
  dsl_ret %v8
  ]
  := by
     simp_mlir
     apply bitvec_Select_1070 

-- Name:Select:1078
-- precondition: true
/-
  %Y = select i1 %c, %W, %Z
  %r = select i1 %c, %X, %Y

=>
  %Y = select i1 %c, %W, %Z
  %r = select i1 %c, %X, %Z

-/
theorem alive_Select_1078 : forall (w : Nat) (c W Z X : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 1 (c)) %v0;
  %v2 := op:const (Bitvec.ofInt w (W)) %v0;
  %v3 := op:const (Bitvec.ofInt w (Z)) %v0;
  %v4 := triple:%v1 %v2 %v3;
  %v5 := op:select w %v4;
  %v6 := op:const (Bitvec.ofInt w (X)) %v0;
  %v7 := triple:%v1 %v6 %v5;
  %v8 := op:select w %v7
  dsl_ret %v8
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 1 (c)) %v0;
  %v2 := op:const (Bitvec.ofInt w (W)) %v0;
  %v3 := op:const (Bitvec.ofInt w (Z)) %v0;
  %v4 := triple:%v1 %v2 %v3;
  %v5 := op:select w %v4;
  %v6 := op:const (Bitvec.ofInt w (X)) %v0;
  %v7 := triple:%v1 %v6 %v3;
  %v8 := op:select w %v7
  dsl_ret %v8
  ]
  := by
     simp_mlir
     apply bitvec_Select_1078 

-- Name:Select:1087
-- precondition: true
/-
  %c = xor i1 %val, true
  %r = select i1 %c, %X, %Y

=>
  %c = xor i1 %val, true
  %r = select i1 %val, %Y, %X

-/
theorem alive_Select_1087 : forall (w : Nat) (val X Y : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 1 (val)) %v0;
  %v2 := op:const  (Vector.cons true Vector.nil) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor 1 %v3;
  %v5 := op:const (Bitvec.ofInt w (X)) %v0;
  %v6 := op:const (Bitvec.ofInt w (Y)) %v0;
  %v7 := triple:%v4 %v5 %v6;
  %v8 := op:select w %v7
  dsl_ret %v8
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 1 (val)) %v0;
  %v2 := op:const  (Vector.cons true Vector.nil) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor 1 %v3;
  %v5 := op:const (Bitvec.ofInt w (Y)) %v0;
  %v6 := op:const (Bitvec.ofInt w (X)) %v0;
  %v7 := triple:%v1 %v5 %v6;
  %v8 := op:select w %v7
  dsl_ret %v8
  ]
  := by
     simp_mlir
     apply bitvec_Select_1087 

-- Name:Select:1100
-- precondition: true
/-
  %r = select i1 true, %X, %Y

=>
  %r = %X

-/
theorem alive_Select_1100 : forall (w : Nat) (X Y : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const  (Vector.cons true Vector.nil) %v0;
  %v2 := op:const (Bitvec.ofInt w (X)) %v0;
  %v3 := op:const (Bitvec.ofInt w (Y)) %v0;
  %v4 := triple:%v1 %v2 %v3;
  %v5 := op:select w %v4
  dsl_ret %v5
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:copy w %v1
  dsl_ret %v2
  ]
  := by
     simp_mlir
     apply bitvec_Select_1100 

-- Name:Select:1105
-- precondition: true
/-
  %r = select i1 false, %X, %Y

=>
  %r = %Y

-/
theorem alive_Select_1105 : forall (w : Nat) (X Y : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const  (Vector.cons false Vector.nil) %v0;
  %v2 := op:const (Bitvec.ofInt w (X)) %v0;
  %v3 := op:const (Bitvec.ofInt w (Y)) %v0;
  %v4 := triple:%v1 %v2 %v3;
  %v5 := op:select w %v4
  dsl_ret %v5
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (Y)) %v0;
  %v2 := op:copy w %v1
  dsl_ret %v2
  ]
  := by
     simp_mlir
     apply bitvec_Select_1105 

-- Name:InstCombineShift: 239
-- precondition: true
/-
  %Op0 = shl %X, C
  %r = lshr %Op0, C

=>
  %Op0 = shl %X, C
  %r = and %X, (-1 u>> C)

-/
theorem alive_InstCombineShift__239 : forall (w : Nat) (X C : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:shl w %v3;
  %v5 := pair:%v4 %v2;
  %v6 := op:lshr w %v5
  dsl_ret %v6
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:shl w %v3;
  %v5 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v6 := pair:%v5 %v2;
  %v7 := op:lshr w %v6;
  %v8 := pair:%v1 %v7;
  %v9 := op:and w %v8
  dsl_ret %v9
  ]
  := by
     simp_mlir
     apply bitvec_InstCombineShift__239 

-- Name:InstCombineShift: 279
-- precondition: true
/-
  %Op0 = lshr %X, C
  %r = shl %Op0, C

=>
  %Op0 = lshr %X, C
  %r = and %X, (-1 << C)

-/
theorem alive_InstCombineShift__279 : forall (w : Nat) (X C : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:lshr w %v3;
  %v5 := pair:%v4 %v2;
  %v6 := op:shl w %v5
  dsl_ret %v6
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:lshr w %v3;
  %v5 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v6 := pair:%v5 %v2;
  %v7 := op:shl w %v6;
  %v8 := pair:%v1 %v7;
  %v9 := op:and w %v8
  dsl_ret %v9
  ]
  := by
     simp_mlir
     apply bitvec_InstCombineShift__279 

-- Name:InstCombineShift: 351
-- precondition: true
/-
  %Op0 = mul i7 %X, C1
  %r = shl %Op0, C2

=>
  %Op0 = mul i7 %X, C1
  %r = mul %X, (C1 << C2)

-/
theorem alive_InstCombineShift__351: forall (X C1 C2 : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 7)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 7 (X)) %v0;
  %v2 := op:const (Bitvec.ofInt 7 (C1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:mul 7 %v3;
  %v5 := op:const (Bitvec.ofInt 7 (C2)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:shl 7 %v6
  dsl_ret %v7
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 7)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 7 (X)) %v0;
  %v2 := op:const (Bitvec.ofInt 7 (C1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:mul 7 %v3;
  %v5 := op:const (Bitvec.ofInt 7 (C2)) %v0;
  %v6 := pair:%v2 %v5;
  %v7 := op:shl 7 %v6;
  %v8 := pair:%v1 %v7;
  %v9 := op:mul 7 %v8
  dsl_ret %v9
  ]
  := by
     simp_mlir
     apply bitvec_InstCombineShift__351

-- Name:InstCombineShift: 422-1
-- precondition: true
/-
  %Op1 = lshr i31 %X, C
  %Op0 = add %Y, %Op1
  %r = shl %Op0, C

=>
  %s = shl %Y, C
  %a = add %s, %X
  %Op1 = lshr i31 %X, C
  %Op0 = add %Y, %Op1
  %r = and %a, (-1 << C)

-/
theorem alive_InstCombineShift__422_1: forall (X C Y : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 31)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 31 (X)) %v0;
  %v2 := op:const (Bitvec.ofInt 31 (C)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:lshr 31 %v3;
  %v5 := op:const (Bitvec.ofInt 31 (Y)) %v0;
  %v6 := pair:%v5 %v4;
  %v7 := op:add 31 %v6;
  %v8 := pair:%v7 %v2;
  %v9 := op:shl 31 %v8
  dsl_ret %v9
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 31)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 31 (Y)) %v0;
  %v2 := op:const (Bitvec.ofInt 31 (C)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:shl 31 %v3;
  %v5 := op:const (Bitvec.ofInt 31 (X)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:add 31 %v6;
  %v8 := pair:%v5 %v2;
  %v9 := op:lshr 31 %v8;
  %v10 := pair:%v1 %v9;
  %v11 := op:add 31 %v10;
  %v12 := op:const (Bitvec.ofInt 31 (-1)) %v0;
  %v13 := pair:%v12 %v2;
  %v14 := op:shl 31 %v13;
  %v15 := pair:%v7 %v14;
  %v16 := op:and 31 %v15
  dsl_ret %v16
  ]
  := by
     simp_mlir
     apply bitvec_InstCombineShift__422_1

-- Name:InstCombineShift: 422-2
-- precondition: true
/-
  %Op1 = ashr i31 %X, C
  %Op0 = add %Y, %Op1
  %r = shl %Op0, C

=>
  %s = shl %Y, C
  %a = add %s, %X
  %Op1 = ashr i31 %X, C
  %Op0 = add %Y, %Op1
  %r = and %a, (-1 << C)

-/
theorem alive_InstCombineShift__422_2: forall (X C Y : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 31)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 31 (X)) %v0;
  %v2 := op:const (Bitvec.ofInt 31 (C)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:ashr 31 %v3;
  %v5 := op:const (Bitvec.ofInt 31 (Y)) %v0;
  %v6 := pair:%v5 %v4;
  %v7 := op:add 31 %v6;
  %v8 := pair:%v7 %v2;
  %v9 := op:shl 31 %v8
  dsl_ret %v9
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 31)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 31 (Y)) %v0;
  %v2 := op:const (Bitvec.ofInt 31 (C)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:shl 31 %v3;
  %v5 := op:const (Bitvec.ofInt 31 (X)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:add 31 %v6;
  %v8 := pair:%v5 %v2;
  %v9 := op:ashr 31 %v8;
  %v10 := pair:%v1 %v9;
  %v11 := op:add 31 %v10;
  %v12 := op:const (Bitvec.ofInt 31 (-1)) %v0;
  %v13 := pair:%v12 %v2;
  %v14 := op:shl 31 %v13;
  %v15 := pair:%v7 %v14;
  %v16 := op:and 31 %v15
  dsl_ret %v16
  ]
  := by
     simp_mlir
     apply bitvec_InstCombineShift__422_2

-- Name:InstCombineShift: 440
-- precondition: true
/-
  %s = lshr %X, C
  %Op1 = and %s, C2
  %Op0 = xor %Y, %Op1
  %r = shl %Op0, C

=>
  %a = and %X, (C2 << C)
  %y2 = shl %Y, C
  %s = lshr %X, C
  %Op1 = and %s, C2
  %Op0 = xor %Y, %Op1
  %r = xor %a, %y2

-/
theorem alive_InstCombineShift__440 : forall (w : Nat) (X C C2 Y : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:lshr w %v3;
  %v5 := op:const (Bitvec.ofInt w (C2)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:and w %v6;
  %v8 := op:const (Bitvec.ofInt w (Y)) %v0;
  %v9 := pair:%v8 %v7;
  %v10 := op:xor w %v9;
  %v11 := pair:%v10 %v2;
  %v12 := op:shl w %v11
  dsl_ret %v12
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C2)) %v0;
  %v3 := op:const (Bitvec.ofInt w (C)) %v0;
  %v4 := pair:%v2 %v3;
  %v5 := op:shl w %v4;
  %v6 := pair:%v1 %v5;
  %v7 := op:and w %v6;
  %v8 := op:const (Bitvec.ofInt w (Y)) %v0;
  %v9 := pair:%v8 %v3;
  %v10 := op:shl w %v9;
  %v11 := pair:%v1 %v3;
  %v12 := op:lshr w %v11;
  %v13 := pair:%v12 %v2;
  %v14 := op:and w %v13;
  %v15 := pair:%v8 %v14;
  %v16 := op:xor w %v15;
  %v17 := pair:%v7 %v10;
  %v18 := op:xor w %v17
  dsl_ret %v18
  ]
  := by
     simp_mlir
     apply bitvec_InstCombineShift__440 

-- Name:InstCombineShift: 458
-- precondition: true
/-
  %s = ashr i31 %X, C
  %Op0 = sub %s, %Y
  %r = shl %Op0, C

=>
  %s2 = shl %Y, C
  %a = sub %X, %s2
  %s = ashr i31 %X, C
  %Op0 = sub %s, %Y
  %r = and %a, (-1 << C)

-/
theorem alive_InstCombineShift__458: forall (X C Y : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 31)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 31 (X)) %v0;
  %v2 := op:const (Bitvec.ofInt 31 (C)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:ashr 31 %v3;
  %v5 := op:const (Bitvec.ofInt 31 (Y)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:sub 31 %v6;
  %v8 := pair:%v7 %v2;
  %v9 := op:shl 31 %v8
  dsl_ret %v9
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 31)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 31 (Y)) %v0;
  %v2 := op:const (Bitvec.ofInt 31 (C)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:shl 31 %v3;
  %v5 := op:const (Bitvec.ofInt 31 (X)) %v0;
  %v6 := pair:%v5 %v4;
  %v7 := op:sub 31 %v6;
  %v8 := pair:%v5 %v2;
  %v9 := op:ashr 31 %v8;
  %v10 := pair:%v9 %v1;
  %v11 := op:sub 31 %v10;
  %v12 := op:const (Bitvec.ofInt 31 (-1)) %v0;
  %v13 := pair:%v12 %v2;
  %v14 := op:shl 31 %v13;
  %v15 := pair:%v7 %v14;
  %v16 := op:and 31 %v15
  dsl_ret %v16
  ]
  := by
     simp_mlir
     apply bitvec_InstCombineShift__458

-- Name:InstCombineShift: 476
-- precondition: true
/-
  %shr = lshr %X, C
  %s = and %shr, C2
  %Op0 = or %s, %Y
  %r = shl %Op0, C

=>
  %s2 = shl %Y, C
  %a = and %X, (C2 << C)
  %shr = lshr %X, C
  %s = and %shr, C2
  %Op0 = or %s, %Y
  %r = or %a, %s2

-/
theorem alive_InstCombineShift__476 : forall (w : Nat) (X C C2 Y : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:lshr w %v3;
  %v5 := op:const (Bitvec.ofInt w (C2)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:and w %v6;
  %v8 := op:const (Bitvec.ofInt w (Y)) %v0;
  %v9 := pair:%v7 %v8;
  %v10 := op:or w %v9;
  %v11 := pair:%v10 %v2;
  %v12 := op:shl w %v11
  dsl_ret %v12
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (Y)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:shl w %v3;
  %v5 := op:const (Bitvec.ofInt w (X)) %v0;
  %v6 := op:const (Bitvec.ofInt w (C2)) %v0;
  %v7 := pair:%v6 %v2;
  %v8 := op:shl w %v7;
  %v9 := pair:%v5 %v8;
  %v10 := op:and w %v9;
  %v11 := pair:%v5 %v2;
  %v12 := op:lshr w %v11;
  %v13 := pair:%v12 %v6;
  %v14 := op:and w %v13;
  %v15 := pair:%v14 %v1;
  %v16 := op:or w %v15;
  %v17 := pair:%v10 %v4;
  %v18 := op:or w %v17
  dsl_ret %v18
  ]
  := by
     simp_mlir
     apply bitvec_InstCombineShift__476 

-- Name:InstCombineShift: 497
-- precondition: true
/-
  %Op0 = xor %X, C2
  %r = lshr %Op0, C

=>
  %s2 = lshr %X, C
  %Op0 = xor %X, C2
  %r = xor %s2, (C2 u>> C)

-/
theorem alive_InstCombineShift__497 : forall (w : Nat) (X C2 C : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C2)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (C)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:lshr w %v6
  dsl_ret %v7
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:lshr w %v3;
  %v5 := op:const (Bitvec.ofInt w (C2)) %v0;
  %v6 := pair:%v1 %v5;
  %v7 := op:xor w %v6;
  %v8 := pair:%v5 %v2;
  %v9 := op:lshr w %v8;
  %v10 := pair:%v4 %v9;
  %v11 := op:xor w %v10
  dsl_ret %v11
  ]
  := by
     simp_mlir
     apply bitvec_InstCombineShift__497 

-- Name:InstCombineShift: 497'''
-- precondition: true
/-
  %Op0 = add %X, C2
  %r = shl %Op0, C

=>
  %s2 = shl %X, C
  %Op0 = add %X, C2
  %r = add %s2, (C2 << C)

-/
theorem alive_InstCombineShift__497''' : forall (w : Nat) (X C2 C : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C2)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:add w %v3;
  %v5 := op:const (Bitvec.ofInt w (C)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:shl w %v6
  dsl_ret %v7
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:shl w %v3;
  %v5 := op:const (Bitvec.ofInt w (C2)) %v0;
  %v6 := pair:%v1 %v5;
  %v7 := op:add w %v6;
  %v8 := pair:%v5 %v2;
  %v9 := op:shl w %v8;
  %v10 := pair:%v4 %v9;
  %v11 := op:add w %v10
  dsl_ret %v11
  ]
  := by
     simp_mlir
     apply bitvec_InstCombineShift__497''' 

-- Name:InstCombineShift: 582
-- precondition: true
/-
  %Op0 = shl %X, C
  %r = lshr %Op0, C

=>
  %Op0 = shl %X, C
  %r = and %X, (-1 u>> C)

-/
theorem alive_InstCombineShift__582 : forall (w : Nat) (X C : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:shl w %v3;
  %v5 := pair:%v4 %v2;
  %v6 := op:lshr w %v5
  dsl_ret %v6
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (X)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:shl w %v3;
  %v5 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v6 := pair:%v5 %v2;
  %v7 := op:lshr w %v6;
  %v8 := pair:%v1 %v7;
  %v9 := op:and w %v8
  dsl_ret %v9
  ]
  := by
     simp_mlir
     apply bitvec_InstCombineShift__582 

-- Name:InstCombineShift: 724
-- precondition: true
/-
  %Op0 = shl i31 C1, %A
  %r = shl %Op0, C2

=>
  %Op0 = shl i31 C1, %A
  %r = shl (C1 << C2), %A

-/
theorem alive_InstCombineShift__724: forall (C1 A C2 : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 31)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 31 (C1)) %v0;
  %v2 := op:const (Bitvec.ofInt 31 (A)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:shl 31 %v3;
  %v5 := op:const (Bitvec.ofInt 31 (C2)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:shl 31 %v6
  dsl_ret %v7
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 31)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 31 (C1)) %v0;
  %v2 := op:const (Bitvec.ofInt 31 (A)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:shl 31 %v3;
  %v5 := op:const (Bitvec.ofInt 31 (C2)) %v0;
  %v6 := pair:%v1 %v5;
  %v7 := op:shl 31 %v6;
  %v8 := pair:%v7 %v2;
  %v9 := op:shl 31 %v8
  dsl_ret %v9
  ]
  := by
     simp_mlir
     apply bitvec_InstCombineShift__724
