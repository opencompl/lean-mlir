
-- TODO: move these tests to a separate file.
---- Failing Tests
import Medusa.BitVec.BVGeneralize

set_option trace.profiler true
set_option trace.profiler.threshold 1
set_option trace.Generalize true


variable {x y : BitVec 32}

#generalize BitVec.signExtend 34 (BitVec.zeroExtend 33 x) = BitVec.zeroExtend 34 x

