module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @g() {addr_space = 0 : i32} : i8
  llvm.func @use1(i1)
  llvm.func @use32(i32)
  llvm.func @use64(i64)
  llvm.func @use_vec(vector<2xi9>)
  llvm.func @test_sext_zext(%arg0: i16) -> i64 {
    %0 = llvm.zext %arg0 : i16 to i32
    %1 = llvm.sext %0 : i32 to i64
    llvm.return %1 : i64
  }
  llvm.func @test2(%arg0: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.xor %arg0, %1  : vector<2xi1>
    %3 = llvm.zext %2 : vector<2xi1> to vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }
  llvm.func @test3(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[23, 42]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.and %1, %0  : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }
  llvm.func @test4(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[23, 42]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.and %1, %0  : vector<2xi32>
    %3 = llvm.xor %2, %0  : vector<2xi32>
    %4 = llvm.zext %3 : vector<2xi32> to vector<2xi64>
    llvm.return %4 : vector<2xi64>
  }
  llvm.func @fold_xor_zext_sandwich(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.xor %1, %0  : i32
    %3 = llvm.zext %2 : i32 to i64
    llvm.return %3 : i64
  }
  llvm.func @fold_xor_zext_sandwich_vec(%arg0: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.xor %1, %0  : vector<2xi32>
    %3 = llvm.zext %2 : vector<2xi32> to vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }
  llvm.func @fold_and_zext_icmp(%arg0: i64, %arg1: i64, %arg2: i64) -> i8 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i8
    %2 = llvm.icmp "slt" %arg0, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i8
    %4 = llvm.and %1, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @fold_or_zext_icmp(%arg0: i64, %arg1: i64, %arg2: i64) -> i8 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i8
    %2 = llvm.icmp "slt" %arg0, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i8
    %4 = llvm.or %1, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @fold_xor_zext_icmp(%arg0: i64, %arg1: i64, %arg2: i64) -> i8 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i8
    %2 = llvm.icmp "slt" %arg0, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i8
    %4 = llvm.xor %1, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @fold_nested_logic_zext_icmp(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i64) -> i8 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i64
    %1 = llvm.zext %0 : i1 to i8
    %2 = llvm.icmp "slt" %arg0, %arg2 : i64
    %3 = llvm.zext %2 : i1 to i8
    %4 = llvm.and %1, %3  : i8
    %5 = llvm.icmp "eq" %arg0, %arg3 : i64
    %6 = llvm.zext %5 : i1 to i8
    %7 = llvm.or %4, %6  : i8
    llvm.return %7 : i8
  }
  llvm.func @sext_zext_apint1(%arg0: i77) -> i1024 {
    %0 = llvm.zext %arg0 : i77 to i533
    %1 = llvm.sext %0 : i533 to i1024
    llvm.return %1 : i1024
  }
  llvm.func @sext_zext_apint2(%arg0: i11) -> i47 {
    %0 = llvm.zext %arg0 : i11 to i39
    %1 = llvm.sext %0 : i39 to i47
    llvm.return %1 : i47
  }
  llvm.func @masked_bit_set(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }
  llvm.func @masked_bit_clear(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.shl %0, %arg1  : vector<2xi32>
    %4 = llvm.and %3, %arg0  : vector<2xi32>
    %5 = llvm.icmp "eq" %4, %2 : vector<2xi32>
    %6 = llvm.zext %5 : vector<2xi1> to vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }
  llvm.func @masked_bit_set_commute(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 3]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.srem %0, %arg0  : vector<2xi32>
    %5 = llvm.shl %1, %arg1  : vector<2xi32>
    %6 = llvm.and %4, %5  : vector<2xi32>
    %7 = llvm.icmp "ne" %6, %3 : vector<2xi32>
    %8 = llvm.zext %7 : vector<2xi1> to vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }
  llvm.func @masked_bit_clear_commute(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.srem %0, %arg0  : i32
    %4 = llvm.shl %1, %arg1  : i32
    %5 = llvm.and %3, %4  : i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    %7 = llvm.zext %6 : i1 to i32
    llvm.return %7 : i32
  }
  llvm.func @masked_bit_set_use1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }
  llvm.func @masked_bit_set_use2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }
  llvm.func @masked_bit_set_use3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }
  llvm.func @masked_bit_clear_use1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }
  llvm.func @masked_bit_clear_use2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }
  llvm.func @masked_bit_clear_use3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }
  llvm.func @masked_bits_set(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }
  llvm.func @div_bit_set(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.sdiv %2, %arg0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }
  llvm.func @masked_bit_set_nonzero_cmp(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg1  : i32
    %2 = llvm.and %1, %arg0  : i32
    %3 = llvm.icmp "ne" %2, %0 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }
  llvm.func @masked_bit_wrong_pred(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "sgt" %3, %1 : i32
    %5 = llvm.zext %4 : i1 to i32
    llvm.return %5 : i32
  }
  llvm.func @zext_or_masked_bit_test(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.icmp "eq" %arg2, %arg1 : i32
    %6 = llvm.or %4, %5  : i1
    %7 = llvm.zext %6 : i1 to i32
    llvm.return %7 : i32
  }
  llvm.func @zext_or_masked_bit_test_uses(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.shl %0, %arg1  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.icmp "eq" %arg2, %arg1 : i32
    %6 = llvm.or %4, %5  : i1
    llvm.call @use1(%6) : (i1) -> ()
    %7 = llvm.zext %6 : i1 to i32
    llvm.return %7 : i32
  }
  llvm.func @notneg_zext_wider(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }
  llvm.func @notneg_zext_narrower(%arg0: vector<2xi32>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.icmp "sgt" %arg0, %0 : vector<2xi32>
    %2 = llvm.zext %1 : vector<2xi1> to vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }
  llvm.func @notneg_zext_wider_use(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %0 : i8
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }
  llvm.func @notneg_zext_narrower_use(%arg0: i32) -> i8 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.call @use1(%1) : (i1) -> ()
    %2 = llvm.zext %1 : i1 to i8
    llvm.return %2 : i8
  }
  llvm.func @disguised_signbit_clear_test(%arg0: i64) -> i8 {
    %0 = llvm.mlir.constant(128 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.and %arg0, %0  : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    %4 = llvm.zext %3 : i1 to i8
    llvm.return %4 : i8
  }
  llvm.func @pr57899(%arg0: i1, %arg1: i32) -> i16 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(64 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %4 = llvm.select %1, %arg1, %0 : i1, i32
    llvm.br ^bb2(%4 : i32)
  ^bb2(%5: i32):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.icmp "ne" %5, %2 : i32
    %7 = llvm.icmp "ne" %5, %3 : i32
    %8 = llvm.and %6, %7  : i1
    %9 = llvm.zext %8 : i1 to i16
    llvm.return %9 : i16
  }
  llvm.func @and_trunc_extra_use1(%arg0: i64, %arg1: i32) -> i64 {
    %0 = llvm.trunc %arg0 : i64 to i32
    llvm.call @use32(%0) : (i32) -> ()
    %1 = llvm.and %0, %arg1  : i32
    %2 = llvm.zext %1 : i32 to i64
    llvm.return %2 : i64
  }
  llvm.func @and_trunc_extra_use1_commute(%arg0: i64, %arg1: i32) -> i64 {
    %0 = llvm.mul %arg1, %arg1  : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.and %0, %1  : i32
    %3 = llvm.zext %2 : i32 to i64
    llvm.return %3 : i64
  }
  llvm.func @and_trunc_extra_use2(%arg0: i64, %arg1: i32) -> i64 {
    %0 = llvm.trunc %arg0 : i64 to i32
    %1 = llvm.and %0, %arg1  : i32
    llvm.call @use32(%1) : (i32) -> ()
    %2 = llvm.zext %1 : i32 to i64
    llvm.return %2 : i64
  }
  llvm.func @and_trunc_extra_use2_constant(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.and %1, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.zext %2 : i32 to i64
    llvm.return %3 : i64
  }
  llvm.func @and_trunc_extra_use3_constant_vec(%arg0: vector<2xi17>) -> vector<2xi17> {
    %0 = llvm.mlir.constant(-3 : i9) : i9
    %1 = llvm.mlir.constant(42 : i9) : i9
    %2 = llvm.mlir.constant(dense<[42, -3]> : vector<2xi9>) : vector<2xi9>
    %3 = llvm.trunc %arg0 : vector<2xi17> to vector<2xi9>
    llvm.call @use_vec(%3) : (vector<2xi9>) -> ()
    %4 = llvm.and %3, %2  : vector<2xi9>
    llvm.call @use_vec(%4) : (vector<2xi9>) -> ()
    %5 = llvm.zext %4 : vector<2xi9> to vector<2xi17>
    llvm.return %5 : vector<2xi17>
  }
  llvm.func @and_trunc_extra_use1_wider_src(%arg0: i65, %arg1: i32) -> i64 {
    %0 = llvm.trunc %arg0 : i65 to i32
    llvm.call @use32(%0) : (i32) -> ()
    %1 = llvm.and %0, %arg1  : i32
    %2 = llvm.zext %1 : i32 to i64
    llvm.return %2 : i64
  }
  llvm.func @zext_icmp_eq0_pow2(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.zext %3 : i1 to i16
    llvm.return %4 : i16
  }
  llvm.func @zext_icmp_eq0_pow2_use1(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.icmp "eq" %2, %1 : i32
    %4 = llvm.zext %3 : i1 to i16
    llvm.return %4 : i16
  }
  llvm.func @zext_icmp_eq0_pow2_use2(%arg0: i32) -> i16 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.zext %3 : i1 to i16
    llvm.return %4 : i16
  }
  llvm.func @zext_icmp_eq_pow2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.shl %arg1, %0  : i8
    %3 = llvm.shl %1, %arg0  : i8
    %4 = llvm.icmp "eq" %2, %3 : i8
    %5 = llvm.zext %4 : i1 to i8
    llvm.return %5 : i8
  }
  llvm.func @zext_icmp_eq_bool_0(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64
    %2 = llvm.icmp "eq" %1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    llvm.return %3 : i64
  }
  llvm.func @zext_icmp_eq_bool_1(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64
    %2 = llvm.icmp "eq" %1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    llvm.return %3 : i64
  }
  llvm.func @zext_icmp_ne_bool_0(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64
    %2 = llvm.icmp "ne" %1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    llvm.return %3 : i64
  }
  llvm.func @zext_icmp_ne_bool_1(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64
    %2 = llvm.icmp "ne" %1, %0 : i64
    %3 = llvm.zext %2 : i1 to i64
    llvm.return %3 : i64
  }
  llvm.func @zext_icmp_eq0_no_shift(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }
  llvm.func @evaluate_zexted_const_expr(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.addressof @g : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = llvm.add %2, %0  : i64
    %4 = llvm.trunc %3 : i64 to i7
    %5 = llvm.mlir.constant(2 : i64) : i64
    %6 = llvm.add %2, %5  : i64
    %7 = llvm.trunc %6 : i64 to i7
    %8 = llvm.select %arg0, %4, %7 : i1, i7
    %9 = llvm.zext %8 : i7 to i64
    llvm.return %9 : i64
  }
  llvm.func @zext_nneg_flag_drop(%arg0: i8, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(128 : i16) : i16
    %2 = llvm.and %arg0, %0  : i8
    %3 = llvm.zext %2 : i8 to i16
    %4 = llvm.or %3, %arg1  : i16
    %5 = llvm.or %4, %1  : i16
    llvm.return %5 : i16
  }
  llvm.func @zext_nneg_redundant_and(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(127 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.and %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @zext_nneg_redundant_and_neg(%arg0: i8) -> i32 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.and %arg0, %0  : i8
    %2 = llvm.zext %1 : i8 to i32
    llvm.return %2 : i32
  }
  llvm.func @zext_nneg_signbit_extract(%arg0: i32) -> i64 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(31 : i64) : i64
    %1 = llvm.zext %arg0 : i32 to i64
    %2 = llvm.lshr %1, %0  : i64
    llvm.return %2 : i64
  }
  llvm.func @zext_nneg_demanded_constant(%arg0: i8) -> i64 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(254 : i64) : i64
    %1 = llvm.zext %arg0 : i8 to i64
    llvm.call @use64(%1) : (i64) -> ()
    %2 = llvm.and %1, %0  : i64
    llvm.return %2 : i64
  }
  llvm.func @zext_nneg_i1(%arg0: i1) -> i32 {
    %0 = llvm.zext %arg0 : i1 to i32
    llvm.return %0 : i32
  }
  llvm.func @zext_nneg_i1_vec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.zext %arg0 : vector<2xi1> to vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }
  llvm.func @zext_nneg_i2(%arg0: i2) -> i32 {
    %0 = llvm.zext %arg0 : i2 to i32
    llvm.return %0 : i32
  }
}
