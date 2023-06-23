import SSA.Core.WellTypedFramework
import SSA.Core.Tactic
import SSA.Projects.InstCombine.InstCombineBase
import SSA.Projects.InstCombine.Tactic

open SSA InstCombine EDSL


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
theorem alive_AndOrXor_2375 : forall (w : Nat) (A x C B D : Bitvec 1)
, TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (x) %v0;
  %v2 := op:const (A) %v0;
  %v3 := op:const (B) %v0;
  %v4 := triple:%v1 %v2 %v3;
  %v5 := op:select w %v4;
  %v6 := op:const (C) %v0;
  %v7 := op:const (D) %v0;
  %v8 := triple:%v1 %v6 %v7;
  %v9 := op:select w %v8;
  %v10 := pair:%v5 %v9;
  %v11 := op:or w %v10
  dsl_ret %v11
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (A) %v0;
  %v2 := op:const (C) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:or 1 %v3;
  %v5 := op:const (B) %v0;
  %v6 := op:const (D) %v0;
  %v7 := pair:%v5 %v6;
  %v8 := op:or 1 %v7;
  %v9 := op:const (x) %v0;
  %v10 := triple:%v9 %v1 %v5;
  %v11 := op:select 1 %v10;
  %v12 := triple:%v9 %v2 %v6;
  %v13 := op:select 1 %v12;
  %v14 := triple:%v9 %v4 %v8;
  %v15 := op:select 1 %v14
  dsl_ret %v15
  ]
  := by
     simp_mlir
     try simp_alive
     print_goal_as_error

-- Name:160
-- precondition: true
/-
  %sh = shl i7 %x, C2
  %r = mul %sh, C1

=>
  %sh = shl i7 %x, C2
  %r = mul %x, (C1 << C2)

-/
theorem alive_160: forall (x C1 C2 : Bitvec 7)
, TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 7)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (x) %v0;
  %v2 := op:const (C2) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:shl 7 %v3;
  %v5 := op:const (C1) %v0;
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
  %v1 := op:const (x) %v0;
  %v2 := op:const (C2) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:shl 7 %v3;
  %v5 := op:const (C1) %v0;
  %v6 := pair:%v5 %v2;
  %v7 := op:shl 7 %v6;
  %v8 := pair:%v1 %v7;
  %v9 := op:mul 7 %v8
  dsl_ret %v9
  ]
  := by
     simp_mlir
     try simp_alive
     print_goal_as_error

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
theorem alive_275: forall (Y X : Bitvec 5)
, TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 5)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (X) %v0;
  %v2 := op:const (Y) %v0;
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
  %v1 := op:const (X) %v0;
  %v2 := op:const (Y) %v0;
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
     try simp_alive
     print_goal_as_error

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
theorem alive_275_2: forall (Y X : Bitvec 5)
, TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 5)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (X) %v0;
  %v2 := op:const (Y) %v0;
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
  %v1 := op:const (X) %v0;
  %v2 := op:const (Y) %v0;
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
     try simp_alive
     print_goal_as_error

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
theorem alive_276: forall (Y X : Bitvec 5)
, TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 5)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (X) %v0;
  %v2 := op:const (Y) %v0;
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
  %v1 := op:const (X) %v0;
  %v2 := op:const (Y) %v0;
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
     try simp_alive
     print_goal_as_error

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
theorem alive_276_2: forall (Y X : Bitvec 5)
, TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 5)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (X) %v0;
  %v2 := op:const (Y) %v0;
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
  %v1 := op:const (X) %v0;
  %v2 := op:const (Y) %v0;
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
     try simp_alive
     print_goal_as_error

-- Name:SimplifyDivRemOfSelect
-- precondition: true
/-
  %sel = select i1 %c, %Y, 0
  %r = udiv %X, %sel

=>
  %sel = select i1 %c, %Y, 0
  %r = udiv %X, %Y

-/
theorem alive_SimplifyDivRemOfSelect : forall (w : Nat) (Y X c : Bitvec 1)
, TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (c) %v0;
  %v2 := op:const (Y) %v0;
  %v3 := op:const (Bitvec.ofInt 1 (0)) %v0;
  %v4 := triple:%v1 %v2 %v3;
  %v5 := op:select w %v4;
  %v6 := op:const (X) %v0;
  %v7 := pair:%v6 %v5;
  %v8 := op:udiv w %v7
  dsl_ret %v8
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (c) %v0;
  %v2 := op:const (Y) %v0;
  %v3 := op:const (Bitvec.ofInt 1 (0)) %v0;
  %v4 := triple:%v1 %v2 %v3;
  %v5 := op:select 1 %v4;
  %v6 := op:const (X) %v0;
  %v7 := pair:%v6 %v2;
  %v8 := op:udiv 1 %v7
  dsl_ret %v8
  ]
  := by
     simp_mlir
     try simp_alive
     print_goal_as_error

