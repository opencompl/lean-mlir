module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @sdiv_common_divisor(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.sdiv %arg2, %arg1  : i5
    %1 = llvm.sdiv %arg3, %arg1  : i5
    %2 = llvm.select %arg0, %1, %0 : i1, i5
    llvm.return %2 : i5
  }
  llvm.func @srem_common_divisor(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.srem %arg2, %arg1  : i5
    %1 = llvm.srem %arg3, %arg1  : i5
    %2 = llvm.select %arg0, %1, %0 : i1, i5
    llvm.return %2 : i5
  }
  llvm.func @udiv_common_divisor(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.udiv %arg2, %arg1  : i5
    %1 = llvm.udiv %arg3, %arg1  : i5
    %2 = llvm.select %arg0, %1, %0 : i1, i5
    llvm.return %2 : i5
  }
  llvm.func @urem_common_divisor(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.urem %arg2, %arg1  : i5
    %1 = llvm.urem %arg3, %arg1  : i5
    %2 = llvm.select %arg0, %1, %0 : i1, i5
    llvm.return %2 : i5
  }
  llvm.func @sdiv_common_dividend(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.sdiv %arg1, %arg2  : i5
    %1 = llvm.sdiv %arg1, %arg3  : i5
    %2 = llvm.select %arg0, %1, %0 : i1, i5
    llvm.return %2 : i5
  }
  llvm.func @srem_common_dividend(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.srem %arg1, %arg2  : i5
    %1 = llvm.srem %arg1, %arg3  : i5
    %2 = llvm.select %arg0, %1, %0 : i1, i5
    llvm.return %2 : i5
  }
  llvm.func @udiv_common_dividend(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.udiv %arg1, %arg2  : i5
    %1 = llvm.udiv %arg1, %arg3  : i5
    %2 = llvm.select %arg0, %1, %0 : i1, i5
    llvm.return %2 : i5
  }
  llvm.func @urem_common_dividend(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.urem %arg1, %arg2  : i5
    %1 = llvm.urem %arg1, %arg3  : i5
    %2 = llvm.select %arg0, %1, %0 : i1, i5
    llvm.return %2 : i5
  }
  llvm.func @sdiv_common_divisor_defined_cond(%arg0: i1 {llvm.noundef}, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.sdiv %arg2, %arg1  : i5
    %1 = llvm.sdiv %arg3, %arg1  : i5
    %2 = llvm.select %arg0, %1, %0 : i1, i5
    llvm.return %2 : i5
  }
  llvm.func @srem_common_divisor_defined_cond(%arg0: i1 {llvm.noundef}, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.srem %arg2, %arg1  : i5
    %1 = llvm.srem %arg3, %arg1  : i5
    %2 = llvm.select %arg0, %1, %0 : i1, i5
    llvm.return %2 : i5
  }
  llvm.func @udiv_common_divisor_defined_cond(%arg0: i1 {llvm.noundef}, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.udiv %arg2, %arg1  : i5
    %1 = llvm.udiv %arg3, %arg1  : i5
    %2 = llvm.select %arg0, %1, %0 : i1, i5
    llvm.return %2 : i5
  }
  llvm.func @urem_common_divisor_defined_cond(%arg0: i1 {llvm.noundef}, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.urem %arg2, %arg1  : i5
    %1 = llvm.urem %arg3, %arg1  : i5
    %2 = llvm.select %arg0, %1, %0 : i1, i5
    llvm.return %2 : i5
  }
  llvm.func @sdiv_common_dividend_defined_cond(%arg0: i1 {llvm.noundef}, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.sdiv %arg1, %arg2  : i5
    %1 = llvm.sdiv %arg1, %arg3  : i5
    %2 = llvm.select %arg0, %1, %0 : i1, i5
    llvm.return %2 : i5
  }
  llvm.func @srem_common_dividend_defined_cond(%arg0: i1 {llvm.noundef}, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.srem %arg1, %arg2  : i5
    %1 = llvm.srem %arg1, %arg3  : i5
    %2 = llvm.select %arg0, %1, %0 : i1, i5
    llvm.return %2 : i5
  }
  llvm.func @udiv_common_dividend_defined_cond(%arg0: i1 {llvm.noundef}, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.udiv %arg1, %arg2  : i5
    %1 = llvm.udiv %arg1, %arg3  : i5
    %2 = llvm.select %arg0, %1, %0 : i1, i5
    llvm.return %2 : i5
  }
  llvm.func @urem_common_dividend_defined_cond(%arg0: i1 {llvm.noundef}, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.urem %arg1, %arg2  : i5
    %1 = llvm.urem %arg1, %arg3  : i5
    %2 = llvm.select %arg0, %1, %0 : i1, i5
    llvm.return %2 : i5
  }
  llvm.func @rem_euclid_1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.add %2, %0  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @rem_euclid_2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "sgt" %2, %1 : i32
    %4 = llvm.add %2, %0  : i32
    %5 = llvm.select %3, %2, %4 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @rem_euclid_wrong_sign_test(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "sgt" %2, %1 : i32
    %4 = llvm.add %2, %0  : i32
    %5 = llvm.select %3, %4, %2 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @rem_euclid_add_different_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(9 : i32) : i32
    %3 = llvm.srem %arg0, %0  : i32
    %4 = llvm.icmp "slt" %3, %1 : i32
    %5 = llvm.add %3, %2  : i32
    %6 = llvm.select %4, %5, %3 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @rem_euclid_wrong_operands_select(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.srem %arg0, %0  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    %4 = llvm.add %2, %0  : i32
    %5 = llvm.select %3, %2, %4 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @rem_euclid_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.srem %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "slt" %3, %2 : vector<2xi32>
    %5 = llvm.add %3, %0  : vector<2xi32>
    %6 = llvm.select %4, %5, %3 : vector<2xi1>, vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }
  llvm.func @rem_euclid_i128(%arg0: i128) -> i128 {
    %0 = llvm.mlir.constant(8 : i128) : i128
    %1 = llvm.mlir.constant(0 : i128) : i128
    %2 = llvm.srem %arg0, %0  : i128
    %3 = llvm.icmp "slt" %2, %1 : i128
    %4 = llvm.add %2, %0  : i128
    %5 = llvm.select %3, %4, %2 : i1, i128
    llvm.return %5 : i128
  }
  llvm.func @rem_euclid_non_const_pow2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.shl %0, %arg0  : i8
    %3 = llvm.srem %arg1, %2  : i8
    %4 = llvm.icmp "slt" %3, %1 : i8
    %5 = llvm.add %3, %2  : i8
    %6 = llvm.select %4, %5, %3 : i1, i8
    llvm.return %6 : i8
  }
  llvm.func @rem_euclid_pow2_true_arm_folded(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.srem %arg0, %0  : i32
    %4 = llvm.icmp "slt" %3, %1 : i32
    %5 = llvm.select %4, %2, %3 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @rem_euclid_pow2_false_arm_folded(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.srem %arg0, %0  : i32
    %4 = llvm.icmp "sge" %3, %1 : i32
    %5 = llvm.select %4, %3, %2 : i1, i32
    llvm.return %5 : i32
  }
  llvm.func @pr89516(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.icmp "slt" %arg1, %0 : i8
    %3 = llvm.shl %1, %arg0 overflow<nuw>  : i8
    %4 = llvm.srem %1, %3  : i8
    %5 = llvm.add %4, %3 overflow<nuw>  : i8
    %6 = llvm.select %2, %5, %4 : i1, i8
    llvm.return %6 : i8
  }
}
