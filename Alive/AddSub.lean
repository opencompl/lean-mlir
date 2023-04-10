
import SSA.Framework
import Alive.Template



-- Name:AddSub:1040
-- precondition: Pre: C2 == ~C1
/-
%Y = or %Z, C2
%X = xor %Y, C1
%LHS = add %X, 1
%r = add %LHS, %RHS
=>
%and = and %Z, C1
%r = sub %RHS, %and
-/
def thm0_ssa : SSA.eval (Op := op) (Val := val) e re  [dsl_bb|
  %v1 := op:const(w, C2) %v424242;
  %v2 := pair: %v0 %v1;
  %v3 := op:or(w) %v2;
  %v6 := op:const(w, C1) %v424242;
  %v7 := pair: %v5 %v6;
  %v8 := op:xor(w) %v7;
  %v11 := op:const(w, 1) %v424242;
  %v12 := pair: %v10 %v11;
  %v13 := op:add(w) %v12;
  %v17 := pair: %v15 %v16;
  %v18 := op:add(w) %v17
  dsl_ret %v18
  ]  =
  SSA.eval (Op := op) (Val := val) e re [dsl_bb|
  %v1 := op:const(w, C1) %v424242;
  %v2 := pair: %v0 %v1;
  %v3 := op:and(w) %v2;
  %v7 := pair: %v5 %v6;
  %v8 := op:sub(w) %v7
  dsl_ret %v8
  ]
  := by simp[SSA.eval]; try sorry

-- Name:AddSub:1040
-- precondition: Pre: C2 == ~C1
/-
%Y = or %Z, C2
%X = xor %Y, C1
%LHS = add %X, 1
%r = add %LHS, %RHS
=>
%and = and %Z, C1
%r = sub %RHS, %and
-/
def thm0_tree : Tree.eval (Op := op) (Val := val)  (
  let vY := (Tree.op (.or w) ((Tree.pair (vZ) ((Tree.op (.const w C2) dummy)))))
  let vX := (Tree.op (.xor w) ((Tree.pair (vY) ((Tree.op (.const w C1) dummy)))))
  let vLHS := (Tree.op (.add w) ((Tree.pair (vX) ((Tree.op (.const w 1) dummy)))))
  (Tree.op (.add w) ((Tree.pair (vLHS) (vRHS))))) =
  Tree.eval (Op := op) (Val := val) (
  let vand := (Tree.op (.and w) ((Tree.pair (vZ) ((Tree.op (.const w C1) dummy)))))
  (Tree.op (.sub w) ((Tree.pair (vRHS) (vand)))))
  := by simp[Tree.eval]; try sorry

-- Name:AddSub:1043
-- precondition: NONE
/-
%Y = and %Z, C1
%X = xor %Y, C1
%LHS = add %X, 1
%r = add %LHS, %RHS
=>
%or = or %Z, ~C1
%r = sub %RHS, %or
-/
def thm1_ssa : SSA.eval (Op := op) (Val := val) e re  [dsl_bb|
  %v1 := op:const(w, C1) %v424242;
  %v2 := pair: %v0 %v1;
  %v3 := op:and(w) %v2;
  %v6 := op:const(w, C1) %v424242;
  %v7 := pair: %v5 %v6;
  %v8 := op:xor(w) %v7;
  %v11 := op:const(w, 1) %v424242;
  %v12 := pair: %v10 %v11;
  %v13 := op:add(w) %v12;
  %v17 := pair: %v15 %v16;
  %v18 := op:add(w) %v17
  dsl_ret %v18
  ]  =
  SSA.eval (Op := op) (Val := val) e re [dsl_bb|
  %v1 := op:const(w, C1) %v424242;
  %v2 := op:negate(w) %v1;
  %v3 := pair: %v0 %v2;
  %v4 := op:or(w) %v3;
  %v8 := pair: %v6 %v7;
  %v9 := op:sub(w) %v8
  dsl_ret %v9
  ]
  := by simp[SSA.eval]; try sorry

