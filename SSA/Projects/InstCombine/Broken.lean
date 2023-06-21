import SSA.Core.WellTypedFramework
import SSA.Core.Tactic
import SSA.Core.Util
import SSA.Projects.InstCombine.InstCombineBase

open SSA InstCombine EDSL

-- Name:AndOrXor:698
-- precondition: true
/-
  %a1 = and %a, %b
  %a2 = and %a, %d
  %op0 = icmp eq %a1, 0
  %op1 = icmp eq %a2, 0
  %r = and %op0, %op1

=>
  %or = or %b, %d
  %a3 = and %a, %or
  %a1 = and %a, %b
  %a2 = and %a, %d
  %op0 = icmp eq %a1, 0
  %op1 = icmp eq %a2, 0
  %r = icmp eq %a3, 0

-/
theorem alive_AndOrXor_698 : forall (w : Nat) (a b d : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:and w %v3;
  %v5 := op:const (Bitvec.ofInt w (d)) %v0;
  %v6 := pair:%v1 %v5;
  %v7 := op:and w %v6;
  %v8 := op:const (Bitvec.ofInt w (0)) %v0;
  %v9 := pair:%v4 %v8;
  %v10 := op:icmp eq  1 %v9;
  %v11 := op:const (Bitvec.ofInt w (0)) %v0;
  %v12 := pair:%v7 %v11;
  %v13 := op:icmp eq  1 %v12;
  %v14 := pair:%v10 %v13;
  %v15 := op:and 1 %v14
  dsl_ret %v15
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (b)) %v0;
  %v2 := op:const (Bitvec.ofInt w (d)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:or w %v3;
  %v5 := op:const (Bitvec.ofInt w (a)) %v0;
  %v6 := pair:%v5 %v4;
  %v7 := op:and w %v6;
  %v8 := pair:%v5 %v1;
  %v9 := op:and w %v8;
  %v10 := pair:%v5 %v2;
  %v11 := op:and w %v10;
  %v12 := op:const (Bitvec.ofInt w (0)) %v0;
  %v13 := pair:%v9 %v12;
  %v14 := op:icmp eq  w %v13;
  %v15 := op:const (Bitvec.ofInt w (0)) %v0;
  %v16 := pair:%v11 %v15;
  %v17 := op:icmp eq  w %v16;
  %v18 := op:const (Bitvec.ofInt w (0)) %v0;
  %v19 := pair:%v7 %v18;
  %v20 := op:icmp eq  w %v19
  dsl_ret %v20
  ]
  := by
     simp_mlir
     print_goal_as_error

-- Name:AndOrXor:709
-- precondition: true
/-
  %a1 = and %a, %b
  %a2 = and %a, %d
  %op0 = icmp eq %a1, %b
  %op1 = icmp eq %a2, %d
  %r = and %op0, %op1

=>
  %or = or %b, %d
  %a3 = and %a, %or
  %a1 = and %a, %b
  %a2 = and %a, %d
  %op0 = icmp eq %a1, %b
  %op1 = icmp eq %a2, %d
  %r = icmp eq %a3, %or

-/
theorem alive_AndOrXor_709 : forall (w : Nat) (a b d : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:and w %v3;
  %v5 := op:const (Bitvec.ofInt w (d)) %v0;
  %v6 := pair:%v1 %v5;
  %v7 := op:and w %v6;
  %v8 := pair:%v4 %v2;
  %v9 := op:icmp eq  1 %v8;
  %v10 := pair:%v7 %v5;
  %v11 := op:icmp eq  1 %v10;
  %v12 := pair:%v9 %v11;
  %v13 := op:and 1 %v12
  dsl_ret %v13
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (b)) %v0;
  %v2 := op:const (Bitvec.ofInt w (d)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:or w %v3;
  %v5 := op:const (Bitvec.ofInt w (a)) %v0;
  %v6 := pair:%v5 %v4;
  %v7 := op:and w %v6;
  %v8 := pair:%v5 %v1;
  %v9 := op:and w %v8;
  %v10 := pair:%v5 %v2;
  %v11 := op:and w %v10;
  %v12 := pair:%v9 %v1;
  %v13 := op:icmp eq  w %v12;
  %v14 := pair:%v11 %v2;
  %v15 := op:icmp eq  w %v14;
  %v16 := pair:%v7 %v4;
  %v17 := op:icmp eq  w %v16
  dsl_ret %v17
  ]
  := by
     simp_mlir
     print_goal_as_error

