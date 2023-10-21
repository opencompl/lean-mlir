import SSA.Projects.InstCombine.TacticAuto
import Mathlib.Data.Bitvec.Defs

open Bitvec

theorem bitvec_AddSub_1043 :
 ∀ (w : ℕ) (C1 Z RHS : Bitvec w), (Z &&& C1 ^^^ C1) + 1 + RHS = RHS - (Z ||| ~~~C1)
:= by alive_auto
      try sorry

theorem bitvec_AddSub_1152:
 ∀ (y x : Bitvec 1), x + y = x ^^^ y
:= by alive_auto
      try sorry

theorem bitvec_AddSub_1156 :
 ∀ (w : ℕ) (b : Bitvec w), b + b = b <<< 1
:= by alive_auto
      try sorry

theorem bitvec_AddSub_1164 :
 ∀ (w : ℕ) (a b : Bitvec w), 0 - a + b = b - a
:= by alive_auto
      try sorry

theorem bitvec_AddSub_1165 :
 ∀ (w : ℕ) (a b : Bitvec w), 0 - a + (0 - b) = 0 - (a + b)
:= by alive_auto
      try sorry

theorem bitvec_AddSub_1176 :
 ∀ (w : ℕ) (a b : Bitvec w), a + (0 - b) = a - b
:= by alive_auto
      try sorry

theorem bitvec_AddSub_1202 :
 ∀ (w : ℕ) (x C : Bitvec w), (x ^^^ -1) + C = C - 1 - x
:= by alive_auto
      try sorry

theorem bitvec_AddSub_1295 :
 ∀ (w : ℕ) (a b : Bitvec w), (a &&& b) + (a ^^^ b) = a ||| b
:= by alive_auto
      try sorry

theorem bitvec_AddSub_1309 :
 ∀ (w : ℕ) (a b : Bitvec w), (a &&& b) + (a ||| b) = a + b
:= by alive_auto
      try sorry

theorem bitvec_AddSub_1539 :
 ∀ (w : ℕ) (a x : Bitvec w), x - (0 - a) = x + a
:= by alive_auto
      try sorry

theorem bitvec_AddSub_1539_2 :
 ∀ (w : ℕ) (x C : Bitvec w), x - C = x + -C
:= by alive_auto
      try sorry

theorem bitvec_AddSub_1556:
 ∀ (y x : Bitvec 1), x - y = x ^^^ y
:= by alive_auto
      try sorry

theorem bitvec_AddSub_1560 :
 ∀ (w : ℕ) (a : Bitvec w), -1 - a = a ^^^ -1
:= by alive_auto
      try sorry

theorem bitvec_AddSub_1564 :
 ∀ (w : ℕ) (x C : Bitvec w), C - (x ^^^ -1) = x + (C + 1)
:= by alive_auto
      try sorry

theorem bitvec_AddSub_1574 :
 ∀ (w : ℕ) (X C C2 : Bitvec w), C - (X + C2) = C - C2 - X
:= by alive_auto
      try sorry

theorem bitvec_AddSub_1614 :
 ∀ (w : ℕ) (Y X : Bitvec w), X - (X + Y) = 0 - Y
:= by alive_auto
      try sorry

theorem bitvec_AddSub_1619 :
 ∀ (w : ℕ) (Y X : Bitvec w), X - Y - X = 0 - Y
:= by alive_auto
      try sorry