-- Name:AddSub:1043
-- precondition: NONE
/-
%Y = and %Z, C1
%X = xor %Y, C1
%LHS = add %X, 1
%r = add %LHS, %RHS
=>
%or = or %Z, ~C1
%r = sub %RHS, %or
-/
def thm1_tree : Tree.eval (Op := op) (Val := val)  (
  let vY := (Tree.op (.and w) ((Tree.pair (vZ) ((Tree.op (.const w C1) dummy)))))
  let vX := (Tree.op (.xor w) ((Tree.pair (vY) ((Tree.op (.const w C1) dummy)))))
  let vLHS := (Tree.op (.add w) ((Tree.pair (vX) ((Tree.op (.const w 1) dummy)))))
  (Tree.op (.add w) ((Tree.pair (vLHS) (vRHS))))) =
  Tree.eval (Op := op) (Val := val) (
  let vor := (Tree.op (.or w) ((Tree.pair (vZ) (Tree.op (.negate w) (Tree.op (.const w C1) dummy)))))
  (Tree.op (.sub w) ((Tree.pair (vRHS) (vor)))))
  := by simp[Tree.eval]; try sorry

-- Name:AddSub:1063
-- precondition: Pre: countTrailingZeros(C1) == 0 && C1 == C2+1
/-
%Y = and %Z, C2
%LHS = xor %Y, C1
%r = add %LHS, %RHS
=>
%or = or %Z, ~C2
%r = sub %RHS, %or
-/
def thm2_ssa : SSA.eval (Op := op) (Val := val) e re  [dsl_bb|
  %v1 := op:const(w, C2) %v424242;
  %v2 := pair: %v0 %v1;
  %v3 := op:and(w) %v2;
  %v6 := op:const(w, C1) %v424242;
  %v7 := pair: %v5 %v6;
  %v8 := op:xor(w) %v7;
  %v12 := pair: %v10 %v11;
  %v13 := op:add(w) %v12
  dsl_ret %v13
  ]  =
  SSA.eval (Op := op) (Val := val) e re [dsl_bb|
  %v1 := op:const(w, C2) %v424242;
  %v2 := op:negate(w) %v1;
  %v3 := pair: %v0 %v2;
  %v4 := op:or(w) %v3;
  %v8 := pair: %v6 %v7;
  %v9 := op:sub(w) %v8
  dsl_ret %v9
  ]
  := by simp[SSA.eval]; try sorry

-- Name:AddSub:1063
-- precondition: Pre: countTrailingZeros(C1) == 0 && C1 == C2+1
/-
%Y = and %Z, C2
%LHS = xor %Y, C1
%r = add %LHS, %RHS
=>
%or = or %Z, ~C2
%r = sub %RHS, %or
-/
def thm2_tree : Tree.eval (Op := op) (Val := val)  (
  let vY := (Tree.op (.and w) ((Tree.pair (vZ) ((Tree.op (.const w C2) dummy)))))
  let vLHS := (Tree.op (.xor w) ((Tree.pair (vY) ((Tree.op (.const w C1) dummy)))))
  (Tree.op (.add w) ((Tree.pair (vLHS) (vRHS))))) =
  Tree.eval (Op := op) (Val := val) (
  let vor := (Tree.op (.or w) ((Tree.pair (vZ) (Tree.op (.negate w) (Tree.op (.const w C2) dummy)))))
  (Tree.op (.sub w) ((Tree.pair (vRHS) (vor)))))
  := by simp[Tree.eval]; try sorry

-- Name:AddSub:1088
-- precondition: Pre: isSignBit(C)
/-
%a = add %x, C
=>
%a = xor %x, C
-/
def thm3_ssa : SSA.eval (Op := op) (Val := val) e re  [dsl_bb|
  %v1 := op:const(w, C) %v424242;
  %v2 := pair: %v0 %v1;
  %v3 := op:add(w) %v2
  dsl_ret %v3
  ]  =
  SSA.eval (Op := op) (Val := val) e re [dsl_bb|
  %v1 := op:const(w, C) %v424242;
  %v2 := pair: %v0 %v1;
  %v3 := op:xor(w) %v2
  dsl_ret %v3
  ]
  := by simp[SSA.eval]; try sorry

