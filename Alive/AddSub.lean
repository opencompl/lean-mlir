
import SSA.Framework
import Alive.Template



-- Name:AddSub:1040
-- precondition: Pre: C2 == ~C1
def thm0 (Width: Nat) : SSA.eval (Op := op) (Val := val) e re  [dsl_bb|
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
  := by simp[SSA.eval]; sorry

-- Name:AddSub:1043
-- precondition: NONE
def thm1 (Width: Nat) : SSA.eval (Op := op) (Val := val) e re  [dsl_bb|
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
  := by simp[SSA.eval]; sorry

-- Name:AddSub:1063
-- precondition: Pre: countTrailingZeros(C1) == 0 && C1 == C2+1
def thm2 (Width: Nat) : SSA.eval (Op := op) (Val := val) e re  [dsl_bb|
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
  := by simp[SSA.eval]; sorry

-- Name:AddSub:1088
-- precondition: Pre: isSignBit(C)
def thm3 (Width: Nat) : SSA.eval (Op := op) (Val := val) e re  [dsl_bb|
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
  := by simp[SSA.eval]; sorry

-- Name:AddSub:1131
-- precondition: Pre: hasOneUse(%LHS) && isPowerOf2(C2+1) && (C2 | computeKnownZeroBits(%Y)) == -1
def thm8 (Width: Nat) : SSA.eval (Op := op) (Val := val) e re  [dsl_bb|
  %v1 := op:const(w, C2) %v424242;
  %v2 := pair: %v0 %v1;
  %v3 := op:xor(w) %v2;
  %v6 := op:const(w, C1) %v424242;
  %v7 := pair: %v5 %v6;
  %v8 := op:add(w) %v7
  dsl_ret %v8
  ]  = 
  SSA.eval (Op := op) (Val := val) e re [dsl_bb|
  %v0 := op:const(w, C1+C2) %v424242;
  %v2 := pair: %v0 %v1;
  %v3 := op:sub(w) %v2
  dsl_ret %v3
  ]
  := by simp[SSA.eval]; sorry

-- Name:AddSub:1142
-- precondition: Pre: isSignBit(C1)
def thm9 (Width: Nat) : SSA.eval (Op := op) (Val := val) e re  [dsl_bb|
  %v1 := op:const(w, C1) %v424242;
  %v2 := pair: %v0 %v1;
  %v3 := op:xor(w) %v2;
  %v6 := op:const(w, C2) %v424242;
  %v7 := pair: %v5 %v6;
  %v8 := op:add(w) %v7
  dsl_ret %v8
  ]  = 
  SSA.eval (Op := op) (Val := val) e re [dsl_bb|
  %v1 := op:const(w, C1^C2) %v424242;
  %v2 := pair: %v0 %v1;
  %v3 := op:add(w) %v2
  dsl_ret %v3
  ]
  := by simp[SSA.eval]; sorry

-- Name:AddSub:1164
-- precondition: NONE
def thm14 (Width: Nat) : SSA.eval (Op := op) (Val := val) e re  [dsl_bb|
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
  := by simp[SSA.eval]; sorry

-- Name:AddSub:1165
-- precondition: NONE
def thm15 (Width: Nat) : SSA.eval (Op := op) (Val := val) e re  [dsl_bb|
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
  := by simp[SSA.eval]; sorry

-- Name:AddSub:1176
-- precondition: NONE
def thm16 (Width: Nat) : SSA.eval (Op := op) (Val := val) e re  [dsl_bb|
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
  := by simp[SSA.eval]; sorry

-- Name:AddSub:1184
-- precondition: Pre: (computeKnownZeroBits(%x) | computeKnownZeroBits(%y)) == -1
def thm17 (Width: Nat) : SSA.eval (Op := op) (Val := val) e re  [dsl_bb|
  %v2 := pair: %v0 %v1;
  %v3 := op:add(w) %v2
  dsl_ret %v3
  ]  = 
  SSA.eval (Op := op) (Val := val) e re [dsl_bb|
  %v2 := pair: %v0 %v1;
  %v3 := op:or(w) %v2
  dsl_ret %v3
  ]
  := by simp[SSA.eval]; sorry

-- Name:AddSub:1206
-- precondition: Pre: hasOneUse(%xc2) && ~((C1 & -C1)-1) == ~((C1 & -C1)-1) & C2
def thm19 (Width: Nat) : SSA.eval (Op := op) (Val := val) e re  [dsl_bb|
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
  := by simp[SSA.eval]; sorry

-- Name:AddSub:1295
-- precondition: NONE
def thm24 (Width: Nat) : SSA.eval (Op := op) (Val := val) e re  [dsl_bb|
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
  := by simp[SSA.eval]; sorry

-- Name:AddSub:1309
-- precondition: NONE
def thm25 (Width: Nat) : SSA.eval (Op := op) (Val := val) e re  [dsl_bb|
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
  := by simp[SSA.eval]; sorry

-- Name:AddSub:1539
-- precondition: NONE
def thm31 (Width: Nat) : SSA.eval (Op := op) (Val := val) e re  [dsl_bb|
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
  := by simp[SSA.eval]; sorry

-- Name:AddSub:1574
-- precondition: NONE
def thm38 (Width: Nat) : SSA.eval (Op := op) (Val := val) e re  [dsl_bb|
  %v1 := op:const(w, C2) %v424242;
  %v2 := pair: %v0 %v1;
  %v3 := op:add(w) %v2;
  %v5 := op:const(w, C) %v424242;
  %v7 := pair: %v5 %v6;
  %v8 := op:sub(w) %v7
  dsl_ret %v8
  ]  = 
  SSA.eval (Op := op) (Val := val) e re [dsl_bb|
  %v0 := op:const(w, C-C2) %v424242;
  %v2 := pair: %v0 %v1;
  %v3 := op:sub(w) %v2
  dsl_ret %v3
  ]
  := by simp[SSA.eval]; sorry

-- Name:AddSub:1614
-- precondition: NONE
def thm43 (Width: Nat) : SSA.eval (Op := op) (Val := val) e re  [dsl_bb|
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
  := by simp[SSA.eval]; sorry

-- Name:AddSub:1619
-- precondition: NONE
def thm44 (Width: Nat) : SSA.eval (Op := op) (Val := val) e re  [dsl_bb|
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
  := by simp[SSA.eval]; sorry

-- Name:AddSub:1624
-- precondition: NONE
def thm45 (Width: Nat) : SSA.eval (Op := op) (Val := val) e re  [dsl_bb|
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
  := by simp[SSA.eval]; sorry

-- Name:AddSub:1648
-- precondition: Pre: hasOneUse(%Op1)
def thm47 (Width: Nat) : SSA.eval (Op := op) (Val := val) e re  [dsl_bb|
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
  := by simp[SSA.eval]; sorry