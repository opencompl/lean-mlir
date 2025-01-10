import Std.Tactic.BVDecide
import SSA.Experimental.Bits.Fast.Reflect

/- This dataset was derived from
   https://github.com/softsec-unh/MBA-Blast/blob/main/dataset/dataset2_64bit.txt
-/

theorem e_1 (x y : BitVec w) :
     - 1 *  ~~~(x ^^^ y) - 2 * y + 1 *  ~~~x =  - 1 *  ~~~(x |||  ~~~y) - 3 * (x &&& y) := by
  bv_automata_circuit (config := { cadical := true })


theorem e_2 (x y : BitVec w) :
    1 *  ~~~x - 2 * (x ^^^ y) + 1 *  ~~~(x &&& y) = 2 *  ~~~(x ||| y) - 1 * (x &&&  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_3 (x y : BitVec w) :
     - 2 *  ~~~(x &&&  ~~~y) + 2 *  ~~~x - 5 *  ~~~(x |||  ~~~y) = 3 * (x &&& y) - 5 * y := by
  bv_automata_circuit (config := { cadical := true })

theorem e_4 (x y : BitVec w) :
    11 *  ~~~(x &&&  ~~~y) - 9 *  ~~~(x ||| y) + 2 * (x &&&  ~~~y) = 2 *  ~~~y + 11 * y := by
  bv_automata_circuit (config := { cadical := true })

theorem e_5 (x y : BitVec w) :
     - 1 *  ~~~y + 2 *  ~~~(x &&& y) - 1 *  ~~~(x |||  ~~~y) - 1 * (x &&&  ~~~y) = 1 *  ~~~x := by
  bv_automata_circuit (config := { cadical := true })

theorem e_6 (x y : BitVec w) :
     - 6 * (x ^^^ y) + 1 *  ~~~x - 5 *  ~~~(x ||| y) + 2 * (x &&&  ~~~y) =  - 4 *  ~~~(x &&& y) - 1 *  ~~~(x |||  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_7 (x y : BitVec w) :
    11 *  ~~~(x &&&  ~~~y) - 11 * x + 11 * (x &&&  ~~~y) + 11 * (x &&& y) = 11 *  ~~~(x ||| y) + 11 * y := by
  bv_automata_circuit (config := { cadical := true })

theorem e_8 (x y : BitVec w) :
    1 * (x |||  ~~~y) - 1 * (x ||| y) - 2 *  ~~~(x ||| y) - 1 * (x &&& y) =  - 1 *  ~~~(x &&&  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_9 (x y : BitVec w) :
     - 2 * (x ^^^ y) + 11 * (x ||| y) + 5 * y - 9 * (x &&&  ~~~y) = 14 *  ~~~(x |||  ~~~y) + 16 * (x &&& y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_10 (x y : BitVec w) :
     - 3 * x - 2 *  ~~~y + 6 * (x &&&  ~~~y) + 4 * (x &&& y) =  - 3 *  ~~~(x ||| y) + 1 * (x |||  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_11 (x y : BitVec w) :
    7 *  ~~~(x &&& y) - 1 *  ~~~y - 6 *  ~~~x - 1 *  ~~~(x |||  ~~~y) = 6 * (x &&&  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_12 (x y : BitVec w) :
     - 3 *  ~~~(x &&&  ~~~x) + 1 *  ~~~x + 2 * (x &&&  ~~~y) + 4 * (x &&& y) =  - 2 *  ~~~(x &&& y) + 1 * x := by
  bv_automata_circuit (config := { cadical := true })

theorem e_13 (x y : BitVec w) :
     - 1 *  ~~~(x ^^^ y) + 5 * x - 6 * (x &&&  ~~~y) - 5 * (x &&& y) = 1 *  ~~~(x |||  ~~~y) - 1 *  ~~~(x &&&  ~~~x) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_14 (x y : BitVec w) :
    2 * x + 5 *  ~~~y + 2 *  ~~~(x |||  ~~~y) - 7 * (x &&&  ~~~y) = 5 *  ~~~(x ||| y) + 2 * y := by
  bv_automata_circuit (config := { cadical := true })

theorem e_15 (x y : BitVec w) :
     - 5 * y + 1 *  ~~~x + 11 *  ~~~(x ^^^ y) + 4 *  ~~~(x |||  ~~~y) = 6 * (x &&& y) + 12 *  ~~~(x ||| y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_16 (x y : BitVec w) :
    1 * (x ||| y) + 7 * x - 1 *  ~~~x - 8 * (x &&& y) =  - 1 *  ~~~(x ||| y) + 8 * (x &&&  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_17 (x y : BitVec w) :
     - 11 *  ~~~(x &&& y) + 14 *  ~~~(x ||| y) + 9 *  ~~~(x |||  ~~~y) + 16 * (x &&&  ~~~y) =  - 2 *  ~~~x + 5 *  ~~~y := by
  bv_automata_circuit (config := { cadical := true })

theorem e_18 (x y : BitVec w) :
    4 * (x |||  ~~~y) - 7 *  ~~~(x ||| y) - 4 * (x &&&  ~~~y) - 7 * (x &&& y) =  - 3 *  ~~~(x &&&  ~~~x) + 3 * (x ^^^ y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_19 (x y : BitVec w) :
    1 * x + 5 * (x ^^^ y) - 2 *  ~~~(x |||  ~~~y) - 3 * (x &&&  ~~~y) - 1 * (x &&& y) = 3 *  ~~~(x &&& y) - 3 *  ~~~(x ||| y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_20 (x y : BitVec w) :
     - 7 * y - 3 * (x |||  ~~~y) + 3 *  ~~~(x ||| y) + 8 *  ~~~(x |||  ~~~y) + 4 * (x &&&  ~~~y) = 1 * (x ^^^ y) - 10 * (x &&& y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_21 (x y : BitVec w) :
    2 * (x ||| y) - 1 *  ~~~(x &&&  ~~~x) + 2 *  ~~~(x ||| y) - 2 *  ~~~(x |||  ~~~y) - 1 * (x &&&  ~~~y) =  - 1 *  ~~~(x &&&  ~~~y) + 2 *  ~~~(x ^^^ y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_22 (x y : BitVec w) :
     - 11 *  ~~~(x &&& y) + 4 *  ~~~(x &&&  ~~~y) + 11 * (x ^^^ y) + 12 *  ~~~(x ||| y) - 4 * (x &&& y) = 5 *  ~~~x - 1 *  ~~~(x |||  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_23 (x y : BitVec w) :
     - 2 *  ~~~(x ^^^ y) - 2 *  ~~~(x &&& y) + 1 *  ~~~(x |||  ~~~y) + 1 * (x &&&  ~~~y) + 1 * (x &&& y) =  - 4 *  ~~~(x ||| y) - 1 * (x ||| y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_24 (x y : BitVec w) :
    7 *  ~~~(x ^^^ y) - 3 * (x ||| y) - 11 * (x ^^^ y) - 7 *  ~~~(x ||| y) + 14 * (x &&&  ~~~y) =  - 14 *  ~~~(x |||  ~~~y) + 4 * (x &&& y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_25 (x y : BitVec w) :
     - 2 *  ~~~y + 2 * (x |||  ~~~y) + 1 *  ~~~x - 5 * (x &&&  ~~~y) - 6 * (x &&& y) = 1 *  ~~~(x &&&  ~~~y) - 5 * x := by
  bv_automata_circuit (config := { cadical := true })

theorem e_26 (x y : BitVec w) :
     - 2 * (x ^^^ y) + 3 * y - 12 *  ~~~(x |||  ~~~y) - 9 * (x &&&  ~~~y) - 14 * (x &&& y) =  - 11 * (x ||| y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_27 (x y : BitVec w) :
    7 * (x ||| y) + 4 * x + 2 *  ~~~(x ||| y) - 7 *  ~~~(x |||  ~~~y) - 9 * (x &&&  ~~~y) = 2 *  ~~~y + 11 * (x &&& y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_28 (x y : BitVec w) :
     - 2 *  ~~~(x &&&  ~~~x) - 6 * x - 9 *  ~~~(x |||  ~~~y) + 8 * (x &&&  ~~~y) + 8 * (x &&& y) =  - 11 *  ~~~x + 9 *  ~~~(x ||| y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_29 (x y : BitVec w) :
     - 3 * (x ||| y) + 2 * (x ^^^ y) + 5 *  ~~~(x &&& y) - 4 * (x &&&  ~~~y) + 3 * (x &&& y) = 4 *  ~~~(x |||  ~~~y) + 5 *  ~~~(x ||| y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_30 (x y : BitVec w) :
    1 * x - 3 *  ~~~(x ^^^ y) - 7 * (x ^^^ y) + 7 *  ~~~(x |||  ~~~y) + 6 * (x &&&  ~~~y) =  - 3 *  ~~~(x ||| y) - 2 * (x &&& y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_31 (x y : BitVec w) :
    1 * (x ||| y) + 3 * y - 4 *  ~~~(x |||  ~~~y) + 6 * (x &&&  ~~~y) + 3 * (x &&& y) = 7 * x := by
  bv_automata_circuit (config := { cadical := true })

theorem e_32 (x y : BitVec w) :
     - 2 *  ~~~(x &&&  ~~~x) + 1 * x + 7 *  ~~~(x |||  ~~~y) + 1 * (x &&&  ~~~y) + 6 * (x &&& y) =  - 7 *  ~~~(x ||| y) + 5 *  ~~~(x &&&  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_33 (x y : BitVec w) :
     - 1 * (x ||| y) - 1 *  ~~~(x &&& y) + 1 *  ~~~(x ||| y) + 1 * (x &&&  ~~~y) + 1 * (x &&& y) =  - 1 * (x ^^^ y) - 1 *  ~~~(x |||  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_34 (x y : BitVec w) :
     - 1 * (x ^^^ y) - 5 * x - 2 *  ~~~(x ||| y) + 1 *  ~~~(x |||  ~~~y) + 3 * (x &&& y) =  - 2 * (x |||  ~~~y) - 4 * (x &&&  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_35 (x y : BitVec w) :
    11 * (x ^^^ y) - 7 *  ~~~(x &&& y) - 1 *  ~~~x - 3 *  ~~~(x |||  ~~~y) - 4 * (x &&&  ~~~y) =  - 8 *  ~~~(x ||| y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_36 (x y : BitVec w) :
     - 1 *  ~~~x - 5 * y - 5 *  ~~~(x ||| y) + 5 *  ~~~(x |||  ~~~y) - 6 * (x &&&  ~~~y) =  - 5 * (x |||  ~~~y) - 1 *  ~~~(x &&& y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_37 (x y : BitVec w) :
    3 * (x ||| y) - 6 * y - 6 *  ~~~(x ||| y) - 6 * (x &&&  ~~~y) - 3 * (x &&& y) =  - 3 *  ~~~(x &&&  ~~~x) - 3 *  ~~~(x ^^^ y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_38 (x y : BitVec w) :
    11 * (x ||| y) + 5 *  ~~~x - 2 *  ~~~(x ||| y) - 16 *  ~~~(x |||  ~~~y) - 11 * (x &&& y) = 3 *  ~~~y + 8 * (x &&&  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_39 (x y : BitVec w) :
     - 1 * (x ||| y) + 7 *  ~~~(x &&& y) - 4 *  ~~~(x |||  ~~~y) - 6 * (x &&&  ~~~y) + 3 * (x &&& y) = 2 *  ~~~(x &&&  ~~~y) + 5 *  ~~~(x ||| y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_40 (x y : BitVec w) :
    1 * y + 3 * (x |||  ~~~y) + 3 *  ~~~(x ^^^ y) - 6 *  ~~~(x ||| y) - 1 *  ~~~(x |||  ~~~y) = 7 * (x &&& y) + 3 * (x &&&  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_41 (x y : BitVec w) :
    1 * (x |||  ~~~y) - 6 * (x ||| y) - 1 *  ~~~(x ||| y) + 5 * (x &&&  ~~~y) + 7 * (x &&& y) = 2 * y - 8 *  ~~~(x |||  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_42 (x y : BitVec w) :
    1 * (x |||  ~~~y) + 1 * (x ^^^ y) - 5 *  ~~~(x &&& y) + 4 *  ~~~(x ||| y) + 4 *  ~~~(x |||  ~~~y) = 1 * (x &&& y) - 3 * (x &&&  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_43 (x y : BitVec w) :
     - 1 * x - 1 * y + 1 *  ~~~(x &&&  ~~~x) - 3 *  ~~~(x ||| y) - 1 * (x &&& y) =  - 2 *  ~~~(x ^^^ y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_44 (x y : BitVec w) :
    2 * (x ||| y) - 1 * y + 11 * (x ^^^ y) - 12 *  ~~~(x |||  ~~~y) - 13 * (x &&&  ~~~y) = 1 * (x &&& y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_45 (x y : BitVec w) :
     - 1 * (x ||| y) - 18 *  ~~~(x ||| y) + 1 *  ~~~(x |||  ~~~y) - 10 * (x &&&  ~~~y) - 6 * (x &&& y) =  - 7 *  ~~~(x ^^^ y) - 11 *  ~~~y := by
  bv_automata_circuit (config := { cadical := true })

theorem e_46 (x y : BitVec w) :
    11 *  ~~~(x &&& y) + 1 * x - 1 * y - 11 *  ~~~(x ||| y) - 10 *  ~~~(x |||  ~~~y) = 12 * (x &&&  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_47 (x y : BitVec w) :
     - 11 *  ~~~(x &&&  ~~~y) + 11 * (x |||  ~~~y) + 10 *  ~~~(x |||  ~~~y) - 11 * (x &&&  ~~~y) - 1 * (x &&& y) =  - 1 * y := by
  bv_automata_circuit (config := { cadical := true })

theorem e_48 (x y : BitVec w) :
    2 *  ~~~y - 2 * (x |||  ~~~y) - 1 *  ~~~(x |||  ~~~y) - 1 * (x &&&  ~~~y) + 2 * (x &&& y) =  - 1 * (x ^^^ y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_49 (x y : BitVec w) :
    11 * (x |||  ~~~y) + 2 * x - 12 *  ~~~(x ||| y) - 13 * (x &&&  ~~~y) - 14 * (x &&& y) =  - 1 *  ~~~(x ^^^ y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_50 (x y : BitVec w) :
    2 *  ~~~y + 1 *  ~~~(x &&&  ~~~x) - 3 * (x ^^^ y) + 8 *  ~~~(x ||| y) + 10 * (x &&& y) = 11 *  ~~~(x &&&  ~~~y) - 13 *  ~~~(x |||  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_51 (x y : BitVec w) :
    1 *  ~~~(x &&&  ~~~x) + 7 * (x |||  ~~~y) - 1 * (x ^^^ y) - 7 *  ~~~(x ||| y) - 6 * (x &&&  ~~~y) = 8 * (x &&& y) + 1 *  ~~~y := by
  bv_automata_circuit (config := { cadical := true })

theorem e_52 (x y : BitVec w) :
    11 *  ~~~(x &&&  ~~~x) - 11 * (x ^^^ y) - 12 *  ~~~(x ||| y) - 1 * (x &&&  ~~~y) - 12 * (x &&& y) =  - 1 * (x |||  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_53 (x y : BitVec w) :
     - 7 * (x ^^^ y) + 2 * (x |||  ~~~y) - 2 *  ~~~(x ||| y) + 8 *  ~~~(x |||  ~~~y) - 1 * (x &&& y) = 1 * y - 5 * (x &&&  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_54 (x y : BitVec w) :
    11 *  ~~~(x &&&  ~~~x) + 2 *  ~~~y - 16 *  ~~~(x ||| y) - 13 * (x &&&  ~~~y) - 14 * (x &&& y) =  - 3 *  ~~~(x ^^^ y) + 11 *  ~~~(x |||  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_55 (x y : BitVec w) :
    11 * (x |||  ~~~y) - 1 *  ~~~y - 2 *  ~~~(x &&&  ~~~x) - 8 *  ~~~(x ||| y) - 8 * (x &&&  ~~~y) =  - 2 *  ~~~(x |||  ~~~y) + 9 * (x &&& y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_56 (x y : BitVec w) :
    1 * x + 2 * (x ^^^ y) - 1 * y - 1 *  ~~~y + 2 *  ~~~(x ||| y) = 2 * (x &&&  ~~~y) + 1 *  ~~~x := by
  bv_automata_circuit (config := { cadical := true })

theorem e_57 (x y : BitVec w) :
     - 1 * (x ^^^ y) + 1 *  ~~~(x ||| y) - 9 *  ~~~(x |||  ~~~y) + 1 * (x &&&  ~~~y) - 11 * (x &&& y) =  - 11 * y + 1 *  ~~~x := by
  bv_automata_circuit (config := { cadical := true })

theorem e_58 (x y : BitVec w) :
    1 *  ~~~(x ^^^ y) + 2 * (x |||  ~~~y) + 4 *  ~~~x - 4 *  ~~~(x |||  ~~~y) - 2 * (x &&&  ~~~y) = 3 * (x &&& y) + 7 *  ~~~(x ||| y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_59 (x y : BitVec w) :
    1 *  ~~~(x &&&  ~~~y) + 4 * y - 7 *  ~~~(x |||  ~~~y) - 2 * (x &&&  ~~~y) - 5 * (x &&& y) = 1 *  ~~~(x ||| y) - 2 * (x ^^^ y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_60 (x y : BitVec w) :
     - 2 *  ~~~y + 7 *  ~~~(x &&& y) + 5 * x - 5 *  ~~~(x ||| y) - 10 * (x &&&  ~~~y) = 7 *  ~~~(x |||  ~~~y) + 5 * (x &&& y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_61 (x y : BitVec w) :
    3 *  ~~~(x ^^^ y) - 1 * (x ||| y) + 1 * (x |||  ~~~y) - 4 *  ~~~(x ||| y) + 1 *  ~~~(x |||  ~~~y) = 3 * (x &&& y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_62 (x y : BitVec w) :
     - 1 *  ~~~(x &&&  ~~~y) + 3 *  ~~~(x &&&  ~~~x) - 2 *  ~~~(x ||| y) - 3 *  ~~~(x |||  ~~~y) - 2 * (x &&& y) =  - 1 * (x ^^^ y) + 4 * (x &&&  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_63 (x y : BitVec w) :
     - 2 *  ~~~x + 11 *  ~~~(x &&&  ~~~x) - 5 * x - 9 *  ~~~(x |||  ~~~y) - 6 * (x &&& y) = 6 * (x &&&  ~~~y) + 9 *  ~~~(x ||| y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_64 (x y : BitVec w) :
     - 1 * (x |||  ~~~y) - 1 *  ~~~(x ^^^ y) + 5 *  ~~~(x ||| y) + 3 *  ~~~(x |||  ~~~y) + 2 * (x &&& y) =  - 1 * (x &&&  ~~~y) + 3 *  ~~~x := by
  bv_automata_circuit (config := { cadical := true })

theorem e_65 (x y : BitVec w) :
     - 11 * (x ^^^ y) + 5 * x + 4 *  ~~~(x &&& y) + 7 *  ~~~(x |||  ~~~y) - 5 * (x &&& y) = 4 *  ~~~(x ||| y) - 2 * (x &&&  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_66 (x y : BitVec w) :
    4 * y - 11 *  ~~~(x &&&  ~~~x) + 4 *  ~~~(x ||| y) + 7 *  ~~~(x |||  ~~~y) + 4 * (x &&&  ~~~y) =  - 7 * (x |||  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_67 (x y : BitVec w) :
     - 11 *  ~~~(x &&& y) + 4 *  ~~~y + 8 *  ~~~(x ||| y) + 8 * (x &&&  ~~~y) + 1 * (x &&& y) =  - 12 *  ~~~(x |||  ~~~y) + 1 *  ~~~(x &&&  ~~~x) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_68 (x y : BitVec w) :
    5 *  ~~~(x &&&  ~~~y) - 2 * (x ^^^ y) - 5 *  ~~~(x ||| y) + 3 *  ~~~(x |||  ~~~y) + 8 * (x &&&  ~~~y) = 6 * (x ||| y) - 1 * (x &&& y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_69 (x y : BitVec w) :
     - 2 *  ~~~y + 7 *  ~~~(x &&&  ~~~x) - 1 * (x ||| y) - 4 * (x &&&  ~~~y) - 6 * (x &&& y) = 6 *  ~~~(x |||  ~~~y) + 5 *  ~~~(x ||| y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_70 (x y : BitVec w) :
     - 1 *  ~~~y - 5 *  ~~~(x &&&  ~~~y) + 8 *  ~~~(x ||| y) + 7 *  ~~~(x |||  ~~~y) + 5 * (x &&& y) =  - 1 * (x &&&  ~~~y) + 2 *  ~~~x := by
  bv_automata_circuit (config := { cadical := true })

theorem e_71 (x y : BitVec w) :
     - 5 *  ~~~x - 2 * x - 2 * (x |||  ~~~y) + 7 *  ~~~(x ||| y) + 3 * (x &&&  ~~~y) =  - 4 * y - 1 * (x ^^^ y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_72 (x y : BitVec w) :
    2 *  ~~~x + 4 *  ~~~(x &&&  ~~~y) - 13 *  ~~~(x |||  ~~~y) - 7 * (x &&&  ~~~y) - 4 * (x &&& y) =  - 7 * (x ^^^ y) + 6 *  ~~~(x ||| y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_73 (x y : BitVec w) :
    4 *  ~~~x + 3 * (x ^^^ y) - 3 *  ~~~(x ||| y) - 7 *  ~~~(x |||  ~~~y) + 3 * (x &&& y) = 1 * (x |||  ~~~y) + 2 * x := by
  bv_automata_circuit (config := { cadical := true })

theorem e_74 (x y : BitVec w) :
     - 6 * (x ||| y) + 4 * (x ^^^ y) + 2 *  ~~~(x ||| y) + 4 *  ~~~(x |||  ~~~y) + 2 * (x &&&  ~~~y) = 2 *  ~~~x - 6 * (x &&& y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_75 (x y : BitVec w) :
    1 *  ~~~(x &&&  ~~~y) + 1 * x - 12 *  ~~~(x ||| y) - 1 *  ~~~(x |||  ~~~y) - 2 * (x &&& y) =  - 11 *  ~~~y + 12 * (x &&&  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_76 (x y : BitVec w) :
     - 1 * y - 1 * (x ||| y) - 7 *  ~~~(x ||| y) - 5 *  ~~~(x |||  ~~~y) + 1 * (x &&&  ~~~y) =  - 7 *  ~~~(x &&&  ~~~y) + 5 * (x &&& y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_77 (x y : BitVec w) :
     - 5 * x - 1 *  ~~~(x &&&  ~~~x) - 1 *  ~~~(x &&& y) + 2 *  ~~~(x ||| y) + 2 *  ~~~(x |||  ~~~y) =  - 7 * (x &&&  ~~~y) - 6 * (x &&& y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_78 (x y : BitVec w) :
    1 *  ~~~y - 2 *  ~~~(x ^^^ y) + 1 *  ~~~(x ||| y) + 4 * (x &&&  ~~~y) + 2 * (x &&& y) = 5 * (x ^^^ y) - 5 *  ~~~(x |||  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_79 (x y : BitVec w) :
    3 *  ~~~y - 11 * x + 11 *  ~~~(x &&&  ~~~x) - 14 *  ~~~(x ||| y) - 3 * (x &&&  ~~~y) = 11 *  ~~~(x |||  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_80 (x y : BitVec w) :
     - 5 *  ~~~(x &&&  ~~~x) - 7 *  ~~~(x ^^^ y) + 4 *  ~~~(x |||  ~~~y) + 5 * (x &&&  ~~~y) + 11 * (x &&& y) =  - 1 *  ~~~(x &&&  ~~~y) - 11 *  ~~~(x ||| y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_81 (x y : BitVec w) :
    1 * y - 7 *  ~~~(x &&& y) + 7 *  ~~~x + 7 * (x &&&  ~~~y) - 1 * (x &&& y) = 1 *  ~~~(x |||  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_82 (x y : BitVec w) :
     - 7 * (x |||  ~~~y) + 3 *  ~~~x - 2 *  ~~~(x ^^^ y) - 10 *  ~~~(x |||  ~~~y) + 2 * (x &&& y) =  - 6 *  ~~~(x ||| y) - 7 * (x ||| y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_83 (x y : BitVec w) :
     - 5 *  ~~~y + 5 * (x |||  ~~~y) - 2 *  ~~~(x |||  ~~~y) - 2 * (x &&&  ~~~y) - 5 * (x &&& y) =  - 2 * (x ^^^ y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_84 (x y : BitVec w) :
     - 2 *  ~~~(x &&& y) - 11 *  ~~~(x &&&  ~~~x) + 12 *  ~~~(x ||| y) + 12 *  ~~~(x |||  ~~~y) + 13 * (x &&&  ~~~y) =  - 1 *  ~~~(x &&&  ~~~y) - 10 * (x &&& y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_85 (x y : BitVec w) :
    1 *  ~~~y + 2 * (x |||  ~~~y) - 4 *  ~~~(x ||| y) - 3 * (x &&&  ~~~y) - 2 * (x &&& y) =  - 1 *  ~~~x + 1 *  ~~~(x |||  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_86 (x y : BitVec w) :
     - 2 *  ~~~(x &&& y) - 11 *  ~~~y + 13 *  ~~~(x ||| y) + 3 *  ~~~(x |||  ~~~y) + 14 * (x &&&  ~~~y) = 1 * (x ^^^ y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_87 (x y : BitVec w) :
    2 * (x |||  ~~~y) + 5 *  ~~~(x &&&  ~~~y) - 7 *  ~~~(x ||| y) - 2 * (x &&&  ~~~y) - 14 * (x &&& y) = 12 *  ~~~(x |||  ~~~y) - 7 * y := by
  bv_automata_circuit (config := { cadical := true })

theorem e_88 (x y : BitVec w) :
    1 *  ~~~(x &&&  ~~~x) - 2 *  ~~~(x ||| y) - 3 *  ~~~(x |||  ~~~y) - 2 * (x &&&  ~~~y) - 3 * (x &&& y) =  - 1 *  ~~~y - 2 * y := by
  bv_automata_circuit (config := { cadical := true })

theorem e_89 (x y : BitVec w) :
     - 5 * (x ^^^ y) - 2 *  ~~~x + 2 *  ~~~(x ||| y) + 14 *  ~~~(x |||  ~~~y) + 5 * (x &&&  ~~~y) =  - 7 * (x &&& y) + 7 * y := by
  bv_automata_circuit (config := { cadical := true })

theorem e_90 (x y : BitVec w) :
     - 5 *  ~~~(x &&& y) - 7 * (x ||| y) + 3 *  ~~~(x ||| y) + 10 *  ~~~(x |||  ~~~y) + 10 * (x &&&  ~~~y) =  - 5 * (x &&& y) - 2 *  ~~~(x &&&  ~~~x) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_91 (x y : BitVec w) :
     - 5 * (x |||  ~~~y) - 5 *  ~~~(x &&& y) + 11 *  ~~~(x ||| y) + 10 * (x &&&  ~~~y) + 6 * (x &&& y) = 1 *  ~~~(x &&&  ~~~y) - 6 *  ~~~(x |||  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_92 (x y : BitVec w) :
    1 * (x ^^^ y) - 1 *  ~~~(x &&&  ~~~x) - 3 *  ~~~(x &&&  ~~~y) + 3 *  ~~~(x |||  ~~~y) + 4 * (x &&& y) =  - 4 *  ~~~(x ||| y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_93 (x y : BitVec w) :
    4 * y + 3 * x + 1 * (x ||| y) - 4 * (x &&&  ~~~y) - 8 * (x &&& y) = 5 *  ~~~(x |||  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_94 (x y : BitVec w) :
    7 *  ~~~x - 3 *  ~~~(x ^^^ y) + 1 * y - 4 *  ~~~(x ||| y) + 2 * (x &&& y) = 8 *  ~~~(x |||  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_95 (x y : BitVec w) :
     - 2 *  ~~~(x ^^^ y) - 1 * (x |||  ~~~y) - 11 *  ~~~(x &&&  ~~~x) + 11 *  ~~~(x |||  ~~~y) + 18 * (x &&&  ~~~y) + 14 * (x &&& y) =  - 20 *  ~~~(x ||| y) + 6 *  ~~~y := by
  bv_automata_circuit (config := { cadical := true })

theorem e_96 (x y : BitVec w) :
    4 *  ~~~y + 7 *  ~~~x - 7 * (x ||| y) - 2 * (x ^^^ y) - 5 *  ~~~(x |||  ~~~y) - 2 * (x &&&  ~~~y) =  - 7 *  ~~~(x &&&  ~~~x) + 18 *  ~~~(x ||| y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_97 (x y : BitVec w) :
     - 2 * x + 7 *  ~~~(x &&&  ~~~y) + 4 *  ~~~x + 11 *  ~~~y - 9 * (x &&&  ~~~y) - 5 * (x &&& y) = 22 *  ~~~(x ||| y) + 11 *  ~~~(x |||  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_98 (x y : BitVec w) :
     - 2 * (x ||| y) - 5 * (x |||  ~~~y) - 3 *  ~~~(x ^^^ y) + 8 *  ~~~(x ||| y) + 2 *  ~~~(x |||  ~~~y) + 10 * (x &&& y) =  - 7 * (x &&&  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_99 (x y : BitVec w) :
     - 5 * (x ^^^ y) - 2 *  ~~~(x &&&  ~~~y) - 3 *  ~~~x + 4 *  ~~~(x ||| y) + 10 *  ~~~(x |||  ~~~y) + 5 * (x &&&  ~~~y) =  - 1 * (x &&& y) - 1 *  ~~~(x ^^^ y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_100 (x y : BitVec w) :
     - 11 * (x |||  ~~~y) + 3 *  ~~~(x &&& y) - 5 *  ~~~y + 13 *  ~~~(x ||| y) - 4 *  ~~~(x |||  ~~~y) + 12 * (x &&&  ~~~y) =  - 1 * (x ^^^ y) - 11 * (x &&& y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_101 (x y : BitVec w) :
    1 *  ~~~(x &&&  ~~~x) - 2 * x - 11 * (x |||  ~~~y) - 1 *  ~~~(x |||  ~~~y) + 12 * (x &&&  ~~~y) + 12 * (x &&& y) =  - 10 *  ~~~(x ||| y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_102 (x y : BitVec w) :
    11 *  ~~~(x &&&  ~~~y) + 1 * (x |||  ~~~y) + 1 * (x ^^^ y) - 6 *  ~~~(x |||  ~~~y) + 10 * (x &&&  ~~~y) - 12 * (x &&& y) = 6 *  ~~~(x &&& y) + 6 *  ~~~y := by
  bv_automata_circuit (config := { cadical := true })

theorem e_103 (x y : BitVec w) :
     - 1 * x + 2 * (x ||| y) + 3 *  ~~~x - 9 *  ~~~(x |||  ~~~y) - 5 * (x &&&  ~~~y) - 5 * (x &&& y) =  - 4 *  ~~~(x &&&  ~~~x) + 7 *  ~~~(x ||| y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_104 (x y : BitVec w) :
    5 * y + 2 * (x |||  ~~~y) + 11 *  ~~~x - 13 *  ~~~(x ||| y) - 16 *  ~~~(x |||  ~~~y) - 7 * (x &&& y) = 2 * (x &&&  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_105 (x y : BitVec w) :
     - 1 *  ~~~(x ^^^ y) - 6 *  ~~~y - 5 * (x ^^^ y) + 7 *  ~~~(x ||| y) + 11 * (x &&&  ~~~y) + 1 * (x &&& y) =  - 5 *  ~~~(x |||  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_106 (x y : BitVec w) :
    3 *  ~~~x - 1 * y + 11 * (x ||| y) - 14 *  ~~~(x |||  ~~~y) - 11 * (x &&&  ~~~y) - 11 * (x &&& y) = 4 *  ~~~(x ||| y) - 1 *  ~~~(x &&&  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_107 (x y : BitVec w) :
     - 1 * y + 7 * x + 1 *  ~~~x + 11 *  ~~~(x &&& y) - 18 * (x &&&  ~~~y) - 6 * (x &&& y) = 11 *  ~~~(x |||  ~~~y) + 12 *  ~~~(x ||| y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_108 (x y : BitVec w) :
     - 2 * x + 2 *  ~~~(x ^^^ y) - 11 *  ~~~x + 9 *  ~~~(x ||| y) + 22 *  ~~~(x |||  ~~~y) + 13 * (x &&&  ~~~y) =  - 11 * (x &&& y) + 11 * (x ||| y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_109 (x y : BitVec w) :
    1 *  ~~~(x ^^^ y) - 3 * x - 1 *  ~~~(x ||| y) + 6 *  ~~~(x |||  ~~~y) + 10 * (x &&&  ~~~y) + 8 * (x &&& y) = 7 * (x ||| y) - 1 * y := by
  bv_automata_circuit (config := { cadical := true })

theorem e_110 (x y : BitVec w) :
    4 *  ~~~y + 7 * y + 2 *  ~~~(x &&&  ~~~x) - 6 *  ~~~(x &&&  ~~~y) - 3 *  ~~~(x |||  ~~~y) - 6 * (x &&&  ~~~y) = 3 * (x &&& y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_111 (x y : BitVec w) :
    2 *  ~~~(x ^^^ y) + 3 *  ~~~y + 3 *  ~~~(x &&& y) - 6 *  ~~~(x ||| y) - 1 *  ~~~(x |||  ~~~y) - 4 * (x &&&  ~~~y) = 2 *  ~~~(x &&&  ~~~x) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_112 (x y : BitVec w) :
     - 11 *  ~~~(x &&&  ~~~x) + 2 *  ~~~(x ^^^ y) - 3 * y + 9 *  ~~~(x ||| y) + 11 * (x &&&  ~~~y) + 12 * (x &&& y) =  - 14 *  ~~~(x |||  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_113 (x y : BitVec w) :
     - 5 *  ~~~(x ^^^ y) - 11 *  ~~~(x &&&  ~~~y) + 14 *  ~~~(x ||| y) + 9 *  ~~~(x |||  ~~~y) - 2 * (x &&&  ~~~y) + 14 * (x &&& y) =  - 2 *  ~~~(x &&&  ~~~x) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_114 (x y : BitVec w) :
    5 * y - 11 * x + 1 *  ~~~(x &&&  ~~~y) - 1 *  ~~~(x ||| y) - 8 *  ~~~(x |||  ~~~y) + 9 * (x &&&  ~~~y) =  - 2 * (x ||| y) - 3 * (x &&& y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_115 (x y : BitVec w) :
    5 *  ~~~(x &&&  ~~~x) - 11 *  ~~~y - 1 * x + 6 *  ~~~(x ||| y) + 7 * (x &&&  ~~~y) - 4 * (x &&& y) = 5 *  ~~~(x |||  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_116 (x y : BitVec w) :
    7 *  ~~~x - 1 *  ~~~(x ^^^ y) - 11 *  ~~~(x ||| y) - 12 *  ~~~(x |||  ~~~y) - 5 * (x &&&  ~~~y) - 4 * (x &&& y) =  - 5 *  ~~~(x &&&  ~~~x) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_117 (x y : BitVec w) :
     - 11 *  ~~~y - 11 *  ~~~(x &&&  ~~~y) - 2 * (x ||| y) + 21 *  ~~~(x ||| y) + 12 *  ~~~(x |||  ~~~y) + 13 * (x &&& y) =  - 12 * (x &&&  ~~~y) - 1 *  ~~~(x &&& y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_118 (x y : BitVec w) :
    1 *  ~~~(x &&&  ~~~x) - 5 * (x |||  ~~~y) - 6 * x - 1 *  ~~~y + 11 * (x &&&  ~~~y) + 10 * (x &&& y) = 1 *  ~~~(x |||  ~~~y) - 5 *  ~~~(x ||| y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_119 (x y : BitVec w) :
    7 * y - 11 *  ~~~y + 9 *  ~~~(x ||| y) - 7 *  ~~~(x |||  ~~~y) + 8 * (x &&&  ~~~y) - 12 * (x &&& y) =  - 2 *  ~~~(x ^^^ y) - 3 * x := by
  bv_automata_circuit (config := { cadical := true })

theorem e_120 (x y : BitVec w) :
    1 *  ~~~x - 11 * (x ||| y) - 7 * (x |||  ~~~y) + 6 *  ~~~(x ||| y) + 10 *  ~~~(x |||  ~~~y) + 18 * (x &&&  ~~~y) =  - 18 * (x &&& y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_121 (x y : BitVec w) :
     - 5 *  ~~~y - 2 *  ~~~(x &&&  ~~~x) - 2 *  ~~~(x ^^^ y) + 9 *  ~~~(x ||| y) + 7 * (x &&&  ~~~y) + 4 * (x &&& y) =  - 2 *  ~~~(x |||  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_122 (x y : BitVec w) :
    2 *  ~~~y + 11 * (x ^^^ y) - 2 *  ~~~x - 1 *  ~~~(x &&& y) + 1 *  ~~~(x ||| y) - 12 * (x &&&  ~~~y) = 8 *  ~~~(x |||  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_123 (x y : BitVec w) :
     - 1 *  ~~~x - 7 * (x |||  ~~~y) + 2 * y + 8 *  ~~~(x ||| y) + 7 * (x &&&  ~~~y) + 5 * (x &&& y) = 1 *  ~~~(x |||  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_124 (x y : BitVec w) :
    11 *  ~~~(x &&&  ~~~y) + 2 *  ~~~(x &&&  ~~~x) - 7 * (x ||| y) - 6 * x - 6 *  ~~~(x |||  ~~~y) + 11 * (x &&&  ~~~y) = 13 *  ~~~(x ||| y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_125 (x y : BitVec w) :
     - 5 *  ~~~x - 11 *  ~~~(x ^^^ y) + 2 *  ~~~(x &&&  ~~~x) + 14 *  ~~~(x ||| y) - 2 * (x &&&  ~~~y) + 9 * (x &&& y) =  - 3 *  ~~~(x |||  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_126 (x y : BitVec w) :
     - 11 *  ~~~(x ^^^ y) - 2 * (x ^^^ y) + 1 * y + 2 *  ~~~(x &&&  ~~~x) - 1 *  ~~~(x |||  ~~~y) + 8 * (x &&& y) =  - 9 *  ~~~(x ||| y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_127 (x y : BitVec w) :
    11 *  ~~~(x &&& y) - 1 *  ~~~(x &&&  ~~~x) + 5 * (x ||| y) - 10 *  ~~~(x ||| y) - 15 *  ~~~(x |||  ~~~y) - 15 * (x &&&  ~~~y) = 4 * (x &&& y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_128 (x y : BitVec w) :
    1 * (x ||| y) - 6 *  ~~~x + 8 *  ~~~(x ||| y) + 8 *  ~~~(x |||  ~~~y) + 1 * (x &&&  ~~~y) + 4 * (x &&& y) = 3 * y + 2 * (x |||  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_129 (x y : BitVec w) :
    1 * (x |||  ~~~y) - 2 * (x ||| y) - 3 *  ~~~y + 2 *  ~~~(x ||| y) + 2 *  ~~~(x |||  ~~~y) + 1 * (x &&& y) =  - 4 * (x &&&  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_130 (x y : BitVec w) :
     - 2 *  ~~~(x &&&  ~~~y) + 3 *  ~~~(x ^^^ y) - 3 * (x ||| y) - 1 *  ~~~(x ||| y) + 3 * (x &&&  ~~~y) + 2 * (x &&& y) =  - 5 *  ~~~(x |||  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_131 (x y : BitVec w) :
     - 11 * x - 1 * (x |||  ~~~y) + 6 *  ~~~(x ||| y) + 2 *  ~~~(x |||  ~~~y) + 19 * (x &&&  ~~~y) + 12 * (x &&& y) = 2 * (x ^^^ y) + 5 *  ~~~y := by
  bv_automata_circuit (config := { cadical := true })

theorem e_132 (x y : BitVec w) :
    11 *  ~~~(x ^^^ y) - 7 * (x |||  ~~~y) + 3 *  ~~~(x &&& y) - 3 *  ~~~(x |||  ~~~y) + 4 * (x &&&  ~~~y) - 4 * (x &&& y) = 7 *  ~~~(x ||| y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_133 (x y : BitVec w) :
    7 *  ~~~y - 2 *  ~~~(x &&&  ~~~x) - 7 *  ~~~(x ||| y) - 1 *  ~~~(x |||  ~~~y) - 10 * (x &&&  ~~~y) - 3 * (x &&& y) =  - 2 * (x |||  ~~~y) - 3 * (x ||| y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_134 (x y : BitVec w) :
     - 3 * (x ||| y) + 4 * (x |||  ~~~y) + 1 * y - 4 *  ~~~(x ||| y) - 1 * (x &&&  ~~~y) - 2 * (x &&& y) =  - 2 *  ~~~(x |||  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_135 (x y : BitVec w) :
     - 7 * (x ||| y) + 2 *  ~~~y + 4 *  ~~~(x ||| y) + 13 *  ~~~(x |||  ~~~y) + 5 * (x &&&  ~~~y) + 7 * (x &&& y) = 6 *  ~~~x := by
  bv_automata_circuit (config := { cadical := true })

theorem e_136 (x y : BitVec w) :
     - 1 * y + 3 * (x ^^^ y) - 2 * (x |||  ~~~y) + 2 *  ~~~(x ||| y) - 2 *  ~~~(x |||  ~~~y) + 3 * (x &&& y) = 1 * (x &&&  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_137 (x y : BitVec w) :
    11 * (x |||  ~~~y) + 7 * (x ^^^ y) - 1 *  ~~~(x ^^^ y) - 2 * y - 5 *  ~~~(x |||  ~~~y) - 18 * (x &&&  ~~~y) = 8 * (x &&& y) + 10 *  ~~~(x ||| y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_138 (x y : BitVec w) :
     - 7 * (x ||| y) - 2 * x + 1 *  ~~~(x &&&  ~~~x) + 2 * (x ^^^ y) - 1 *  ~~~(x ||| y) + 4 *  ~~~(x |||  ~~~y) =  - 8 * (x &&& y) - 6 * (x &&&  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_139 (x y : BitVec w) :
     - 1 * x - 1 * (x ^^^ y) - 2 *  ~~~(x &&&  ~~~y) + 1 *  ~~~x + 2 *  ~~~(x |||  ~~~y) + 3 * (x &&& y) =  - 2 * (x &&&  ~~~y) - 1 *  ~~~(x ||| y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_140 (x y : BitVec w) :
     - 11 *  ~~~x + 5 * (x ||| y) + 4 *  ~~~(x ^^^ y) + 7 *  ~~~(x ||| y) + 6 *  ~~~(x |||  ~~~y) - 9 * (x &&& y) = 5 * (x &&&  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_141 (x y : BitVec w) :
     - 6 * (x ^^^ y) + 2 *  ~~~x + 5 *  ~~~(x &&& y) + 4 *  ~~~(x ||| y) + 1 * (x &&&  ~~~y) + 11 * (x &&& y) =  - 10 *  ~~~(x |||  ~~~y) + 11 *  ~~~(x &&&  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_142 (x y : BitVec w) :
    2 * y - 7 *  ~~~(x &&&  ~~~y) + 7 *  ~~~(x ||| y) - 6 *  ~~~(x |||  ~~~y) - 11 * (x &&&  ~~~y) + 5 * (x &&& y) =  - 11 * (x ^^^ y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_143 (x y : BitVec w) :
     - 1 *  ~~~(x &&&  ~~~y) - 6 *  ~~~(x ^^^ y) + 11 * x + 18 *  ~~~(x ||| y) + 1 *  ~~~(x |||  ~~~y) + 2 * (x &&& y) = 6 * (x |||  ~~~y) + 5 *  ~~~y := by
  bv_automata_circuit (config := { cadical := true })

theorem e_144 (x y : BitVec w) :
     - 5 *  ~~~x - 1 * (x ^^^ y) + 6 *  ~~~(x ||| y) + 7 *  ~~~(x |||  ~~~y) + 1 * (x &&&  ~~~y) + 1 * (x &&& y) = 1 *  ~~~(x &&&  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_145 (x y : BitVec w) :
     - 7 * (x ^^^ y) - 5 * x + 2 *  ~~~(x &&&  ~~~x) - 1 * (x ||| y) - 2 *  ~~~(x ||| y) + 6 *  ~~~(x |||  ~~~y) =  - 11 * (x &&&  ~~~y) - 4 * (x &&& y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_146 (x y : BitVec w) :
     - 3 * (x ^^^ y) - 11 *  ~~~y + 7 *  ~~~(x ||| y) + 3 *  ~~~(x |||  ~~~y) + 10 * (x &&&  ~~~y) - 4 * (x &&& y) =  - 4 * (x |||  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_147 (x y : BitVec w) :
    1 *  ~~~y - 7 *  ~~~(x &&& y) + 7 *  ~~~(x ||| y) + 8 *  ~~~(x |||  ~~~y) + 7 * (x &&&  ~~~y) + 1 * (x &&& y) = 1 *  ~~~(x &&&  ~~~x) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_148 (x y : BitVec w) :
    5 *  ~~~(x &&&  ~~~x) - 6 *  ~~~x - 5 * y - 11 * (x ^^^ y) + 2 *  ~~~(x ||| y) + 7 * (x &&&  ~~~y) =  - 17 *  ~~~(x |||  ~~~y) + 1 *  ~~~y := by
  bv_automata_circuit (config := { cadical := true })

theorem e_149 (x y : BitVec w) :
     - 1 *  ~~~(x &&& y) + 2 *  ~~~(x &&&  ~~~x) - 3 *  ~~~(x ||| y) - 3 *  ~~~(x |||  ~~~y) - 4 * (x &&&  ~~~y) - 5 * (x &&& y) =  - 2 *  ~~~x - 3 * x := by
  bv_automata_circuit (config := { cadical := true })

theorem e_150 (x y : BitVec w) :
     - 1 *  ~~~(x ^^^ y) + 3 *  ~~~(x &&&  ~~~y) - 1 *  ~~~(x &&& y) - 1 *  ~~~(x ||| y) - 2 *  ~~~(x |||  ~~~y) - 2 * (x &&& y) =  - 1 * (x &&&  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_151 (x y : BitVec w) :
     - 6 *  ~~~(x ^^^ y) - 1 * y + 1 *  ~~~(x ||| y) - 4 *  ~~~(x |||  ~~~y) + 11 * (x &&&  ~~~y) + 13 * (x &&& y) = 11 * x - 5 *  ~~~(x &&&  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_152 (x y : BitVec w) :
    3 *  ~~~(x &&& y) + 2 *  ~~~(x &&&  ~~~x) + 7 *  ~~~y - 2 * x - 12 *  ~~~(x ||| y) - 10 * (x &&&  ~~~y) = 5 *  ~~~(x |||  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_153 (x y : BitVec w) :
    1 *  ~~~(x ^^^ y) + 7 *  ~~~y - 1 * (x ||| y) - 3 * (x ^^^ y) + 4 *  ~~~(x |||  ~~~y) - 3 * (x &&&  ~~~y) = 8 *  ~~~(x ||| y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_154 (x y : BitVec w) :
    1 *  ~~~(x &&& y) - 11 *  ~~~(x &&&  ~~~x) - 1 *  ~~~y + 11 *  ~~~(x ||| y) + 8 *  ~~~(x |||  ~~~y) + 9 * (x &&& y) =  - 11 * (x &&&  ~~~y) - 2 * y := by
  bv_automata_circuit (config := { cadical := true })

theorem e_155 (x y : BitVec w) :
    3 * (x |||  ~~~y) - 1 * y - 7 *  ~~~(x &&&  ~~~x) + 5 *  ~~~x + 4 * (x &&&  ~~~y) + 6 * (x &&& y) =  - 3 *  ~~~(x |||  ~~~y) + 1 *  ~~~(x ^^^ y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_156 (x y : BitVec w) :
     - 1 *  ~~~y - 7 * (x |||  ~~~y) + 1 * y + 8 *  ~~~(x ||| y) + 8 * (x &&&  ~~~y) + 6 * (x &&& y) = 1 *  ~~~(x |||  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_157 (x y : BitVec w) :
     - 2 * (x |||  ~~~y) - 3 *  ~~~(x ^^^ y) + 5 *  ~~~(x ||| y) + 18 *  ~~~(x |||  ~~~y) + 20 * (x &&&  ~~~y) + 12 * (x &&& y) = 7 * (x ||| y) + 11 * (x ^^^ y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_158 (x y : BitVec w) :
     - 3 *  ~~~y - 11 *  ~~~(x &&&  ~~~y) - 2 *  ~~~x + 11 *  ~~~(x &&& y) + 2 *  ~~~(x |||  ~~~y) - 8 * (x &&&  ~~~y) =  - 11 * (x &&& y) - 5 *  ~~~(x ||| y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_159 (x y : BitVec w) :
     - 2 * (x |||  ~~~y) + 1 * (x ^^^ y) + 2 *  ~~~y + 1 *  ~~~(x &&&  ~~~x) - 2 * (x &&&  ~~~y) + 1 * (x &&& y) = 2 *  ~~~(x |||  ~~~y) + 1 *  ~~~(x ||| y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_160 (x y : BitVec w) :
    7 *  ~~~(x &&& y) + 7 * x - 5 * y - 2 *  ~~~(x |||  ~~~y) - 14 * (x &&&  ~~~y) - 2 * (x &&& y) = 7 *  ~~~(x ||| y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_161 (x y : BitVec w) :
     - 11 *  ~~~(x &&&  ~~~y) - 7 * y + 11 *  ~~~(x ||| y) + 19 *  ~~~(x |||  ~~~y) + 1 * (x &&&  ~~~y) + 19 * (x &&& y) = 1 * (x ||| y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_162 (x y : BitVec w) :
    1 *  ~~~(x &&&  ~~~x) + 11 *  ~~~(x &&& y) - 3 * (x ||| y) - 1 *  ~~~y - 13 *  ~~~(x ||| y) - 9 *  ~~~(x |||  ~~~y) = 10 * (x &&&  ~~~y) - 2 * (x |||  ~~~y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_163 (x y : BitVec w) :
    3 *  ~~~(x &&& y) - 3 *  ~~~(x &&&  ~~~y) - 1 * (x |||  ~~~y) - 2 *  ~~~(x |||  ~~~y) - 2 * (x &&&  ~~~y) + 4 * (x &&& y) =  - 2 *  ~~~x + 1 *  ~~~(x ||| y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_164 (x y : BitVec w) :
    7 *  ~~~x - 2 *  ~~~(x &&& y) + 1 * y - 6 *  ~~~(x |||  ~~~y) - 3 * (x &&&  ~~~y) - 1 * (x &&& y) =  - 5 *  ~~~y + 10 *  ~~~(x ||| y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_165 (x y : BitVec w) :
    1 * x + 1 *  ~~~(x &&&  ~~~x) - 11 * (x ^^^ y) + 1 *  ~~~(x ||| y) + 10 *  ~~~(x |||  ~~~y) + 11 * (x &&&  ~~~y) = 2 *  ~~~y + 2 * (x &&& y) := by
  bv_automata_circuit (config := { cadical := true })

theorem e_166 (x y : BitVec w) :
     - 7 * (x ^^^ y) + 3 * (x |||  ~~~y) - 2 *  ~~~(x ||| y) - 4 *  ~~~(x |||  ~~~y) + 4 * (x &&&  ~~~y) - 13 * (x &&& y) = 1 *  ~~~(x ^^^ y) - 11 * y := by
  bv_automata_circuit (config := { cadical := true })

theorem e_167 (x y : BitVec w) :
    2 *  ~~~(x &&&  ~~~y) - 6 *  ~~~y - 5 *  ~~~(x ^^^ y) + 1 *  ~~~(x &&&  ~~~x) + 8 *  ~~~(x ||| y) + 5 * (x &&&  ~~~y) =  - 2 * (x &&& y) + 3 *  ~~~(x |||  ~~~y) := by
