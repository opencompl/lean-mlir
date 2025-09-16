import SSA.Projects.InstCombine.LLVM.PrettyEDSL

def test1_before := [llvm|
{
  ^bb0(%0: i64, %1: i1):
    "llvm.return"(%0) : (i64) -> ()
}
]

/--
info: "builtin.module { \n^bb0(%0 : i1, %1 : i64):\n  \"llvm.return\"(%0) : (i64) -> ()\n }"
-/
#guard_msgs in #eval test1_before.toPrint