-- Name:AndOrXor:716
-- precondition: true
/-
  %a1 = and %a, %b
  %a2 = and %a, %d
  %op0 = icmp eq %a1, %a
  %op1 = icmp eq %a2, %a
  %r = and %op0, %op1

=>
  %a4 = and %b, %d
  %a3 = and %a, %a4
  %a1 = and %a, %b
  %a2 = and %a, %d
  %op0 = icmp eq %a1, %a
  %op1 = icmp eq %a2, %a
  %r = icmp eq %a3, %a

-/
theorem alive_AndOrXor_716 : forall (w : Nat) (a b d : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:and w %v3;
  %v5 := op:const (Bitvec.ofInt w (d)) %v0;
  %v6 := pair:%v1 %v5;
  %v7 := op:and w %v6;
  %v8 := pair:%v4 %v1;
  %v9 := op:icmp eq  1 %v8;
  %v10 := pair:%v7 %v1;
  %v11 := op:icmp eq  1 %v10;
  %v12 := pair:%v9 %v11;
  %v13 := op:and 1 %v12
  dsl_ret %v13
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (b)) %v0;
  %v2 := op:const (Bitvec.ofInt w (d)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:and w %v3;
  %v5 := op:const (Bitvec.ofInt w (a)) %v0;
  %v6 := pair:%v5 %v4;
  %v7 := op:and w %v6;
  %v8 := pair:%v5 %v1;
  %v9 := op:and w %v8;
  %v10 := pair:%v5 %v2;
  %v11 := op:and w %v10;
  %v12 := pair:%v9 %v5;
  %v13 := op:icmp eq  w %v12;
  %v14 := pair:%v11 %v5;
  %v15 := op:icmp eq  w %v14;
  %v16 := pair:%v7 %v5;
  %v17 := op:icmp eq  w %v16
  dsl_ret %v17
  ]
  := by
     simp_mlir
     print_goal_as_error

-- Name:AndOrXor:794
-- precondition: true
/-
  %op0 = icmp sgt %a, %b
  %op1 = icmp ne %a, %b
  %r = and %op0, %op1

=>
  %op0 = icmp sgt %a, %b
  %op1 = icmp ne %a, %b
  %r = icmp sgt %a, %b

-/
theorem alive_AndOrXor_794 : forall (w : Nat) (a b : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp sgt  1 %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:icmp ne  1 %v5;
  %v7 := pair:%v4 %v6;
  %v8 := op:and 1 %v7
  dsl_ret %v8
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp sgt  w %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:icmp ne  w %v5;
  %v7 := pair:%v1 %v2;
  %v8 := op:icmp sgt  w %v7
  dsl_ret %v8
  ]
  := by
     simp_mlir
     print_goal_as_error

-- Name:AndOrXor:827
-- precondition: true
/-
  %op0 = icmp eq %a, 0
  %op1 = icmp eq %b, 0
  %r = and %op0, %op1

=>
  %o = or %a, %b
  %op0 = icmp eq %a, 0
  %op1 = icmp eq %b, 0
  %r = icmp eq %o, 0

