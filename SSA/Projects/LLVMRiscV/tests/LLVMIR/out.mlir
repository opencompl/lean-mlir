{
  ^bb0(%arg10: i32, %arg11: i32, %arg12: i1):
    %14 = "llvm.select"(%arg12, %arg10, %arg11) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
    "llvm.return"(%14) : (i32) -> ()
}
