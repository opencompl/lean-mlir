module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use.i8(i8)
  llvm.func @sdiv_exact_eq_0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sdiv %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @udiv_exact_ne_0(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.udiv %arg0, %arg1  : i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @sdiv_exact_ne_1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.sdiv %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @udiv_exact_eq_1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.udiv %arg0, %arg1  : i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @sdiv_exact_eq_9_no_of(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(9 : i8) : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.sdiv %arg0, %2  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @sdiv_exact_eq_9_may_of(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(9 : i8) : i8
    %1 = llvm.sdiv %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @sdiv_exact_eq_9_no_of_fail_multiuse(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(9 : i8) : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.sdiv %arg0, %2  : i8
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @sdiv_exact_eq_9_must_of_todo_is_false(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(55 : i8) : i8
    %1 = llvm.mlir.constant(9 : i8) : i8
    %2 = llvm.or %arg1, %0  : i8
    %3 = llvm.sdiv %arg0, %2  : i8
    %4 = llvm.icmp "eq" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @udiv_exact_ne_30_no_of(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(30 : i8) : i8
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.udiv %arg0, %2  : i8
    %4 = llvm.icmp "ne" %3, %1 : i8
    llvm.return %4 : i1
  }
}