-- Name:AddSub:1088
-- precondition: Pre: isSignBit(C)
/-
%a = add %x, C
=>
%a = xor %x, C
-/
def thm3_tree : Tree.eval (Op := op) (Val := val)  (
  (Tree.op (.add w) ((Tree.pair (vx) ((Tree.op (.const w C) dummy)))))) =
  Tree.eval (Op := op) (Val := val) (
  (Tree.op (.xor w) ((Tree.pair (vx) ((Tree.op (.const w C) dummy))))))
  := by simp[Tree.eval]; try sorry

-- Name:AddSub:1164
-- precondition: NONE
/-
%na = sub 0, %a
%c = add %na, %b
=>
%c = sub %b, %a
-/
def thm14_ssa : SSA.eval (Op := op) (Val := val) e re  [dsl_bb|
  %v0 := op:const(w, 0) %v424242;
  %v2 := pair: %v0 %v1;
  %v3 := op:sub(w) %v2;
  %v7 := pair: %v5 %v6;
  %v8 := op:add(w) %v7
  dsl_ret %v8
  ]  =
  SSA.eval (Op := op) (Val := val) e re [dsl_bb|
  %v2 := pair: %v0 %v1;
  %v3 := op:sub(w) %v2
  dsl_ret %v3
  ]
  := by simp[SSA.eval]; try sorry

-- Name:AddSub:1164
-- precondition: NONE
/-
%na = sub 0, %a
%c = add %na, %b
=>
%c = sub %b, %a
-/
def thm14_tree : Tree.eval (Op := op) (Val := val)  (
  let vna := (Tree.op (.sub w) ((Tree.pair ((Tree.op (.const w 0) dummy)) (va))))
  (Tree.op (.add w) ((Tree.pair (vna) (vb))))) =
  Tree.eval (Op := op) (Val := val) (
  (Tree.op (.sub w) ((Tree.pair (vb) (va)))))
  := by simp[Tree.eval]; try sorry

-- Name:AddSub:1165
-- precondition: NONE
/-
%na = sub 0, %a
%nb = sub 0, %b
%c = add %na, %nb
=>
%ab = add %a, %b
%c = sub 0, %ab
-/
def thm15_ssa : SSA.eval (Op := op) (Val := val) e re  [dsl_bb|
  %v0 := op:const(w, 0) %v424242;
  %v2 := pair: %v0 %v1;
  %v3 := op:sub(w) %v2;
  %v5 := op:const(w, 0) %v424242;
  %v7 := pair: %v5 %v6;
  %v8 := op:sub(w) %v7;
  %v12 := pair: %v10 %v11;
  %v13 := op:add(w) %v12
  dsl_ret %v13
  ]  =
  SSA.eval (Op := op) (Val := val) e re [dsl_bb|
  %v2 := pair: %v0 %v1;
  %v3 := op:add(w) %v2;
  %v5 := op:const(w, 0) %v424242;
  %v7 := pair: %v5 %v6;
  %v8 := op:sub(w) %v7
  dsl_ret %v8
  ]
  := by simp[SSA.eval]; try sorry

-- Name:AddSub:1165
-- precondition: NONE
/-
%na = sub 0, %a
%nb = sub 0, %b
%c = add %na, %nb
=>
%ab = add %a, %b
%c = sub 0, %ab
-/
def thm15_tree : Tree.eval (Op := op) (Val := val)  (
  let vna := (Tree.op (.sub w) ((Tree.pair ((Tree.op (.const w 0) dummy)) (va))))
  let vnb := (Tree.op (.sub w) ((Tree.pair ((Tree.op (.const w 0) dummy)) (vb))))
  (Tree.op (.add w) ((Tree.pair (vna) (vnb))))) =
  Tree.eval (Op := op) (Val := val) (
  let vab := (Tree.op (.add w) ((Tree.pair (va) (vb))))
  (Tree.op (.sub w) ((Tree.pair ((Tree.op (.const w 0) dummy)) (vab)))))
  := by simp[Tree.eval]; try sorry

