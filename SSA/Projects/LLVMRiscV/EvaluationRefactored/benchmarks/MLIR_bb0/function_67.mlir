{
^bb0(%arg0: i64, %arg1: i64):
%0 = "llvm.srem"(%arg0, %arg1) {isExactFlag} : (i64, i64) -> i64
"llvm.return"(%0) : (i64) -> ()
}