-- Name:805
-- precondition: true
/-
  %r = sdiv 1, %X

=>
  %inc = add %X, 1
  %c = icmp ult %inc, 3
  %r = select i1 %c, %X, 0

-/
theorem alive_805 : forall (w : Nat) (X : Bitvec 1)
, TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (1)) %v0;
  %v2 := op:const (X) %v0;
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
  %v1 := op:const (X) %v0;
  %v2 := op:const (Bitvec.ofInt w (1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:add w %v3;
  %v5 := op:const (Bitvec.ofInt w (3)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:icmp ult  w %v6;
  %v8 := op:const (Bitvec.ofInt 1 (0)) %v0;
  %v9 := triple:%v7 %v1 %v8;
  %v10 := op:select w %v9
  dsl_ret %v10
  ]
  := by
     simp_mlir
     try simp_alive
     print_goal_as_error

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
theorem alive_820: forall (X Op1 : Bitvec 9)
, TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 9)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (X) %v0;
  %v2 := op:const (Op1) %v0;
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
  %v1 := op:const (X) %v0;
  %v2 := op:const (Op1) %v0;
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
     try simp_alive
     print_goal_as_error

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
theorem alive_820': forall (X Op1 : Bitvec 9)
, TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 9)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (X) %v0;
  %v2 := op:const (Op1) %v0;
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
  %v1 := op:const (X) %v0;
  %v2 := op:const (Op1) %v0;
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
     try simp_alive
     print_goal_as_error

-- Name:891
-- precondition: true
/-
  %s = shl i13 1, %N
  %r = udiv %x, %s

=>
  %s = shl i13 1, %N
  %r = lshr %x, %N

-/
theorem alive_891: forall (x N : Bitvec 13)
, TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 13)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 13 (1)) %v0;
  %v2 := op:const (N) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:shl 13 %v3;
  %v5 := op:const (x) %v0;
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
  %v2 := op:const (N) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:shl 13 %v3;
  %v5 := op:const (x) %v0;
  %v6 := pair:%v5 %v2;
  %v7 := op:lshr 13 %v6
  dsl_ret %v7
  ]
  := by
     simp_mlir
     try simp_alive
     print_goal_as_error

-- Name:891-exact
-- precondition: true
/-
  %s = shl i13 1, %N
  %r = udiv exact %x, %s

=>
  %s = shl i13 1, %N
  %r = lshr exact %x, %N

-/
theorem alive_891_exact: forall (x N : Bitvec 13)
, TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 13)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 13 (1)) %v0;
  %v2 := op:const (N) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:shl 13 %v3;
  %v5 := op:const (x) %v0;
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
  %v2 := op:const (N) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:shl 13 %v3;
  %v5 := op:const (x) %v0;
  %v6 := pair:%v5 %v2;
  %v7 := op:lshr 13 %v6
  dsl_ret %v7
  ]
  := by
     simp_mlir
     try simp_alive
     print_goal_as_error

-- Name:1049
-- precondition: true
/-
  %Op0 = sub nsw i11 0, %X
  %r = sdiv %Op0, C

=>
  %Op0 = sub nsw i11 0, %X
  %r = sdiv %X, -C

-/
theorem alive_1049: forall (X C : Bitvec 11)
, TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 11)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 11 (0)) %v0;
  %v2 := op:const (X) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sub 11 %v3;
  %v5 := op:const (C) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:sdiv 11 %v6
  dsl_ret %v7
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 11)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 11 (0)) %v0;
  %v2 := op:const (X) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sub 11 %v3;
  %v5 := op:const (C) %v0;
  %v6 := op:neg 11 %v5;
  %v7 := pair:%v2 %v6;
  %v8 := op:sdiv 11 %v7
  dsl_ret %v8
  ]
  := by
     simp_mlir
     try simp_alive
     print_goal_as_error

