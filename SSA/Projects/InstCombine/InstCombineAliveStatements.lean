import SSA.Projects.InstCombine.InstCombineBase

theorem bitvec_AddSub_1043 :
 ∀ (w : ℕ) (Z C1 RHS : ℤ),
  (Option.bind
      (Bitvec.add? (Bitvec.xor (Bitvec.and (Bitvec.ofInt' w Z) (Bitvec.ofInt' w C1)) (Bitvec.ofInt' w C1))
        (Bitvec.ofInt' w 1))
      fun fst => Bitvec.add? fst (Bitvec.ofInt' w RHS)) ⊑
    some (Bitvec.sub (Bitvec.ofInt' w RHS) (Bitvec.or (Bitvec.ofInt' w Z) (Bitvec.not (Bitvec.ofInt' w C1))))
:=sorry

theorem bitvec_AddSub_1152:
 ∀ (x y : ℤ),
  Bitvec.add? (Bitvec.ofInt' 1 x) (Bitvec.ofInt' 1 y) ⊑ some (Bitvec.xor (Bitvec.ofInt' 1 x) (Bitvec.ofInt' 1 y))
:=sorry

theorem bitvec_AddSub_1156 :
 ∀ (w : ℕ) (b : ℤ),
  Bitvec.add? (Bitvec.ofInt' w b) (Bitvec.ofInt' w b) ⊑
    some (Bitvec.shl (Bitvec.ofInt' w b) (Bitvec.toNat (Bitvec.ofInt' w 1)))
:=sorry

theorem bitvec_AddSub_1156_2 :
 ∀ (w : ℕ) (b : ℤ),
  Bitvec.add? (Bitvec.ofInt' w b) (Bitvec.ofInt' w b) ⊑
    some (Bitvec.shl (Bitvec.ofInt' w b) (Bitvec.toNat (Bitvec.ofInt' w 1)))
:=sorry

theorem bitvec_AddSub_1156_3 :
 ∀ (w : ℕ) (b : ℤ),
  Bitvec.add? (Bitvec.ofInt' w b) (Bitvec.ofInt' w b) ⊑
    some (Bitvec.shl (Bitvec.ofInt' w b) (Bitvec.toNat (Bitvec.ofInt' w 1)))
:=sorry

theorem bitvec_AddSub_1164 :
 ∀ (w : ℕ) (a b : ℤ),
  Bitvec.add? (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w a)) (Bitvec.ofInt' w b) ⊑
    some (Bitvec.sub (Bitvec.ofInt' w b) (Bitvec.ofInt' w a))
:=sorry

theorem bitvec_AddSub_1165 :
 ∀ (w : ℕ) (a b : ℤ),
  Bitvec.add? (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w a))
      (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w b)) ⊑
    Option.bind (Bitvec.add? (Bitvec.ofInt' w a) (Bitvec.ofInt' w b)) fun snd =>
      some (Bitvec.sub (Bitvec.ofInt' w 0) snd)
:=sorry

theorem bitvec_AddSub_1176 :
 ∀ (w : ℕ) (b a : ℤ),
  Bitvec.add? (Bitvec.ofInt' w a) (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w b)) ⊑
    some (Bitvec.sub (Bitvec.ofInt' w a) (Bitvec.ofInt' w b))
:=sorry

theorem bitvec_AddSub_1202 :
 ∀ (w : ℕ) (x C : ℤ),
  Bitvec.add? (Bitvec.xor (Bitvec.ofInt' w x) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w C) ⊑
    some (Bitvec.sub (Bitvec.sub (Bitvec.ofInt' w C) (Bitvec.ofInt' w 1)) (Bitvec.ofInt' w x))
:=sorry

theorem bitvec_AddSub_1295 :
 ∀ (w : ℕ) (a b : ℤ),
  Bitvec.add? (Bitvec.and (Bitvec.ofInt' w a) (Bitvec.ofInt' w b))
      (Bitvec.xor (Bitvec.ofInt' w a) (Bitvec.ofInt' w b)) ⊑
    some (Bitvec.or (Bitvec.ofInt' w a) (Bitvec.ofInt' w b))
:=sorry

theorem bitvec_AddSub_1309 :
 ∀ (w : ℕ) (a b : ℤ),
  Bitvec.add? (Bitvec.and (Bitvec.ofInt' w a) (Bitvec.ofInt' w b)) (Bitvec.or (Bitvec.ofInt' w a) (Bitvec.ofInt' w b)) ⊑
    Bitvec.add? (Bitvec.ofInt' w a) (Bitvec.ofInt' w b)
:=sorry

theorem bitvec_AddSub_1309_2 :
 ∀ (w : ℕ) (a b : ℤ),
  Bitvec.add? (Bitvec.and (Bitvec.ofInt' w a) (Bitvec.ofInt' w b)) (Bitvec.or (Bitvec.ofInt' w a) (Bitvec.ofInt' w b)) ⊑
    Bitvec.add? (Bitvec.ofInt' w a) (Bitvec.ofInt' w b)
:=sorry

theorem bitvec_AddSub_1309_3 :
 ∀ (w : ℕ) (a b : ℤ),
  Bitvec.add? (Bitvec.and (Bitvec.ofInt' w a) (Bitvec.ofInt' w b)) (Bitvec.or (Bitvec.ofInt' w a) (Bitvec.ofInt' w b)) ⊑
    Bitvec.add? (Bitvec.ofInt' w a) (Bitvec.ofInt' w b)
:=sorry

theorem bitvec_AddSub_1539 :
 ∀ (w : ℕ) (a x : ℤ),
  some (Bitvec.sub (Bitvec.ofInt' w x) (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w a))) ⊑
    Bitvec.add? (Bitvec.ofInt' w x) (Bitvec.ofInt' w a)
:=sorry

theorem bitvec_AddSub_1539_2 :
 ∀ (w : ℕ) (x C : ℤ),
  some (Bitvec.sub (Bitvec.ofInt' w x) (Bitvec.ofInt' w C)) ⊑
    Bitvec.add? (Bitvec.ofInt' w x) (Bitvec.neg (Bitvec.ofInt' w C))
:=sorry

theorem bitvec_AddSub_1546 :
 ∀ (w : ℕ) (a x : ℤ),
  some (Bitvec.sub (Bitvec.ofInt' w x) (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w a))) ⊑
    Bitvec.add? (Bitvec.ofInt' w x) (Bitvec.ofInt' w a)
:=sorry

theorem bitvec_AddSub_1556:
 ∀ (x y : ℤ),
  some (Bitvec.sub (Bitvec.ofInt' 1 x) (Bitvec.ofInt' 1 y)) ⊑ some (Bitvec.xor (Bitvec.ofInt' 1 x) (Bitvec.ofInt' 1 y))
:=sorry

theorem bitvec_AddSub_1560 :
 ∀ (w : ℕ) (a : ℤ),
  some (Bitvec.sub (Bitvec.ofInt' w (-1)) (Bitvec.ofInt' w a)) ⊑
    some (Bitvec.xor (Bitvec.ofInt' w a) (Bitvec.ofInt' w (-1)))
:=sorry

theorem bitvec_AddSub_1564 :
 ∀ (w : ℕ) (x C : ℤ),
  some (Bitvec.sub (Bitvec.ofInt' w C) (Bitvec.xor (Bitvec.ofInt' w x) (Bitvec.ofInt' w (-1)))) ⊑
    Option.bind (Bitvec.add? (Bitvec.ofInt' w C) (Bitvec.ofInt' w 1)) fun snd => Bitvec.add? (Bitvec.ofInt' w x) snd
:=sorry

theorem bitvec_AddSub_1574 :
 ∀ (w : ℕ) (X C2 C : ℤ),
  (Option.bind (Bitvec.add? (Bitvec.ofInt' w X) (Bitvec.ofInt' w C2)) fun snd =>
      some (Bitvec.sub (Bitvec.ofInt' w C) snd)) ⊑
    some (Bitvec.sub (Bitvec.sub (Bitvec.ofInt' w C) (Bitvec.ofInt' w C2)) (Bitvec.ofInt' w X))
:=sorry

theorem bitvec_AddSub_1614 :
 ∀ (w : ℕ) (X Y : ℤ),
  (Option.bind (Bitvec.add? (Bitvec.ofInt' w X) (Bitvec.ofInt' w Y)) fun snd =>
      some (Bitvec.sub (Bitvec.ofInt' w X) snd)) ⊑
    some (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w Y))
:=sorry

theorem bitvec_AddSub_1619 :
 ∀ (w : ℕ) (X Y : ℤ),
  some (Bitvec.sub (Bitvec.sub (Bitvec.ofInt' w X) (Bitvec.ofInt' w Y)) (Bitvec.ofInt' w X)) ⊑
    some (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w Y))
:=sorry

theorem bitvec_AddSub_1624 :
 ∀ (w : ℕ) (A B : ℤ),
  some
      (Bitvec.sub (Bitvec.or (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))
        (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))) ⊑
    some (Bitvec.and (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))
:=sorry

theorem bitvec_AndOrXor_135 :
 ∀ (w : ℕ) (X C1 C2 : ℤ),
  some (Bitvec.and (Bitvec.xor (Bitvec.ofInt' w X) (Bitvec.ofInt' w C1)) (Bitvec.ofInt' w C2)) ⊑
    some
      (Bitvec.xor (Bitvec.and (Bitvec.ofInt' w X) (Bitvec.ofInt' w C2))
        (Bitvec.and (Bitvec.ofInt' w C1) (Bitvec.ofInt' w C2)))
:=sorry

theorem bitvec_AndOrXor_144 :
 ∀ (w : ℕ) (X C1 C2 : ℤ),
  some (Bitvec.and (Bitvec.or (Bitvec.ofInt' w X) (Bitvec.ofInt' w C1)) (Bitvec.ofInt' w C2)) ⊑
    some
      (Bitvec.and (Bitvec.or (Bitvec.ofInt' w X) (Bitvec.and (Bitvec.ofInt' w C1) (Bitvec.ofInt' w C2)))
        (Bitvec.ofInt' w C2))
:=sorry

theorem bitvec_AndOrXor_698:
 ∀ (a b d : ℤ),
  some
      (Bitvec.and (Bitvec.fromBool (Bitvec.and (Bitvec.ofInt' 1 a) (Bitvec.ofInt' 1 b) == Bitvec.ofInt' 1 0))
        (Bitvec.fromBool (Bitvec.and (Bitvec.ofInt' 1 a) (Bitvec.ofInt' 1 d) == Bitvec.ofInt' 1 0))) ⊑
    some
      (Bitvec.fromBool
        (Bitvec.and (Bitvec.ofInt' 1 a) (Bitvec.or (Bitvec.ofInt' 1 b) (Bitvec.ofInt' 1 d)) == Bitvec.ofInt' 1 0))
:=sorry

theorem bitvec_AndOrXor_709:
 ∀ (a b d : ℤ),
  some
      (Bitvec.and (Bitvec.fromBool (Bitvec.and (Bitvec.ofInt' 1 a) (Bitvec.ofInt' 1 b) == Bitvec.ofInt' 1 b))
        (Bitvec.fromBool (Bitvec.and (Bitvec.ofInt' 1 a) (Bitvec.ofInt' 1 d) == Bitvec.ofInt' 1 d))) ⊑
    some
      (Bitvec.fromBool
        (Bitvec.and (Bitvec.ofInt' 1 a) (Bitvec.or (Bitvec.ofInt' 1 b) (Bitvec.ofInt' 1 d)) ==
          Bitvec.or (Bitvec.ofInt' 1 b) (Bitvec.ofInt' 1 d)))
:=sorry

theorem bitvec_AndOrXor_716:
 ∀ (a b d : ℤ),
  some
      (Bitvec.and (Bitvec.fromBool (Bitvec.and (Bitvec.ofInt' 1 a) (Bitvec.ofInt' 1 b) == Bitvec.ofInt' 1 a))
        (Bitvec.fromBool (Bitvec.and (Bitvec.ofInt' 1 a) (Bitvec.ofInt' 1 d) == Bitvec.ofInt' 1 a))) ⊑
    some
      (Bitvec.fromBool
        (Bitvec.and (Bitvec.ofInt' 1 a) (Bitvec.and (Bitvec.ofInt' 1 b) (Bitvec.ofInt' 1 d)) == Bitvec.ofInt' 1 a))
:=sorry

theorem bitvec_AndOrXor_794:
 ∀ (a b : ℤ),
  some
      (Bitvec.and (Bitvec.fromBool (decide (Bitvec.toInt (Bitvec.ofInt' 1 b) < Bitvec.toInt (Bitvec.ofInt' 1 a))))
        (Bitvec.fromBool (Bitvec.ofInt' 1 a != Bitvec.ofInt' 1 b))) ⊑
    some (Bitvec.fromBool (decide (Bitvec.toInt (Bitvec.ofInt' 1 b) < Bitvec.toInt (Bitvec.ofInt' 1 a))))
:=sorry

theorem bitvec_AndOrXor_827:
 ∀ (a b : ℤ),
  some
      (Bitvec.and (Bitvec.fromBool (Bitvec.ofInt' 1 a == Bitvec.ofInt' 1 0))
        (Bitvec.fromBool (Bitvec.ofInt' 1 b == Bitvec.ofInt' 1 0))) ⊑
    some (Bitvec.fromBool (Bitvec.or (Bitvec.ofInt' 1 a) (Bitvec.ofInt' 1 b) == Bitvec.ofInt' 1 0))
:=sorry

theorem bitvec_AndOrXor_887_2:
 ∀ (a C1 : ℤ),
  some
      (Bitvec.and (Bitvec.fromBool (Bitvec.ofInt' 1 a == Bitvec.ofInt' 1 C1))
        (Bitvec.fromBool (Bitvec.ofInt' 1 a != Bitvec.ofInt' 1 C1))) ⊑
    some (false ::ᵥ Vector.nil)
:=sorry

theorem bitvec_AndOrXor_1230__ :
 ∀ (w : ℕ) (notOp0 notOp1 : ℤ),
  some
      (Bitvec.and (Bitvec.xor (Bitvec.ofInt' w notOp0) (Bitvec.ofInt' w (-1)))
        (Bitvec.xor (Bitvec.ofInt' w notOp1) (Bitvec.ofInt' w (-1)))) ⊑
    some (Bitvec.xor (Bitvec.or (Bitvec.ofInt' w notOp0) (Bitvec.ofInt' w notOp1)) (Bitvec.ofInt' w (-1)))
:=sorry

theorem bitvec_AndOrXor_1241_ :
 ∀ (w : ℕ) (A B : ℤ),
  some
      (Bitvec.and (Bitvec.or (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))
        (Bitvec.xor (Bitvec.and (Bitvec.ofInt' w A) (Bitvec.ofInt' w B)) (Bitvec.ofInt' w (-1)))) ⊑
    some (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))
:=sorry

theorem bitvec_AndOrXor_1247_ :
 ∀ (w : ℕ) (A B : ℤ),
  some
      (Bitvec.and (Bitvec.xor (Bitvec.and (Bitvec.ofInt' w A) (Bitvec.ofInt' w B)) (Bitvec.ofInt' w (-1)))
        (Bitvec.or (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))) ⊑
    some (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))
:=sorry

theorem bitvec_AndOrXor_1253_A_ :
 ∀ (w : ℕ) (A B : ℤ),
  some (Bitvec.and (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w B)) (Bitvec.ofInt' w A)) ⊑
    some (Bitvec.and (Bitvec.ofInt' w A) (Bitvec.xor (Bitvec.ofInt' w B) (Bitvec.ofInt' w (-1))))
:=sorry

theorem bitvec_AndOrXor_1280_ :
 ∀ (w : ℕ) (A B : ℤ),
  some
      (Bitvec.and (Bitvec.or (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w B))
        (Bitvec.ofInt' w A)) ⊑
    some (Bitvec.and (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))
:=sorry

theorem bitvec_AndOrXor_1288_ :
 ∀ (w : ℕ) (A B C : ℤ),
  some
      (Bitvec.and (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))
        (Bitvec.xor (Bitvec.xor (Bitvec.ofInt' w B) (Bitvec.ofInt' w C)) (Bitvec.ofInt' w A))) ⊑
    some
      (Bitvec.and (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))
        (Bitvec.xor (Bitvec.ofInt' w C) (Bitvec.ofInt' w (-1))))
:=sorry

theorem bitvec_AndOrXor_1294_ :
 ∀ (w : ℕ) (A B : ℤ),
  some
      (Bitvec.and (Bitvec.or (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))
        (Bitvec.xor (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w B))) ⊑
    some (Bitvec.and (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))
:=sorry

theorem bitvec_AndOrXor_1683_1:
 ∀ (a b : ℤ),
  some
      (Bitvec.or (Bitvec.fromBool (decide (Bitvec.toNat (Bitvec.ofInt' 1 b) < Bitvec.toNat (Bitvec.ofInt' 1 a))))
        (Bitvec.fromBool (Bitvec.ofInt' 1 a == Bitvec.ofInt' 1 b))) ⊑
    some (Bitvec.fromBool (decide (Bitvec.toNat (Bitvec.ofInt' 1 b) ≤ Bitvec.toNat (Bitvec.ofInt' 1 a))))
:=sorry

theorem bitvec_AndOrXor_1683_2:
 ∀ (a b : ℤ),
  some
      (Bitvec.or (Bitvec.fromBool (decide (Bitvec.toNat (Bitvec.ofInt' 1 b) ≤ Bitvec.toNat (Bitvec.ofInt' 1 a))))
        (Bitvec.fromBool (Bitvec.ofInt' 1 a != Bitvec.ofInt' 1 b))) ⊑
    some (true ::ᵥ Vector.nil)
:=sorry

theorem bitvec_AndOrXor_1704:
 ∀ (B A : ℤ),
  some
      (Bitvec.or (Bitvec.fromBool (Bitvec.ofInt' 1 B == Bitvec.ofInt' 1 0))
        (Bitvec.fromBool (decide (Bitvec.toNat (Bitvec.ofInt' 1 A) < Bitvec.toNat (Bitvec.ofInt' 1 B))))) ⊑
    Option.bind (Bitvec.add? (Bitvec.ofInt' 1 B) (Bitvec.ofInt' 1 (-1))) fun fst =>
      some (Bitvec.fromBool (decide (Bitvec.toNat (Bitvec.ofInt' 1 A) ≤ Bitvec.toNat fst)))
:=sorry

theorem bitvec_AndOrXor_1705:
 ∀ (B A : ℤ),
  some
      (Bitvec.or (Bitvec.fromBool (Bitvec.ofInt' 1 B == Bitvec.ofInt' 1 0))
        (Bitvec.fromBool (decide (Bitvec.toNat (Bitvec.ofInt' 1 A) < Bitvec.toNat (Bitvec.ofInt' 1 B))))) ⊑
    Option.bind (Bitvec.add? (Bitvec.ofInt' 1 B) (Bitvec.ofInt' 1 (-1))) fun fst =>
      some (Bitvec.fromBool (decide (Bitvec.toNat (Bitvec.ofInt' 1 A) ≤ Bitvec.toNat fst)))
:=sorry

theorem bitvec_AndOrXor_1733:
 ∀ (A B : ℤ),
  some
      (Bitvec.or (Bitvec.fromBool (Bitvec.ofInt' 1 A != Bitvec.ofInt' 1 0))
        (Bitvec.fromBool (Bitvec.ofInt' 1 B != Bitvec.ofInt' 1 0))) ⊑
    some (Bitvec.fromBool (Bitvec.or (Bitvec.ofInt' 1 A) (Bitvec.ofInt' 1 B) != Bitvec.ofInt' 1 0))
:=sorry

theorem bitvec_AndOrXor_2063__ :
 ∀ (w : ℕ) (x C1 C : ℤ),
  some (Bitvec.or (Bitvec.xor (Bitvec.ofInt' w x) (Bitvec.ofInt' w C1)) (Bitvec.ofInt' w C)) ⊑
    some
      (Bitvec.xor (Bitvec.or (Bitvec.ofInt' w x) (Bitvec.ofInt' w C))
        (Bitvec.and (Bitvec.ofInt' w C1) (Bitvec.not (Bitvec.ofInt' w C))))
:=sorry

theorem bitvec_AndOrXor_2113___ :
 ∀ (w : ℕ) (A B : ℤ),
  some
      (Bitvec.or (Bitvec.and (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w B))
        (Bitvec.ofInt' w A)) ⊑
    some (Bitvec.or (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))
:=sorry

theorem bitvec_AndOrXor_2118___ :
 ∀ (w : ℕ) (A B : ℤ),
  some
      (Bitvec.or (Bitvec.and (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))
        (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w (-1)))) ⊑
    some (Bitvec.or (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w B))
:=sorry

theorem bitvec_AndOrXor_2123___ :
 ∀ (w : ℕ) (B A : ℤ),
  some
      (Bitvec.or (Bitvec.and (Bitvec.ofInt' w A) (Bitvec.xor (Bitvec.ofInt' w B) (Bitvec.ofInt' w (-1))))
        (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))) ⊑
    some (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))
:=sorry

theorem bitvec_AndOrXor_2188 :
 ∀ (w : ℕ) (D A : ℤ),
  some
      (Bitvec.or (Bitvec.and (Bitvec.ofInt' w A) (Bitvec.xor (Bitvec.ofInt' w D) (Bitvec.ofInt' w (-1))))
        (Bitvec.and (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w D))) ⊑
    some (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w D))
:=sorry

theorem bitvec_AndOrXor_2231__ :
 ∀ (w : ℕ) (A B C : ℤ),
  some
      (Bitvec.or (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))
        (Bitvec.xor (Bitvec.xor (Bitvec.ofInt' w B) (Bitvec.ofInt' w C)) (Bitvec.ofInt' w A))) ⊑
    some (Bitvec.or (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w B)) (Bitvec.ofInt' w C))
:=sorry

theorem bitvec_AndOrXor_2243__ :
 ∀ (w : ℕ) (B C A : ℤ),
  some
      (Bitvec.or (Bitvec.and (Bitvec.or (Bitvec.ofInt' w B) (Bitvec.ofInt' w C)) (Bitvec.ofInt' w A))
        (Bitvec.ofInt' w B)) ⊑
    some (Bitvec.or (Bitvec.ofInt' w B) (Bitvec.and (Bitvec.ofInt' w A) (Bitvec.ofInt' w C)))
:=sorry

theorem bitvec_AndOrXor_2247__ :
 ∀ (w : ℕ) (A B : ℤ),
  some
      (Bitvec.or (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w (-1)))
        (Bitvec.xor (Bitvec.ofInt' w B) (Bitvec.ofInt' w (-1)))) ⊑
    some (Bitvec.xor (Bitvec.and (Bitvec.ofInt' w A) (Bitvec.ofInt' w B)) (Bitvec.ofInt' w (-1)))
:=sorry

theorem bitvec_AndOrXor_2263 :
 ∀ (w : ℕ) (op0 B : ℤ),
  some (Bitvec.or (Bitvec.ofInt' w op0) (Bitvec.xor (Bitvec.ofInt' w op0) (Bitvec.ofInt' w B))) ⊑
    some (Bitvec.or (Bitvec.ofInt' w op0) (Bitvec.ofInt' w B))
:=sorry

theorem bitvec_AndOrXor_2264 :
 ∀ (w : ℕ) (A B : ℤ),
  some
      (Bitvec.or (Bitvec.ofInt' w A)
        (Bitvec.xor (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w B))) ⊑
    some (Bitvec.or (Bitvec.ofInt' w A) (Bitvec.xor (Bitvec.ofInt' w B) (Bitvec.ofInt' w (-1))))
:=sorry

theorem bitvec_AndOrXor_2265 :
 ∀ (w : ℕ) (A B : ℤ),
  some
      (Bitvec.or (Bitvec.and (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))
        (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))) ⊑
    some (Bitvec.or (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))
:=sorry

theorem bitvec_AndOrXor_2284 :
 ∀ (w : ℕ) (A B : ℤ),
  some
      (Bitvec.or (Bitvec.ofInt' w A)
        (Bitvec.xor (Bitvec.or (Bitvec.ofInt' w A) (Bitvec.ofInt' w B)) (Bitvec.ofInt' w (-1)))) ⊑
    some (Bitvec.or (Bitvec.ofInt' w A) (Bitvec.xor (Bitvec.ofInt' w B) (Bitvec.ofInt' w (-1))))
:=sorry

theorem bitvec_AndOrXor_2285 :
 ∀ (w : ℕ) (A B : ℤ),
  some
      (Bitvec.or (Bitvec.ofInt' w A)
        (Bitvec.xor (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w B)) (Bitvec.ofInt' w (-1)))) ⊑
    some (Bitvec.or (Bitvec.ofInt' w A) (Bitvec.xor (Bitvec.ofInt' w B) (Bitvec.ofInt' w (-1))))
:=sorry

theorem bitvec_AndOrXor_2297 :
 ∀ (w : ℕ) (A B : ℤ),
  some
      (Bitvec.or (Bitvec.and (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))
        (Bitvec.xor (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w B))) ⊑
    some (Bitvec.xor (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w B))
:=sorry

theorem bitvec_AndOrXor_2367 :
 ∀ (w : ℕ) (A C1 op1 : ℤ),
  some (Bitvec.or (Bitvec.or (Bitvec.ofInt' w A) (Bitvec.ofInt' w C1)) (Bitvec.ofInt' w op1)) ⊑
    some (Bitvec.or (Bitvec.or (Bitvec.ofInt' w A) (Bitvec.ofInt' w op1)) (Bitvec.ofInt' w C1))
:=sorry

theorem bitvec_AndOrXor_2375 :
 ∀ (w : ℕ) (x A B C D : ℤ),
  some
      (Bitvec.or (Bitvec.select (Bitvec.ofInt' 1 x) (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))
        (Bitvec.select (Bitvec.ofInt' 1 x) (Bitvec.ofInt' w C) (Bitvec.ofInt' w D))) ⊑
    some
      (Bitvec.select (Bitvec.ofInt' 1 x) (Bitvec.or (Bitvec.ofInt' w A) (Bitvec.ofInt' w C))
        (Bitvec.or (Bitvec.ofInt' w B) (Bitvec.ofInt' w D)))
:=sorry

theorem bitvec_AndOrXor_2416 :
 ∀ (w : ℕ) (nx y : ℤ),
  some
      (Bitvec.xor (Bitvec.and (Bitvec.xor (Bitvec.ofInt' w nx) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w y))
        (Bitvec.ofInt' w (-1))) ⊑
    some (Bitvec.or (Bitvec.ofInt' w nx) (Bitvec.xor (Bitvec.ofInt' w y) (Bitvec.ofInt' w (-1))))
:=sorry

theorem bitvec_AndOrXor_2417 :
 ∀ (w : ℕ) (nx y : ℤ),
  some
      (Bitvec.xor (Bitvec.or (Bitvec.xor (Bitvec.ofInt' w nx) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w y))
        (Bitvec.ofInt' w (-1))) ⊑
    some (Bitvec.and (Bitvec.ofInt' w nx) (Bitvec.xor (Bitvec.ofInt' w y) (Bitvec.ofInt' w (-1))))
:=sorry

theorem bitvec_AndOrXor_2429 :
 ∀ (w : ℕ) (x y : ℤ),
  some (Bitvec.xor (Bitvec.and (Bitvec.ofInt' w x) (Bitvec.ofInt' w y)) (Bitvec.ofInt' w (-1))) ⊑
    some
      (Bitvec.or (Bitvec.xor (Bitvec.ofInt' w x) (Bitvec.ofInt' w (-1)))
        (Bitvec.xor (Bitvec.ofInt' w y) (Bitvec.ofInt' w (-1))))
:=sorry

theorem bitvec_AndOrXor_2430 :
 ∀ (w : ℕ) (x y : ℤ),
  some (Bitvec.xor (Bitvec.or (Bitvec.ofInt' w x) (Bitvec.ofInt' w y)) (Bitvec.ofInt' w (-1))) ⊑
    some
      (Bitvec.and (Bitvec.xor (Bitvec.ofInt' w x) (Bitvec.ofInt' w (-1)))
        (Bitvec.xor (Bitvec.ofInt' w y) (Bitvec.ofInt' w (-1))))
:=sorry

theorem bitvec_AndOrXor_2443 :
 ∀ (w : ℕ) (x y : ℤ),
  some
      (Bitvec.xor
        (Bitvec.sshr (Bitvec.xor (Bitvec.ofInt' w x) (Bitvec.ofInt' w (-1))) (Bitvec.toNat (Bitvec.ofInt' w y)))
        (Bitvec.ofInt' w (-1))) ⊑
    some (Bitvec.sshr (Bitvec.ofInt' w x) (Bitvec.toNat (Bitvec.ofInt' w y)))
:=sorry

theorem bitvec_AndOrXor_2453:
 ∀ (x y : ℤ),
  some
      (Bitvec.xor (Bitvec.fromBool (decide (Bitvec.toInt (Bitvec.ofInt' 1 x) < Bitvec.toInt (Bitvec.ofInt' 1 y))))
        (Bitvec.ofInt' 1 (-1))) ⊑
    some (Bitvec.fromBool (decide (Bitvec.toInt (Bitvec.ofInt' 1 y) ≤ Bitvec.toInt (Bitvec.ofInt' 1 x))))
:=sorry

theorem bitvec_AndOrXor_2475 :
 ∀ (w : ℕ) (C x : ℤ),
  some (Bitvec.xor (Bitvec.sub (Bitvec.ofInt' w C) (Bitvec.ofInt' w x)) (Bitvec.ofInt' w (-1))) ⊑
    Bitvec.add? (Bitvec.ofInt' w x) (Bitvec.sub (Bitvec.ofInt' w (-1)) (Bitvec.ofInt' w C))
:=sorry

theorem bitvec_AndOrXor_2486 :
 ∀ (w : ℕ) (x C : ℤ),
  (Option.bind (Bitvec.add? (Bitvec.ofInt' w x) (Bitvec.ofInt' w C)) fun fst =>
      some (Bitvec.xor fst (Bitvec.ofInt' w (-1)))) ⊑
    some (Bitvec.sub (Bitvec.sub (Bitvec.ofInt' w (-1)) (Bitvec.ofInt' w C)) (Bitvec.ofInt' w x))
:=sorry

theorem bitvec_AndOrXor_2581__ :
 ∀ (w : ℕ) (a op1 : ℤ),
  some (Bitvec.xor (Bitvec.or (Bitvec.ofInt' w a) (Bitvec.ofInt' w op1)) (Bitvec.ofInt' w op1)) ⊑
    some (Bitvec.and (Bitvec.ofInt' w a) (Bitvec.xor (Bitvec.ofInt' w op1) (Bitvec.ofInt' w (-1))))
:=sorry

theorem bitvec_AndOrXor_2587__ :
 ∀ (w : ℕ) (a op1 : ℤ),
  some (Bitvec.xor (Bitvec.and (Bitvec.ofInt' w a) (Bitvec.ofInt' w op1)) (Bitvec.ofInt' w op1)) ⊑
    some (Bitvec.and (Bitvec.xor (Bitvec.ofInt' w a) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w op1))
:=sorry

theorem bitvec_AndOrXor_2595 :
 ∀ (w : ℕ) (a b : ℤ),
  some
      (Bitvec.xor (Bitvec.and (Bitvec.ofInt' w a) (Bitvec.ofInt' w b))
        (Bitvec.or (Bitvec.ofInt' w a) (Bitvec.ofInt' w b))) ⊑
    some (Bitvec.xor (Bitvec.ofInt' w a) (Bitvec.ofInt' w b))
:=sorry

theorem bitvec_AndOrXor_2607 :
 ∀ (w : ℕ) (a b : ℤ),
  some
      (Bitvec.xor (Bitvec.or (Bitvec.ofInt' w a) (Bitvec.xor (Bitvec.ofInt' w b) (Bitvec.ofInt' w (-1))))
        (Bitvec.or (Bitvec.xor (Bitvec.ofInt' w a) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w b))) ⊑
    some (Bitvec.xor (Bitvec.ofInt' w a) (Bitvec.ofInt' w b))
:=sorry

theorem bitvec_AndOrXor_2617 :
 ∀ (w : ℕ) (a b : ℤ),
  some
      (Bitvec.xor (Bitvec.and (Bitvec.ofInt' w a) (Bitvec.xor (Bitvec.ofInt' w b) (Bitvec.ofInt' w (-1))))
        (Bitvec.and (Bitvec.xor (Bitvec.ofInt' w a) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w b))) ⊑
    some (Bitvec.xor (Bitvec.ofInt' w a) (Bitvec.ofInt' w b))
:=sorry

theorem bitvec_AndOrXor_2627 :
 ∀ (w : ℕ) (a c b : ℤ),
  some
      (Bitvec.xor (Bitvec.xor (Bitvec.ofInt' w a) (Bitvec.ofInt' w c))
        (Bitvec.or (Bitvec.ofInt' w a) (Bitvec.ofInt' w b))) ⊑
    some
      (Bitvec.xor (Bitvec.and (Bitvec.xor (Bitvec.ofInt' w a) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w b))
        (Bitvec.ofInt' w c))
:=sorry

theorem bitvec_AndOrXor_2647 :
 ∀ (w : ℕ) (a b : ℤ),
  some
      (Bitvec.xor (Bitvec.and (Bitvec.ofInt' w a) (Bitvec.ofInt' w b))
        (Bitvec.xor (Bitvec.ofInt' w a) (Bitvec.ofInt' w b))) ⊑
    some (Bitvec.or (Bitvec.ofInt' w a) (Bitvec.ofInt' w b))
:=sorry

theorem bitvec_AndOrXor_2658 :
 ∀ (w : ℕ) (b a : ℤ),
  some
      (Bitvec.xor (Bitvec.and (Bitvec.ofInt' w a) (Bitvec.xor (Bitvec.ofInt' w b) (Bitvec.ofInt' w (-1))))
        (Bitvec.xor (Bitvec.ofInt' w a) (Bitvec.ofInt' w (-1)))) ⊑
    some (Bitvec.xor (Bitvec.and (Bitvec.ofInt' w a) (Bitvec.ofInt' w b)) (Bitvec.ofInt' w (-1)))
:=sorry

theorem bitvec_AndOrXor_2663:
 ∀ (a b : ℤ),
  some
      (Bitvec.xor (Bitvec.fromBool (decide (Bitvec.toNat (Bitvec.ofInt' 1 a) ≤ Bitvec.toNat (Bitvec.ofInt' 1 b))))
        (Bitvec.fromBool (Bitvec.ofInt' 1 a != Bitvec.ofInt' 1 b))) ⊑
    some (Bitvec.fromBool (decide (Bitvec.toNat (Bitvec.ofInt' 1 b) ≤ Bitvec.toNat (Bitvec.ofInt' 1 a))))
:=sorry

theorem bitvec_152 :
 ∀ (w : ℕ) (x : ℤ),
  Bitvec.mul? (Bitvec.ofInt' w x) (Bitvec.ofInt' w (-1)) ⊑ some (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w x))
:=sorry

theorem bitvec_160:
 ∀ (x C2 C1 : ℤ),
  Bitvec.mul? (Bitvec.shl (Bitvec.ofInt' 7 x) (Bitvec.toNat (Bitvec.ofInt' 7 C2))) (Bitvec.ofInt' 7 C1) ⊑
    Bitvec.mul? (Bitvec.ofInt' 7 x) (Bitvec.shl (Bitvec.ofInt' 7 C1) (Bitvec.toNat (Bitvec.ofInt' 7 C2)))
:=sorry

theorem bitvec_229 :
 ∀ (w : ℕ) (X C1 Op1 : ℤ),
  (Option.bind (Bitvec.add? (Bitvec.ofInt' w X) (Bitvec.ofInt' w C1)) fun fst =>
      Bitvec.mul? fst (Bitvec.ofInt' w Op1)) ⊑
    Option.bind (Bitvec.mul? (Bitvec.ofInt' w X) (Bitvec.ofInt' w Op1)) fun fst =>
      Option.bind (Bitvec.mul? (Bitvec.ofInt' w C1) (Bitvec.ofInt' w Op1)) fun snd => Bitvec.add? fst snd
:=sorry

theorem bitvec_239 :
 ∀ (w : ℕ) (X Y : ℤ),
  Bitvec.mul? (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w X))
      (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w Y)) ⊑
    Bitvec.mul? (Bitvec.ofInt' w X) (Bitvec.ofInt' w Y)
:=sorry

theorem bitvec_265 :
 ∀ (w : ℕ) (X Y : ℤ),
  (Option.bind (Bitvec.udiv? (Bitvec.ofInt' w X) (Bitvec.ofInt' w Y)) fun fst => Bitvec.mul? fst (Bitvec.ofInt' w Y)) ⊑
    some (Bitvec.ofInt' w X)
:=sorry

theorem bitvec_265_2 :
 ∀ (w : ℕ) (X Y : ℤ),
  (Option.bind (Bitvec.sdiv? (Bitvec.ofInt' w X) (Bitvec.ofInt' w Y)) fun fst => Bitvec.mul? fst (Bitvec.ofInt' w Y)) ⊑
    some (Bitvec.ofInt' w X)
:=sorry

theorem bitvec_266 :
 ∀ (w : ℕ) (X Y : ℤ),
  (Option.bind (Bitvec.udiv? (Bitvec.ofInt' w X) (Bitvec.ofInt' w Y)) fun fst =>
      Bitvec.mul? fst (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w Y))) ⊑
    some (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w X))
:=sorry

theorem bitvec_266_2 :
 ∀ (w : ℕ) (X Y : ℤ),
  (Option.bind (Bitvec.sdiv? (Bitvec.ofInt' w X) (Bitvec.ofInt' w Y)) fun fst =>
      Bitvec.mul? fst (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w Y))) ⊑
    some (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w X))
:=sorry

theorem bitvec_275:
 ∀ (X Y : ℤ),
  (Option.bind (Bitvec.udiv? (Bitvec.ofInt' 5 X) (Bitvec.ofInt' 5 Y)) fun fst => Bitvec.mul? fst (Bitvec.ofInt' 5 Y)) ⊑
    Option.bind (Bitvec.urem? (Bitvec.ofInt' 5 X) (Bitvec.ofInt' 5 Y)) fun snd =>
      some (Bitvec.sub (Bitvec.ofInt' 5 X) snd)
:=sorry

theorem bitvec_275_2:
 ∀ (X Y : ℤ),
  (Option.bind (Bitvec.sdiv? (Bitvec.ofInt' 5 X) (Bitvec.ofInt' 5 Y)) fun fst => Bitvec.mul? fst (Bitvec.ofInt' 5 Y)) ⊑
    Option.bind (Bitvec.urem? (Bitvec.ofInt' 5 X) (Bitvec.ofInt' 5 Y)) fun snd =>
      some (Bitvec.sub (Bitvec.ofInt' 5 X) snd)
:=sorry

theorem bitvec_276:
 ∀ (X Y : ℤ),
  (Option.bind (Bitvec.sdiv? (Bitvec.ofInt' 5 X) (Bitvec.ofInt' 5 Y)) fun fst =>
      Bitvec.mul? fst (Bitvec.sub (Bitvec.ofInt' 5 0) (Bitvec.ofInt' 5 Y))) ⊑
    Option.bind (Bitvec.urem? (Bitvec.ofInt' 5 X) (Bitvec.ofInt' 5 Y)) fun fst =>
      some (Bitvec.sub fst (Bitvec.ofInt' 5 X))
:=sorry

theorem bitvec_276_2:
 ∀ (X Y : ℤ),
  (Option.bind (Bitvec.udiv? (Bitvec.ofInt' 5 X) (Bitvec.ofInt' 5 Y)) fun fst =>
      Bitvec.mul? fst (Bitvec.sub (Bitvec.ofInt' 5 0) (Bitvec.ofInt' 5 Y))) ⊑
    Option.bind (Bitvec.urem? (Bitvec.ofInt' 5 X) (Bitvec.ofInt' 5 Y)) fun fst =>
      some (Bitvec.sub fst (Bitvec.ofInt' 5 X))
:=sorry

theorem bitvec_283:
 ∀ (X Y : ℤ),
  Bitvec.mul? (Bitvec.ofInt' 1 X) (Bitvec.ofInt' 1 Y) ⊑ some (Bitvec.and (Bitvec.ofInt' 1 X) (Bitvec.ofInt' 1 Y))
:=sorry

theorem bitvec_290_ :
 ∀ (w : ℕ) (Y Op1 : ℤ),
  Bitvec.mul? (Bitvec.shl (Bitvec.ofInt' w 1) (Bitvec.toNat (Bitvec.ofInt' w Y))) (Bitvec.ofInt' w Op1) ⊑
    some (Bitvec.shl (Bitvec.ofInt' w Op1) (Bitvec.toNat (Bitvec.ofInt' w Y)))
:=sorry

theorem bitvec_SimplifyDivRemOfSelect :
 ∀ (w : ℕ) (c Y X : ℤ),
  Bitvec.udiv? (Bitvec.ofInt' w X) (Bitvec.select (Bitvec.ofInt' 1 c) (Bitvec.ofInt' w Y) (Bitvec.ofInt' w 0)) ⊑
    Bitvec.udiv? (Bitvec.ofInt' w X) (Bitvec.ofInt' w Y)
:=sorry

theorem bitvec_820:
 ∀ (X Op1 : ℤ),
  (Option.bind (Bitvec.urem? (Bitvec.ofInt' 9 X) (Bitvec.ofInt' 9 Op1)) fun x =>
      Bitvec.sdiv? (Bitvec.sub (Bitvec.ofInt' 9 X) x) (Bitvec.ofInt' 9 Op1)) ⊑
    Bitvec.sdiv? (Bitvec.ofInt' 9 X) (Bitvec.ofInt' 9 Op1)
:=sorry

theorem bitvec_820':
 ∀ (X Op1 : ℤ),
  (Option.bind (Bitvec.urem? (Bitvec.ofInt' 9 X) (Bitvec.ofInt' 9 Op1)) fun x =>
      Bitvec.udiv? (Bitvec.sub (Bitvec.ofInt' 9 X) x) (Bitvec.ofInt' 9 Op1)) ⊑
    Bitvec.udiv? (Bitvec.ofInt' 9 X) (Bitvec.ofInt' 9 Op1)
:=sorry

theorem bitvec_891:
 ∀ (N x : ℤ),
  Bitvec.udiv? (Bitvec.ofInt' 13 x) (Bitvec.shl (Bitvec.ofInt' 13 1) (Bitvec.toNat (Bitvec.ofInt' 13 N))) ⊑
    some (Bitvec.ushr (Bitvec.ofInt' 13 x) (Bitvec.toNat (Bitvec.ofInt' 13 N)))
:=sorry

theorem bitvec_891_exact:
 ∀ (N x : ℤ),
  Bitvec.udiv? (Bitvec.ofInt' 13 x) (Bitvec.shl (Bitvec.ofInt' 13 1) (Bitvec.toNat (Bitvec.ofInt' 13 N))) ⊑
    some (Bitvec.ushr (Bitvec.ofInt' 13 x) (Bitvec.toNat (Bitvec.ofInt' 13 N)))
:=sorry

theorem bitvec_1030 :
 ∀ (w : ℕ) (X : ℤ),
  Bitvec.sdiv? (Bitvec.ofInt' w X) (Bitvec.ofInt' w (-1)) ⊑ some (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w X))
:=sorry

theorem bitvec_1049:
 ∀ (X C : ℤ),
  Bitvec.sdiv? (Bitvec.sub (Bitvec.ofInt' 11 0) (Bitvec.ofInt' 11 X)) (Bitvec.ofInt' 11 C) ⊑
    Bitvec.sdiv? (Bitvec.ofInt' 11 X) (Bitvec.neg (Bitvec.ofInt' 11 C))
:=sorry

theorem bitvec_Select_846:
 ∀ (B C : ℤ),
  some (Bitvec.select (Bitvec.ofInt' 1 B) (true ::ᵥ Vector.nil) (Bitvec.ofInt' 1 C)) ⊑
    some (Bitvec.or (Bitvec.ofInt' 1 B) (Bitvec.ofInt' 1 C))
:=sorry

theorem bitvec_Select_850:
 ∀ (B C : ℤ),
  some (Bitvec.select (Bitvec.ofInt' 1 B) (false ::ᵥ Vector.nil) (Bitvec.ofInt' 1 C)) ⊑
    some (Bitvec.and (Bitvec.xor (Bitvec.ofInt' 1 B) (true ::ᵥ Vector.nil)) (Bitvec.ofInt' 1 C))
:=sorry

theorem bitvec_Select_855:
 ∀ (B C : ℤ),
  some (Bitvec.select (Bitvec.ofInt' 1 B) (Bitvec.ofInt' 1 C) (false ::ᵥ Vector.nil)) ⊑
    some (Bitvec.and (Bitvec.ofInt' 1 B) (Bitvec.ofInt' 1 C))
:=sorry

theorem bitvec_Select_859:
 ∀ (B C : ℤ),
  some (Bitvec.select (Bitvec.ofInt' 1 B) (Bitvec.ofInt' 1 C) (true ::ᵥ Vector.nil)) ⊑
    some (Bitvec.or (Bitvec.xor (Bitvec.ofInt' 1 B) (true ::ᵥ Vector.nil)) (Bitvec.ofInt' 1 C))
:=sorry

theorem bitvec_Select_851:
 ∀ (a b : ℤ),
  some (Bitvec.select (Bitvec.ofInt' 1 a) (Bitvec.ofInt' 1 b) (Bitvec.ofInt' 1 a)) ⊑
    some (Bitvec.and (Bitvec.ofInt' 1 a) (Bitvec.ofInt' 1 b))
:=sorry

theorem bitvec_Select_852:
 ∀ (a b : ℤ),
  some (Bitvec.select (Bitvec.ofInt' 1 a) (Bitvec.ofInt' 1 a) (Bitvec.ofInt' 1 b)) ⊑
    some (Bitvec.or (Bitvec.ofInt' 1 a) (Bitvec.ofInt' 1 b))
:=sorry

theorem bitvec_Select_962 :
 ∀ (w : ℕ) (x y z c : ℤ),
  (Option.bind (Bitvec.add? (Bitvec.ofInt' w x) (Bitvec.ofInt' w y)) fun __do_lift =>
      Option.bind (Bitvec.add? (Bitvec.ofInt' w x) (Bitvec.ofInt' w z)) fun __do_lift_1 =>
        some (Bitvec.select (Bitvec.ofInt' 1 c) __do_lift __do_lift_1)) ⊑
    Bitvec.add? (Bitvec.ofInt' w x) (Bitvec.select (Bitvec.ofInt' 1 c) (Bitvec.ofInt' w y) (Bitvec.ofInt' w z))
:=sorry

theorem bitvec_Select_967a:
 ∀ (x y c : ℤ),
  (Option.bind (Bitvec.add? (Bitvec.ofInt' 9 x) (Bitvec.ofInt' 9 y)) fun __do_lift =>
      some (Bitvec.select (Bitvec.ofInt' 1 c) __do_lift (Bitvec.sub (Bitvec.ofInt' 9 x) (Bitvec.ofInt' 9 y)))) ⊑
    Bitvec.add? (Bitvec.ofInt' 9 x)
      (Bitvec.select (Bitvec.ofInt' 1 c) (Bitvec.ofInt' 9 y) (Bitvec.sub (Bitvec.ofInt' 9 0) (Bitvec.ofInt' 9 y)))
:=sorry

theorem bitvec_Select_967b:
 ∀ (x y c : ℤ),
  (Option.bind (Bitvec.add? (Bitvec.ofInt' 9 x) (Bitvec.ofInt' 9 y)) fun __do_lift =>
      some (Bitvec.select (Bitvec.ofInt' 1 c) (Bitvec.sub (Bitvec.ofInt' 9 x) (Bitvec.ofInt' 9 y)) __do_lift)) ⊑
    Bitvec.add? (Bitvec.ofInt' 9 x)
      (Bitvec.select (Bitvec.ofInt' 1 c) (Bitvec.sub (Bitvec.ofInt' 9 0) (Bitvec.ofInt' 9 y)) (Bitvec.ofInt' 9 y))
:=sorry

theorem bitvec_Select_1070 :
 ∀ (w : ℕ) (c W Z Y : ℤ),
  some
      (Bitvec.select (Bitvec.ofInt' 1 c) (Bitvec.select (Bitvec.ofInt' 1 c) (Bitvec.ofInt' w W) (Bitvec.ofInt' w Z))
        (Bitvec.ofInt' w Y)) ⊑
    some (Bitvec.select (Bitvec.ofInt' 1 c) (Bitvec.ofInt' w W) (Bitvec.ofInt' w Y))
:=sorry

theorem bitvec_Select_1078 :
 ∀ (w : ℕ) (c W Z X : ℤ),
  some
      (Bitvec.select (Bitvec.ofInt' 1 c) (Bitvec.ofInt' w X)
        (Bitvec.select (Bitvec.ofInt' 1 c) (Bitvec.ofInt' w W) (Bitvec.ofInt' w Z))) ⊑
    some (Bitvec.select (Bitvec.ofInt' 1 c) (Bitvec.ofInt' w X) (Bitvec.ofInt' w Z))
:=sorry

theorem bitvec_Select_1100 :
 ∀ (w : ℕ) (X Y : ℤ),
  some (Bitvec.select (true ::ᵥ Vector.nil) (Bitvec.ofInt' w X) (Bitvec.ofInt' w Y)) ⊑ some (Bitvec.ofInt' w X)
:=sorry

theorem bitvec_Select_1105 :
 ∀ (w : ℕ) (X Y : ℤ),
  some (Bitvec.select (false ::ᵥ Vector.nil) (Bitvec.ofInt' w X) (Bitvec.ofInt' w Y)) ⊑ some (Bitvec.ofInt' w Y)
:=sorry

theorem bitvec_InstCombineShift__239 :
 ∀ (w : ℕ) (X C : ℤ),
  some
      (Bitvec.ushr (Bitvec.shl (Bitvec.ofInt' w X) (Bitvec.toNat (Bitvec.ofInt' w C)))
        (Bitvec.toNat (Bitvec.ofInt' w C))) ⊑
    some (Bitvec.and (Bitvec.ofInt' w X) (Bitvec.ushr (Bitvec.ofInt' w (-1)) (Bitvec.toNat (Bitvec.ofInt' w C))))
:=sorry

theorem bitvec_InstCombineShift__279 :
 ∀ (w : ℕ) (X C : ℤ),
  some
      (Bitvec.shl (Bitvec.ushr (Bitvec.ofInt' w X) (Bitvec.toNat (Bitvec.ofInt' w C)))
        (Bitvec.toNat (Bitvec.ofInt' w C))) ⊑
    some (Bitvec.and (Bitvec.ofInt' w X) (Bitvec.shl (Bitvec.ofInt' w (-1)) (Bitvec.toNat (Bitvec.ofInt' w C))))
:=sorry

theorem bitvec_InstCombineShift__351:
 ∀ (X C1 C2 : ℤ),
  (Option.bind (Bitvec.mul? (Bitvec.ofInt' 7 X) (Bitvec.ofInt' 7 C1)) fun fst =>
      some (Bitvec.shl fst (Bitvec.toNat (Bitvec.ofInt' 7 C2)))) ⊑
    Bitvec.mul? (Bitvec.ofInt' 7 X) (Bitvec.shl (Bitvec.ofInt' 7 C1) (Bitvec.toNat (Bitvec.ofInt' 7 C2)))
:=sorry

theorem bitvec_InstCombineShift__422_1:
 ∀ (X C Y : ℤ),
  (Option.bind (Bitvec.add? (Bitvec.ofInt' 31 Y) (Bitvec.ushr (Bitvec.ofInt' 31 X) (Bitvec.toNat (Bitvec.ofInt' 31 C))))
      fun fst => some (Bitvec.shl fst (Bitvec.toNat (Bitvec.ofInt' 31 C)))) ⊑
    Option.bind (Bitvec.add? (Bitvec.shl (Bitvec.ofInt' 31 Y) (Bitvec.toNat (Bitvec.ofInt' 31 C))) (Bitvec.ofInt' 31 X))
      fun fst => some (Bitvec.and fst (Bitvec.shl (Bitvec.ofInt' 31 (-1)) (Bitvec.toNat (Bitvec.ofInt' 31 C))))
:=sorry

theorem bitvec_InstCombineShift__422_2:
 ∀ (X C Y : ℤ),
  (Option.bind (Bitvec.add? (Bitvec.ofInt' 31 Y) (Bitvec.sshr (Bitvec.ofInt' 31 X) (Bitvec.toNat (Bitvec.ofInt' 31 C))))
      fun fst => some (Bitvec.shl fst (Bitvec.toNat (Bitvec.ofInt' 31 C)))) ⊑
    Option.bind (Bitvec.add? (Bitvec.shl (Bitvec.ofInt' 31 Y) (Bitvec.toNat (Bitvec.ofInt' 31 C))) (Bitvec.ofInt' 31 X))
      fun fst => some (Bitvec.and fst (Bitvec.shl (Bitvec.ofInt' 31 (-1)) (Bitvec.toNat (Bitvec.ofInt' 31 C))))
:=sorry

theorem bitvec_InstCombineShift__440 :
 ∀ (w : ℕ) (X C C2 Y : ℤ),
  some
      (Bitvec.shl
        (Bitvec.xor (Bitvec.ofInt' w Y)
          (Bitvec.and (Bitvec.ushr (Bitvec.ofInt' w X) (Bitvec.toNat (Bitvec.ofInt' w C))) (Bitvec.ofInt' w C2)))
        (Bitvec.toNat (Bitvec.ofInt' w C))) ⊑
    some
      (Bitvec.xor (Bitvec.and (Bitvec.ofInt' w X) (Bitvec.shl (Bitvec.ofInt' w C2) (Bitvec.toNat (Bitvec.ofInt' w C))))
        (Bitvec.shl (Bitvec.ofInt' w Y) (Bitvec.toNat (Bitvec.ofInt' w C))))
:=sorry

theorem bitvec_InstCombineShift__458:
 ∀ (X C Y : ℤ),
  some
      (Bitvec.shl
        (Bitvec.sub (Bitvec.sshr (Bitvec.ofInt' 31 X) (Bitvec.toNat (Bitvec.ofInt' 31 C))) (Bitvec.ofInt' 31 Y))
        (Bitvec.toNat (Bitvec.ofInt' 31 C))) ⊑
    some
      (Bitvec.and
        (Bitvec.sub (Bitvec.ofInt' 31 X) (Bitvec.shl (Bitvec.ofInt' 31 Y) (Bitvec.toNat (Bitvec.ofInt' 31 C))))
        (Bitvec.shl (Bitvec.ofInt' 31 (-1)) (Bitvec.toNat (Bitvec.ofInt' 31 C))))
:=sorry

theorem bitvec_InstCombineShift__476 :
 ∀ (w : ℕ) (X C C2 Y : ℤ),
  some
      (Bitvec.shl
        (Bitvec.or
          (Bitvec.and (Bitvec.ushr (Bitvec.ofInt' w X) (Bitvec.toNat (Bitvec.ofInt' w C))) (Bitvec.ofInt' w C2))
          (Bitvec.ofInt' w Y))
        (Bitvec.toNat (Bitvec.ofInt' w C))) ⊑
    some
      (Bitvec.or (Bitvec.and (Bitvec.ofInt' w X) (Bitvec.shl (Bitvec.ofInt' w C2) (Bitvec.toNat (Bitvec.ofInt' w C))))
        (Bitvec.shl (Bitvec.ofInt' w Y) (Bitvec.toNat (Bitvec.ofInt' w C))))
:=sorry

theorem bitvec_InstCombineShift__497 :
 ∀ (w : ℕ) (X C2 C : ℤ),
  some (Bitvec.ushr (Bitvec.xor (Bitvec.ofInt' w X) (Bitvec.ofInt' w C2)) (Bitvec.toNat (Bitvec.ofInt' w C))) ⊑
    some
      (Bitvec.xor (Bitvec.ushr (Bitvec.ofInt' w X) (Bitvec.toNat (Bitvec.ofInt' w C)))
        (Bitvec.ushr (Bitvec.ofInt' w C2) (Bitvec.toNat (Bitvec.ofInt' w C))))
:=sorry

theorem bitvec_InstCombineShift__497''' :
 ∀ (w : ℕ) (X C2 C : ℤ),
  (Option.bind (Bitvec.add? (Bitvec.ofInt' w X) (Bitvec.ofInt' w C2)) fun fst =>
      some (Bitvec.shl fst (Bitvec.toNat (Bitvec.ofInt' w C)))) ⊑
    Bitvec.add? (Bitvec.shl (Bitvec.ofInt' w X) (Bitvec.toNat (Bitvec.ofInt' w C)))
      (Bitvec.shl (Bitvec.ofInt' w C2) (Bitvec.toNat (Bitvec.ofInt' w C)))
:=sorry

theorem bitvec_InstCombineShift__582 :
 ∀ (w : ℕ) (X C : ℤ),
  some
      (Bitvec.ushr (Bitvec.shl (Bitvec.ofInt' w X) (Bitvec.toNat (Bitvec.ofInt' w C)))
        (Bitvec.toNat (Bitvec.ofInt' w C))) ⊑
    some (Bitvec.and (Bitvec.ofInt' w X) (Bitvec.ushr (Bitvec.ofInt' w (-1)) (Bitvec.toNat (Bitvec.ofInt' w C))))
:=sorry

theorem bitvec_InstCombineShift__724:
 ∀ (C1 A C2 : ℤ),
  some
      (Bitvec.shl (Bitvec.shl (Bitvec.ofInt' 31 C1) (Bitvec.toNat (Bitvec.ofInt' 31 A)))
        (Bitvec.toNat (Bitvec.ofInt' 31 C2))) ⊑
    some
      (Bitvec.shl (Bitvec.shl (Bitvec.ofInt' 31 C1) (Bitvec.toNat (Bitvec.ofInt' 31 C2)))
        (Bitvec.toNat (Bitvec.ofInt' 31 A)))

:=sorry
