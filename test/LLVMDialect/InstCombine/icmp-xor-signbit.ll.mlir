module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @slt_to_ult(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.icmp "slt" %1, %2 : i8
    llvm.return %3 : i1
  }
  llvm.func @slt_to_ult_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.xor %arg0, %0  : vector<2xi8>
    %2 = llvm.xor %arg1, %0  : vector<2xi8>
    %3 = llvm.icmp "slt" %1, %2 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @ult_to_slt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.icmp "ult" %1, %2 : i8
    llvm.return %3 : i1
  }
  llvm.func @ult_to_slt_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.xor %arg0, %0  : vector<2xi8>
    %2 = llvm.xor %arg1, %0  : vector<2xi8>
    %3 = llvm.icmp "ult" %1, %2 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @slt_to_ugt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.icmp "slt" %1, %2 : i8
    llvm.return %3 : i1
  }
  llvm.func @slt_to_ugt_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.xor %arg0, %0  : vector<2xi8>
    %2 = llvm.xor %arg1, %0  : vector<2xi8>
    %3 = llvm.icmp "slt" %1, %2 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @ult_to_sgt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.icmp "ult" %1, %2 : i8
    llvm.return %3 : i1
  }
  llvm.func @ult_to_sgt_splat(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.xor %arg0, %0  : vector<2xi8>
    %2 = llvm.xor %arg1, %0  : vector<2xi8>
    %3 = llvm.icmp "ult" %1, %2 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @sge_to_ugt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(15 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.icmp "sge" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @sge_to_ugt_splat(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<15> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.xor %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "sge" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @uge_to_sgt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(15 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.icmp "uge" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @uge_to_sgt_splat(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<15> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.xor %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "uge" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @sge_to_ult(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(15 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.icmp "sge" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @sge_to_ult_splat(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<15> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.xor %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "sge" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @uge_to_slt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(15 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.icmp "uge" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @uge_to_slt_splat(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<15> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.xor %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "uge" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @sgt_to_ugt_bitcasted_splat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<8xi1> {
    %0 = llvm.mlir.constant(dense<-2139062144> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.xor %arg0, %0  : vector<2xi32>
    %2 = llvm.xor %arg1, %0  : vector<2xi32>
    %3 = llvm.bitcast %1 : vector<2xi32> to vector<8xi8>
    %4 = llvm.bitcast %2 : vector<2xi32> to vector<8xi8>
    %5 = llvm.icmp "sgt" %3, %4 : vector<8xi8>
    llvm.return %5 : vector<8xi1>
  }
  llvm.func @negative_simplify_splat(%arg0: vector<4xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[0, -128, 0, -128]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.mlir.constant(dense<0> : vector<2xi16>) : vector<2xi16>
    %3 = llvm.or %arg0, %0  : vector<4xi8>
    %4 = llvm.bitcast %3 : vector<4xi8> to vector<2xi16>
    %5 = llvm.icmp "sgt" %4, %2 : vector<2xi16>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @slt_zero_eq_i1(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.zext %arg1 : i1 to i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.icmp "eq" %1, %2 : i32
    llvm.return %3 : i1
  }
  llvm.func @slt_zero_eq_i1_fail(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.zext %arg1 : i1 to i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.icmp "eq" %1, %2 : i32
    llvm.return %3 : i1
  }
  llvm.func @slt_zero_eq_ne_0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.icmp "eq" %3, %4 : i32
    llvm.return %5 : i1
  }
  llvm.func @slt_zero_ne_ne_0(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.icmp "ne" %3, %4 : i32
    llvm.return %5 : i1
  }
  llvm.func @slt_zero_eq_ne_0_vec(%arg0: vector<4xi32>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(dense<31> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.icmp "ne" %arg0, %1 : vector<4xi32>
    %4 = llvm.zext %3 : vector<4xi1> to vector<4xi32>
    %5 = llvm.lshr %arg0, %2  : vector<4xi32>
    %6 = llvm.icmp "eq" %4, %5 : vector<4xi32>
    llvm.return %6 : vector<4xi1>
  }
  llvm.func @slt_zero_ne_ne_b(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %arg1 : i32
    %2 = llvm.zext %1 : i1 to i32
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.icmp "ne" %2, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @slt_zero_eq_ne_0_fail1(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.ashr %arg0, %1  : i32
    %5 = llvm.icmp "eq" %3, %4 : i32
    llvm.return %5 : i1
  }
  llvm.func @slt_zero_eq_ne_0_fail2(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.lshr %arg0, %1  : i32
    %5 = llvm.icmp "eq" %3, %4 : i32
    llvm.return %5 : i1
  }
}
