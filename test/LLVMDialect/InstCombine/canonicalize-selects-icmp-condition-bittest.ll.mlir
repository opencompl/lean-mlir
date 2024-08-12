module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use8(i8)
  llvm.func @use1(i1)
  llvm.func @p0(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    %3 = llvm.select %2, %arg1, %arg2 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @p1(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    %4 = llvm.select %3, %arg1, %arg2 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @n2(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.call @use1(%2) : (i1) -> ()
    %3 = llvm.select %2, %arg1, %arg2 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @t3(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8, %arg5: !llvm.ptr, %arg6: i1) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.cond_br %arg6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.select %2, %arg1, %arg2 : i1, i8
    llvm.store %3, %arg5 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %4 = llvm.select %2, %arg3, %arg4 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @t4(%arg0: i8, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8, %arg5: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    %4 = llvm.select %3, %arg1, %arg2 : i1, i8
    llvm.store %4, %arg5 {alignment = 1 : i64} : i8, !llvm.ptr
    %5 = llvm.select %3, %arg3, %arg4 : i1, i8
    llvm.return %5 : i8
  }
  llvm.func @n5(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    %4 = llvm.select %3, %arg1, %arg2 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @n6(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    %4 = llvm.select %3, %arg1, %arg2 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @n7(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    %3 = llvm.select %2, %arg1, %arg2 : i1, i8
    llvm.return %3 : i8
  }
  llvm.func @n8(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    %4 = llvm.select %3, %arg1, %arg2 : i1, i8
    llvm.return %4 : i8
  }
}