-/
theorem alive_AndOrXor_827 : forall (w : Nat) (a b : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (0)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp eq  1 %v3;
  %v5 := op:const (Bitvec.ofInt w (b)) %v0;
  %v6 := op:const (Bitvec.ofInt w (0)) %v0;
  %v7 := pair:%v5 %v6;
  %v8 := op:icmp eq  1 %v7;
  %v9 := pair:%v4 %v8;
  %v10 := op:and 1 %v9
  dsl_ret %v10
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:or w %v3;
  %v5 := op:const (Bitvec.ofInt w (0)) %v0;
  %v6 := pair:%v1 %v5;
  %v7 := op:icmp eq  w %v6;
  %v8 := op:const (Bitvec.ofInt w (0)) %v0;
  %v9 := pair:%v2 %v8;
  %v10 := op:icmp eq  w %v9;
  %v11 := op:const (Bitvec.ofInt w (0)) %v0;
  %v12 := pair:%v4 %v11;
  %v13 := op:icmp eq  w %v12
  dsl_ret %v13
  ]
  := by
     simp_mlir
     print_goal_as_error

-- Name:AndOrXor:887-2
-- precondition: true
/-
  %op0 = icmp eq %a, C1
  %op1 = icmp ne %a, C1
  %r = and %op0, %op1

=>
  %op0 = icmp eq %a, C1
  %op1 = icmp ne %a, C1
  %r = false

-/
theorem alive_AndOrXor_887_2 : forall (w : Nat) (a C1 : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp eq  1 %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:icmp ne  1 %v5;
  %v7 := pair:%v4 %v6;
  %v8 := op:and 1 %v7
  dsl_ret %v8
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp eq  w %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:icmp ne  w %v5;
  %v7 := op:const  (Vector.cons false Vector.nil) %v0;
  %v8 := op:copy 1 %v7
  dsl_ret %v8
  ]
  := by
     simp_mlir
     print_goal_as_error

-- Name:AndOrXor:1683-1
-- precondition: true
/-
  %op0 = icmp ugt %a, %b
  %op1 = icmp eq %a, %b
  %r = or %op0, %op1

=>
  %op0 = icmp ugt %a, %b
  %op1 = icmp eq %a, %b
  %r = icmp uge %a, %b

-/
theorem alive_AndOrXor_1683_1 : forall (w : Nat) (a b : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp ugt  1 %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:icmp eq  1 %v5;
  %v7 := pair:%v4 %v6;
  %v8 := op:or 1 %v7
  dsl_ret %v8
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp ugt  w %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:icmp eq  w %v5;
  %v7 := pair:%v1 %v2;
  %v8 := op:icmp uge  w %v7
  dsl_ret %v8
  ]
  := by
     simp_mlir
     print_goal_as_error

-- Name:AndOrXor:1683-2
-- precondition: true
/-
  %op0 = icmp uge %a, %b
  %op1 = icmp ne %a, %b
  %r = or %op0, %op1

=>
  %op0 = icmp uge %a, %b
  %op1 = icmp ne %a, %b
  %r = true

-/
theorem alive_AndOrXor_1683_2 : forall (w : Nat) (a b : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp uge  1 %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:icmp ne  1 %v5;
  %v7 := pair:%v4 %v6;
  %v8 := op:or 1 %v7
  dsl_ret %v8
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp uge  w %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:icmp ne  w %v5;
  %v7 := op:const  (Vector.cons true Vector.nil) %v0;
  %v8 := op:copy 1 %v7
  dsl_ret %v8
  ]
  := by
     simp_mlir
     print_goal_as_error

-- Name:AndOrXor:1683-1
-- precondition: true
/-
  %op0 = icmp ugt %a, %b
  %op1 = icmp eq %a, %b
  %r = or %op0, %op1

=>
  %op0 = icmp ugt %a, %b
  %op1 = icmp eq %a, %b
  %r = icmp uge %a, %b

