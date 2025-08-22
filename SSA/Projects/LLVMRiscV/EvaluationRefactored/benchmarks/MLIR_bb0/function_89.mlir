{
^bb0(%arg0: i1):
%0 = "llvm.sext"(%arg0) : (i1) -> i64
%1 = "llvm.srem"(%0, %0) {isExactFlag} : (i64, i64) -> i64
"llvm.return"(%1) : (i64) -> ()
}
