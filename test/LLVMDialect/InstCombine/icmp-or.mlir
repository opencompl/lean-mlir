module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i8)
  llvm.func @set_low_bit_mask_eq(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(19 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @set_low_bit_mask_ne(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<3> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<19> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.or %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @set_low_bit_mask_ugt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(19 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @set_low_bit_mask_ult(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(19 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @set_low_bit_mask_uge(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(20 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.icmp "uge" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @set_low_bit_mask_ule(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(18 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.icmp "ule" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @set_low_bit_mask_sgt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(20 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @set_low_bit_mask_slt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.mlir.constant(19 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @set_low_bit_mask_sge(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(31 : i8) : i8
    %1 = llvm.mlir.constant(51 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.icmp "sge" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @set_low_bit_mask_sle(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(63 : i8) : i8
    %1 = llvm.mlir.constant(68 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.icmp "sle" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @eq_const_mask(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.or %arg1, %0  : i8
    %3 = llvm.icmp "eq" %1, %2 : i8
    llvm.return %3 : i1
  }
  llvm.func @ne_const_mask(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-106, 5]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.or %arg0, %0  : vector<2xi8>
    %2 = llvm.or %arg1, %0  : vector<2xi8>
    %3 = llvm.icmp "ne" %1, %2 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @eq_const_mask_not_equality(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.or %arg1, %0  : i8
    %3 = llvm.icmp "sgt" %1, %2 : i8
    llvm.return %3 : i1
  }
  llvm.func @eq_const_mask_not_same(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.or %arg1, %1  : i8
    %4 = llvm.icmp "eq" %2, %3 : i8
    llvm.return %4 : i1
  }
  llvm.func @eq_const_mask_wrong_opcode(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.icmp "eq" %1, %2 : i8
    llvm.return %3 : i1
  }
  llvm.func @eq_const_mask_use1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    llvm.call @use(%1) : (i8) -> ()
    %2 = llvm.or %arg1, %0  : i8
    %3 = llvm.icmp "eq" %1, %2 : i8
    llvm.return %3 : i1
  }
  llvm.func @eq_const_mask_use2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.or %arg1, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %1, %2 : i8
    llvm.return %3 : i1
  }
  llvm.func @decrement_slt_0(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.add %arg0, %0  : vector<2xi8>
    %4 = llvm.or %3, %arg0  : vector<2xi8>
    %5 = llvm.icmp "slt" %4, %2 : vector<2xi8>
    llvm.return %5 : vector<2xi1>
  }
  llvm.func @decrement_slt_0_commute_use1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mul %arg0, %0  : i8
    %4 = llvm.add %3, %1  : i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.or %3, %4  : i8
    %6 = llvm.icmp "slt" %5, %2 : i8
    llvm.return %6 : i1
  }
  llvm.func @decrement_slt_0_use2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.or %2, %arg0  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.icmp "slt" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @decrement_slt_n1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.or %1, %arg0  : i8
    %3 = llvm.icmp "slt" %2, %0 : i8
    llvm.return %3 : i1
  }
  llvm.func @not_decrement_slt_0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.or %2, %arg0  : i8
    %4 = llvm.icmp "slt" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @decrement_sgt_n1(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.add %arg0, %0  : vector<2xi8>
    %2 = llvm.or %1, %arg0  : vector<2xi8>
    %3 = llvm.icmp "sgt" %2, %0 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @decrement_sgt_n1_commute_use1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mul %arg0, %0  : i8
    %3 = llvm.add %2, %1  : i8
    llvm.call @use(%3) : (i8) -> ()
    %4 = llvm.or %2, %3  : i8
    %5 = llvm.icmp "sgt" %4, %1 : i8
    llvm.return %5 : i1
  }
  llvm.func @decrement_sgt_n1_use2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.add %arg0, %0  : i8
    %2 = llvm.or %1, %arg0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "sgt" %2, %0 : i8
    llvm.return %3 : i1
  }
  llvm.func @decrement_sgt_0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.or %2, %arg0  : i8
    %4 = llvm.icmp "sgt" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @not_decrement_sgt_n1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.or %2, %arg0  : i8
    %4 = llvm.icmp "sgt" %3, %1 : i8
    llvm.return %4 : i1
  }
  llvm.func @icmp_or_xor_2_eq(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.xor %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.icmp "eq" %3, %0 : i64
    llvm.return %4 : i1
  }
  llvm.func @icmp_or_xor_2_ne(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.xor %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.icmp "ne" %3, %0 : i64
    llvm.return %4 : i1
  }
  llvm.func @icmp_or_xor_2_eq_fail(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.xor %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.icmp "eq" %3, %0 : i64
    llvm.return %4 : i1
  }
  llvm.func @icmp_or_xor_2_ne_fail(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.xor %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.icmp "ne" %3, %0 : i64
    llvm.return %4 : i1
  }
  llvm.func @icmp_or_xor_2_3_fail(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.xor %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.icmp "eq" %3, %0 : i64
    %5 = llvm.icmp "eq" %1, %0 : i64
    %6 = llvm.or %4, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @icmp_or_xor_2_4_fail(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.xor %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.icmp "eq" %3, %0 : i64
    %5 = llvm.icmp "eq" %2, %0 : i64
    %6 = llvm.or %4, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @icmp_or_xor_3_1(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.xor %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.xor %arg4, %arg5  : i64
    %5 = llvm.or %3, %4  : i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    llvm.return %6 : i1
  }
  llvm.func @icmp_or_xor_3_2_fail(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.xor %arg2, %arg3  : i64
    %3 = llvm.and %1, %2  : i64
    %4 = llvm.xor %arg4, %arg5  : i64
    %5 = llvm.or %3, %4  : i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    llvm.return %6 : i1
  }
  llvm.func @icmp_or_xor_3_3(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.xor %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.xor %arg4, %arg5  : i64
    %5 = llvm.or %4, %3  : i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    llvm.return %6 : i1
  }
  llvm.func @icmp_or_xor_3_4_fail(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.xor %arg2, %arg3  : i64
    %3 = llvm.and %1, %2  : i64
    %4 = llvm.xor %arg4, %arg5  : i64
    %5 = llvm.or %4, %3  : i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    llvm.return %6 : i1
  }
  llvm.func @icmp_or_xor_4_1(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.xor %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.xor %arg4, %arg5  : i64
    %5 = llvm.xor %arg6, %arg7  : i64
    %6 = llvm.or %4, %5  : i64
    %7 = llvm.or %3, %6  : i64
    %8 = llvm.icmp "eq" %7, %0 : i64
    llvm.return %8 : i1
  }
  llvm.func @icmp_or_xor_4_2(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.xor %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.xor %arg4, %arg5  : i64
    %5 = llvm.xor %arg6, %arg7  : i64
    %6 = llvm.or %4, %5  : i64
    %7 = llvm.or %6, %3  : i64
    %8 = llvm.icmp "eq" %7, %0 : i64
    llvm.return %8 : i1
  }
  llvm.func @icmp_or_sub_2_eq(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sub %arg0, %arg1  : i64
    %2 = llvm.sub %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.icmp "eq" %3, %0 : i64
    llvm.return %4 : i1
  }
  llvm.func @icmp_or_sub_2_ne(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sub %arg0, %arg1  : i64
    %2 = llvm.sub %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.icmp "ne" %3, %0 : i64
    llvm.return %4 : i1
  }
  llvm.func @icmp_or_sub_2_eq_fail(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.sub %arg0, %arg1  : i64
    %2 = llvm.sub %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.icmp "eq" %3, %0 : i64
    llvm.return %4 : i1
  }
  llvm.func @icmp_or_sub_2_ne_fail(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.sub %arg0, %arg1  : i64
    %2 = llvm.sub %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.icmp "ne" %3, %0 : i64
    llvm.return %4 : i1
  }
  llvm.func @icmp_or_sub_2_3_fail(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.sub %arg0, %arg1  : i64
    %3 = llvm.sub %arg2, %arg3  : i64
    %4 = llvm.or %2, %3  : i64
    %5 = llvm.icmp "eq" %4, %0 : i64
    %6 = llvm.icmp "eq" %2, %1 : i64
    %7 = llvm.or %5, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @icmp_or_sub_2_4_fail(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.sub %arg0, %arg1  : i64
    %3 = llvm.sub %arg2, %arg3  : i64
    %4 = llvm.or %2, %3  : i64
    %5 = llvm.icmp "eq" %4, %0 : i64
    %6 = llvm.icmp "eq" %3, %1 : i64
    %7 = llvm.or %5, %6  : i1
    llvm.return %7 : i1
  }
  llvm.func @icmp_or_sub_3_1(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sub %arg0, %arg1  : i64
    %2 = llvm.sub %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.sub %arg4, %arg5  : i64
    %5 = llvm.or %3, %4  : i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    llvm.return %6 : i1
  }
  llvm.func @icmp_or_sub_3_2_fail(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sub %arg0, %arg1  : i64
    %2 = llvm.sub %arg2, %arg3  : i64
    %3 = llvm.and %1, %2  : i64
    %4 = llvm.sub %arg4, %arg5  : i64
    %5 = llvm.or %3, %4  : i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    llvm.return %6 : i1
  }
  llvm.func @icmp_or_sub_3_3(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sub %arg0, %arg1  : i64
    %2 = llvm.sub %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.sub %arg4, %arg5  : i64
    %5 = llvm.or %4, %3  : i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    llvm.return %6 : i1
  }
  llvm.func @icmp_or_sub_3_4_fail(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sub %arg0, %arg1  : i64
    %2 = llvm.sub %arg2, %arg3  : i64
    %3 = llvm.and %1, %2  : i64
    %4 = llvm.sub %arg4, %arg5  : i64
    %5 = llvm.or %4, %3  : i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    llvm.return %6 : i1
  }
  llvm.func @icmp_or_sub_4_1(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sub %arg0, %arg1  : i64
    %2 = llvm.sub %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.sub %arg4, %arg5  : i64
    %5 = llvm.sub %arg6, %arg7  : i64
    %6 = llvm.or %4, %5  : i64
    %7 = llvm.or %3, %6  : i64
    %8 = llvm.icmp "eq" %7, %0 : i64
    llvm.return %8 : i1
  }
  llvm.func @icmp_or_sub_4_2(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sub %arg0, %arg1  : i64
    %2 = llvm.sub %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.sub %arg4, %arg5  : i64
    %5 = llvm.sub %arg6, %arg7  : i64
    %6 = llvm.or %4, %5  : i64
    %7 = llvm.or %6, %3  : i64
    %8 = llvm.icmp "eq" %7, %0 : i64
    llvm.return %8 : i1
  }
  llvm.func @icmp_or_xor_with_sub_2_eq(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.sub %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.icmp "eq" %3, %0 : i64
    llvm.return %4 : i1
  }
  llvm.func @icmp_or_xor_with_sub_2_ne(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.sub %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.icmp "ne" %3, %0 : i64
    llvm.return %4 : i1
  }
  llvm.func @icmp_or_xor_with_sub_3_1(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.xor %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.sub %arg4, %arg5  : i64
    %5 = llvm.or %3, %4  : i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    llvm.return %6 : i1
  }
  llvm.func @icmp_or_xor_with_sub_3_2(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.sub %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.xor %arg4, %arg5  : i64
    %5 = llvm.or %3, %4  : i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    llvm.return %6 : i1
  }
  llvm.func @icmp_or_xor_with_sub_3_3(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.xor %arg0, %arg1  : i64
    %2 = llvm.sub %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.sub %arg4, %arg5  : i64
    %5 = llvm.or %3, %4  : i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    llvm.return %6 : i1
  }
  llvm.func @icmp_or_xor_with_sub_3_4(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sub %arg0, %arg1  : i64
    %2 = llvm.xor %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.xor %arg4, %arg5  : i64
    %5 = llvm.or %3, %4  : i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    llvm.return %6 : i1
  }
  llvm.func @icmp_or_xor_with_sub_3_5(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sub %arg0, %arg1  : i64
    %2 = llvm.xor %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.sub %arg4, %arg5  : i64
    %5 = llvm.or %3, %4  : i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    llvm.return %6 : i1
  }
  llvm.func @icmp_or_xor_with_sub_3_6(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.sub %arg0, %arg1  : i64
    %2 = llvm.sub %arg2, %arg3  : i64
    %3 = llvm.or %1, %2  : i64
    %4 = llvm.xor %arg4, %arg5  : i64
    %5 = llvm.or %3, %4  : i64
    %6 = llvm.icmp "eq" %5, %0 : i64
    llvm.return %6 : i1
  }
  llvm.func @or_disjoint_with_constants(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(19 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }
  llvm.func @or_disjoint_with_constants2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(71 : i8) : i8
    %2 = llvm.or %arg0, %0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.call @use(%2) : (i8) -> ()
    llvm.return %3 : i1
  }
  llvm.func @or_disjoint_with_constants_fail_missing_const1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(19 : i8) : i8
    %1 = llvm.or %arg0, %arg1  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }
  llvm.func @or_disjoint_with_constants_fail_missing_const2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(19 : i8) : i8
    %1 = llvm.or %arg0, %0  : i8
    %2 = llvm.icmp "eq" %1, %arg1 : i8
    llvm.return %2 : i1
  }
}