theorem bitvec_AddSub_1624 :
 ∀ (w : ℕ) (A B : Bitvec w), (A ||| B) - (A ^^^ B) = A &&& B
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_135 :
 ∀ (w : ℕ) (X C1 C2 : Bitvec w), (X ^^^ C1) &&& C2 = X &&& C2 ^^^ C1 &&& C2
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_144 :
 ∀ (w : ℕ) (X C1 C2 : Bitvec w), (X ||| C1) &&& C2 = (X ||| C1 &&& C2) &&& C2
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_698 :
 ∀ (w : ℕ) (a b d : Bitvec w), ofBool (a &&& b == 0) &&& ofBool (a &&& d == 0) = ofBool (a &&& (b ||| d) == 0)
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_709 :
 ∀ (w : ℕ) (a b d : Bitvec w), ofBool (a &&& b == b) &&& ofBool (a &&& d == d) = ofBool (a &&& (b ||| d) == b ||| d)
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_716 :
 ∀ (w : ℕ) (a b d : Bitvec w), ofBool (a &&& b == a) &&& ofBool (a &&& d == a) = ofBool (a &&& (b &&& d) == a)
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_794 :
 ∀ (w : ℕ) (a b : Bitvec w), (a >ₛ b) &&& ofBool (a != b) = (a >ₛ b)
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_827 :
 ∀ (w : ℕ) (a b : Bitvec w), ofBool (a == 0) &&& ofBool (b == 0) = ofBool (a ||| b == 0)
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_887_2 :
 ∀ (w : ℕ) (a C1 : Bitvec w), ofBool (a == C1) &&& ofBool (a != C1) = ofBool false
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_1230__A__B___A__B :
 ∀ (w : ℕ) (notOp0 notOp1 : Bitvec w), (notOp0 ^^^ -1) &&& (notOp1 ^^^ -1) = (notOp0 ||| notOp1) ^^^ -1
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_1241_AB__AB__AB :
 ∀ (w : ℕ) (A B : Bitvec w), (A ||| B) &&& (A &&& B ^^^ -1) = A ^^^ B
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_1247_AB__AB__AB :
 ∀ (w : ℕ) (A B : Bitvec w), (A &&& B ^^^ -1) &&& (A ||| B) = A ^^^ B
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_1253_A__AB___A__B :
 ∀ (w : ℕ) (A B : Bitvec w), (A ^^^ B) &&& A = A &&& (B ^^^ -1)
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_1280_ABA___AB :
 ∀ (w : ℕ) (A B : Bitvec w), (A ^^^ -1 ||| B) &&& A = A &&& B
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_1288_A__B__B__C__A___A__B__C :
 ∀ (w : ℕ) (A C B : Bitvec w), (A ^^^ B) &&& (B ^^^ C ^^^ A) = (A ^^^ B) &&& (C ^^^ -1)
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_1294_A__B__A__B___A__B :
 ∀ (w : ℕ) (A B : Bitvec w), (A ||| B) &&& (A ^^^ -1 ^^^ B) = A &&& B
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_1683_1 :
 ∀ (w : ℕ) (a b : Bitvec w), (a >ᵤ b) ||| ofBool (a == b) = (a ≥ᵤ b)
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_1683_2 :
 ∀ (w : ℕ) (a b : Bitvec w), (a ≥ᵤ b) ||| ofBool (a != b) = ofBool true
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_1704 :
 ∀ (w : ℕ) (A B : Bitvec w), ofBool (B == 0) ||| (A <ᵤ B) = (B + -1 ≥ᵤ A)
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_1705 :
 ∀ (w : ℕ) (A B : Bitvec w), ofBool (B == 0) ||| (B >ᵤ A) = (B + -1 ≥ᵤ A)
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_1733 :
 ∀ (w : ℕ) (A B : Bitvec w), ofBool (A != 0) ||| ofBool (B != 0) = ofBool (A ||| B != 0)
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_2063__X__C1__C2____X__C2__C1__C2 :
 ∀ (w : ℕ) (x C1 C : Bitvec w), x ^^^ C1 ||| C = (x ||| C) ^^^ C1 &&& ~~~C
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_2113___A__B__A___A__B :
 ∀ (w : ℕ) (A B : Bitvec w), (A ^^^ -1) &&& B ||| A = A ||| B
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_2118___A__B__A___A__B :
 ∀ (w : ℕ) (A B : Bitvec w), A &&& B ||| A ^^^ -1 = A ^^^ -1 ||| B
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_2123___A__B__A__B___A__B :
 ∀ (w : ℕ) (A B : Bitvec w), A &&& (B ^^^ -1) ||| A ^^^ B = A ^^^ B
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_2188 :
 ∀ (w : ℕ) (A D : Bitvec w), A &&& (D ^^^ -1) ||| (A ^^^ -1) &&& D = A ^^^ D
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_2231__A__B__B__C__A___A__B__C :
 ∀ (w : ℕ) (A C B : Bitvec w), A ^^^ B ||| B ^^^ C ^^^ A = A ^^^ B ||| C
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_2243__B__C__A__B___B__A__C :
 ∀ (w : ℕ) (A C B : Bitvec w), (B ||| C) &&& A ||| B = B ||| A &&& C
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_2247__A__B__A__B :
 ∀ (w : ℕ) (A B : Bitvec w), A ^^^ -1 ||| B ^^^ -1 = A &&& B ^^^ -1
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_2263 :
 ∀ (w : ℕ) (B op0 : Bitvec w), op0 ||| op0 ^^^ B = op0 ||| B
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_2264 :
 ∀ (w : ℕ) (A B : Bitvec w), A ||| A ^^^ -1 ^^^ B = A ||| B ^^^ -1
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_2265 :
 ∀ (w : ℕ) (A B : Bitvec w), A &&& B ||| A ^^^ B = A ||| B
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_2284 :
 ∀ (w : ℕ) (A B : Bitvec w), A ||| (A ||| B) ^^^ -1 = A ||| B ^^^ -1
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_2285 :
 ∀ (w : ℕ) (A B : Bitvec w), A ||| A ^^^ B ^^^ -1 = A ||| B ^^^ -1
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_2297 :
 ∀ (w : ℕ) (A B : Bitvec w), A &&& B ||| A ^^^ -1 ^^^ B = A ^^^ -1 ^^^ B
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_2367 :
 ∀ (w : ℕ) (A C1 op1 : Bitvec w), A ||| C1 ||| op1 = A ||| op1 ||| C1
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_2416 :
 ∀ (w : ℕ) (nx y : Bitvec w), (nx ^^^ -1) &&& y ^^^ -1 = nx ||| y ^^^ -1
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_2417 :
 ∀ (w : ℕ) (nx y : Bitvec w), (nx ^^^ -1 ||| y) ^^^ -1 = nx &&& (y ^^^ -1)
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_2429 :
 ∀ (w : ℕ) (y x : Bitvec w), x &&& y ^^^ -1 = x ^^^ -1 ||| y ^^^ -1
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_2430 :
 ∀ (w : ℕ) (y x : Bitvec w), (x ||| y) ^^^ -1 = (x ^^^ -1) &&& (y ^^^ -1)
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_2443 :
 ∀ (w : ℕ) (y x : Bitvec w), sshr (x ^^^ -1) (Bitvec.toNat y) ^^^ -1 = sshr x (Bitvec.toNat y)
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_2453 :
 ∀ (w : ℕ) (y x : Bitvec w), (x <ₛ y) ^^^ -1 = (x ≥ₛ y)
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_2475 :
 ∀ (w : ℕ) (x C : Bitvec w), C - x ^^^ -1 = x + (-1 - C)
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_2486 :
 ∀ (w : ℕ) (x C : Bitvec w), x + C ^^^ -1 = -1 - C - x
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_2581__BAB___A__B :
 ∀ (w : ℕ) (a op1 : Bitvec w), (a ||| op1) ^^^ op1 = a &&& (op1 ^^^ -1)
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_2587__BAA___B__A :
 ∀ (w : ℕ) (a op1 : Bitvec w), a &&& op1 ^^^ op1 = (a ^^^ -1) &&& op1
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_2595 :
 ∀ (w : ℕ) (a b : Bitvec w), a &&& b ^^^ (a ||| b) = a ^^^ b
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_2607 :
 ∀ (w : ℕ) (a b : Bitvec w), (a ||| b ^^^ -1) ^^^ (a ^^^ -1 ||| b) = a ^^^ b
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_2617 :
 ∀ (w : ℕ) (a b : Bitvec w), a &&& (b ^^^ -1) ^^^ (a ^^^ -1) &&& b = a ^^^ b
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_2627 :
 ∀ (w : ℕ) (a c b : Bitvec w), a ^^^ c ^^^ (a ||| b) = (a ^^^ -1) &&& b ^^^ c
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_2647 :
 ∀ (w : ℕ) (a b : Bitvec w), a &&& b ^^^ (a ^^^ b) = a ||| b
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_2658 :
 ∀ (w : ℕ) (a b : Bitvec w), a &&& (b ^^^ -1) ^^^ (a ^^^ -1) = a &&& b ^^^ -1
