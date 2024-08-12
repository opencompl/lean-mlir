module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @eq_t_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg0, %1  : vector<2xi1>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @eq_f_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.xor %arg0, %1  : vector<2xi1>
    %5 = llvm.icmp "eq" %4, %3 : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @ne_t_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg0, %1  : vector<2xi1>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @ne_f_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.xor %arg0, %1  : vector<2xi1>
    %5 = llvm.icmp "ne" %4, %3 : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @ugt_t_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg0, %1  : vector<2xi1>
    %3 = llvm.icmp "ugt" %2, %1 : vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @ugt_f_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.xor %arg0, %1  : vector<2xi1>
    %5 = llvm.icmp "ugt" %4, %3 : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @ult_t_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg0, %1  : vector<2xi1>
    %3 = llvm.icmp "ult" %2, %1 : vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @ult_f_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.xor %arg0, %1  : vector<2xi1>
    %5 = llvm.icmp "ult" %4, %3 : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @sgt_t_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg0, %1  : vector<2xi1>
    %3 = llvm.icmp "sgt" %2, %1 : vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @sgt_f_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.xor %arg0, %1  : vector<2xi1>
    %5 = llvm.icmp "sgt" %4, %3 : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @slt_t_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg0, %1  : vector<2xi1>
    %3 = llvm.icmp "slt" %2, %1 : vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @slt_f_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.xor %arg0, %1  : vector<2xi1>
    %5 = llvm.icmp "slt" %4, %3 : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @uge_t_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg0, %1  : vector<2xi1>
    %3 = llvm.icmp "uge" %2, %1 : vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @uge_f_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.xor %arg0, %1  : vector<2xi1>
    %5 = llvm.icmp "uge" %4, %3 : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @ule_t_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg0, %1  : vector<2xi1>
    %3 = llvm.icmp "ule" %2, %1 : vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @ule_f_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.xor %arg0, %1  : vector<2xi1>
    %5 = llvm.icmp "ule" %4, %3 : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @sge_t_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg0, %1  : vector<2xi1>
    %3 = llvm.icmp "sge" %2, %1 : vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @sge_f_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.xor %arg0, %1  : vector<2xi1>
    %5 = llvm.icmp "sge" %4, %3 : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @sle_t_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg0, %1  : vector<2xi1>
    %3 = llvm.icmp "sle" %2, %1 : vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @sle_f_not(%arg0: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %4 = llvm.xor %arg0, %1  : vector<2xi1>
    %5 = llvm.icmp "sle" %4, %3 : vector<2xi1>
    llvm.return %5 : vector<2xi1>
  }
}
