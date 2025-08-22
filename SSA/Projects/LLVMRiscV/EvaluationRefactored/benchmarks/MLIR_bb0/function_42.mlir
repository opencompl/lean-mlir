{
^bb0(%arg0: i64):
%0 = "llvm.srem"(%arg0, %arg0) : (i64, i64) -> i64
%1 = "llvm.or"(%arg0, %0) {isDisjointFlag} : (i64, i64) -> i64
"llvm.return"(%1) : (i64) -> ()
}
