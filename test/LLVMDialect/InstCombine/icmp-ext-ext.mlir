module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @zext_zext_sgt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.icmp "sgt" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @zext_zext_ugt(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.zext %arg0 : vector<2xi8> to vector<2xi32>
    %1 = llvm.zext %arg1 : vector<2xi8> to vector<2xi32>
    %2 = llvm.icmp "ugt" %0, %1 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @zext_zext_eq(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.icmp "eq" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @zext_zext_sle_op0_narrow(%arg0: i8, %arg1: i16) -> i1 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.zext %arg1 : i16 to i32
    %2 = llvm.icmp "sle" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @zext_zext_ule_op0_wide(%arg0: i9, %arg1: i8) -> i1 {
    %0 = llvm.zext %arg0 : i9 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.icmp "ule" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @sext_sext_slt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sext %arg0 : i8 to i32
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.icmp "slt" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @sext_sext_ult(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sext %arg0 : i8 to i32
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.icmp "ult" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @sext_sext_ne(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sext %arg0 : i8 to i32
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.icmp "ne" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @sext_sext_sge_op0_narrow(%arg0: i5, %arg1: i8) -> i1 {
    %0 = llvm.sext %arg0 : i5 to i32
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.icmp "sge" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @sext_sext_uge_op0_wide(%arg0: vector<2xi16>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.sext %arg0 : vector<2xi16> to vector<2xi32>
    %1 = llvm.sext %arg1 : vector<2xi8> to vector<2xi32>
    %2 = llvm.icmp "uge" %0, %1 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @zext_sext_sgt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.icmp "sgt" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @zext_nneg_sext_sgt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.icmp "sgt" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @zext_sext_ugt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.icmp "ugt" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @zext_nneg_sext_ugt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.icmp "ugt" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @zext_sext_eq(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.icmp "eq" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @zext_nneg_sext_eq(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.icmp "eq" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @zext_sext_sle_op0_narrow(%arg0: i8, %arg1: i16) -> i1 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.sext %arg1 : i16 to i32
    %2 = llvm.icmp "sle" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @zext_nneg_sext_sle_op0_narrow(%arg0: i8, %arg1: i16) -> i1 {
    %0 = llvm.zext %arg0 : i8 to i32
    %1 = llvm.sext %arg1 : i16 to i32
    %2 = llvm.icmp "sle" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @zext_sext_ule_op0_wide(%arg0: i9, %arg1: i8) -> i1 {
    %0 = llvm.zext %arg0 : i9 to i32
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.icmp "ule" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @zext_nneg_sext_ule_op0_wide(%arg0: i9, %arg1: i8) -> i1 {
    %0 = llvm.zext %arg0 : i9 to i32
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.icmp "ule" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @sext_zext_slt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sext %arg0 : i8 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.icmp "slt" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @sext_zext_nneg_slt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sext %arg0 : i8 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.icmp "slt" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @sext_zext_ult(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sext %arg0 : i8 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.icmp "ult" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @sext_zext_nneg_ult(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.sext %arg0 : i8 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.icmp "ult" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @sext_zext_ne(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    %1 = llvm.zext %arg1 : vector<2xi8> to vector<2xi32>
    %2 = llvm.icmp "ne" %0, %1 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @sext_zext_nneg_ne(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.sext %arg0 : vector<2xi8> to vector<2xi32>
    %1 = llvm.zext %arg1 : vector<2xi8> to vector<2xi32>
    %2 = llvm.icmp "ne" %0, %1 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @sext_zext_sge_op0_narrow(%arg0: i5, %arg1: i8) -> i1 {
    %0 = llvm.sext %arg0 : i5 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.icmp "sge" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @sext_zext_nneg_sge_op0_narrow(%arg0: i5, %arg1: i8) -> i1 {
    %0 = llvm.sext %arg0 : i5 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.icmp "sge" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @sext_zext_uge_op0_wide(%arg0: i16, %arg1: i8) -> i1 {
    %0 = llvm.sext %arg0 : i16 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.icmp "uge" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @sext_zext_nneg_uge_op0_wide(%arg0: i16, %arg1: i8) -> i1 {
    %0 = llvm.sext %arg0 : i16 to i32
    %1 = llvm.zext %arg1 : i8 to i32
    %2 = llvm.icmp "uge" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @zext_sext_sgt_known_nonneg(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.udiv %0, %arg0  : i8
    %2 = llvm.zext %1 : i8 to i32
    %3 = llvm.sext %arg1 : i8 to i32
    %4 = llvm.icmp "sgt" %2, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @zext_sext_ugt_known_nonneg(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.zext %1 : i8 to i32
    %3 = llvm.sext %arg1 : i8 to i32
    %4 = llvm.icmp "ugt" %2, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @zext_sext_eq_known_nonneg(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.lshr %arg0, %0  : i8
    %2 = llvm.zext %1 : i8 to i32
    %3 = llvm.sext %arg1 : i8 to i32
    %4 = llvm.icmp "eq" %2, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @zext_sext_sle_known_nonneg_op0_narrow(%arg0: i8, %arg1: i16) -> i1 {
    %0 = llvm.mlir.constant(12 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.zext %1 : i8 to i32
    %3 = llvm.sext %arg1 : i16 to i32
    %4 = llvm.icmp "sle" %2, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @zext_sext_ule_known_nonneg_op0_wide(%arg0: i9, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(254 : i9) : i9
    %1 = llvm.urem %arg0, %0  : i9
    %2 = llvm.zext %1 : i9 to i32
    %3 = llvm.sext %arg1 : i8 to i32
    %4 = llvm.icmp "ule" %2, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @sext_zext_slt_known_nonneg(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(126 : i8) : i8
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.zext %2 : i8 to i32
    %4 = llvm.icmp "slt" %1, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @sext_zext_ult_known_nonneg(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.lshr %arg1, %0  : i8
    %3 = llvm.zext %2 : i8 to i32
    %4 = llvm.icmp "ult" %1, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @sext_zext_ne_known_nonneg(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.udiv %arg1, %0  : i8
    %3 = llvm.zext %2 : i8 to i32
    %4 = llvm.icmp "ne" %1, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @sext_zext_sge_known_nonneg_op0_narrow(%arg0: vector<2xi5>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.sext %arg0 : vector<2xi5> to vector<2xi32>
    %1 = llvm.mul %arg1, %arg1 overflow<nsw>  : vector<2xi8>
    %2 = llvm.zext %1 : vector<2xi8> to vector<2xi32>
    %3 = llvm.icmp "sge" %0, %2 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @sext_zext_uge_known_nonneg_op0_wide(%arg0: i16, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(12 : i8) : i8
    %1 = llvm.sext %arg0 : i16 to i32
    %2 = llvm.and %arg1, %0  : i8
    %3 = llvm.zext %2 : i8 to i32
    %4 = llvm.icmp "uge" %1, %3 : i32
    llvm.return %4 : i1
  }
  llvm.func @zext_eq_sext(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i32
    %1 = llvm.sext %arg1 : i1 to i32
    %2 = llvm.icmp "eq" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @zext_eq_sext_fail_not_i1(%arg0: i1, %arg1: i8) -> i1 {
    %0 = llvm.zext %arg0 : i1 to i32
    %1 = llvm.sext %arg1 : i8 to i32
    %2 = llvm.icmp "eq" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @zext_ne_sext(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.zext %arg0 : vector<2xi1> to vector<2xi8>
    %1 = llvm.sext %arg1 : vector<2xi1> to vector<2xi8>
    %2 = llvm.icmp "ne" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }
}