-/
theorem alive_AndOrXor_1683_1 : forall (w : Nat) (a b : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp ugt  1 %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:icmp eq  1 %v5;
  %v7 := pair:%v4 %v6;
  %v8 := op:or 1 %v7
  dsl_ret %v8
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp ugt  w %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:icmp eq  w %v5;
  %v7 := pair:%v1 %v2;
  %v8 := op:icmp uge  w %v7
  dsl_ret %v8
  ]
  := by
     simp_mlir
     print_goal_as_error

-- Name:AndOrXor:1683-2
-- precondition: true
/-
  %op0 = icmp uge %a, %b
  %op1 = icmp ne %a, %b
  %r = or %op0, %op1

=>
  %op0 = icmp uge %a, %b
  %op1 = icmp ne %a, %b
  %r = true

-/
theorem alive_AndOrXor_1683_2 : forall (w : Nat) (a b : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp uge  1 %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:icmp ne  1 %v5;
  %v7 := pair:%v4 %v6;
  %v8 := op:or 1 %v7
  dsl_ret %v8
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp uge  w %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:icmp ne  w %v5;
  %v7 := op:const  (Vector.cons true Vector.nil) %v0;
  %v8 := op:copy 1 %v7
  dsl_ret %v8
  ]
  := by
     simp_mlir
     print_goal_as_error

-- Name:AndOrXor:1683-1
-- precondition: true
/-
  %op0 = icmp ugt %a, %b
  %op1 = icmp eq %a, %b
  %r = or %op0, %op1

=>
  %op0 = icmp ugt %a, %b
  %op1 = icmp eq %a, %b
  %r = icmp uge %a, %b

-/
theorem alive_AndOrXor_1683_1 : forall (w : Nat) (a b : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp ugt  1 %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:icmp eq  1 %v5;
  %v7 := pair:%v4 %v6;
  %v8 := op:or 1 %v7
  dsl_ret %v8
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp ugt  w %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:icmp eq  w %v5;
  %v7 := pair:%v1 %v2;
  %v8 := op:icmp uge  w %v7
  dsl_ret %v8
  ]
  := by
     simp_mlir
     print_goal_as_error

-- Name:AndOrXor:1683-2
-- precondition: true
/-
  %op0 = icmp uge %a, %b
  %op1 = icmp ne %a, %b
  %r = or %op0, %op1

=>
  %op0 = icmp uge %a, %b
  %op1 = icmp ne %a, %b
  %r = true

-/
theorem alive_AndOrXor_1683_2 : forall (w : Nat) (a b : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp uge  1 %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:icmp ne  1 %v5;
  %v7 := pair:%v4 %v6;
  %v8 := op:or 1 %v7
  dsl_ret %v8
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp uge  w %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:icmp ne  w %v5;
  %v7 := op:const  (Vector.cons true Vector.nil) %v0;
  %v8 := op:copy 1 %v7
  dsl_ret %v8
  ]
  := by
     simp_mlir
     print_goal_as_error

-- Name:AndOrXor:1683-1
-- precondition: true
/-
  %op0 = icmp ugt %a, %b
  %op1 = icmp eq %a, %b
  %r = or %op0, %op1

=>
  %op0 = icmp ugt %a, %b
  %op1 = icmp eq %a, %b
  %r = icmp uge %a, %b

-/
theorem alive_AndOrXor_1683_1 : forall (w : Nat) (a b : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp ugt  1 %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:icmp eq  1 %v5;
  %v7 := pair:%v4 %v6;
  %v8 := op:or 1 %v7
  dsl_ret %v8
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp ugt  w %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:icmp eq  w %v5;
  %v7 := pair:%v1 %v2;
  %v8 := op:icmp uge  w %v7
  dsl_ret %v8
  ]
  := by
     simp_mlir
     print_goal_as_error

-- Name:AndOrXor:1683-2
-- precondition: true
/-
  %op0 = icmp uge %a, %b
  %op1 = icmp ne %a, %b
  %r = or %op0, %op1

=>
  %op0 = icmp uge %a, %b
  %op1 = icmp ne %a, %b
  %r = true

