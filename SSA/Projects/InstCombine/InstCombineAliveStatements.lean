import SSA.Projects.InstCombine.ForMathlib

def statement1 : (Option.bind
      (Bitvec.add? (Bitvec.xor (Bitvec.and (Bitvec.ofInt' w Z') (Bitvec.ofInt' w C1)) (Bitvec.ofInt' w C1))
        (Bitvec.ofInt' w 1))
      fun fst => Bitvec.add? fst (Bitvec.ofInt' w RHS')) ⊑
    some (Bitvec.sub (Bitvec.ofInt' w RHS') (Bitvec.or (Bitvec.ofInt' w Z') (Bitvec.not (Bitvec.ofInt' w C0))))
    := sorry

def statement2 :  Bitvec.add? (Bitvec.ofInt' w x) (Bitvec.ofInt' w y) ⊑
    some (Bitvec.xor (Bitvec.ofInt' w x) (Bitvec.ofInt' w y))
    := sorry

def statement3 :  Bitvec.add? (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w a)) (Bitvec.ofInt' w b) ⊑
    some (Bitvec.sub (Bitvec.ofInt' w b) (Bitvec.ofInt' w a))
    := sorry

def statement4 :  Bitvec.add? (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w a))
      (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w b)) ⊑
    Option.bind (Bitvec.add? (Bitvec.ofInt' w a) (Bitvec.ofInt' w b)) fun snd =>
      some (Bitvec.sub (Bitvec.ofInt' w 0) snd)
    := sorry

def statement5 :  Bitvec.add? (Bitvec.ofInt' w a) (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w b)) ⊑
    some (Bitvec.sub (Bitvec.ofInt' w a) (Bitvec.ofInt' w b))
    := sorry

def statement6 :  Bitvec.add? (Bitvec.and (Bitvec.ofInt' w a) (Bitvec.ofInt' w b))
      (Bitvec.xor (Bitvec.ofInt' w a) (Bitvec.ofInt' w b)) ⊑
    some (Bitvec.or (Bitvec.ofInt' w a) (Bitvec.ofInt' w b))
    := sorry

def statement7 :  Bitvec.add? (Bitvec.and (Bitvec.ofInt' w a) (Bitvec.ofInt' w b))
      (Bitvec.or (Bitvec.ofInt' w a) (Bitvec.ofInt' w b)) ⊑
    Bitvec.add? (Bitvec.ofInt' w a) (Bitvec.ofInt' w b)
    := sorry

def statement8 :  Bitvec.add? (Bitvec.and (Bitvec.ofInt' w a) (Bitvec.ofInt' w b))
      (Bitvec.or (Bitvec.ofInt' w a) (Bitvec.ofInt' w b)) ⊑
    Bitvec.add? (Bitvec.ofInt' w a) (Bitvec.ofInt' w b)
    := sorry

def statement9 :  Bitvec.add? (Bitvec.and (Bitvec.ofInt' w a) (Bitvec.ofInt' w b))
      (Bitvec.or (Bitvec.ofInt' w a) (Bitvec.ofInt' w b)) ⊑
    Bitvec.add? (Bitvec.ofInt' w a) (Bitvec.ofInt' w b)
    := sorry

def statement10 :  some (Bitvec.sub (Bitvec.ofInt' w x) (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w a))) ⊑
    Bitvec.add? (Bitvec.ofInt' w x) (Bitvec.ofInt' w a)
    := sorry

def statement11 :  some (Bitvec.sub (Bitvec.ofInt' w x) (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w a))) ⊑
    Bitvec.add? (Bitvec.ofInt' w x) (Bitvec.ofInt' w a)
    := sorry

def statement12 :  some (Bitvec.sub (Bitvec.ofInt' w x) (Bitvec.ofInt' w y)) ⊑
    some (Bitvec.xor (Bitvec.ofInt' w x) (Bitvec.ofInt' w y))
    := sorry

def statement13 :  some (Bitvec.sub (Bitvec.ofInt' w (-1)) (Bitvec.ofInt' w a)) ⊑
    some (Bitvec.xor (Bitvec.ofInt' w a) (Bitvec.ofInt' w (-1)))
    := sorry

def statement14 :  (Option.bind (Bitvec.add? (Bitvec.ofInt' w X) (Bitvec.ofInt' w Y)) fun snd =>
      some (Bitvec.sub (Bitvec.ofInt' w X) snd)) ⊑
    some (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w Y))
    := sorry

def statement15 :  some (Bitvec.sub (Bitvec.sub (Bitvec.ofInt' w X) (Bitvec.ofInt' w Y)) (Bitvec.ofInt' w X)) ⊑
    some (Bitvec.sub (Bitvec.ofInt' w 0) (Bitvec.ofInt' w Y))
    := sorry

def statement16 :  some
      (Bitvec.sub (Bitvec.or (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))
        (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))) ⊑
    some (Bitvec.and (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))
    := sorry

def statement17 :  some
      (Bitvec.and (Bitvec.xor (Bitvec.ofInt' w notOp0) (Bitvec.ofInt' w (-1)))
        (Bitvec.xor (Bitvec.ofInt' w notOp1) (Bitvec.ofInt' w (-1)))) ⊑
    some (Bitvec.xor (Bitvec.or (Bitvec.ofInt' w notOp0) (Bitvec.ofInt' w notOp1)) (Bitvec.ofInt' w (-1)))
    := sorry

def statement18 :  some
      (Bitvec.and (Bitvec.or (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))
        (Bitvec.xor (Bitvec.and (Bitvec.ofInt' w A) (Bitvec.ofInt' w B)) (Bitvec.ofInt' w (-1)))) ⊑
    some (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))
    := sorry

def statement19 :  some
      (Bitvec.and (Bitvec.xor (Bitvec.and (Bitvec.ofInt' w A) (Bitvec.ofInt' w B)) (Bitvec.ofInt' w (-1)))
        (Bitvec.or (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))) ⊑
    some (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))
    := sorry

def statement20 :  some (Bitvec.and (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w B)) (Bitvec.ofInt' w A)) ⊑
    some (Bitvec.and (Bitvec.ofInt' w A) (Bitvec.xor (Bitvec.ofInt' w B) (Bitvec.ofInt' w (-1))))
    := sorry

def statement21 :  some
      (Bitvec.and (Bitvec.or (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w B))
        (Bitvec.ofInt' w A)) ⊑
    some (Bitvec.and (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))
    := sorry

def statement22 :  some
      (Bitvec.and (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))
        (Bitvec.xor (Bitvec.xor (Bitvec.ofInt' w B) (Bitvec.ofInt' w C)) (Bitvec.ofInt' w A))) ⊑
    some
      (Bitvec.and (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))
        (Bitvec.xor (Bitvec.ofInt' w C) (Bitvec.ofInt' w (-1))))
    := sorry

def statement23 :  some
      (Bitvec.and (Bitvec.or (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))
        (Bitvec.xor (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w B))) ⊑
    some (Bitvec.and (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))
    := sorry

def statement24 :  some
      (Bitvec.or (Bitvec.and (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w B))
        (Bitvec.ofInt' w A)) ⊑
    some (Bitvec.or (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))
    := sorry

def statement25 :  some
      (Bitvec.or (Bitvec.and (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))
        (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w (-1)))) ⊑
    some (Bitvec.or (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w B))
    := sorry

def statement26 :  some
      (Bitvec.or (Bitvec.and (Bitvec.ofInt' w A) (Bitvec.xor (Bitvec.ofInt' w B) (Bitvec.ofInt' w (-1))))
        (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))) ⊑
    some (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))
    := sorry

def statement27 :  some
      (Bitvec.or (Bitvec.and (Bitvec.ofInt' w A) (Bitvec.xor (Bitvec.ofInt' w D) (Bitvec.ofInt' w (-1))))
        (Bitvec.and (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w D))) ⊑
    some (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w D))
    := sorry

def statement28 :  some
      (Bitvec.or (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))
        (Bitvec.xor (Bitvec.xor (Bitvec.ofInt' w B) (Bitvec.ofInt' w C)) (Bitvec.ofInt' w A))) ⊑
    some (Bitvec.or (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w B)) (Bitvec.ofInt' w C))
    := sorry

def statement29 :  some
      (Bitvec.or (Bitvec.and (Bitvec.or (Bitvec.ofInt' w B) (Bitvec.ofInt' w C)) (Bitvec.ofInt' w A))
        (Bitvec.ofInt' w B)) ⊑
    some (Bitvec.or (Bitvec.ofInt' w B) (Bitvec.and (Bitvec.ofInt' w A) (Bitvec.ofInt' w C)))
    := sorry

def statement30 :  some
      (Bitvec.or (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w (-1)))
        (Bitvec.xor (Bitvec.ofInt' w B) (Bitvec.ofInt' w (-1)))) ⊑
    some (Bitvec.xor (Bitvec.and (Bitvec.ofInt' w A) (Bitvec.ofInt' w B)) (Bitvec.ofInt' w (-1)))
    := sorry

def statement31 :  some (Bitvec.or (Bitvec.ofInt' w op0) (Bitvec.xor (Bitvec.ofInt' w op0) (Bitvec.ofInt' w B))) ⊑
    some (Bitvec.or (Bitvec.ofInt' w op0) (Bitvec.ofInt' w B))
    := sorry

def statement32 :  some
      (Bitvec.or (Bitvec.ofInt' w A)
        (Bitvec.xor (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w B))) ⊑
    some (Bitvec.or (Bitvec.ofInt' w A) (Bitvec.xor (Bitvec.ofInt' w B) (Bitvec.ofInt' w (-1))))
    := sorry

def statement33 :  some
      (Bitvec.or (Bitvec.and (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))
        (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))) ⊑
    some (Bitvec.or (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))
    := sorry

def statement34 :  some
      (Bitvec.or (Bitvec.ofInt' w A)
        (Bitvec.xor (Bitvec.or (Bitvec.ofInt' w A) (Bitvec.ofInt' w B)) (Bitvec.ofInt' w (-1)))) ⊑
    some (Bitvec.or (Bitvec.ofInt' w A) (Bitvec.xor (Bitvec.ofInt' w B) (Bitvec.ofInt' w (-1))))
    := sorry

def statement35 :  some
      (Bitvec.or (Bitvec.ofInt' w A)
        (Bitvec.xor (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w B)) (Bitvec.ofInt' w (-1)))) ⊑
    some (Bitvec.or (Bitvec.ofInt' w A) (Bitvec.xor (Bitvec.ofInt' w B) (Bitvec.ofInt' w (-1))))
    := sorry

def statement36 :  some
      (Bitvec.or (Bitvec.and (Bitvec.ofInt' w A) (Bitvec.ofInt' w B))
        (Bitvec.xor (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w B))) ⊑
    some (Bitvec.xor (Bitvec.xor (Bitvec.ofInt' w A) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w B))
    := sorry

def statement37 :  some (Bitvec.or (Bitvec.or (Bitvec.ofInt' w A) (Bitvec.ofInt' w C1)) (Bitvec.ofInt' w op1)) ⊑
    some (Bitvec.or (Bitvec.or (Bitvec.ofInt' w A) (Bitvec.ofInt' w op1)) (Bitvec.ofInt' w C1))
    := sorry

def statement38 :  some
      (Bitvec.xor (Bitvec.and (Bitvec.xor (Bitvec.ofInt' w nx) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w y))
        (Bitvec.ofInt' w (-1))) ⊑
    some (Bitvec.or (Bitvec.ofInt' w nx) (Bitvec.xor (Bitvec.ofInt' w y) (Bitvec.ofInt' w (-1))))
    := sorry

def statement39 :  some
      (Bitvec.xor (Bitvec.or (Bitvec.xor (Bitvec.ofInt' w nx) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w y))
        (Bitvec.ofInt' w (-1))) ⊑
    some (Bitvec.and (Bitvec.ofInt' w nx) (Bitvec.xor (Bitvec.ofInt' w y) (Bitvec.ofInt' w (-1))))
    := sorry

def statement40 :  some (Bitvec.xor (Bitvec.and (Bitvec.ofInt' w x) (Bitvec.ofInt' w y)) (Bitvec.ofInt' w (-1))) ⊑
    some
      (Bitvec.or (Bitvec.xor (Bitvec.ofInt' w x) (Bitvec.ofInt' w (-1)))
        (Bitvec.xor (Bitvec.ofInt' w y) (Bitvec.ofInt' w (-1))))
    := sorry

def statement41 :  some (Bitvec.xor (Bitvec.or (Bitvec.ofInt' w x) (Bitvec.ofInt' w y)) (Bitvec.ofInt' w (-1))) ⊑
    some
      (Bitvec.and (Bitvec.xor (Bitvec.ofInt' w x) (Bitvec.ofInt' w (-1)))
        (Bitvec.xor (Bitvec.ofInt' w y) (Bitvec.ofInt' w (-1))))
    := sorry

def statement42 :  some (Bitvec.xor (Bitvec.or (Bitvec.ofInt' w a) (Bitvec.ofInt' w op1)) (Bitvec.ofInt' w op1)) ⊑
    some (Bitvec.and (Bitvec.ofInt' w a) (Bitvec.xor (Bitvec.ofInt' w op1) (Bitvec.ofInt' w (-1))))
    := sorry

def statement43 :  some (Bitvec.xor (Bitvec.and (Bitvec.ofInt' w a) (Bitvec.ofInt' w op1)) (Bitvec.ofInt' w op1)) ⊑
    some (Bitvec.and (Bitvec.xor (Bitvec.ofInt' w a) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w op1))
    := sorry

def statement44 :  some
      (Bitvec.xor (Bitvec.and (Bitvec.ofInt' w a) (Bitvec.ofInt' w b))
        (Bitvec.or (Bitvec.ofInt' w a) (Bitvec.ofInt' w b))) ⊑
    some (Bitvec.xor (Bitvec.ofInt' w a) (Bitvec.ofInt' w b))
    := sorry

def statement45 :  some
      (Bitvec.xor (Bitvec.or (Bitvec.ofInt' w a) (Bitvec.xor (Bitvec.ofInt' w b) (Bitvec.ofInt' w (-1))))
        (Bitvec.or (Bitvec.xor (Bitvec.ofInt' w a) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w b))) ⊑
    some (Bitvec.xor (Bitvec.ofInt' w a) (Bitvec.ofInt' w b))
    := sorry

def statement46 :  some
      (Bitvec.xor (Bitvec.and (Bitvec.ofInt' w a) (Bitvec.xor (Bitvec.ofInt' w b) (Bitvec.ofInt' w (-1))))
        (Bitvec.and (Bitvec.xor (Bitvec.ofInt' w a) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w b))) ⊑
    some (Bitvec.xor (Bitvec.ofInt' w a) (Bitvec.ofInt' w b))
    := sorry

def statement47 :  some
      (Bitvec.xor (Bitvec.xor (Bitvec.ofInt' w a) (Bitvec.ofInt' w c))
        (Bitvec.or (Bitvec.ofInt' w a) (Bitvec.ofInt' w b))) ⊑
    some
      (Bitvec.xor (Bitvec.and (Bitvec.xor (Bitvec.ofInt' w a) (Bitvec.ofInt' w (-1))) (Bitvec.ofInt' w b))
        (Bitvec.ofInt' w c))
    := sorry
    
def statement48 :  some
      (Bitvec.xor (Bitvec.and (Bitvec.ofInt' w a) (Bitvec.ofInt' w b))
        (Bitvec.xor (Bitvec.ofInt' w a) (Bitvec.ofInt' w b))) ⊑
    some (Bitvec.or (Bitvec.ofInt' w a) (Bitvec.ofInt' w b))
    := sorry

def statement49 :  some
      (Bitvec.xor (Bitvec.and (Bitvec.ofInt' w a) (Bitvec.xor (Bitvec.ofInt' w b) (Bitvec.ofInt' w (-1))))
        (Bitvec.xor (Bitvec.ofInt' w a) (Bitvec.ofInt' w (-1)))) ⊑
    some (Bitvec.xor (Bitvec.and (Bitvec.ofInt' w a) (Bitvec.ofInt' w b)) (Bitvec.ofInt' w (-1)))
    := sorry