-- Name:AddSub:1176
-- precondition: NONE
/-
%nb = sub 0, %b
%c = add %a, %nb
=>
%c = sub %a, %b
-/
def thm16_ssa : SSA.eval (Op := op) (Val := val) e re  [dsl_bb|
  %v0 := op:const(w, 0) %v424242;
  %v2 := pair: %v0 %v1;
  %v3 := op:sub(w) %v2;
  %v7 := pair: %v5 %v6;
  %v8 := op:add(w) %v7
  dsl_ret %v8
  ]  =
  SSA.eval (Op := op) (Val := val) e re [dsl_bb|
  %v2 := pair: %v0 %v1;
  %v3 := op:sub(w) %v2
  dsl_ret %v3
  ]
  := by simp[SSA.eval]; try sorry

-- Name:AddSub:1176
-- precondition: NONE
/-
%nb = sub 0, %b
%c = add %a, %nb
=>
%c = sub %a, %b
-/
def thm16_tree : Tree.eval (Op := op) (Val := val)  (
  let vnb := (Tree.op (.sub w) ((Tree.pair ((Tree.op (.const w 0) dummy)) (vb))))
  (Tree.op (.add w) ((Tree.pair (va) (vnb))))) =
  Tree.eval (Op := op) (Val := val) (
  (Tree.op (.sub w) ((Tree.pair (va) (vb)))))
  := by simp[Tree.eval]; try sorry

-- Name:AddSub:1184
-- precondition: Pre: (computeKnownZeroBits(%x) | computeKnownZeroBits(%y)) == -1
/-
%r = add %x, %y
=>
%r = or %x, %y
-/
def thm17_ssa : SSA.eval (Op := op) (Val := val) e re  [dsl_bb|
  %v2 := pair: %v0 %v1;
  %v3 := op:add(w) %v2
  dsl_ret %v3
  ]  =
  SSA.eval (Op := op) (Val := val) e re [dsl_bb|
  %v2 := pair: %v0 %v1;
  %v3 := op:or(w) %v2
  dsl_ret %v3
  ]
  := by simp[SSA.eval]; try sorry

-- Name:AddSub:1184
-- precondition: Pre: (computeKnownZeroBits(%x) | computeKnownZeroBits(%y)) == -1
/-
%r = add %x, %y
=>
%r = or %x, %y
-/
def thm17_tree : Tree.eval (Op := op) (Val := val)  (
  (Tree.op (.add w) ((Tree.pair (vx) (vy))))) =
  Tree.eval (Op := op) (Val := val) (
  (Tree.op (.or w) ((Tree.pair (vx) (vy)))))
  := by simp[Tree.eval]; try sorry

-- Name:AddSub:1206
-- precondition: Pre: hasOneUse(%xc2) && ~((C1 & -C1)-1) == ~((C1 & -C1)-1) & C2
/-
%xc2 = and %x, C2
%r = add %xc2, C1
=>
%xc1 = add %x, C1
%r = and %xc1, C2
-/
def thm19_ssa : SSA.eval (Op := op) (Val := val) e re  [dsl_bb|
  %v1 := op:const(w, C2) %v424242;
  %v2 := pair: %v0 %v1;
  %v3 := op:and(w) %v2;
  %v6 := op:const(w, C1) %v424242;
  %v7 := pair: %v5 %v6;
  %v8 := op:add(w) %v7
  dsl_ret %v8
  ]  =
  SSA.eval (Op := op) (Val := val) e re [dsl_bb|
  %v1 := op:const(w, C1) %v424242;
  %v2 := pair: %v0 %v1;
  %v3 := op:add(w) %v2;
  %v6 := op:const(w, C2) %v424242;
  %v7 := pair: %v5 %v6;
  %v8 := op:and(w) %v7
  dsl_ret %v8
  ]
  := by simp[SSA.eval]; try sorry

