



def lhs (x x' : BitVec 4 ) :=  BitVec.ofBool (BitVec.slt x  x')

def rhs (x x' : BitVec 4 ) := BitVec.signExtend 1 (BitVec.setWidth 8 (BitVec.ofBool (BitVec.slt (BitVec.setWidth 8 x) (BitVec.setWidth 8 x'))))

def rhs1 (x x' : BitVec 4 ) := BitVec.signExtend 1 (BitVec.setWidth 8 (BitVec.ofBool (BitVec.slt (BitVec.setWidth 8 x) (BitVec.setWidth 8 x'))))
def rhs2 (x x' : BitVec 4 ) := (BitVec.ofBool (BitVec.slt (BitVec.setWidth 8 x) (BitVec.setWidth 8 x')))
def test : IO Unit :=
  have w := 4
  for xx in [0 : 2^w] do
    for yy in [0 : 2^w] do
      have x := BitVec.ofNat 4 xx
      have y := BitVec.ofNat 4 yy
      IO.print f!"
       lhs {x}  {y} = rhs  {x}  {y}"

      if (lhs x y)  ≠ (rhs x y) then
        IO.println f!"
        Testing  {x}  {y}
        original  :  {lhs x  y}

        signExtened :  { rhs  x  y}
        rhs 2 is  :  { rhs2  x  y} where
        {(BitVec.setWidth 8 x)}  and
        {(BitVec.setWidth 8 y)}
        }
         "

        IO.println "FAIL"

      IO.println ""
    IO.println ""

#eval test
