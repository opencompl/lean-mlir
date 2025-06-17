module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 238 : index} {
    %0 = llvm.ashr %arg0, %arg0 : i64
    %1 = llvm.icmp "ule" %0, %arg0 : i64
    return %1 : i1
  }
}