:= by alive_auto
      try sorry

theorem bitvec_AndOrXor_2663 :
 ∀ (w : ℕ) (a b : Bitvec w), (a ≤ᵤ b) ^^^ ofBool (a != b) = (a ≥ᵤ b)
:= by alive_auto
      try sorry

theorem bitvec_152 :
 ∀ (w : ℕ) (x : Bitvec w), x * -1 = 0 - x
:= by alive_auto
      try sorry

theorem bitvec_160:
 ∀ (x C1 C2 : Bitvec 7), x <<< C2 * C1 = x * C1 <<< C2
:= by alive_auto
      try sorry

theorem bitvec_229 :
 ∀ (w : ℕ) (X C1 Op1 : Bitvec w), (X + C1) * Op1 = X * Op1 + C1 * Op1
:= by alive_auto
      try sorry

theorem bitvec_239 :
 ∀ (w : ℕ) (Y X : Bitvec w), (0 - X) * (0 - Y) = X * Y
:= by alive_auto
      try sorry

theorem bitvec_275:
 ∀ (Y X : Bitvec 5),
  (Option.bind (udiv? X Y) fun fst => some (fst * Y)) ⊑ Option.bind (urem? X Y) fun snd => some (X - snd)
:= by alive_auto
      try sorry

theorem bitvec_275_2:
 ∀ (Y X : Bitvec 5),
  (Option.bind (sdiv? X Y) fun fst => some (fst * Y)) ⊑ Option.bind (urem? X Y) fun snd => some (X - snd)