-- Name:Select:637
-- precondition: true
/-
  %c = icmp eq %X, C
  %r = select i1 %c, %X, %Y

=>
  %c = icmp eq %X, C
  %r = select i1 %c, C, %Y

-/
theorem alive_Select_637 : forall (w : Nat) (Y C : Bitvec 1)
(X : Bitvec w)
, TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (X) %v0;
  %v2 := op:const (C) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp eq  w %v3;
  %v5 := op:const (Y) %v0;
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
  %v1 := op:const (X) %v0;
  %v2 := op:const (C) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp eq  w %v3;
  %v5 := op:const (Y) %v0;
  %v6 := triple:%v4 %v2 %v5;
  %v7 := op:select w %v6
  dsl_ret %v7
  ]
  := by
     simp_mlir
     try simp_alive
     print_goal_as_error

-- Name:Select:641
-- precondition: true
/-
  %c = icmp ne %X, C
  %r = select i1 %c, %Y, %X

=>
  %c = icmp ne %X, C
  %r = select i1 %c, %Y, C

-/
theorem alive_Select_641 : forall (w : Nat) (Y C : Bitvec 1)
(X : Bitvec w)
, TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (X) %v0;
  %v2 := op:const (C) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp ne  w %v3;
  %v5 := op:const (Y) %v0;
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
  %v1 := op:const (X) %v0;
  %v2 := op:const (C) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp ne  w %v3;
  %v5 := op:const (Y) %v0;
  %v6 := triple:%v4 %v5 %v2;
  %v7 := op:select w %v6
  dsl_ret %v7
  ]
  := by
     simp_mlir
     try simp_alive
     print_goal_as_error

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
theorem alive_Select_699 : forall (w : Nat) (A B : Bitvec 1)
, TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (A) %v0;
  %v2 := op:const (B) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp uge  w %v3;
  %v5 := triple:%v4 %v1 %v2;
  %v6 := op:select 1 %v5;
  %v7 := pair:%v6 %v2;
  %v8 := op:icmp uge  w %v7;
  %v9 := triple:%v8 %v6 %v2;
  %v10 := op:select 1 %v9
  dsl_ret %v10
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (A) %v0;
  %v2 := op:const (B) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp uge  1 %v3;
  %v5 := triple:%v4 %v1 %v2;
  %v6 := op:select 1 %v5;
  %v7 := pair:%v6 %v2;
  %v8 := op:icmp uge  1 %v7;
  %v9 := triple:%v4 %v1 %v2;
  %v10 := op:select 1 %v9
  dsl_ret %v10
  ]
  := by
     simp_mlir
     try simp_alive
     print_goal_as_error

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
theorem alive_Select_700 : forall (w : Nat) (A B : Bitvec 1)
, TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (A) %v0;
  %v2 := op:const (B) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp slt  w %v3;
  %v5 := triple:%v4 %v1 %v2;
  %v6 := op:select 1 %v5;
  %v7 := pair:%v6 %v2;
  %v8 := op:icmp slt  w %v7;
  %v9 := triple:%v8 %v6 %v2;
  %v10 := op:select 1 %v9
  dsl_ret %v10
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (A) %v0;
  %v2 := op:const (B) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp slt  1 %v3;
  %v5 := triple:%v4 %v1 %v2;
  %v6 := op:select 1 %v5;
  %v7 := pair:%v6 %v2;
  %v8 := op:icmp slt  1 %v7;
  %v9 := triple:%v4 %v1 %v2;
  %v10 := op:select 1 %v9
  dsl_ret %v10
  ]
  := by
     simp_mlir
     try simp_alive
     print_goal_as_error

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
theorem alive_Select_704 : forall (w : Nat) (A B : Bitvec 1)
, TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (A) %v0;
  %v2 := op:const (B) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp slt  w %v3;
  %v5 := triple:%v4 %v1 %v2;
  %v6 := op:select 1 %v5;
  %v7 := pair:%v6 %v1;
  %v8 := op:icmp sge  w %v7;
  %v9 := triple:%v8 %v6 %v1;
  %v10 := op:select 1 %v9
  dsl_ret %v10
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (A) %v0;
  %v2 := op:const (B) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp slt  1 %v3;
  %v5 := triple:%v4 %v1 %v2;
  %v6 := op:select 1 %v5;
  %v7 := pair:%v6 %v1;
  %v8 := op:icmp sge  1 %v7;
  %v9 := op:copy 1 %v1
  dsl_ret %v9
  ]
  := by
     simp_mlir
     try simp_alive
     print_goal_as_error

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
theorem alive_Select_705 : forall (w : Nat) (A B : Bitvec 1)
, TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (A) %v0;
  %v2 := op:const (B) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp sge  w %v3;
  %v5 := triple:%v4 %v1 %v2;
  %v6 := op:select 1 %v5;
  %v7 := pair:%v6 %v1;
  %v8 := op:icmp slt  w %v7;
  %v9 := triple:%v8 %v6 %v1;
  %v10 := op:select 1 %v9
  dsl_ret %v10
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (A) %v0;
  %v2 := op:const (B) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp sge  1 %v3;
  %v5 := triple:%v4 %v1 %v2;
  %v6 := op:select 1 %v5;
  %v7 := pair:%v6 %v1;
  %v8 := op:icmp slt  1 %v7;
  %v9 := op:copy 1 %v1
  dsl_ret %v9
  ]
  := by
     simp_mlir
     try simp_alive
     print_goal_as_error

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
theorem alive_Select_740 : forall (w : Nat) (A : Bitvec 1)
, TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (A) %v0;
  %v2 := op:const (Bitvec.ofInt w (0)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp sgt  w %v3;
  %v5 := op:const (Bitvec.ofInt 1 (0)) %v0;
  %v6 := pair:%v5 %v1;
  %v7 := op:sub 1 %v6;
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
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (A) %v0;
  %v2 := op:const (Bitvec.ofInt 1 (0)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp sgt  1 %v3;
  %v5 := op:const (Bitvec.ofInt 1 (0)) %v0;
  %v6 := pair:%v5 %v1;
  %v7 := op:sub 1 %v6;
  %v8 := triple:%v4 %v1 %v7;
  %v9 := op:select 1 %v8;
  %v10 := op:const (Bitvec.ofInt 1 (-1)) %v0;
  %v11 := pair:%v9 %v10;
  %v12 := op:icmp sgt  1 %v11;
  %v13 := op:const (Bitvec.ofInt 1 (0)) %v0;
  %v14 := pair:%v13 %v9;
  %v15 := op:sub 1 %v14;
  %v16 := triple:%v4 %v1 %v7;
  %v17 := op:select 1 %v16
  dsl_ret %v17
  ]
  := by
     simp_mlir
     try simp_alive
     print_goal_as_error

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
theorem alive_Select_741 : forall (w : Nat) (A : Bitvec 1)
, TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (A) %v0;
  %v2 := op:const (Bitvec.ofInt w (0)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp sgt  w %v3;
  %v5 := op:const (Bitvec.ofInt 1 (0)) %v0;
  %v6 := pair:%v5 %v1;
  %v7 := op:sub 1 %v6;
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
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (A) %v0;
  %v2 := op:const (Bitvec.ofInt 1 (0)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp sgt  1 %v3;
  %v5 := op:const (Bitvec.ofInt 1 (0)) %v0;
  %v6 := pair:%v5 %v1;
  %v7 := op:sub 1 %v6;
  %v8 := triple:%v4 %v7 %v1;
  %v9 := op:select 1 %v8;
  %v10 := op:const (Bitvec.ofInt 1 (-1)) %v0;
  %v11 := pair:%v9 %v10;
  %v12 := op:icmp sgt  1 %v11;
  %v13 := op:const (Bitvec.ofInt 1 (0)) %v0;
  %v14 := pair:%v13 %v9;
  %v15 := op:sub 1 %v14;
  %v16 := triple:%v4 %v7 %v1;
  %v17 := op:select 1 %v16
  dsl_ret %v17
  ]
  := by
     simp_mlir
     try simp_alive
     print_goal_as_error

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
theorem alive_Select_746 : forall (w : Nat) (A : Bitvec 1)
, TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (A) %v0;
  %v2 := op:const (Bitvec.ofInt w (0)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp slt  w %v3;
  %v5 := op:const (Bitvec.ofInt 1 (0)) %v0;
  %v6 := pair:%v5 %v1;
  %v7 := op:sub 1 %v6;
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
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 1 (0)) %v0;
  %v2 := op:const (A) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sub 1 %v3;
  %v5 := op:const (Bitvec.ofInt 1 (0)) %v0;
  %v6 := pair:%v2 %v5;
  %v7 := op:icmp sgt  1 %v6;
  %v8 := op:const (Bitvec.ofInt 1 (0)) %v0;
  %v9 := pair:%v2 %v8;
  %v10 := op:icmp slt  1 %v9;
  %v11 := triple:%v10 %v2 %v4;
  %v12 := op:select 1 %v11;
  %v13 := op:const (Bitvec.ofInt 1 (0)) %v0;
  %v14 := pair:%v12 %v13;
  %v15 := op:icmp sgt  1 %v14;
  %v16 := op:const (Bitvec.ofInt 1 (0)) %v0;
  %v17 := pair:%v16 %v12;
  %v18 := op:sub 1 %v17;
  %v19 := triple:%v7 %v2 %v4;
  %v20 := op:select 1 %v19
  dsl_ret %v20
  ]
  := by
     simp_mlir
     try simp_alive
     print_goal_as_error

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
theorem alive_Select_747 : forall (w : Nat) (A : Bitvec 1)
, TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (A) %v0;
  %v2 := op:const (Bitvec.ofInt w (0)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp sgt  w %v3;
  %v5 := op:const (Bitvec.ofInt 1 (0)) %v0;
  %v6 := pair:%v5 %v1;
  %v7 := op:sub 1 %v6;
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
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 1 (0)) %v0;
  %v2 := op:const (A) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:sub 1 %v3;
  %v5 := op:const (Bitvec.ofInt 1 (0)) %v0;
  %v6 := pair:%v2 %v5;
  %v7 := op:icmp slt  1 %v6;
  %v8 := op:const (Bitvec.ofInt 1 (0)) %v0;
  %v9 := pair:%v2 %v8;
  %v10 := op:icmp sgt  1 %v9;
  %v11 := triple:%v10 %v2 %v4;
  %v12 := op:select 1 %v11;
  %v13 := op:const (Bitvec.ofInt 1 (0)) %v0;
  %v14 := pair:%v12 %v13;
  %v15 := op:icmp slt  1 %v14;
  %v16 := op:const (Bitvec.ofInt 1 (0)) %v0;
  %v17 := pair:%v16 %v12;
  %v18 := op:sub 1 %v17;
  %v19 := triple:%v7 %v2 %v4;
  %v20 := op:select 1 %v19
  dsl_ret %v20
  ]
  := by
     simp_mlir
     try simp_alive
     print_goal_as_error

