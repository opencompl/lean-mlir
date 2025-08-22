{
^bb0(%arg0: i64):
%0 = "llvm.udiv"(%arg0, %arg0) {isExactFlag} : (i64, i64) -> i64
%1 = "llvm.srem"(%arg0, %0) {isExactFlag} : (i64, i64) -> i64
"llvm.return"(%1) : (i64) -> ()
}