-- Name:AddSub:1206
-- precondition: Pre: hasOneUse(%xc2) && ~((C1 & -C1)-1) == ~((C1 & -C1)-1) & C2
/-
%xc2 = and %x, C2
%r = add %xc2, C1
=>
%xc1 = add %x, C1
%r = and %xc1, C2
-/
def thm19_tree : Tree.eval (Op := op) (Val := val)  (
  let vxc2 := (Tree.op (.and w) ((Tree.pair (vx) ((Tree.op (.const w C2) dummy)))))
  (Tree.op (.add w) ((Tree.pair (vxc2) ((Tree.op (.const w C1) dummy)))))) =
  Tree.eval (Op := op) (Val := val) (
  let vxc1 := (Tree.op (.add w) ((Tree.pair (vx) ((Tree.op (.const w C1) dummy)))))
  (Tree.op (.and w) ((Tree.pair (vxc1) ((Tree.op (.const w C2) dummy))))))
  := by simp[Tree.eval]; try sorry

-- Name:AddSub:1295
-- precondition: NONE
/-
%aab = and %a, %b
%aob = xor %a, %b
%c = add %aab, %aob
=>
%c = or %a, %b
-/
def thm24_ssa : SSA.eval (Op := op) (Val := val) e re  [dsl_bb|
  %v2 := pair: %v0 %v1;
  %v3 := op:and(w) %v2;
  %v5 := pair: %v0 %v1;
  %v6 := op:xor(w) %v5;
  %v10 := pair: %v8 %v9;
  %v11 := op:add(w) %v10
  dsl_ret %v11
  ]  =
  SSA.eval (Op := op) (Val := val) e re [dsl_bb|
  %v2 := pair: %v0 %v1;
  %v3 := op:or(w) %v2
  dsl_ret %v3
  ]
  := by simp[SSA.eval]; try sorry

-- Name:AddSub:1295
-- precondition: NONE
/-
%aab = and %a, %b
%aob = xor %a, %b
%c = add %aab, %aob
=>
%c = or %a, %b
-/
def thm24_tree : Tree.eval (Op := op) (Val := val)  (
  let vaab := (Tree.op (.and w) ((Tree.pair (va) (vb))))
  let vaob := (Tree.op (.xor w) ((Tree.pair (va) (vb))))
  (Tree.op (.add w) ((Tree.pair (vaab) (vaob))))) =
  Tree.eval (Op := op) (Val := val) (
  (Tree.op (.or w) ((Tree.pair (va) (vb)))))
  := by simp[Tree.eval]; try sorry

-- Name:AddSub:1309
-- precondition: NONE
/-
%lhs = and %a, %b
%rhs = or %a, %b
%c = add %lhs, %rhs
=>
%c = add %a, %b
-/
def thm25_ssa : SSA.eval (Op := op) (Val := val) e re  [dsl_bb|
  %v2 := pair: %v0 %v1;
  %v3 := op:and(w) %v2;
  %v5 := pair: %v0 %v1;
  %v6 := op:or(w) %v5;
  %v10 := pair: %v8 %v9;
  %v11 := op:add(w) %v10
  dsl_ret %v11
  ]  =
  SSA.eval (Op := op) (Val := val) e re [dsl_bb|
  %v2 := pair: %v0 %v1;
  %v3 := op:add(w) %v2
  dsl_ret %v3
  ]
  := by simp[SSA.eval]; try sorry

-- Name:AddSub:1309
-- precondition: NONE
/-
%lhs = and %a, %b
%rhs = or %a, %b
%c = add %lhs, %rhs
=>
%c = add %a, %b
-/
def thm25_tree : Tree.eval (Op := op) (Val := val)  (
  let vlhs := (Tree.op (.and w) ((Tree.pair (va) (vb))))
  let vrhs := (Tree.op (.or w) ((Tree.pair (va) (vb))))
  (Tree.op (.add w) ((Tree.pair (vlhs) (vrhs))))) =
  Tree.eval (Op := op) (Val := val) (
  (Tree.op (.add w) ((Tree.pair (va) (vb)))))
  := by simp[Tree.eval]; try sorry