:= by alive_auto
      try sorry

theorem bitvec_276:
 ∀ (Y X : Bitvec 5),
  (Option.bind (sdiv? X Y) fun fst => some (fst * (0 - Y))) ⊑ Option.bind (urem? X Y) fun fst => some (fst - X)
:= by alive_auto
      try sorry

theorem bitvec_276_2:
 ∀ (Y X : Bitvec 5),
  (Option.bind (udiv? X Y) fun fst => some (fst * (0 - Y))) ⊑ Option.bind (urem? X Y) fun fst => some (fst - X)
:= by alive_auto
      try sorry

theorem bitvec_283:
 ∀ (Y X : Bitvec 1), X * Y = X &&& Y
:= by alive_auto
      try sorry

theorem bitvec_290__292 :
 ∀ (w : ℕ) (Y Op1 : Bitvec w), 1 <<< Y * Op1 = Op1 <<< Y
:= by alive_auto
      try sorry

theorem bitvec_820:
 ∀ (X Op1 : Bitvec 9),
  (Option.bind (Option.bind (urem? X Op1) fun snd => some (X - snd)) fun fst => sdiv? fst Op1) ⊑ sdiv? X Op1
:= by alive_auto
      try sorry

theorem bitvec_820':
 ∀ (X Op1 : Bitvec 9),
  (Option.bind (Option.bind (urem? X Op1) fun snd => some (X - snd)) fun fst => udiv? fst Op1) ⊑ udiv? X Op1
:= by alive_auto
      try sorry

theorem bitvec_891:
 ∀ (x N : Bitvec 13), udiv? x (1 <<< N) ⊑ some (x >>> N)
:= by alive_auto
      try sorry

theorem bitvec_1030 :
 ∀ (w : ℕ) (X : Bitvec w), sdiv? X (-1) ⊑ some (0 - X)
:= by alive_auto
      try sorry

theorem bitvec_Select_846:
 ∀ (C B : Bitvec 1), select B (ofBool true) C = B ||| C
