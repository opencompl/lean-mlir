module {
  func.func @main(%arg0: i64) -> i1 attributes {seed = 168 : index} {
    %0 = llvm.srem %arg0, %arg0 {isExactFlag} : i64
    %1 = llvm.icmp "eq" %0, %0 : i64
    return %1 : i1
  }
}
