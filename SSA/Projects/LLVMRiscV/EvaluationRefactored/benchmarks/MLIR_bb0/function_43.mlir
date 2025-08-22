{
^bb0(%arg0: i64):
%0 = "llvm.and"(%arg0, %arg0) : (i64, i64) -> i64
"llvm.return"(%0) : (i64) -> ()
}
