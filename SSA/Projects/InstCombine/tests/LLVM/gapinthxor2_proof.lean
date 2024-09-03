
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gapinthxor2_proof
theorem test1_thm (x x_1 : BitVec 447) :
  x_1 &&& 70368744177664#447 ^^^ x &&& 70368744177663#447 =
    x_1 &&& 70368744177664#447 ||| x &&& 70368744177663#447 := sorry

theorem test2_thm (x : BitVec 1005) : x ^^^ 0#1005 = x := sorry

theorem test3_thm (x : BitVec 123) : x ^^^ x = 0#123 := sorry

theorem test4_thm (x : BitVec 737) :
  x ^^^
      (722947573429303679218971863604384733017946601434003846318950894300849620572466815975903723774778879224549853567560703123999563997664868082592397590652658203246283799419575326866593810558132103097281884026581639773628137471#737 ^^^
        x) =
    722947573429303679218971863604384733017946601434003846318950894300849620572466815975903723774778879224549853567560703123999563997664868082592397590652658203246283799419575326866593810558132103097281884026581639773628137471#737 := sorry

theorem test5_thm (x : BitVec 700) :
  (x ||| 288230376151711743#700) ^^^ 288230376151711743#700 =
    x &&&
      5260135901548373507240989882880128665550339802823173859498280903068732154297080822113666536277588451226982968856178217713019432250183803863127814770651880849955223671128444598191663757884322716983062875584069632#700 := sorry

theorem test6_thm (x : BitVec 77) : x ^^^ 23#77 ^^^ 23#77 = x := sorry

theorem test7_thm (x : BitVec 1023) :
  (x ||| 70368744177663#1023) ^^^ 703687463#1023 =
    x &&&
        89884656743115795386465259539451236680898848947115328636715040578866337902750481566354238661203768010560056939935696678829394884407208311246423715319737062188883946712432742638151109800623047059726541476042502884419075341171231440736956555270413618581675255342293149119973622969239858152417678094443367890944#1023 |||
      70368040490200#1023 := sorry