-- Name:AddSub:1539
-- precondition: NONE
/-
%na = sub 0, %a
%r = sub %x, %na
=>
%r = add %x, %a
-/
def thm31_ssa : SSA.eval (Op := op) (Val := val) e re  [dsl_bb|
  %v0 := op:const(w, 0) %v424242;
  %v2 := pair: %v0 %v1;
  %v3 := op:sub(w) %v2;
  %v7 := pair: %v5 %v6;
  %v8 := op:sub(w) %v7
  dsl_ret %v8
  ]  =
  SSA.eval (Op := op) (Val := val) e re [dsl_bb|
  %v2 := pair: %v0 %v1;
  %v3 := op:add(w) %v2
  dsl_ret %v3
  ]
  := by simp[SSA.eval]; try sorry

-- Name:AddSub:1539
-- precondition: NONE
/-
%na = sub 0, %a
%r = sub %x, %na
=>
%r = add %x, %a
-/
def thm31_tree : Tree.eval (Op := op) (Val := val)  (
  let vna := (Tree.op (.sub w) ((Tree.pair ((Tree.op (.const w 0) dummy)) (va))))
  (Tree.op (.sub w) ((Tree.pair (vx) (vna))))) =
  Tree.eval (Op := op) (Val := val) (
  (Tree.op (.add w) ((Tree.pair (vx) (va)))))
  := by simp[Tree.eval]; try sorry

-- Name:AddSub:1614
-- precondition: NONE
/-
%Op1 = add %X, %Y
%r = sub %X, %Op1
=>
%r = sub 0, %Y
-/
def thm43_ssa : SSA.eval (Op := op) (Val := val) e re  [dsl_bb|
  %v2 := pair: %v0 %v1;
  %v3 := op:add(w) %v2;
  %v6 := pair: %v0 %v5;
  %v7 := op:sub(w) %v6
  dsl_ret %v7
  ]  =
  SSA.eval (Op := op) (Val := val) e re [dsl_bb|
  %v0 := op:const(w, 0) %v424242;
  %v2 := pair: %v0 %v1;
  %v3 := op:sub(w) %v2
  dsl_ret %v3
  ]
  := by simp[SSA.eval]; try sorry

-- Name:AddSub:1614
-- precondition: NONE
/-
%Op1 = add %X, %Y
%r = sub %X, %Op1
=>
%r = sub 0, %Y
-/
def thm43_tree : Tree.eval (Op := op) (Val := val)  (
  let vOp1 := (Tree.op (.add w) ((Tree.pair (vX) (vY))))
  (Tree.op (.sub w) ((Tree.pair (vX) (vOp1))))) =
  Tree.eval (Op := op) (Val := val) (
  (Tree.op (.sub w) ((Tree.pair ((Tree.op (.const w 0) dummy)) (vY)))))
  := by simp[Tree.eval]; try sorry

-- Name:AddSub:1619
-- precondition: NONE
/-
%Op0 = sub %X, %Y
%r = sub %Op0, %X
=>
%r = sub 0, %Y
-/
def thm44_ssa : SSA.eval (Op := op) (Val := val) e re  [dsl_bb|
  %v2 := pair: %v0 %v1;
  %v3 := op:sub(w) %v2;
  %v6 := pair: %v5 %v0;
  %v7 := op:sub(w) %v6
  dsl_ret %v7
  ]  =
  SSA.eval (Op := op) (Val := val) e re [dsl_bb|
  %v0 := op:const(w, 0) %v424242;
  %v2 := pair: %v0 %v1;
  %v3 := op:sub(w) %v2
  dsl_ret %v3
  ]
  := by simp[SSA.eval]; try sorry