:= by alive_auto
      try sorry

theorem bitvec_Select_850:
 ∀ (C B : Bitvec 1), select B (ofBool false) C = (B ^^^ ofBool true) &&& C
:= by alive_auto
      try sorry

theorem bitvec_Select_855:
 ∀ (C B : Bitvec 1), select B C (ofBool false) = B &&& C
:= by alive_auto
      try sorry

theorem bitvec_Select_859:
 ∀ (C B : Bitvec 1), select B C (ofBool true) = B ^^^ ofBool true ||| C
:= by alive_auto
      try sorry

theorem bitvec_Select_851:
 ∀ (a b : Bitvec 1), select a b a = a &&& b
:= by alive_auto
      try sorry

theorem bitvec_Select_852:
 ∀ (a b : Bitvec 1), select a a b = a ||| b
:= by alive_auto
      try sorry

theorem bitvec_Select_1100 :
 ∀ (w : ℕ) (Y X : Bitvec w), select (ofBool true) X Y = X
:= by alive_auto
      try sorry

theorem bitvec_Select_1105 :
 ∀ (w : ℕ) (Y X : Bitvec w), select (ofBool false) X Y = Y
:= by alive_auto
      try sorry

theorem bitvec_InstCombineShift__239 :
 ∀ (w : ℕ) (X C : Bitvec w), X <<< C >>> C = X &&& (-1) >>> C
:= by alive_auto
      try sorry

theorem bitvec_InstCombineShift__279 :
 ∀ (w : ℕ) (X C : Bitvec w), X >>> C <<< C = X &&& (-1) <<< C
:= by alive_auto
      try sorry

theorem bitvec_InstCombineShift__351:
 ∀ (X C1 C2 : Bitvec 7), (X * C1) <<< C2 = X * C1 <<< C2
:= by alive_auto
      try sorry

theorem bitvec_InstCombineShift__422_1:
 ∀ (Y X C : Bitvec 31), (Y + X >>> C) <<< C = Y <<< C + X &&& (-1) <<< C
:= by alive_auto
      try sorry

theorem bitvec_InstCombineShift__422_2:
 ∀ (Y X C : Bitvec 31), (Y + sshr X (Bitvec.toNat C)) <<< C = Y <<< C + X &&& (-1) <<< C
:= by alive_auto
      try sorry

theorem bitvec_InstCombineShift__440 :
 ∀ (w : ℕ) (Y X C C2 : Bitvec w), (Y ^^^ X >>> C &&& C2) <<< C = X &&& C2 <<< C ^^^ Y <<< C
:= by alive_auto
      try sorry

theorem bitvec_InstCombineShift__458:
 ∀ (Y X C : Bitvec 31), (sshr X (Bitvec.toNat C) - Y) <<< C = X - Y <<< C &&& (-1) <<< C
:= by alive_auto
      try sorry

theorem bitvec_InstCombineShift__476 :
 ∀ (w : ℕ) (Y X C C2 : Bitvec w), (X >>> C &&& C2 ||| Y) <<< C = X &&& C2 <<< C ||| Y <<< C
:= by alive_auto
      try sorry

theorem bitvec_InstCombineShift__497 :
 ∀ (w : ℕ) (X C C2 : Bitvec w), (X ^^^ C2) >>> C = X >>> C ^^^ C2 >>> C
:= by alive_auto
      try sorry

theorem bitvec_InstCombineShift__497''' :
 ∀ (w : ℕ) (X C C2 : Bitvec w), (X + C2) <<< C = X <<< C + C2 <<< C
:= by alive_auto
      try sorry

theorem bitvec_InstCombineShift__582 :
 ∀ (w : ℕ) (X C : Bitvec w), X <<< C >>> C = X &&& (-1) >>> C
:= by alive_auto
      try sorry

theorem bitvec_InstCombineShift__724:
 ∀ (A C2 C1 : Bitvec 31), C1 <<< A <<< C2 = C1 <<< C2 <<< A

:=sorry
