module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @barrier() -> i1
  llvm.func @use.i8(i8)
  llvm.func @icmp_ult_x_y(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.and %arg0, %arg1  : i8
    %1 = llvm.icmp "ult" %0, %arg0 : i8
    llvm.return %1 : i1
  }
  llvm.func @icmp_ult_x_y_2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mul %arg0, %arg0  : i8
    %1 = llvm.and %0, %arg1  : i8
    %2 = llvm.icmp "ugt" %0, %1 : i8
    llvm.return %2 : i1
  }
  llvm.func @icmp_uge_x_y(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.and %arg0, %arg1  : vector<2xi8>
    %1 = llvm.icmp "uge" %0, %arg0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }
  llvm.func @icmp_uge_x_y_2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mul %arg0, %arg0  : i8
    %1 = llvm.and %0, %arg1  : i8
    %2 = llvm.icmp "ule" %0, %1 : i8
    llvm.return %2 : i1
  }
  llvm.func @icmp_sge_x_negy(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg1, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.and %arg0, %arg1  : i8
    %3 = llvm.icmp "sge" %2, %arg0 : i8
    llvm.return %3 : i1
  }
  llvm.func @icmp_slt_x_negy(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg1, %0 : i8
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.and %arg0, %arg1  : i8
    %3 = llvm.icmp "slt" %2, %arg0 : i8
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    %4 = llvm.call @barrier() : () -> i1
    llvm.return %4 : i1
  }
  llvm.func @icmp_slt_x_negy_fail_maybe_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "sle" %arg1, %0 : i8
    llvm.cond_br %1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.and %arg0, %arg1  : i8
    %3 = llvm.icmp "slt" %2, %arg0 : i8
    llvm.return %3 : i1
  ^bb2:  // pred: ^bb0
    %4 = llvm.call @barrier() : () -> i1
    llvm.return %4 : i1
  }
  llvm.func @icmp_sle_x_negy(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.or %arg1, %0  : i8
    %2 = llvm.and %1, %arg0  : i8
    %3 = llvm.icmp "sle" %2, %arg0 : i8
    llvm.return %3 : i1
  }
  llvm.func @icmp_sgt_x_negy(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.or %arg1, %0  : vector<2xi8>
    %2 = llvm.and %1, %arg0  : vector<2xi8>
    %3 = llvm.icmp "sgt" %2, %arg0 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @icmp_sgt_x_negy_fail_partial(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-128, 4]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.or %arg1, %0  : vector<2xi8>
    %2 = llvm.and %1, %arg0  : vector<2xi8>
    %3 = llvm.icmp "sgt" %2, %arg0 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @icmp_sle_x_posy(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.and %arg1, %0  : vector<2xi8>
    %2 = llvm.and %1, %arg0  : vector<2xi8>
    %3 = llvm.icmp "sle" %2, %arg0 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @icmp_sle_x_posy_fail_partial(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[127, -65]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.and %arg1, %0  : vector<2xi8>
    %2 = llvm.and %1, %arg0  : vector<2xi8>
    %3 = llvm.icmp "sle" %2, %arg0 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @icmp_sgt_x_posy(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "sge" %arg1, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.and %arg0, %arg1  : i8
    %3 = llvm.icmp "sgt" %2, %arg0 : i8
    llvm.return %3 : i1
  }
  llvm.func @icmp_sgt_negx_y(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.or %arg0, %0  : vector<2xi8>
    %2 = llvm.and %1, %arg1  : vector<2xi8>
    %3 = llvm.icmp "sgt" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @icmp_sle_negx_y(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.and %arg0, %arg1  : i8
    %3 = llvm.icmp "sle" %2, %arg0 : i8
    llvm.return %3 : i1
  }
  llvm.func @icmp_sle_negx_y_fail_maybe_zero(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "sle" %arg0, %0 : i8
    "llvm.intr.assume"(%1) : (i1) -> ()
    %2 = llvm.and %arg0, %arg1  : i8
    %3 = llvm.icmp "sle" %2, %arg0 : i8
    llvm.return %3 : i1
  }
  llvm.func @icmp_eq_x_invertable_y_todo(%arg0: i8, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(24 : i8) : i8
    %2 = llvm.select %arg1, %0, %1 : i1, i8
    %3 = llvm.and %arg0, %2  : i8
    %4 = llvm.icmp "eq" %arg0, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @icmp_eq_x_invertable_y(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    %2 = llvm.and %arg0, %1  : i8
    %3 = llvm.icmp "eq" %arg0, %2 : i8
    llvm.return %3 : i1
  }
  llvm.func @icmp_eq_x_invertable_y_fail_multiuse(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    %2 = llvm.and %arg0, %1  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %arg0, %2 : i8
    llvm.return %3 : i1
  }
  llvm.func @icmp_eq_x_invertable_y2_todo(%arg0: i8, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(24 : i8) : i8
    %2 = llvm.select %arg1, %0, %1 : i1, i8
    %3 = llvm.and %arg0, %2  : i8
    %4 = llvm.icmp "eq" %2, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @icmp_eq_x_invertable_y2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg1, %0  : i8
    %2 = llvm.and %arg0, %1  : i8
    %3 = llvm.icmp "eq" %1, %2 : i8
    llvm.return %3 : i1
  }
  llvm.func @icmp_eq_x_invertable_y_fail_immconstant(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }
}
