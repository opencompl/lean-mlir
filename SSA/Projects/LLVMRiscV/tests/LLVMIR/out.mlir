{
  ^bb0(%arg2: i64, %arg3: i64):
    %1 = "llvm.xor"(%arg2, %arg3) : (i64, i64) -> i64
    "llvm.return"(%1) : (i64) -> ()
}