-/
theorem alive_AndOrXor_1683_2 : forall (w : Nat) (a b : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp uge  1 %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:icmp ne  1 %v5;
  %v7 := pair:%v4 %v6;
  %v8 := op:or 1 %v7
  dsl_ret %v8
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp uge  w %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:icmp ne  w %v5;
  %v7 := op:const  (Vector.cons true Vector.nil) %v0;
  %v8 := op:copy 1 %v7
  dsl_ret %v8
  ]
  := by
     simp_mlir
     print_goal_as_error

-- Name:AndOrXor:1683-1
-- precondition: true
/-
  %op0 = icmp ugt %a, %b
  %op1 = icmp eq %a, %b
  %r = or %op0, %op1

=>
  %op0 = icmp ugt %a, %b
  %op1 = icmp eq %a, %b
  %r = icmp uge %a, %b

-/
theorem alive_AndOrXor_1683_1 : forall (w : Nat) (a b : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp ugt  1 %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:icmp eq  1 %v5;
  %v7 := pair:%v4 %v6;
  %v8 := op:or 1 %v7
  dsl_ret %v8
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp ugt  w %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:icmp eq  w %v5;
  %v7 := pair:%v1 %v2;
  %v8 := op:icmp uge  w %v7
  dsl_ret %v8
  ]
  := by
     simp_mlir
     print_goal_as_error

-- Name:AndOrXor:1683-2
-- precondition: true
/-
  %op0 = icmp uge %a, %b
  %op1 = icmp ne %a, %b
  %r = or %op0, %op1

=>
  %op0 = icmp uge %a, %b
  %op1 = icmp ne %a, %b
  %r = true

-/
theorem alive_AndOrXor_1683_2 : forall (w : Nat) (a b : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp uge  1 %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:icmp ne  1 %v5;
  %v7 := pair:%v4 %v6;
  %v8 := op:or 1 %v7
  dsl_ret %v8
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp uge  w %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:icmp ne  w %v5;
  %v7 := op:const  (Vector.cons true Vector.nil) %v0;
  %v8 := op:copy 1 %v7
  dsl_ret %v8
  ]
  := by
     simp_mlir
     print_goal_as_error

-- Name:AndOrXor:1683-1
-- precondition: true
/-
  %op0 = icmp ugt %a, %b
  %op1 = icmp eq %a, %b
  %r = or %op0, %op1

=>
  %op0 = icmp ugt %a, %b
  %op1 = icmp eq %a, %b
  %r = icmp uge %a, %b

-/
theorem alive_AndOrXor_1683_1 : forall (w : Nat) (a b : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp ugt  1 %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:icmp eq  1 %v5;
  %v7 := pair:%v4 %v6;
  %v8 := op:or 1 %v7
  dsl_ret %v8
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp ugt  w %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:icmp eq  w %v5;
  %v7 := pair:%v1 %v2;
  %v8 := op:icmp uge  w %v7
  dsl_ret %v8
  ]
  := by
     simp_mlir
     print_goal_as_error

-- Name:AndOrXor:1683-2
-- precondition: true
/-
  %op0 = icmp uge %a, %b
  %op1 = icmp ne %a, %b
  %r = or %op0, %op1

=>
  %op0 = icmp uge %a, %b
  %op1 = icmp ne %a, %b
  %r = true

-/
theorem alive_AndOrXor_1683_2 : forall (w : Nat) (a b : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp uge  1 %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:icmp ne  1 %v5;
  %v7 := pair:%v4 %v6;
  %v8 := op:or 1 %v7
  dsl_ret %v8
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp uge  w %v3;
  %v5 := pair:%v1 %v2;
  %v6 := op:icmp ne  w %v5;
  %v7 := op:const  (Vector.cons true Vector.nil) %v0;
  %v8 := op:copy 1 %v7
  dsl_ret %v8
  ]
  := by
     simp_mlir
     print_goal_as_error
