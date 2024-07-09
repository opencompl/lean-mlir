module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @sgt_3_impliesF_eq_2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.icmp "sgt" %arg0, %0 : i8
    %3 = llvm.select %2, %1, %arg1 : i1, i8
    %4 = llvm.icmp "eq" %3, %arg0 : i8
    llvm.return %4 : i1
  }
  llvm.func @sgt_3_impliesT_sgt_2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.icmp "sgt" %arg0, %0 : i8
    %3 = llvm.select %2, %1, %arg1 : i1, i8
    %4 = llvm.icmp "sgt" %3, %arg0 : i8
    llvm.return %4 : i1
  }
  llvm.func @sgt_x_impliesF_eq_smin_todo(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %arg2 : i8
    %2 = llvm.select %1, %0, %arg1 : i1, i8
    %3 = llvm.icmp "eq" %2, %arg0 : i8
    llvm.return %3 : i1
  }
  llvm.func @slt_x_impliesT_ne_smin_todo(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %arg2 : i8
    %2 = llvm.select %1, %0, %arg1 : i1, i8
    %3 = llvm.icmp "ne" %arg0, %2 : i8
    llvm.return %3 : i1
  }
  llvm.func @ult_x_impliesT_eq_umax_todo(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ugt" %arg2, %arg0 : i8
    %2 = llvm.select %1, %0, %arg1 : i1, i8
    %3 = llvm.icmp "ne" %2, %arg0 : i8
    llvm.return %3 : i1
  }
  llvm.func @ult_1_impliesF_eq_1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %0 : i8
    %2 = llvm.select %1, %0, %arg1 : i1, i8
    %3 = llvm.icmp "eq" %arg0, %2 : i8
    llvm.return %3 : i1
  }
  llvm.func @ugt_x_impliesF_eq_umin_todo(%arg0: i8, %arg1: i8, %arg2: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ugt" %arg2, %arg0 : i8
    %2 = llvm.select %1, %0, %arg1 : i1, i8
    %3 = llvm.icmp "eq" %arg0, %2 : i8
    llvm.return %3 : i1
  }
}