-- Name:Select:858
-- precondition: true
/-
  %nota = xor %a, -1
  %r = select i1 %a, %nota, %b

=>
  %nota = xor %a, -1
  %r = and %nota, %b

-/
theorem alive_Select_858 : forall (w : Nat) (a b : Bitvec 1)
, TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (a) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (b) %v0;
  %v6 := triple:%v1 %v4 %v5;
  %v7 := op:select w %v6
  dsl_ret %v7
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (a) %v0;
  %v2 := op:const (Bitvec.ofInt 1 (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor 1 %v3;
  %v5 := op:const (b) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:and 1 %v6
  dsl_ret %v7
  ]
  := by
     simp_mlir
     try simp_alive
     print_goal_as_error

-- Name:Select:859'
-- precondition: true
/-
  %nota = xor %a, -1
  %r = select i1 %a, %b, %nota

=>
  %nota = xor %a, -1
  %r = or %nota, %b

-/
theorem alive_Select_859' : forall (w : Nat) (a b : Bitvec 1)
, TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (a) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (b) %v0;
  %v6 := triple:%v1 %v5 %v4;
  %v7 := op:select w %v6
  dsl_ret %v7
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (a) %v0;
  %v2 := op:const (Bitvec.ofInt 1 (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor 1 %v3;
  %v5 := op:const (b) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:or 1 %v6
  dsl_ret %v7
  ]
  := by
     simp_mlir
     try simp_alive
     print_goal_as_error

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
theorem alive_Select_962 : forall (w : Nat) (y c z : Bitvec 1)
(x : Bitvec w)
, TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (x) %v0;
  %v2 := op:const (y) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:add w %v3;
  %v5 := op:const (z) %v0;
  %v6 := pair:%v1 %v5;
  %v7 := op:add w %v6;
  %v8 := op:const (c) %v0;
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
  %v1 := op:const (c) %v0;
  %v2 := op:const (y) %v0;
  %v3 := op:const (z) %v0;
  %v4 := triple:%v1 %v2 %v3;
  %v5 := op:select w %v4;
  %v6 := op:const (x) %v0;
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
     try simp_alive
     print_goal_as_error

-- Name:Select:1070
-- precondition: true
/-
  %X = select i1 %c, %W, %Z
  %r = select i1 %c, %X, %Y

=>
  %X = select i1 %c, %W, %Z
  %r = select i1 %c, %W, %Y

-/
theorem alive_Select_1070 : forall (w : Nat) (Y c Z W : Bitvec 1)
, TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (c) %v0;
  %v2 := op:const (W) %v0;
  %v3 := op:const (Z) %v0;
  %v4 := triple:%v1 %v2 %v3;
  %v5 := op:select w %v4;
  %v6 := op:const (Y) %v0;
  %v7 := triple:%v1 %v5 %v6;
  %v8 := op:select w %v7
  dsl_ret %v8
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (c) %v0;
  %v2 := op:const (W) %v0;
  %v3 := op:const (Z) %v0;
  %v4 := triple:%v1 %v2 %v3;
  %v5 := op:select 1 %v4;
  %v6 := op:const (Y) %v0;
  %v7 := triple:%v1 %v2 %v6;
  %v8 := op:select 1 %v7
  dsl_ret %v8
  ]
  := by
     simp_mlir
     try simp_alive
     print_goal_as_error

-- Name:Select:1078
-- precondition: true
/-
  %Y = select i1 %c, %W, %Z
  %r = select i1 %c, %X, %Y

=>
  %Y = select i1 %c, %W, %Z
  %r = select i1 %c, %X, %Z

-/
theorem alive_Select_1078 : forall (w : Nat) (X c Z W : Bitvec 1)
, TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (c) %v0;
  %v2 := op:const (W) %v0;
  %v3 := op:const (Z) %v0;
  %v4 := triple:%v1 %v2 %v3;
  %v5 := op:select w %v4;
  %v6 := op:const (X) %v0;
  %v7 := triple:%v1 %v6 %v5;
  %v8 := op:select w %v7
  dsl_ret %v8
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (c) %v0;
  %v2 := op:const (W) %v0;
  %v3 := op:const (Z) %v0;
  %v4 := triple:%v1 %v2 %v3;
  %v5 := op:select 1 %v4;
  %v6 := op:const (X) %v0;
  %v7 := triple:%v1 %v6 %v3;
  %v8 := op:select 1 %v7
  dsl_ret %v8
  ]
  := by
     simp_mlir
     try simp_alive
     print_goal_as_error