-- Name:Select:850
-- precondition: true
/-
  %A = select i1 %B, false, %C

=>
  %notb = xor i1 %B, true
  %A = and %notb, %C

-/
theorem alive_Select_850 : forall (w : Nat) (B C : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 1 (B)) %v0;
  %v2 := op:const  (Vector.cons false Vector.nil) %v0;
  %v3 := op:const (Bitvec.ofInt w (C)) %v0;
  %v4 := triple:%v1 %v2 %v3;
  %v5 := op:select 1 %v4
  dsl_ret %v5
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 1 (B)) %v0;
  %v2 := op:const  (Vector.cons true Vector.nil) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor 1 %v3;
  %v5 := op:const (Bitvec.ofInt 1 (C)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:and 1 %v6
  dsl_ret %v7
  ]
  := by
     simp_mlir
     print_goal_as_error

-- Name:Select:855
-- precondition: true
/-
  %A = select i1 %B, %C, false

=>
  %A = and %B, %C

-/
theorem alive_Select_855 : forall (w : Nat) (B C : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 1 (B)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C)) %v0;
  %v3 := op:const  (Vector.cons false Vector.nil) %v0;
  %v4 := triple:%v1 %v2 %v3;
  %v5 := op:select 1 %v4
  dsl_ret %v5
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 1 (B)) %v0;
  %v2 := op:const (Bitvec.ofInt 1 (C)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:and 1 %v3
  dsl_ret %v4
  ]
  := by
     simp_mlir
     print_goal_as_error

-- Name:Select:859
-- precondition: true
/-
  %A = select i1 %B, %C, true

=>
  %notb = xor i1 %B, true
  %A = or %notb, %C

-/
theorem alive_Select_859 : forall (w : Nat) (B C : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 1 (B)) %v0;
  %v2 := op:const (Bitvec.ofInt w (C)) %v0;
  %v3 := op:const  (Vector.cons true Vector.nil) %v0;
  %v4 := triple:%v1 %v2 %v3;
  %v5 := op:select 1 %v4
  dsl_ret %v5
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 1 (B)) %v0;
  %v2 := op:const  (Vector.cons true Vector.nil) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor 1 %v3;
  %v5 := op:const (Bitvec.ofInt 1 (C)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:or 1 %v6
  dsl_ret %v7
  ]
  := by
     simp_mlir
     print_goal_as_error

-- Name:Select:851
-- precondition: true
/-
  %r = select i1 %a, %b, %a

=>
  %r = and %a, %b

-/
theorem alive_Select_851 : forall (w : Nat) (a b : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 1 (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := triple:%v1 %v2 %v1;
  %v4 := op:select 1 %v3
  dsl_ret %v4
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 1 (a)) %v0;
  %v2 := op:const (Bitvec.ofInt 1 (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:and 1 %v3
  dsl_ret %v4
  ]
  := by
     simp_mlir
     print_goal_as_error

-- Name:Select:852
-- precondition: true
/-
  %r = select i1 %a, %a, %b

=>
  %r = or %a, %b

-/
theorem alive_Select_852 : forall (w : Nat) (a b : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 1 (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (b)) %v0;
  %v3 := triple:%v1 %v1 %v2;
  %v4 := op:select 1 %v3
  dsl_ret %v4
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt 1 (a)) %v0;
  %v2 := op:const (Bitvec.ofInt 1 (b)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:or 1 %v3
  dsl_ret %v4
  ]
  := by
     simp_mlir
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
theorem alive_Select_858 : forall (w : Nat) (a b : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (b)) %v0;
  %v6 := triple:%v1 %v4 %v5;
  %v7 := op:select w %v6
  dsl_ret %v7
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (b)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:and w %v6
  dsl_ret %v7
  ]
  := by
     simp_mlir
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
theorem alive_Select_859' : forall (w : Nat) (a b : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (b)) %v0;
  %v6 := triple:%v1 %v5 %v4;
  %v7 := op:select w %v6
  dsl_ret %v7
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec w)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (a)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:xor w %v3;
  %v5 := op:const (Bitvec.ofInt w (b)) %v0;
  %v6 := pair:%v4 %v5;
  %v7 := op:or w %v6
  dsl_ret %v7
  ]
  := by
     simp_mlir
     print_goal_as_error

