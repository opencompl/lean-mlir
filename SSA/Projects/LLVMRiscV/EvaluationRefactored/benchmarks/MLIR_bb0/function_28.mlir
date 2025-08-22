{
^bb0(%arg0: i1):
%0 = "llvm.zext"(%arg0) : (i1) -> i64
"llvm.return"(%0) : (i64) -> ()
}
