import Std.Data.BitVec

def ofBool : (Bool) -> Std.BitVec 1
 | c => if c then 1 else 0
