module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i32)
  llvm.func @cttz_zext_zero_undef(%arg0: i16) -> i32 {
    %0 = llvm.zext %arg0 : i16 to i32
    %1 = "llvm.intr.cttz"(%0) <{is_zero_poison = true}> : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @cttz_zext_zero_def(%arg0: i16) -> i32 {
    %0 = llvm.zext %arg0 : i16 to i32
    %1 = "llvm.intr.cttz"(%0) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @cttz_zext_zero_undef_extra_use(%arg0: i16) -> i32 {
    %0 = llvm.zext %arg0 : i16 to i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = "llvm.intr.cttz"(%0) <{is_zero_poison = true}> : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @cttz_zext_zero_undef_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %1 = "llvm.intr.cttz"(%0) <{is_zero_poison = true}> : (vector<2xi64>) -> vector<2xi64>
    llvm.return %1 : vector<2xi64>
  }
  llvm.func @cttz_zext_zero_def_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.zext %arg0 : vector<2xi32> to vector<2xi64>
    %1 = "llvm.intr.cttz"(%0) <{is_zero_poison = false}> : (vector<2xi64>) -> vector<2xi64>
    llvm.return %1 : vector<2xi64>
  }
  llvm.func @cttz_sext_zero_undef(%arg0: i16) -> i32 {
    %0 = llvm.sext %arg0 : i16 to i32
    %1 = "llvm.intr.cttz"(%0) <{is_zero_poison = true}> : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @cttz_sext_zero_def(%arg0: i16) -> i32 {
    %0 = llvm.sext %arg0 : i16 to i32
    %1 = "llvm.intr.cttz"(%0) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @cttz_sext_zero_undef_extra_use(%arg0: i16) -> i32 {
    %0 = llvm.sext %arg0 : i16 to i32
    llvm.call @use(%0) : (i32) -> ()
    %1 = "llvm.intr.cttz"(%0) <{is_zero_poison = true}> : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @cttz_sext_zero_undef_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.sext %arg0 : vector<2xi32> to vector<2xi64>
    %1 = "llvm.intr.cttz"(%0) <{is_zero_poison = true}> : (vector<2xi64>) -> vector<2xi64>
    llvm.return %1 : vector<2xi64>
  }
  llvm.func @cttz_sext_zero_def_vec(%arg0: vector<2xi32>) -> vector<2xi64> {
    %0 = llvm.sext %arg0 : vector<2xi32> to vector<2xi64>
    %1 = "llvm.intr.cttz"(%0) <{is_zero_poison = false}> : (vector<2xi64>) -> vector<2xi64>
    llvm.return %1 : vector<2xi64>
  }
  llvm.func @cttz_of_lowest_set_bit(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = "llvm.intr.cttz"(%2) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @cttz_of_lowest_set_bit_commuted(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.udiv %0, %arg0  : i32
    %3 = llvm.sub %1, %2  : i32
    %4 = llvm.and %2, %3  : i32
    %5 = "llvm.intr.cttz"(%4) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %5 : i32
  }
  llvm.func @cttz_of_lowest_set_bit_poison_flag(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = "llvm.intr.cttz"(%2) <{is_zero_poison = true}> : (i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @cttz_of_lowest_set_bit_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.sub %1, %arg0  : vector<2xi64>
    %3 = llvm.and %2, %arg0  : vector<2xi64>
    %4 = "llvm.intr.cttz"(%3) <{is_zero_poison = false}> : (vector<2xi64>) -> vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @cttz_of_lowest_set_bit_vec_undef(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.sub %1, %arg0  : vector<2xi64>
    %3 = llvm.and %2, %arg0  : vector<2xi64>
    %4 = "llvm.intr.cttz"(%3) <{is_zero_poison = false}> : (vector<2xi64>) -> vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @cttz_of_lowest_set_bit_wrong_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = "llvm.intr.cttz"(%2) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @cttz_of_lowest_set_bit_wrong_operand(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg1  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = "llvm.intr.cttz"(%2) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @cttz_of_lowest_set_bit_wrong_intrinsic(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = "llvm.intr.ctlz"(%2) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %3 : i32
  }
  llvm.func @cttz_of_power_of_two(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.lshr %0, %arg0  : i32
    %3 = llvm.add %2, %1  : i32
    %4 = "llvm.intr.cttz"(%3) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %4 : i32
  }
  llvm.func @cttz_of_power_of_two_zero_poison(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.lshr %0, %arg0  : i32
    %3 = llvm.add %2, %1  : i32
    %4 = "llvm.intr.cttz"(%3) <{is_zero_poison = true}> : (i32) -> i32
    llvm.return %4 : i32
  }
  llvm.func @cttz_of_power_of_two_wrong_intrinsic(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.lshr %0, %arg0  : i32
    %3 = llvm.add %2, %1  : i32
    %4 = "llvm.intr.ctlz"(%3) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %4 : i32
  }
  llvm.func @cttz_of_power_of_two_wrong_constant_1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.lshr %0, %arg0  : i32
    %3 = llvm.add %2, %1  : i32
    %4 = "llvm.intr.cttz"(%3) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %4 : i32
  }
  llvm.func @cttz_of_power_of_two_wrong_constant_2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.lshr %0, %arg0  : i32
    %2 = llvm.add %1, %0  : i32
    %3 = "llvm.intr.cttz"(%2) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %3 : i32
  }
}