-- Name:AddSub:1619
-- precondition: NONE
/-
%Op0 = sub %X, %Y
%r = sub %Op0, %X
=>
%r = sub 0, %Y
-/
def thm44_tree : Tree.eval (Op := op) (Val := val)  (
  let vOp0 := (Tree.op (.sub w) ((Tree.pair (vX) (vY))))
  (Tree.op (.sub w) ((Tree.pair (vOp0) (vX))))) =
  Tree.eval (Op := op) (Val := val) (
  (Tree.op (.sub w) ((Tree.pair ((Tree.op (.const w 0) dummy)) (vY)))))
  := by simp[Tree.eval]; try sorry

-- Name:AddSub:1624
-- precondition: NONE
/-
%Op0 = or %A, %B
%Op1 = xor %A, %B
%r = sub %Op0, %Op1
=>
%r = and %A, %B
-/
def thm45_ssa : SSA.eval (Op := op) (Val := val) e re  [dsl_bb|
  %v2 := pair: %v0 %v1;
  %v3 := op:or(w) %v2;
  %v5 := pair: %v0 %v1;
  %v6 := op:xor(w) %v5;
  %v10 := pair: %v8 %v9;
  %v11 := op:sub(w) %v10
  dsl_ret %v11
  ]  =
  SSA.eval (Op := op) (Val := val) e re [dsl_bb|
  %v2 := pair: %v0 %v1;
  %v3 := op:and(w) %v2
  dsl_ret %v3
  ]
  := by simp[SSA.eval]; try sorry

-- Name:AddSub:1624
-- precondition: NONE
/-
%Op0 = or %A, %B
%Op1 = xor %A, %B
%r = sub %Op0, %Op1
=>
%r = and %A, %B
-/
def thm45_tree : Tree.eval (Op := op) (Val := val)  (
  let vOp0 := (Tree.op (.or w) ((Tree.pair (vA) (vB))))
  let vOp1 := (Tree.op (.xor w) ((Tree.pair (vA) (vB))))
  (Tree.op (.sub w) ((Tree.pair (vOp0) (vOp1))))) =
  Tree.eval (Op := op) (Val := val) (
  (Tree.op (.and w) ((Tree.pair (vA) (vB)))))
  := by simp[Tree.eval]; try sorry

-- Name:AddSub:1648
-- precondition: Pre: hasOneUse(%Op1)
/-
%Op1 = sub %Y, %Z
%r = sub %X, %Op1
=>
%s = sub %Z, %Y
%r = add %X, %s
-/
def thm47_ssa : SSA.eval (Op := op) (Val := val) e re  [dsl_bb|
  %v2 := pair: %v0 %v1;
  %v3 := op:sub(w) %v2;
  %v7 := pair: %v5 %v6;
  %v8 := op:sub(w) %v7
  dsl_ret %v8
  ]  =
  SSA.eval (Op := op) (Val := val) e re [dsl_bb|
  %v2 := pair: %v0 %v1;
  %v3 := op:sub(w) %v2;
  %v7 := pair: %v5 %v6;
  %v8 := op:add(w) %v7
  dsl_ret %v8
  ]
  := by simp[SSA.eval]; try sorry

-- Name:AddSub:1648
-- precondition: Pre: hasOneUse(%Op1)
/-
%Op1 = sub %Y, %Z
%r = sub %X, %Op1
=>
%s = sub %Z, %Y
%r = add %X, %s
-/
def thm47_tree : Tree.eval (Op := op) (Val := val)  (
  let vOp1 := (Tree.op (.sub w) ((Tree.pair (vY) (vZ))))
  (Tree.op (.sub w) ((Tree.pair (vX) (vOp1))))) =
  Tree.eval (Op := op) (Val := val) (
  let vs := (Tree.op (.sub w) ((Tree.pair (vZ) (vY))))
  (Tree.op (.add w) ((Tree.pair (vX) (vs)))))
  := by simp[Tree.eval]; try sorry