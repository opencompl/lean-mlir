namespace BitVec

def ushr_xor_distrib (a b c : BitVec w) :
    (a ^^^ b) >>> c = (a >>> c) ^^^ (b >>> c) := by
  simp only [HShiftRight.hShiftRight]
  ext
  simp

def ushr_and_distrib (a b c : BitVec w) :
    (a &&& b) >>> c = (a >>> c) &&& (b >>> c) := by
  simp only [HShiftRight.hShiftRight]
  ext
  simp

def ushr_or_distrib (a b c : BitVec w) :
    (a ||| b) >>> c = (a >>> c) ||| (b >>> c) := by
  simp only [HShiftRight.hShiftRight]
  ext
  simp

def xor_assoc (a b c : BitVec w) :
    a ^^^ b ^^^ c = a ^^^ (b ^^^ c) := by
  ext i
  simp [Bool.xor_assoc]

def and_assoc (a b c : BitVec w) :
    a &&& b &&& c = a &&& (b &&& c) := by
  ext i
  simp [Bool.and_assoc]

def or_assoc (a b c : BitVec w) :
    a ||| b ||| c = a ||| (b ||| c) := by
  ext i
  simp [Bool.or_assoc]

end BitVec