-- Name:Select:1087
-- precondition: true
/-
  %c = xor i1 %val, true
  %r = select i1 %c, %X, %Y

=>
  %c = xor i1 %val, true
  %r = select i1 %val, %Y, %X

-/
theorem alive_Select_1087 : forall (w : Nat) (Y X val : Bitvec 1)
, TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (val) %v0;
  %v2 := op:const (Bitvec.ofBool true) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor 1 %v3;
  %v5 := op:const (X) %v0;
  %v6 := op:const (Y) %v0;
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
  %v1 := op:const (val) %v0;
  %v2 := op:const (Bitvec.ofBool true) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor 1 %v3;
  %v5 := op:const (Y) %v0;
  %v6 := op:const (X) %v0;
  %v7 := triple:%v1 %v5 %v6;
  %v8 := op:select w %v7
  dsl_ret %v8
  ]
  := by
     simp_mlir
     try simp_alive
     print_goal_as_error

-- Name:InstCombineShift: 351
-- precondition: true
/-
  %Op0 = mul i7 %X, C1
  %r = shl %Op0, C2

=>
  %Op0 = mul i7 %X, C1
  %r = mul %X, (C1 << C2)

-/
theorem alive_InstCombineShift__351: forall (X C1 C2 : Bitvec 7)
, TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.STMT (UserType.base (BaseType.bitvec 7)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (X) %v0;
  %v2 := op:const (C1) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:mul 7 %v3;
  %v5 := op:const (C2) %v0;
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
  %v1 := op:const (X) %v0;
  %v2 := op:const (C1) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:mul 7 %v3;
  %v5 := op:const (C2) %v0;
  %v6 := pair:%v2 %v5;
  %v7 := op:shl 7 %v6;
  %v8 := pair:%v1 %v7;
  %v9 := op:mul 7 %v8
  dsl_ret %v9
  ]
  := by
     simp_mlir
     try simp_alive
     print_goal_as_error

