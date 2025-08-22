{
^bb0(%arg0: i64):
%0 = "llvm.lshr"(%arg0, %arg0) {isExactFlag} : (i64, i64) -> i64
%1 = "llvm.xor"(%0, %arg0) : (i64, i64) -> i64
"llvm.return"(%1) : (i64) -> ()
}
