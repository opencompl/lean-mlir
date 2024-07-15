module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use.i1(i1)
  llvm.func @use.i8(i8)
  llvm.func @replace_with_y_noundef(%arg0: i8, %arg1: i8 {llvm.noundef}, %arg2: i8) -> i8 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i8
    %1 = llvm.and %arg0, %arg1  : i8
    %2 = llvm.select %0, %1, %arg2 : i1, i8
    llvm.return %2 : i8
  }
  llvm.func @replace_with_x_noundef(%arg0: i8 {llvm.noundef}, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i8
    llvm.call @use.i1(%0) : (i1) -> ()
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.select %0, %arg2, %1 : i1, i8
    llvm.return %2 : i8
  }
  llvm.func @replace_with_x_maybe_undef_fail(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.icmp "ne" %arg0, %arg1 : i8
    llvm.call @use.i1(%0) : (i1) -> ()
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.select %0, %arg2, %1 : i1, i8
    llvm.return %2 : i8
  }
  llvm.func @replace_with_y_for_new_oneuse(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(13 : i8) : i8
    %1 = llvm.mul %arg0, %0  : i8
    %2 = llvm.icmp "eq" %1, %arg1 : i8
    %3 = llvm.add %1, %arg1 overflow<nuw>  : i8
    %4 = llvm.select %2, %3, %arg2 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @replace_with_y_for_new_oneuse2(%arg0: i8, %arg1: i8 {llvm.noundef}, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(13 : i8) : i8
    %1 = llvm.mul %arg0, %0  : i8
    %2 = llvm.icmp "eq" %1, %arg1 : i8
    %3 = llvm.add %1, %arg3 overflow<nuw>  : i8
    %4 = llvm.select %2, %3, %arg2 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @replace_with_x_for_new_oneuse(%arg0: i8 {llvm.noundef}, %arg1: i8 {llvm.noundef}, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(13 : i8) : i8
    %1 = llvm.mul %arg0, %0  : i8
    %2 = llvm.add %arg1, %arg3  : i8
    %3 = llvm.icmp "eq" %1, %2 : i8
    %4 = llvm.mul %1, %2  : i8
    %5 = llvm.select %3, %4, %arg2 : i1, i8
    llvm.return %5 : i8
  }
  llvm.func @replace_with_x_for_new_oneuse2(%arg0: i8 {llvm.noundef}, %arg1: i8, %arg2: i8, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(13 : i8) : i8
    %1 = llvm.mul %arg0, %0  : i8
    %2 = llvm.add %arg1, %arg3  : i8
    %3 = llvm.icmp "eq" %1, %2 : i8
    %4 = llvm.mul %arg4, %2  : i8
    %5 = llvm.select %3, %4, %arg2 : i1, i8
    llvm.return %5 : i8
  }
  llvm.func @replace_with_x_for_simple_binop(%arg0: i8 {llvm.noundef}, %arg1: i8, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(13 : i8) : i8
    %1 = llvm.mul %arg0, %0  : i8
    %2 = llvm.add %arg1, %arg3  : i8
    %3 = llvm.icmp "eq" %1, %2 : i8
    %4 = llvm.mul %1, %2  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %5 = llvm.select %3, %4, %arg2 : i1, i8
    llvm.return %5 : i8
  }
  llvm.func @replace_with_none_for_new_oneuse_fail_maybe_undef(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(13 : i8) : i8
    %1 = llvm.mul %arg0, %0  : i8
    %2 = llvm.icmp "eq" %1, %arg1 : i8
    %3 = llvm.mul %1, %arg1  : i8
    %4 = llvm.select %2, %3, %arg2 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @replace_with_y_for_simple_binop(%arg0: i8, %arg1: i8 {llvm.noundef}, %arg2: i8) -> i8 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i8
    %1 = llvm.mul %arg0, %arg1 overflow<nsw>  : i8
    %2 = llvm.select %0, %1, %arg2 : i1, i8
    llvm.return %2 : i8
  }
  llvm.func @replace_with_y_for_simple_binop_fail_multiuse(%arg0: i8, %arg1: i8 {llvm.noundef}, %arg2: i8) -> i8 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i8
    %1 = llvm.mul %arg0, %arg1 overflow<nsw>  : i8
    %2 = llvm.select %0, %1, %arg2 : i1, i8
    llvm.call @use.i8(%1) : (i8) -> ()
    llvm.return %2 : i8
  }
  llvm.func @replace_with_y_for_simple_binop_fail(%arg0: i8, %arg1: i8 {llvm.noundef}, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.icmp "eq" %arg0, %arg1 : i8
    %1 = llvm.mul %arg0, %arg3 overflow<nsw>  : i8
    %2 = llvm.select %0, %1, %arg2 : i1, i8
    llvm.return %2 : i8
  }
}
