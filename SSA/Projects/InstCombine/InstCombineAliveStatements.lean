import SSA.Projects.InstCombine.InstCombineBase

theorem bitvec_AddSub_1043 :
 ∀ (w Z C1 RHS : ℕ),
  (Option.bind
      (Bitvec.add? (Bitvec.xor (Bitvec.and (Bitvec.ofInt' w ↑Z) (Bitvec.ofInt' w ↑C1)) (Bitvec.ofInt' w ↑C1))
        (Bitvec.ofInt' w 1))
      fun fst => Bitvec.add? fst (Bitvec.ofInt' w ↑RHS)) =
    some (Bitvec.sub (Bitvec.ofInt' w ↑RHS) (Bitvec.or (Bitvec.ofInt' w ↑Z) (Bitvec.not (Bitvec.ofInt' w ↑C1))))
:=sorry

theorem bitvec_AddSub_1152:
 ∀ (x y : ℕ),
  Bitvec.add? (Bitvec.ofInt' 1 ↑x) (Bitvec.ofInt' 1 ↑y) = some (Bitvec.xor (Bitvec.ofInt' 1 ↑x) (Bitvec.ofInt' 1 ↑y))
:=sorry

theorem bitvec_AddSub_1156 :
 ∀ (w b : ℕ),
  Bitvec.add? (Bitvec.ofInt' w ↑b) (Bitvec.ofInt' w ↑b) =
    some (Bitvec.shl (Bitvec.ofInt' w ↑b) (Bitvec.toNat (Bitvec.ofInt' w 1)))
:=sorry

theorem bitvec_AddSub_1156_2 :
 ∀ (w b : ℕ),
  Bitvec.add? (Bitvec.ofInt' w ↑b) (Bitvec.ofInt' w ↑b) =
    some (Bitvec.shl (Bitvec.ofInt' w ↑b) (Bitvec.toNat (Bitvec.ofInt' w 1)))
:=sorry

theorem bitvec_AddSub_1156_3 :
 ∀ (w b : ℕ),
  Bitvec.add? (Bitvec.ofInt' w ↑b) (Bitvec.ofInt' w ↑b) =
    some (Bitvec.shl (Bitvec.ofInt' w ↑b) (Bitvec.toNat (Bitvec.ofInt' w 1)))
:=sorry

theorem bitvec_AddSub_1164 :
 ∀ (w a b : ℕ),
  Bitvec.add? (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w ↑a)) (Bitvec.ofInt' w ↑b) =
    some (Bitvec.sub (Bitvec.ofInt' w ↑b) (Bitvec.ofInt' w ↑a))
:=sorry

theorem bitvec_AddSub_1165 :
 ∀ (w a b : ℕ),
  Bitvec.add? (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w ↑a))
      (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w ↑b)) =
    Option.bind (Bitvec.add? (Bitvec.ofInt' w ↑a) (Bitvec.ofInt' w ↑b)) fun snd =>
      some (Bitvec.sub (Bitvec.ofInt' w 0) snd)
:=sorry

theorem bitvec_AddSub_1176 :
 ∀ (w b a : ℕ),
  Bitvec.add? (Bitvec.ofInt' w ↑a) (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w ↑b)) =
    some (Bitvec.sub (Bitvec.ofInt' w ↑a) (Bitvec.ofInt' w ↑b))
:=sorry

theorem bitvec_AddSub_1202 :
 ∀ (w x C : ℕ),
  Bitvec.add? (Bitvec.xor (Bitvec.ofInt' w ↑x) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w ↑C) =
    some (Bitvec.sub (Bitvec.sub (Bitvec.ofInt' w ↑C) (Bitvec.ofInt' w 1)) (Bitvec.ofInt' w ↑x))
:=sorry

theorem bitvec_AddSub_1295 :
 ∀ (w a b : ℕ),
  Bitvec.add? (Bitvec.and (Bitvec.ofInt' w ↑a) (Bitvec.ofInt' w ↑b))
      (Bitvec.xor (Bitvec.ofInt' w ↑a) (Bitvec.ofInt' w ↑b)) =
    some (Bitvec.or (Bitvec.ofInt' w ↑a) (Bitvec.ofInt' w ↑b))
:=sorry

theorem bitvec_AddSub_1309 :
 ∀ (w a b : ℕ),
  Bitvec.add? (Bitvec.and (Bitvec.ofInt' w ↑a) (Bitvec.ofInt' w ↑b))
      (Bitvec.or (Bitvec.ofInt' w ↑a) (Bitvec.ofInt' w ↑b)) =
    Bitvec.add? (Bitvec.ofInt' w ↑a) (Bitvec.ofInt' w ↑b)
:=sorry

theorem bitvec_AddSub_1309_2 :
 ∀ (w a b : ℕ),
  Bitvec.add? (Bitvec.and (Bitvec.ofInt' w ↑a) (Bitvec.ofInt' w ↑b))
      (Bitvec.or (Bitvec.ofInt' w ↑a) (Bitvec.ofInt' w ↑b)) =
    Bitvec.add? (Bitvec.ofInt' w ↑a) (Bitvec.ofInt' w ↑b)
:=sorry

theorem bitvec_AddSub_1309_3 :
 ∀ (w a b : ℕ),
  Bitvec.add? (Bitvec.and (Bitvec.ofInt' w ↑a) (Bitvec.ofInt' w ↑b))
      (Bitvec.or (Bitvec.ofInt' w ↑a) (Bitvec.ofInt' w ↑b)) =
    Bitvec.add? (Bitvec.ofInt' w ↑a) (Bitvec.ofInt' w ↑b)
:=sorry

theorem bitvec_AddSub_1539 :
 ∀ (w a x : ℕ),
  some (Bitvec.sub (Bitvec.ofInt' w ↑x) (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w ↑a))) =
    Bitvec.add? (Bitvec.ofInt' w ↑x) (Bitvec.ofInt' w ↑a)
:=sorry

theorem bitvec_AddSub_1539_2 :
 ∀ (w x C : ℕ),
  some (Bitvec.sub (Bitvec.ofInt' w ↑x) (Bitvec.ofInt' w ↑C)) =
    Bitvec.add? (Bitvec.ofInt' w ↑x) (Bitvec.neg (Bitvec.ofInt' w ↑C))
:=sorry

theorem bitvec_AddSub_1546 :
 ∀ (w a x : ℕ),
  some (Bitvec.sub (Bitvec.ofInt' w ↑x) (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w ↑a))) =
    Bitvec.add? (Bitvec.ofInt' w ↑x) (Bitvec.ofInt' w ↑a)
:=sorry

theorem bitvec_AddSub_1556:
 ∀ (x y : ℕ),
  some (Bitvec.sub (Bitvec.ofInt' 1 ↑x) (Bitvec.ofInt' 1 ↑y)) =
    some (Bitvec.xor (Bitvec.ofInt' 1 ↑x) (Bitvec.ofInt' 1 ↑y))
:=sorry

theorem bitvec_AddSub_1560 :
 ∀ (w a : ℕ),
  some (Bitvec.sub (Bitvec.ofInt' w (-1)) (Bitvec.ofInt' w ↑a)) =
    some (Bitvec.xor (Bitvec.ofInt' w ↑a) (Bitvec.ofInt' w (-1)))
:=sorry

theorem bitvec_AddSub_1564 :
 ∀ (w x C : ℕ),
  some (Bitvec.sub (Bitvec.ofInt' w ↑C) (Bitvec.xor (Bitvec.ofInt' w ↑x) (Bitvec.ofInt' w (-1)))) =
    Option.bind (Bitvec.add? (Bitvec.ofInt' w ↑C) (Bitvec.ofInt' w 1)) fun snd => Bitvec.add? (Bitvec.ofInt' w ↑x) snd
:=sorry

theorem bitvec_AddSub_1574 :
 ∀ (w X C2 C : ℕ),
  (Option.bind (Bitvec.add? (Bitvec.ofInt' w ↑X) (Bitvec.ofInt' w ↑C2)) fun snd =>
      some (Bitvec.sub (Bitvec.ofInt' w ↑C) snd)) =
    some (Bitvec.sub (Bitvec.sub (Bitvec.ofInt' w ↑C) (Bitvec.ofInt' w ↑C2)) (Bitvec.ofInt' w ↑X))
:=sorry

theorem bitvec_AddSub_1614 :
 ∀ (w X Y : ℕ),
  (Option.bind (Bitvec.add? (Bitvec.ofInt' w ↑X) (Bitvec.ofInt' w ↑Y)) fun snd =>
      some (Bitvec.sub (Bitvec.ofInt' w ↑X) snd)) =
    some (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w ↑Y))
:=sorry

theorem bitvec_AddSub_1619 :
 ∀ (w X Y : ℕ),
  some (Bitvec.sub (Bitvec.sub (Bitvec.ofInt' w ↑X) (Bitvec.ofInt' w ↑Y)) (Bitvec.ofInt' w ↑X)) =
    some (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w ↑Y))
:=sorry

theorem bitvec_AddSub_1624 :
 ∀ (w A B : ℕ),
  some
      (Bitvec.sub (Bitvec.or (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w ↑B))
        (Bitvec.xor (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w ↑B))) =
    some (Bitvec.and (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w ↑B))
:=sorry

theorem bitvec_AndOrXor_135 :
 ∀ (w X C1 C2 : ℕ),
  some (Bitvec.and (Bitvec.xor (Bitvec.ofInt' w ↑X) (Bitvec.ofInt' w ↑C1)) (Bitvec.ofInt' w ↑C2)) =
    some
      (Bitvec.xor (Bitvec.and (Bitvec.ofInt' w ↑X) (Bitvec.ofInt' w ↑C2))
        (Bitvec.and (Bitvec.ofInt' w ↑C1) (Bitvec.ofInt' w ↑C2)))
:=sorry

theorem bitvec_AndOrXor_144 :
 ∀ (w X C1 C2 : ℕ),
  some (Bitvec.and (Bitvec.or (Bitvec.ofInt' w ↑X) (Bitvec.ofInt' w ↑C1)) (Bitvec.ofInt' w ↑C2)) =
    some
      (Bitvec.and (Bitvec.or (Bitvec.ofInt' w ↑X) (Bitvec.and (Bitvec.ofInt' w ↑C1) (Bitvec.ofInt' w ↑C2)))
        (Bitvec.ofInt' w ↑C2))
:=sorry

theorem bitvec_AndOrXor_698:
 ∀ (a b d : ℕ),
  some
      (Bitvec.and (Bitvec.fromBool (Bitvec.and (Bitvec.ofInt' 1 ↑a) (Bitvec.ofInt' 1 ↑b) == Bitvec.ofInt' 1 0))
        (Bitvec.fromBool (Bitvec.and (Bitvec.ofInt' 1 ↑a) (Bitvec.ofInt' 1 ↑d) == Bitvec.ofInt' 1 0))) =
    some
      (Bitvec.fromBool
        (Bitvec.and (Bitvec.ofInt' 1 ↑a) (Bitvec.or (Bitvec.ofInt' 1 ↑b) (Bitvec.ofInt' 1 ↑d)) == Bitvec.ofInt' 1 0))
:=sorry

theorem bitvec_AndOrXor_709:
 ∀ (a b d : ℕ),
  some
      (Bitvec.and (Bitvec.fromBool (Bitvec.and (Bitvec.ofInt' 1 ↑a) (Bitvec.ofInt' 1 ↑b) == Bitvec.ofInt' 1 ↑b))
        (Bitvec.fromBool (Bitvec.and (Bitvec.ofInt' 1 ↑a) (Bitvec.ofInt' 1 ↑d) == Bitvec.ofInt' 1 ↑d))) =
    some
      (Bitvec.fromBool
        (Bitvec.and (Bitvec.ofInt' 1 ↑a) (Bitvec.or (Bitvec.ofInt' 1 ↑b) (Bitvec.ofInt' 1 ↑d)) ==
          Bitvec.or (Bitvec.ofInt' 1 ↑b) (Bitvec.ofInt' 1 ↑d)))
:=sorry

theorem bitvec_AndOrXor_716:
 ∀ (a b d : ℕ),
  some
      (Bitvec.and (Bitvec.fromBool (Bitvec.and (Bitvec.ofInt' 1 ↑a) (Bitvec.ofInt' 1 ↑b) == Bitvec.ofInt' 1 ↑a))
        (Bitvec.fromBool (Bitvec.and (Bitvec.ofInt' 1 ↑a) (Bitvec.ofInt' 1 ↑d) == Bitvec.ofInt' 1 ↑a))) =
    some
      (Bitvec.fromBool
        (Bitvec.and (Bitvec.ofInt' 1 ↑a) (Bitvec.and (Bitvec.ofInt' 1 ↑b) (Bitvec.ofInt' 1 ↑d)) == Bitvec.ofInt' 1 ↑a))
:=sorry

theorem bitvec_AndOrXor_794:
 ∀ (a b : ℕ),
  some
      (Bitvec.and (Bitvec.fromBool (decide (Bitvec.toInt (Bitvec.ofInt' 1 ↑b) < Bitvec.toInt (Bitvec.ofInt' 1 ↑a))))
        (Bitvec.fromBool (Bitvec.ofInt' 1 ↑a != Bitvec.ofInt' 1 ↑b))) =
    some (Bitvec.fromBool (decide (Bitvec.toInt (Bitvec.ofInt' 1 ↑b) < Bitvec.toInt (Bitvec.ofInt' 1 ↑a))))
:=sorry

theorem bitvec_AndOrXor_827:
 ∀ (a b : ℕ),
  some
      (Bitvec.and (Bitvec.fromBool (Bitvec.ofInt' 1 ↑a == Bitvec.ofInt' 1 0))
        (Bitvec.fromBool (Bitvec.ofInt' 1 ↑b == Bitvec.ofInt' 1 0))) =
    some (Bitvec.fromBool (Bitvec.or (Bitvec.ofInt' 1 ↑a) (Bitvec.ofInt' 1 ↑b) == Bitvec.ofInt' 1 0))
:=sorry

theorem bitvec_AndOrXor_887_2:
 ∀ (a C1 : ℕ),
  some
      (Bitvec.and (Bitvec.fromBool (Bitvec.ofInt' 1 ↑a == Bitvec.ofInt' 1 ↑C1))
        (Bitvec.fromBool (Bitvec.ofInt' 1 ↑a != Bitvec.ofInt' 1 ↑C1))) =
    some (false ::ᵥ Vector.nil)
:=sorry

theorem bitvec_AndOrXor_1230__ :
 ∀ (w notOp0 notOp1 : ℕ),
  some
      (Bitvec.and (Bitvec.xor (Bitvec.ofInt' w ↑notOp0) (Bitvec.ofInt' w (-1)))
        (Bitvec.xor (Bitvec.ofInt' w ↑notOp1) (Bitvec.ofInt' w (-1)))) =
    some (Bitvec.xor (Bitvec.or (Bitvec.ofInt' w ↑notOp0) (Bitvec.ofInt' w ↑notOp1)) (Bitvec.ofInt' w (-1)))
:=sorry

theorem bitvec_AndOrXor_1241_ :
 ∀ (w A B : ℕ),
  some
      (Bitvec.and (Bitvec.or (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w ↑B))
        (Bitvec.xor (Bitvec.and (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w ↑B)) (Bitvec.ofInt' w (-1)))) =
    some (Bitvec.xor (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w ↑B))
:=sorry

theorem bitvec_AndOrXor_1247_ :
 ∀ (w A B : ℕ),
  some
      (Bitvec.and (Bitvec.xor (Bitvec.and (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w ↑B)) (Bitvec.ofInt' w (-1)))
        (Bitvec.or (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w ↑B))) =
    some (Bitvec.xor (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w ↑B))
:=sorry

theorem bitvec_AndOrXor_1253_A_ :
 ∀ (w A B : ℕ),
  some (Bitvec.and (Bitvec.xor (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w ↑B)) (Bitvec.ofInt' w ↑A)) =
    some (Bitvec.and (Bitvec.ofInt' w ↑A) (Bitvec.xor (Bitvec.ofInt' w ↑B) (Bitvec.ofInt' w (-1))))
:=sorry

theorem bitvec_AndOrXor_1280_ :
 ∀ (w A B : ℕ),
  some
      (Bitvec.and (Bitvec.or (Bitvec.xor (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w ↑B))
        (Bitvec.ofInt' w ↑A)) =
    some (Bitvec.and (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w ↑B))
:=sorry

theorem bitvec_AndOrXor_1288_ :
 ∀ (w A B C : ℕ),
  some
      (Bitvec.and (Bitvec.xor (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w ↑B))
        (Bitvec.xor (Bitvec.xor (Bitvec.ofInt' w ↑B) (Bitvec.ofInt' w ↑C)) (Bitvec.ofInt' w ↑A))) =
    some
      (Bitvec.and (Bitvec.xor (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w ↑B))
        (Bitvec.xor (Bitvec.ofInt' w ↑C) (Bitvec.ofInt' w (-1))))
:=sorry

theorem bitvec_AndOrXor_1294_ :
 ∀ (w A B : ℕ),
  some
      (Bitvec.and (Bitvec.or (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w ↑B))
        (Bitvec.xor (Bitvec.xor (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w ↑B))) =
    some (Bitvec.and (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w ↑B))
:=sorry

theorem bitvec_AndOrXor_1683_1:
 ∀ (a b : ℕ),
  some
      (Bitvec.or (Bitvec.fromBool (decide (Bitvec.toNat (Bitvec.ofInt' 1 ↑b) < Bitvec.toNat (Bitvec.ofInt' 1 ↑a))))
        (Bitvec.fromBool (Bitvec.ofInt' 1 ↑a == Bitvec.ofInt' 1 ↑b))) =
    some (Bitvec.fromBool (decide (Bitvec.toNat (Bitvec.ofInt' 1 ↑b) ≤ Bitvec.toNat (Bitvec.ofInt' 1 ↑a))))
:=sorry

theorem bitvec_AndOrXor_1683_2:
 ∀ (a b : ℕ),
  some
      (Bitvec.or (Bitvec.fromBool (decide (Bitvec.toNat (Bitvec.ofInt' 1 ↑b) ≤ Bitvec.toNat (Bitvec.ofInt' 1 ↑a))))
        (Bitvec.fromBool (Bitvec.ofInt' 1 ↑a != Bitvec.ofInt' 1 ↑b))) =
    some (true ::ᵥ Vector.nil)
:=sorry

theorem bitvec_AndOrXor_1704:
 ∀ (B A : ℕ),
  some
      (Bitvec.or (Bitvec.fromBool (Bitvec.ofInt' 1 ↑B == Bitvec.ofInt' 1 0))
        (Bitvec.fromBool (decide (Bitvec.toNat (Bitvec.ofInt' 1 ↑A) < Bitvec.toNat (Bitvec.ofInt' 1 ↑B))))) =
    Option.bind (Bitvec.add? (Bitvec.ofInt' 1 ↑B) (Bitvec.ofInt' 1 (-1))) fun fst =>
      some (Bitvec.fromBool (decide (Bitvec.toNat (Bitvec.ofInt' 1 ↑A) ≤ Bitvec.toNat fst)))
:=sorry

theorem bitvec_AndOrXor_1705:
 ∀ (B A : ℕ),
  some
      (Bitvec.or (Bitvec.fromBool (Bitvec.ofInt' 1 ↑B == Bitvec.ofInt' 1 0))
        (Bitvec.fromBool (decide (Bitvec.toNat (Bitvec.ofInt' 1 ↑A) < Bitvec.toNat (Bitvec.ofInt' 1 ↑B))))) =
    Option.bind (Bitvec.add? (Bitvec.ofInt' 1 ↑B) (Bitvec.ofInt' 1 (-1))) fun fst =>
      some (Bitvec.fromBool (decide (Bitvec.toNat (Bitvec.ofInt' 1 ↑A) ≤ Bitvec.toNat fst)))
:=sorry

theorem bitvec_AndOrXor_1733:
 ∀ (A B : ℕ),
  some
      (Bitvec.or (Bitvec.fromBool (Bitvec.ofInt' 1 ↑A != Bitvec.ofInt' 1 0))
        (Bitvec.fromBool (Bitvec.ofInt' 1 ↑B != Bitvec.ofInt' 1 0))) =
    some (Bitvec.fromBool (Bitvec.or (Bitvec.ofInt' 1 ↑A) (Bitvec.ofInt' 1 ↑B) != Bitvec.ofInt' 1 0))
:=sorry

theorem bitvec_AndOrXor_2063__ :
 ∀ (w x C1 C : ℕ),
  some (Bitvec.or (Bitvec.xor (Bitvec.ofInt' w ↑x) (Bitvec.ofInt' w ↑C1)) (Bitvec.ofInt' w ↑C)) =
    some
      (Bitvec.xor (Bitvec.or (Bitvec.ofInt' w ↑x) (Bitvec.ofInt' w ↑C))
        (Bitvec.and (Bitvec.ofInt' w ↑C1) (Bitvec.not (Bitvec.ofInt' w ↑C))))
:=sorry

theorem bitvec_AndOrXor_2113___ :
 ∀ (w A B : ℕ),
  some
      (Bitvec.or (Bitvec.and (Bitvec.xor (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w ↑B))
        (Bitvec.ofInt' w ↑A)) =
    some (Bitvec.or (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w ↑B))
:=sorry

theorem bitvec_AndOrXor_2118___ :
 ∀ (w A B : ℕ),
  some
      (Bitvec.or (Bitvec.and (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w ↑B))
        (Bitvec.xor (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w (-1)))) =
    some (Bitvec.or (Bitvec.xor (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w ↑B))
:=sorry

theorem bitvec_AndOrXor_2123___ :
 ∀ (w B A : ℕ),
  some
      (Bitvec.or (Bitvec.and (Bitvec.ofInt' w ↑A) (Bitvec.xor (Bitvec.ofInt' w ↑B) (Bitvec.ofInt' w (-1))))
        (Bitvec.xor (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w ↑B))) =
    some (Bitvec.xor (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w ↑B))
:=sorry

theorem bitvec_AndOrXor_2188 :
 ∀ (w D A : ℕ),
  some
      (Bitvec.or (Bitvec.and (Bitvec.ofInt' w ↑A) (Bitvec.xor (Bitvec.ofInt' w ↑D) (Bitvec.ofInt' w (-1))))
        (Bitvec.and (Bitvec.xor (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w ↑D))) =
    some (Bitvec.xor (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w ↑D))
:=sorry

theorem bitvec_AndOrXor_2231__ :
 ∀ (w A B C : ℕ),
  some
      (Bitvec.or (Bitvec.xor (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w ↑B))
        (Bitvec.xor (Bitvec.xor (Bitvec.ofInt' w ↑B) (Bitvec.ofInt' w ↑C)) (Bitvec.ofInt' w ↑A))) =
    some (Bitvec.or (Bitvec.xor (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w ↑B)) (Bitvec.ofInt' w ↑C))
:=sorry

theorem bitvec_AndOrXor_2243__ :
 ∀ (w B C A : ℕ),
  some
      (Bitvec.or (Bitvec.and (Bitvec.or (Bitvec.ofInt' w ↑B) (Bitvec.ofInt' w ↑C)) (Bitvec.ofInt' w ↑A))
        (Bitvec.ofInt' w ↑B)) =
    some (Bitvec.or (Bitvec.ofInt' w ↑B) (Bitvec.and (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w ↑C)))
:=sorry

theorem bitvec_AndOrXor_2247__ :
 ∀ (w A B : ℕ),
  some
      (Bitvec.or (Bitvec.xor (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w (-1)))
        (Bitvec.xor (Bitvec.ofInt' w ↑B) (Bitvec.ofInt' w (-1)))) =
    some (Bitvec.xor (Bitvec.and (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w ↑B)) (Bitvec.ofInt' w (-1)))
:=sorry

theorem bitvec_AndOrXor_2263 :
 ∀ (w op0 B : ℕ),
  some (Bitvec.or (Bitvec.ofInt' w ↑op0) (Bitvec.xor (Bitvec.ofInt' w ↑op0) (Bitvec.ofInt' w ↑B))) =
    some (Bitvec.or (Bitvec.ofInt' w ↑op0) (Bitvec.ofInt' w ↑B))
:=sorry

theorem bitvec_AndOrXor_2264 :
 ∀ (w A B : ℕ),
  some
      (Bitvec.or (Bitvec.ofInt' w ↑A)
        (Bitvec.xor (Bitvec.xor (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w ↑B))) =
    some (Bitvec.or (Bitvec.ofInt' w ↑A) (Bitvec.xor (Bitvec.ofInt' w ↑B) (Bitvec.ofInt' w (-1))))
:=sorry

theorem bitvec_AndOrXor_2265 :
 ∀ (w A B : ℕ),
  some
      (Bitvec.or (Bitvec.and (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w ↑B))
        (Bitvec.xor (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w ↑B))) =
    some (Bitvec.or (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w ↑B))
:=sorry

theorem bitvec_AndOrXor_2284 :
 ∀ (w A B : ℕ),
  some
      (Bitvec.or (Bitvec.ofInt' w ↑A)
        (Bitvec.xor (Bitvec.or (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w ↑B)) (Bitvec.ofInt' w (-1)))) =
    some (Bitvec.or (Bitvec.ofInt' w ↑A) (Bitvec.xor (Bitvec.ofInt' w ↑B) (Bitvec.ofInt' w (-1))))
:=sorry

theorem bitvec_AndOrXor_2285 :
 ∀ (w A B : ℕ),
  some
      (Bitvec.or (Bitvec.ofInt' w ↑A)
        (Bitvec.xor (Bitvec.xor (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w ↑B)) (Bitvec.ofInt' w (-1)))) =
    some (Bitvec.or (Bitvec.ofInt' w ↑A) (Bitvec.xor (Bitvec.ofInt' w ↑B) (Bitvec.ofInt' w (-1))))
:=sorry

theorem bitvec_AndOrXor_2297 :
 ∀ (w A B : ℕ),
  some
      (Bitvec.or (Bitvec.and (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w ↑B))
        (Bitvec.xor (Bitvec.xor (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w ↑B))) =
    some (Bitvec.xor (Bitvec.xor (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w ↑B))
:=sorry

theorem bitvec_AndOrXor_2367 :
 ∀ (w A C1 op1 : ℕ),
  some (Bitvec.or (Bitvec.or (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w ↑C1)) (Bitvec.ofInt' w ↑op1)) =
    some (Bitvec.or (Bitvec.or (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w ↑op1)) (Bitvec.ofInt' w ↑C1))
:=sorry

theorem bitvec_AndOrXor_2375 :
 ∀ (w x A B C D : ℕ),
  some
      (Bitvec.or (Bitvec.select (Bitvec.ofInt' 1 ↑x) (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w ↑B))
        (Bitvec.select (Bitvec.ofInt' 1 ↑x) (Bitvec.ofInt' w ↑C) (Bitvec.ofInt' w ↑D))) =
    some
      (Bitvec.select (Bitvec.ofInt' 1 ↑x) (Bitvec.or (Bitvec.ofInt' w ↑A) (Bitvec.ofInt' w ↑C))
        (Bitvec.or (Bitvec.ofInt' w ↑B) (Bitvec.ofInt' w ↑D)))
:=sorry

theorem bitvec_AndOrXor_2416 :
 ∀ (w nx y : ℕ),
  some
      (Bitvec.xor (Bitvec.and (Bitvec.xor (Bitvec.ofInt' w ↑nx) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w ↑y))
        (Bitvec.ofInt' w (-1))) =
    some (Bitvec.or (Bitvec.ofInt' w ↑nx) (Bitvec.xor (Bitvec.ofInt' w ↑y) (Bitvec.ofInt' w (-1))))
:=sorry

theorem bitvec_AndOrXor_2417 :
 ∀ (w nx y : ℕ),
  some
      (Bitvec.xor (Bitvec.or (Bitvec.xor (Bitvec.ofInt' w ↑nx) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w ↑y))
        (Bitvec.ofInt' w (-1))) =
    some (Bitvec.and (Bitvec.ofInt' w ↑nx) (Bitvec.xor (Bitvec.ofInt' w ↑y) (Bitvec.ofInt' w (-1))))
:=sorry

theorem bitvec_AndOrXor_2429 :
 ∀ (w x y : ℕ),
  some (Bitvec.xor (Bitvec.and (Bitvec.ofInt' w ↑x) (Bitvec.ofInt' w ↑y)) (Bitvec.ofInt' w (-1))) =
    some
      (Bitvec.or (Bitvec.xor (Bitvec.ofInt' w ↑x) (Bitvec.ofInt' w (-1)))
        (Bitvec.xor (Bitvec.ofInt' w ↑y) (Bitvec.ofInt' w (-1))))
:=sorry

theorem bitvec_AndOrXor_2430 :
 ∀ (w x y : ℕ),
  some (Bitvec.xor (Bitvec.or (Bitvec.ofInt' w ↑x) (Bitvec.ofInt' w ↑y)) (Bitvec.ofInt' w (-1))) =
    some
      (Bitvec.and (Bitvec.xor (Bitvec.ofInt' w ↑x) (Bitvec.ofInt' w (-1)))
        (Bitvec.xor (Bitvec.ofInt' w ↑y) (Bitvec.ofInt' w (-1))))
:=sorry

theorem bitvec_AndOrXor_2443 :
 ∀ (w x y : ℕ),
  some
      (Bitvec.xor
        (Bitvec.sshr (Bitvec.xor (Bitvec.ofInt' w ↑x) (Bitvec.ofInt' w (-1))) (Bitvec.toNat (Bitvec.ofInt' w ↑y)))
        (Bitvec.ofInt' w (-1))) =
    some (Bitvec.sshr (Bitvec.ofInt' w ↑x) (Bitvec.toNat (Bitvec.ofInt' w ↑y)))
:=sorry

theorem bitvec_AndOrXor_2453:
 ∀ (x y : ℕ),
  some
      (Bitvec.xor (Bitvec.fromBool (decide (Bitvec.toInt (Bitvec.ofInt' 1 ↑x) < Bitvec.toInt (Bitvec.ofInt' 1 ↑y))))
        (Bitvec.ofInt' 1 (-1))) =
    some (Bitvec.fromBool (decide (Bitvec.toInt (Bitvec.ofInt' 1 ↑y) ≤ Bitvec.toInt (Bitvec.ofInt' 1 ↑x))))
:=sorry

theorem bitvec_AndOrXor_2475 :
 ∀ (w C x : ℕ),
  some (Bitvec.xor (Bitvec.sub (Bitvec.ofInt' w ↑C) (Bitvec.ofInt' w ↑x)) (Bitvec.ofInt' w (-1))) =
    Bitvec.add? (Bitvec.ofInt' w ↑x) (Bitvec.sub (Bitvec.ofInt' w (-1)) (Bitvec.ofInt' w ↑C))
:=sorry

theorem bitvec_AndOrXor_2486 :
 ∀ (w x C : ℕ),
  (Option.bind (Bitvec.add? (Bitvec.ofInt' w ↑x) (Bitvec.ofInt' w ↑C)) fun fst =>
      some (Bitvec.xor fst (Bitvec.ofInt' w (-1)))) =
    some (Bitvec.sub (Bitvec.sub (Bitvec.ofInt' w (-1)) (Bitvec.ofInt' w ↑C)) (Bitvec.ofInt' w ↑x))
:=sorry

theorem bitvec_AndOrXor_2581__ :
 ∀ (w a op1 : ℕ),
  some (Bitvec.xor (Bitvec.or (Bitvec.ofInt' w ↑a) (Bitvec.ofInt' w ↑op1)) (Bitvec.ofInt' w ↑op1)) =
    some (Bitvec.and (Bitvec.ofInt' w ↑a) (Bitvec.xor (Bitvec.ofInt' w ↑op1) (Bitvec.ofInt' w (-1))))
:=sorry

theorem bitvec_AndOrXor_2587__ :
 ∀ (w a op1 : ℕ),
  some (Bitvec.xor (Bitvec.and (Bitvec.ofInt' w ↑a) (Bitvec.ofInt' w ↑op1)) (Bitvec.ofInt' w ↑op1)) =
    some (Bitvec.and (Bitvec.xor (Bitvec.ofInt' w ↑a) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w ↑op1))
:=sorry

theorem bitvec_AndOrXor_2595 :
 ∀ (w a b : ℕ),
  some
      (Bitvec.xor (Bitvec.and (Bitvec.ofInt' w ↑a) (Bitvec.ofInt' w ↑b))
        (Bitvec.or (Bitvec.ofInt' w ↑a) (Bitvec.ofInt' w ↑b))) =
    some (Bitvec.xor (Bitvec.ofInt' w ↑a) (Bitvec.ofInt' w ↑b))
:=sorry

theorem bitvec_AndOrXor_2607 :
 ∀ (w a b : ℕ),
  some
      (Bitvec.xor (Bitvec.or (Bitvec.ofInt' w ↑a) (Bitvec.xor (Bitvec.ofInt' w ↑b) (Bitvec.ofInt' w (-1))))
        (Bitvec.or (Bitvec.xor (Bitvec.ofInt' w ↑a) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w ↑b))) =
    some (Bitvec.xor (Bitvec.ofInt' w ↑a) (Bitvec.ofInt' w ↑b))
:=sorry

theorem bitvec_AndOrXor_2617 :
 ∀ (w a b : ℕ),
  some
      (Bitvec.xor (Bitvec.and (Bitvec.ofInt' w ↑a) (Bitvec.xor (Bitvec.ofInt' w ↑b) (Bitvec.ofInt' w (-1))))
        (Bitvec.and (Bitvec.xor (Bitvec.ofInt' w ↑a) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w ↑b))) =
    some (Bitvec.xor (Bitvec.ofInt' w ↑a) (Bitvec.ofInt' w ↑b))
:=sorry

theorem bitvec_AndOrXor_2627 :
 ∀ (w a c b : ℕ),
  some
      (Bitvec.xor (Bitvec.xor (Bitvec.ofInt' w ↑a) (Bitvec.ofInt' w ↑c))
        (Bitvec.or (Bitvec.ofInt' w ↑a) (Bitvec.ofInt' w ↑b))) =
    some
      (Bitvec.xor (Bitvec.and (Bitvec.xor (Bitvec.ofInt' w ↑a) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w ↑b))
        (Bitvec.ofInt' w ↑c))
:=sorry

theorem bitvec_AndOrXor_2647 :
 ∀ (w a b : ℕ),
  some
      (Bitvec.xor (Bitvec.and (Bitvec.ofInt' w ↑a) (Bitvec.ofInt' w ↑b))
        (Bitvec.xor (Bitvec.ofInt' w ↑a) (Bitvec.ofInt' w ↑b))) =
    some (Bitvec.or (Bitvec.ofInt' w ↑a) (Bitvec.ofInt' w ↑b))
:=sorry

theorem bitvec_AndOrXor_2658 :
 ∀ (w b a : ℕ),
  some
      (Bitvec.xor (Bitvec.and (Bitvec.ofInt' w ↑a) (Bitvec.xor (Bitvec.ofInt' w ↑b) (Bitvec.ofInt' w (-1))))
        (Bitvec.xor (Bitvec.ofInt' w ↑a) (Bitvec.ofInt' w (-1)))) =
    some (Bitvec.xor (Bitvec.and (Bitvec.ofInt' w ↑a) (Bitvec.ofInt' w ↑b)) (Bitvec.ofInt' w (-1)))
:=sorry

theorem bitvec_AndOrXor_2663:
 ∀ (a b : ℕ),
  some
      (Bitvec.xor (Bitvec.fromBool (decide (Bitvec.toNat (Bitvec.ofInt' 1 ↑a) ≤ Bitvec.toNat (Bitvec.ofInt' 1 ↑b))))
        (Bitvec.fromBool (Bitvec.ofInt' 1 ↑a != Bitvec.ofInt' 1 ↑b))) =
    some (Bitvec.fromBool (decide (Bitvec.toNat (Bitvec.ofInt' 1 ↑b) ≤ Bitvec.toNat (Bitvec.ofInt' 1 ↑a))))
:=sorry

theorem bitvec_152 :
 ∀ (w x : ℕ),
  Bitvec.mul? (Bitvec.ofInt' w ↑x) (Bitvec.ofInt' w (-1)) = some (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w ↑x))
:=sorry

theorem bitvec_229 :
 ∀ (w X C1 Op1 : ℕ),
  (Option.bind (Bitvec.add? (Bitvec.ofInt' w ↑X) (Bitvec.ofInt' w ↑C1)) fun fst =>
      Bitvec.mul? fst (Bitvec.ofInt' w ↑Op1)) =
    Option.bind (Bitvec.mul? (Bitvec.ofInt' w ↑X) (Bitvec.ofInt' w ↑Op1)) fun fst =>
      Option.bind (Bitvec.mul? (Bitvec.ofInt' w ↑C1) (Bitvec.ofInt' w ↑Op1)) fun snd => Bitvec.add? fst snd
:=sorry

theorem bitvec_239 :
 ∀ (w X Y : ℕ),
  Bitvec.mul? (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w ↑X))
      (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w ↑Y)) =
    Bitvec.mul? (Bitvec.ofInt' w ↑X) (Bitvec.ofInt' w ↑Y)
:=sorry

theorem bitvec_265 :
 ∀ (w X Y : ℕ),
  (Option.bind (Bitvec.udiv? (Bitvec.ofInt' w ↑X) (Bitvec.ofInt' w ↑Y)) fun fst =>
      Bitvec.mul? fst (Bitvec.ofInt' w ↑Y)) =
    some (Bitvec.ofInt' w ↑X)
:=sorry

theorem bitvec_265_2 :
 ∀ (w X Y : ℕ),
  (Option.bind (Bitvec.sdiv? (Bitvec.ofInt' w ↑X) (Bitvec.ofInt' w ↑Y)) fun fst =>
      Bitvec.mul? fst (Bitvec.ofInt' w ↑Y)) =
    some (Bitvec.ofInt' w ↑X)
:=sorry

theorem bitvec_266 :
 ∀ (w X Y : ℕ),
  (Option.bind (Bitvec.udiv? (Bitvec.ofInt' w ↑X) (Bitvec.ofInt' w ↑Y)) fun fst =>
      Bitvec.mul? fst (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w ↑Y))) =
    some (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w ↑X))
:=sorry

theorem bitvec_266_2 :
 ∀ (w X Y : ℕ),
  (Option.bind (Bitvec.sdiv? (Bitvec.ofInt' w ↑X) (Bitvec.ofInt' w ↑Y)) fun fst =>
      Bitvec.mul? fst (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w ↑Y))) =
    some (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w ↑X))
:=sorry

theorem bitvec_283:
 ∀ (X Y : ℕ),
  Bitvec.mul? (Bitvec.ofInt' 1 ↑X) (Bitvec.ofInt' 1 ↑Y) = some (Bitvec.and (Bitvec.ofInt' 1 ↑X) (Bitvec.ofInt' 1 ↑Y))
:=sorry

theorem bitvec_290_ :
 ∀ (w Y Op1 : ℕ),
  Bitvec.mul? (Bitvec.shl (Bitvec.ofInt' w 1) (Bitvec.toNat (Bitvec.ofInt' w ↑Y))) (Bitvec.ofInt' w ↑Op1) =
    some (Bitvec.shl (Bitvec.ofInt' w ↑Op1) (Bitvec.toNat (Bitvec.ofInt' w ↑Y)))
:=sorry

theorem bitvec_SimplifyDivRemOfSelect :
 ∀ (w c Y X : ℕ),
  Bitvec.udiv? (Bitvec.ofInt' w ↑X) (Bitvec.select (Bitvec.ofInt' 1 ↑c) (Bitvec.ofInt' w ↑Y) (Bitvec.ofInt' w 0)) =
    Bitvec.udiv? (Bitvec.ofInt' w ↑X) (Bitvec.ofInt' w ↑Y)
:=sorry

theorem bitvec_1030 :
 ∀ (w X : ℕ),
  Bitvec.sdiv? (Bitvec.ofInt' w ↑X) (Bitvec.ofInt' w (-1)) = some (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w ↑X))
:=sorry

theorem bitvec_Select_846:
 ∀ (B C : ℕ),
  some (Bitvec.select (Bitvec.ofInt' 1 ↑B) (true ::ᵥ Vector.nil) (Bitvec.ofInt' 1 ↑C)) =
    some (Bitvec.or (Bitvec.ofInt' 1 ↑B) (Bitvec.ofInt' 1 ↑C))
:=sorry

theorem bitvec_Select_850:
 ∀ (B C : ℕ),
  some (Bitvec.select (Bitvec.ofInt' 1 ↑B) (false ::ᵥ Vector.nil) (Bitvec.ofInt' 1 ↑C)) =
    some (Bitvec.and (Bitvec.xor (Bitvec.ofInt' 1 ↑B) (true ::ᵥ Vector.nil)) (Bitvec.ofInt' 1 ↑C))
:=sorry

theorem bitvec_Select_855:
 ∀ (B C : ℕ),
  some (Bitvec.select (Bitvec.ofInt' 1 ↑B) (Bitvec.ofInt' 1 ↑C) (false ::ᵥ Vector.nil)) =
    some (Bitvec.and (Bitvec.ofInt' 1 ↑B) (Bitvec.ofInt' 1 ↑C))
:=sorry

theorem bitvec_Select_859:
 ∀ (B C : ℕ),
  some (Bitvec.select (Bitvec.ofInt' 1 ↑B) (Bitvec.ofInt' 1 ↑C) (true ::ᵥ Vector.nil)) =
    some (Bitvec.or (Bitvec.xor (Bitvec.ofInt' 1 ↑B) (true ::ᵥ Vector.nil)) (Bitvec.ofInt' 1 ↑C))
:=sorry

theorem bitvec_Select_851:
 ∀ (a b : ℕ),
  some (Bitvec.select (Bitvec.ofInt' 1 ↑a) (Bitvec.ofInt' 1 ↑b) (Bitvec.ofInt' 1 ↑a)) =
    some (Bitvec.and (Bitvec.ofInt' 1 ↑a) (Bitvec.ofInt' 1 ↑b))
:=sorry

theorem bitvec_Select_852:
 ∀ (a b : ℕ),
  some (Bitvec.select (Bitvec.ofInt' 1 ↑a) (Bitvec.ofInt' 1 ↑a) (Bitvec.ofInt' 1 ↑b)) =
    some (Bitvec.or (Bitvec.ofInt' 1 ↑a) (Bitvec.ofInt' 1 ↑b))
:=sorry

theorem bitvec_Select_962 :
 ∀ (w x y z c : ℕ),
  (Option.bind (Bitvec.add? (Bitvec.ofInt' w ↑x) (Bitvec.ofInt' w ↑y)) fun __do_lift =>
      Option.bind (Bitvec.add? (Bitvec.ofInt' w ↑x) (Bitvec.ofInt' w ↑z)) fun __do_lift_1 =>
        some (Bitvec.select (Bitvec.ofInt' 1 ↑c) __do_lift __do_lift_1)) =
    Bitvec.add? (Bitvec.ofInt' w ↑x) (Bitvec.select (Bitvec.ofInt' 1 ↑c) (Bitvec.ofInt' w ↑y) (Bitvec.ofInt' w ↑z))
:=sorry

theorem bitvec_Select_1070 :
 ∀ (w c W Z Y : ℕ),
  some
      (Bitvec.select (Bitvec.ofInt' 1 ↑c) (Bitvec.select (Bitvec.ofInt' 1 ↑c) (Bitvec.ofInt' w ↑W) (Bitvec.ofInt' w ↑Z))
        (Bitvec.ofInt' w ↑Y)) =
    some (Bitvec.select (Bitvec.ofInt' 1 ↑c) (Bitvec.ofInt' w ↑W) (Bitvec.ofInt' w ↑Y))
:=sorry

theorem bitvec_Select_1078 :
 ∀ (w c W Z X : ℕ),
  some
      (Bitvec.select (Bitvec.ofInt' 1 ↑c) (Bitvec.ofInt' w ↑X)
        (Bitvec.select (Bitvec.ofInt' 1 ↑c) (Bitvec.ofInt' w ↑W) (Bitvec.ofInt' w ↑Z))) =
    some (Bitvec.select (Bitvec.ofInt' 1 ↑c) (Bitvec.ofInt' w ↑X) (Bitvec.ofInt' w ↑Z))
:=sorry

theorem bitvec_Select_1100 :
 ∀ (w X Y : ℕ),
  some (Bitvec.select (true ::ᵥ Vector.nil) (Bitvec.ofInt' w ↑X) (Bitvec.ofInt' w ↑Y)) = some (Bitvec.ofInt' w ↑X)
:=sorry

theorem bitvec_Select_1105 :
 ∀ (w X Y : ℕ),
  some (Bitvec.select (false ::ᵥ Vector.nil) (Bitvec.ofInt' w ↑X) (Bitvec.ofInt' w ↑Y)) = some (Bitvec.ofInt' w ↑Y)
:=sorry

theorem bitvec_InstCombineShift__239 :
 ∀ (w X C : ℕ),
  some
      (Bitvec.ushr (Bitvec.shl (Bitvec.ofInt' w ↑X) (Bitvec.toNat (Bitvec.ofInt' w ↑C)))
        (Bitvec.toNat (Bitvec.ofInt' w ↑C))) =
    some (Bitvec.and (Bitvec.ofInt' w ↑X) (Bitvec.ushr (Bitvec.ofInt' w (-1)) (Bitvec.toNat (Bitvec.ofInt' w ↑C))))
:=sorry

theorem bitvec_InstCombineShift__279 :
 ∀ (w X C : ℕ),
  some
      (Bitvec.shl (Bitvec.ushr (Bitvec.ofInt' w ↑X) (Bitvec.toNat (Bitvec.ofInt' w ↑C)))
        (Bitvec.toNat (Bitvec.ofInt' w ↑C))) =
    some (Bitvec.and (Bitvec.ofInt' w ↑X) (Bitvec.shl (Bitvec.ofInt' w (-1)) (Bitvec.toNat (Bitvec.ofInt' w ↑C))))
:=sorry

theorem bitvec_InstCombineShift__440 :
 ∀ (w X C C2 Y : ℕ),
  some
      (Bitvec.shl
        (Bitvec.xor (Bitvec.ofInt' w ↑Y)
          (Bitvec.and (Bitvec.ushr (Bitvec.ofInt' w ↑X) (Bitvec.toNat (Bitvec.ofInt' w ↑C))) (Bitvec.ofInt' w ↑C2)))
        (Bitvec.toNat (Bitvec.ofInt' w ↑C))) =
    some
      (Bitvec.xor
        (Bitvec.and (Bitvec.ofInt' w ↑X) (Bitvec.shl (Bitvec.ofInt' w ↑C2) (Bitvec.toNat (Bitvec.ofInt' w ↑C))))
        (Bitvec.shl (Bitvec.ofInt' w ↑Y) (Bitvec.toNat (Bitvec.ofInt' w ↑C))))
:=sorry

theorem bitvec_InstCombineShift__476 :
 ∀ (w X C C2 Y : ℕ),
  some
      (Bitvec.shl
        (Bitvec.or
          (Bitvec.and (Bitvec.ushr (Bitvec.ofInt' w ↑X) (Bitvec.toNat (Bitvec.ofInt' w ↑C))) (Bitvec.ofInt' w ↑C2))
          (Bitvec.ofInt' w ↑Y))
        (Bitvec.toNat (Bitvec.ofInt' w ↑C))) =
    some
      (Bitvec.or
        (Bitvec.and (Bitvec.ofInt' w ↑X) (Bitvec.shl (Bitvec.ofInt' w ↑C2) (Bitvec.toNat (Bitvec.ofInt' w ↑C))))
        (Bitvec.shl (Bitvec.ofInt' w ↑Y) (Bitvec.toNat (Bitvec.ofInt' w ↑C))))
:=sorry

theorem bitvec_InstCombineShift__497 :
 ∀ (w X C2 C : ℕ),
  some (Bitvec.ushr (Bitvec.xor (Bitvec.ofInt' w ↑X) (Bitvec.ofInt' w ↑C2)) (Bitvec.toNat (Bitvec.ofInt' w ↑C))) =
    some
      (Bitvec.xor (Bitvec.ushr (Bitvec.ofInt' w ↑X) (Bitvec.toNat (Bitvec.ofInt' w ↑C)))
        (Bitvec.ushr (Bitvec.ofInt' w ↑C2) (Bitvec.toNat (Bitvec.ofInt' w ↑C))))
:=sorry

theorem bitvec_InstCombineShift__497' :
 ∀ (w X C2 C : ℕ),
  (Option.bind (Bitvec.add? (Bitvec.ofInt' w ↑X) (Bitvec.ofInt' w ↑C2)) fun fst =>
      some (Bitvec.shl fst (Bitvec.toNat (Bitvec.ofInt' w ↑C)))) =
    Bitvec.add? (Bitvec.shl (Bitvec.ofInt' w ↑X) (Bitvec.toNat (Bitvec.ofInt' w ↑C)))
      (Bitvec.shl (Bitvec.ofInt' w ↑C2) (Bitvec.toNat (Bitvec.ofInt' w ↑C)))
:=sorry

theorem bitvec_InstCombineShift__582 :
 ∀ (w X C : ℕ),
  some
      (Bitvec.ushr (Bitvec.shl (Bitvec.ofInt' w ↑X) (Bitvec.toNat (Bitvec.ofInt' w ↑C)))
        (Bitvec.toNat (Bitvec.ofInt' w ↑C))) =
    some (Bitvec.and (Bitvec.ofInt' w ↑X) (Bitvec.ushr (Bitvec.ofInt' w (-1)) (Bitvec.toNat (Bitvec.ofInt' w ↑C))))
:=sorry