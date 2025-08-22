{
^bb0(%arg0: i64, %arg1: i64):
%0 = "llvm.udiv"(%arg0, %arg1) {isExactFlag} : (i64, i64) -> i64
%1 = "llvm.ashr"(%0, %0) {isExactFlag} : (i64, i64) -> i64
"llvm.return"(%1) : (i64) -> ()
}