-- Name:AndOrXor:1705
-- precondition: true
/-
  %cmp1 = icmp eq %B, 0
  %cmp2 = icmp ugt %B, %A
  %r = or %cmp1, %cmp2

=>
  %b1 = add %B, -1
  %cmp1 = icmp eq %B, 0
  %cmp2 = icmp ugt %B, %A
  %r = icmp uge %b1, %A

-/
theorem alive_AndOrXor_1705 : forall (w : Nat) (B A : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (B)) %v0;
  %v2 := op:const (Bitvec.ofInt w (0)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp eq  1 %v3;
  %v5 := op:const (Bitvec.ofInt w (A)) %v0;
  %v6 := pair:%v1 %v5;
  %v7 := op:icmp ugt  1 %v6;
  %v8 := pair:%v4 %v7;
  %v9 := op:or 1 %v8
  dsl_ret %v9
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (B)) %v0;
  %v2 := op:const (Bitvec.ofInt w (-1)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:add w %v3;
  %v5 := op:const (Bitvec.ofInt w (0)) %v0;
  %v6 := pair:%v1 %v5;
  %v7 := op:icmp eq  w %v6;
  %v8 := op:const (Bitvec.ofInt w (A)) %v0;
  %v9 := pair:%v1 %v8;
  %v10 := op:icmp ugt  w %v9;
  %v11 := pair:%v4 %v8;
  %v12 := op:icmp uge  w %v11
  dsl_ret %v12
  ]
  := by
     simp_mlir
     print_goal_as_error

-- Name:AndOrXor:1733
-- precondition: true
/-
  %cmp1 = icmp ne %A, 0
  %cmp2 = icmp ne %B, 0
  %r = or %cmp1, %cmp2

=>
  %or = or %A, %B
  %cmp1 = icmp ne %A, 0
  %cmp2 = icmp ne %B, 0
  %r = icmp ne %or, 0

-/
theorem alive_AndOrXor_1733 : forall (w : Nat) (A B : Int), TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (0)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:icmp ne  1 %v3;
  %v5 := op:const (Bitvec.ofInt w (B)) %v0;
  %v6 := op:const (Bitvec.ofInt w (0)) %v0;
  %v7 := pair:%v5 %v6;
  %v8 := op:icmp ne  1 %v7;
  %v9 := pair:%v4 %v8;
  %v10 := op:or 1 %v9
  dsl_ret %v10
  ]  ⊑
  TSSA.eval
  (Op := Op) (e := e)
  (i := TSSAIndex.TERMINATOR (UserType.base (BaseType.bitvec 1)))
  [dsl_bb|
  ^bb
  %v0 := unit: ;
  %v1 := op:const (Bitvec.ofInt w (A)) %v0;
  %v2 := op:const (Bitvec.ofInt w (B)) %v0;
  %v3 := pair:%v1 %v2;
  %v4 := op:or w %v3;
  %v5 := op:const (Bitvec.ofInt w (0)) %v0;
  %v6 := pair:%v1 %v5;
  %v7 := op:icmp ne  w %v6;
  %v8 := op:const (Bitvec.ofInt w (0)) %v0;
  %v9 := pair:%v2 %v8;
  %v10 := op:icmp ne  w %v9;
  %v11 := op:const (Bitvec.ofInt w (0)) %v0;
  %v12 := pair:%v4 %v11;
  %v13 := op:icmp ne  w %v12
  dsl_ret %v13
  ]
  := by
     simp_mlir
     print_goal_as_error
