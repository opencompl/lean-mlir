module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @v0_select_of_consts(%arg0: i32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %2, %0, %1 : i1, i32
    llvm.store %4, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    %5 = llvm.xor %2, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @v1_select_of_var_and_const(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %2, %arg1, %1 : i1, i32
    llvm.store %4, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    %5 = llvm.xor %2, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @v2_select_of_const_and_var(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %2, %0, %arg1 : i1, i32
    llvm.store %4, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    %5 = llvm.xor %2, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @v3_branch(%arg0: i32, %arg1: !llvm.ptr, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.icmp "sgt" %arg0, %1 : i32
    llvm.cond_br %3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %2, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %2, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    %5 = llvm.xor %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @v4_not_store(%arg0: i32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(-32768 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.xor %3, %1  : i1
    llvm.store %4, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    %5 = llvm.icmp "sgt" %arg0, %2 : i32
    %6 = llvm.select %3, %0, %2 : i1, i32
    %7 = llvm.xor %3, %5  : i1
    llvm.return %7 : i1
  }
  llvm.func @v5_select_and_not(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.icmp "sgt" %arg0, %1 : i32
    %5 = llvm.select %3, %0, %arg1 : i1, i32
    %6 = llvm.xor %3, %2  : i1
    llvm.store %6, %arg3 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.store %5, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    %7 = llvm.xor %3, %4  : i1
    llvm.return %7 : i1
  }
  llvm.func @n6_select_and_not(%arg0: i32, %arg1: i32, %arg2: !llvm.ptr, %arg3: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %2, %0, %arg1 : i1, i32
    llvm.store %2, %arg3 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.store %4, %arg2 {alignment = 4 : i64} : i32, !llvm.ptr
    %5 = llvm.xor %2, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @n7_store(%arg0: i32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(32767 : i32) : i32
    %1 = llvm.mlir.constant(-32768 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.store %2, %arg1 {alignment = 1 : i64} : i1, !llvm.ptr
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %2, %0, %1 : i1, i32
    %5 = llvm.xor %2, %3  : i1
    llvm.return %5 : i1
  }
}
