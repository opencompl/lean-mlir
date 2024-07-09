module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use32(i32)
  llvm.func @sel_sext_constants(%arg0: i1) -> i16 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i8
    %3 = llvm.sext %2 : i8 to i16
    llvm.return %3 : i16
  }
  llvm.func @sel_zext_constants(%arg0: i1) -> i16 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.select %arg0, %0, %1 : i1, i8
    %3 = llvm.zext %2 : i8 to i16
    llvm.return %3 : i16
  }
  llvm.func @sel_fpext_constants(%arg0: i1) -> f64 {
    %0 = llvm.mlir.constant(-2.550000e+02 : f32) : f32
    %1 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %2 = llvm.select %arg0, %0, %1 : i1, f32
    %3 = llvm.fpext %2 : f32 to f64
    llvm.return %3 : f64
  }
  llvm.func @sel_sext(%arg0: i32, %arg1: i1) -> i64 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.select %arg1, %arg0, %0 : i1, i32
    %2 = llvm.sext %1 : i32 to i64
    llvm.return %2 : i64
  }
  llvm.func @sel_sext_vec(%arg0: vector<4xi32>, %arg1: vector<4xi1>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(dense<42> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.select %arg1, %arg0, %0 : vector<4xi1>, vector<4xi32>
    %2 = llvm.sext %1 : vector<4xi32> to vector<4xi64>
    llvm.return %2 : vector<4xi64>
  }
  llvm.func @sel_zext(%arg0: i32, %arg1: i1) -> i64 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.select %arg1, %arg0, %0 : i1, i32
    %2 = llvm.zext %1 : i32 to i64
    llvm.return %2 : i64
  }
  llvm.func @sel_zext_vec(%arg0: vector<4xi32>, %arg1: vector<4xi1>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(dense<42> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.select %arg1, %arg0, %0 : vector<4xi1>, vector<4xi32>
    %2 = llvm.zext %1 : vector<4xi32> to vector<4xi64>
    llvm.return %2 : vector<4xi64>
  }
  llvm.func @trunc_sel_larger_sext(%arg0: i32, %arg1: i1) -> i64 {
    %0 = llvm.mlir.constant(42 : i16) : i16
    %1 = llvm.trunc %arg0 : i32 to i16
    %2 = llvm.select %arg1, %1, %0 : i1, i16
    %3 = llvm.sext %2 : i16 to i64
    llvm.return %3 : i64
  }
  llvm.func @trunc_sel_larger_sext_vec(%arg0: vector<2xi32>, %arg1: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[42, 43]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.trunc %arg0 : vector<2xi32> to vector<2xi16>
    %2 = llvm.select %arg1, %1, %0 : vector<2xi1>, vector<2xi16>
    %3 = llvm.sext %2 : vector<2xi16> to vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }
  llvm.func @trunc_sel_smaller_sext(%arg0: i64, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i16) : i16
    %1 = llvm.trunc %arg0 : i64 to i16
    %2 = llvm.select %arg1, %1, %0 : i1, i16
    %3 = llvm.sext %2 : i16 to i32
    llvm.return %3 : i32
  }
  llvm.func @trunc_sel_smaller_sext_vec(%arg0: vector<2xi64>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 43]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi16>
    %2 = llvm.select %arg1, %1, %0 : vector<2xi1>, vector<2xi16>
    %3 = llvm.sext %2 : vector<2xi16> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @trunc_sel_equal_sext(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i16) : i16
    %1 = llvm.trunc %arg0 : i32 to i16
    %2 = llvm.select %arg1, %1, %0 : i1, i16
    %3 = llvm.sext %2 : i16 to i32
    llvm.return %3 : i32
  }
  llvm.func @trunc_sel_equal_sext_vec(%arg0: vector<2xi32>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 43]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.trunc %arg0 : vector<2xi32> to vector<2xi16>
    %2 = llvm.select %arg1, %1, %0 : vector<2xi1>, vector<2xi16>
    %3 = llvm.sext %2 : vector<2xi16> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @trunc_sel_larger_zext(%arg0: i32, %arg1: i1) -> i64 {
    %0 = llvm.mlir.constant(42 : i16) : i16
    %1 = llvm.trunc %arg0 : i32 to i16
    %2 = llvm.select %arg1, %1, %0 : i1, i16
    %3 = llvm.zext %2 : i16 to i64
    llvm.return %3 : i64
  }
  llvm.func @trunc_sel_larger_zext_vec(%arg0: vector<2xi32>, %arg1: vector<2xi1>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<[42, 43]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.trunc %arg0 : vector<2xi32> to vector<2xi16>
    %2 = llvm.select %arg1, %1, %0 : vector<2xi1>, vector<2xi16>
    %3 = llvm.zext %2 : vector<2xi16> to vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }
  llvm.func @trunc_sel_smaller_zext(%arg0: i64, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i16) : i16
    %1 = llvm.trunc %arg0 : i64 to i16
    %2 = llvm.select %arg1, %1, %0 : i1, i16
    %3 = llvm.zext %2 : i16 to i32
    llvm.return %3 : i32
  }
  llvm.func @trunc_sel_smaller_zext_vec(%arg0: vector<2xi64>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 43]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi16>
    %2 = llvm.select %arg1, %1, %0 : vector<2xi1>, vector<2xi16>
    %3 = llvm.zext %2 : vector<2xi16> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @trunc_sel_equal_zext(%arg0: i32, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i16) : i16
    %1 = llvm.trunc %arg0 : i32 to i16
    %2 = llvm.select %arg1, %1, %0 : i1, i16
    %3 = llvm.zext %2 : i16 to i32
    llvm.return %3 : i32
  }
  llvm.func @trunc_sel_equal_zext_vec(%arg0: vector<2xi32>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 43]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.trunc %arg0 : vector<2xi32> to vector<2xi16>
    %2 = llvm.select %arg1, %1, %0 : vector<2xi1>, vector<2xi16>
    %3 = llvm.zext %2 : vector<2xi16> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @trunc_sel_larger_fpext(%arg0: f32, %arg1: i1) -> f64 {
    %0 = llvm.mlir.constant(4.200000e+01 : f16) : f16
    %1 = llvm.fptrunc %arg0 : f32 to f16
    %2 = llvm.select %arg1, %1, %0 : i1, f16
    %3 = llvm.fpext %2 : f16 to f64
    llvm.return %3 : f64
  }
  llvm.func @trunc_sel_larger_fpext_vec(%arg0: vector<2xf32>, %arg1: vector<2xi1>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[4.200000e+01, 4.300000e+01]> : vector<2xf16>) : vector<2xf16>
    %1 = llvm.fptrunc %arg0 : vector<2xf32> to vector<2xf16>
    %2 = llvm.select %arg1, %1, %0 : vector<2xi1>, vector<2xf16>
    %3 = llvm.fpext %2 : vector<2xf16> to vector<2xf64>
    llvm.return %3 : vector<2xf64>
  }
  llvm.func @trunc_sel_smaller_fpext(%arg0: f64, %arg1: i1) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f16) : f16
    %1 = llvm.fptrunc %arg0 : f64 to f16
    %2 = llvm.select %arg1, %1, %0 : i1, f16
    %3 = llvm.fpext %2 : f16 to f32
    llvm.return %3 : f32
  }
  llvm.func @trunc_sel_smaller_fpext_vec(%arg0: vector<2xf64>, %arg1: vector<2xi1>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[4.200000e+01, 4.300000e+01]> : vector<2xf16>) : vector<2xf16>
    %1 = llvm.fptrunc %arg0 : vector<2xf64> to vector<2xf16>
    %2 = llvm.select %arg1, %1, %0 : vector<2xi1>, vector<2xf16>
    %3 = llvm.fpext %2 : vector<2xf16> to vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }
  llvm.func @trunc_sel_equal_fpext(%arg0: f32, %arg1: i1) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f16) : f16
    %1 = llvm.fptrunc %arg0 : f32 to f16
    %2 = llvm.select %arg1, %1, %0 : i1, f16
    %3 = llvm.fpext %2 : f16 to f32
    llvm.return %3 : f32
  }
  llvm.func @trunc_sel_equal_fpext_vec(%arg0: vector<2xf32>, %arg1: vector<2xi1>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[4.200000e+01, 4.300000e+01]> : vector<2xf16>) : vector<2xf16>
    %1 = llvm.fptrunc %arg0 : vector<2xf32> to vector<2xf16>
    %2 = llvm.select %arg1, %1, %0 : vector<2xi1>, vector<2xf16>
    %3 = llvm.fpext %2 : vector<2xf16> to vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }
  llvm.func @test_sext1(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.select %arg1, %1, %0 : i1, i32
    llvm.return %2 : i32
  }
  llvm.func @test_sext2(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.select %arg1, %0, %1 : i1, i32
    llvm.return %2 : i32
  }
  llvm.func @test_sext3(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.select %arg1, %0, %1 : i1, i32
    llvm.return %2 : i32
  }
  llvm.func @test_sext4(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.select %arg1, %1, %0 : i1, i32
    llvm.return %2 : i32
  }
  llvm.func @test_zext1(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.select %arg1, %1, %0 : i1, i32
    llvm.return %2 : i32
  }
  llvm.func @test_zext2(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.select %arg1, %0, %1 : i1, i32
    llvm.return %2 : i32
  }
  llvm.func @test_zext3(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.select %arg1, %0, %1 : i1, i32
    llvm.return %2 : i32
  }
  llvm.func @test_zext4(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.select %arg1, %1, %0 : i1, i32
    llvm.return %2 : i32
  }
  llvm.func @test_negative_sext(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.select %arg1, %1, %0 : i1, i32
    llvm.return %2 : i32
  }
  llvm.func @test_negative_zext(%arg0: i1, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.select %arg1, %1, %0 : i1, i32
    llvm.return %2 : i32
  }
  llvm.func @test_bits_sext(%arg0: i8, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(-128 : i32) : i32
    %1 = llvm.sext %arg0 : i8 to i32
    %2 = llvm.select %arg1, %1, %0 : i1, i32
    llvm.return %2 : i32
  }
  llvm.func @test_bits_zext(%arg0: i8, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.zext %arg0 : i8 to i32
    %2 = llvm.select %arg1, %1, %0 : i1, i32
    llvm.return %2 : i32
  }
  llvm.func @sel_sext_const_uses(%arg0: i8, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.mlir.constant(127 : i32) : i32
    %2 = llvm.icmp "ugt" %arg1, %0 : i8
    %3 = llvm.sext %arg0 : i8 to i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.select %2, %3, %1 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @sel_zext_const_uses(%arg0: i8, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(15 : i8) : i8
    %1 = llvm.mlir.constant(255 : i32) : i32
    %2 = llvm.icmp "sgt" %arg1, %0 : i8
    %3 = llvm.zext %arg0 : i8 to i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.select %2, %1, %3 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @test_op_op(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.sext %1 : i1 to i32
    %3 = llvm.icmp "sgt" %arg1, %0 : i32
    %4 = llvm.sext %3 : i1 to i32
    %5 = llvm.icmp "sgt" %arg2, %0 : i32
    %6 = llvm.select %5, %2, %4 : i1, i32
    llvm.return %6 : i32
  }
  llvm.func @test_vectors_sext(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sext %arg0 : vector<2xi1> to vector<2xi32>
    %3 = llvm.select %arg1, %2, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @test_vectors_sext_nonsplat(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[0, -1]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.select %arg1, %1, %0 : vector<2xi1>, vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @test_vectors_zext(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.zext %arg0 : vector<2xi1> to vector<2xi32>
    %3 = llvm.select %arg1, %2, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @test_vectors_zext_nonsplat(%arg0: vector<2xi1>, %arg1: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[1, 0]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.select %arg1, %1, %0 : vector<2xi1>, vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @scalar_select_of_vectors_sext(%arg0: vector<2xi1>, %arg1: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sext %arg0 : vector<2xi1> to vector<2xi32>
    %3 = llvm.select %arg1, %2, %1 : i1, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @scalar_select_of_vectors_zext(%arg0: vector<2xi1>, %arg1: i1) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.zext %arg0 : vector<2xi1> to vector<2xi32>
    %3 = llvm.select %arg1, %2, %1 : i1, vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @sext_true_val_must_be_all_ones(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.select %arg0, %1, %0 : i1, i32
    llvm.return %2 : i32
  }
  llvm.func @sext_true_val_must_be_all_ones_vec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 12]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.select %arg0, %1, %0 : vector<2xi1>, vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @zext_true_val_must_be_one(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.select %arg0, %1, %0 : i1, i32
    llvm.return %2 : i32
  }
  llvm.func @zext_true_val_must_be_one_vec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 12]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.select %arg0, %1, %0 : vector<2xi1>, vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @sext_false_val_must_be_zero(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.sext %arg0 : i1 to i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.return %2 : i32
  }
  llvm.func @sext_false_val_must_be_zero_vec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 12]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.select %arg0, %0, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @zext_false_val_must_be_zero(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.select %arg0, %0, %1 : i1, i32
    llvm.return %2 : i32
  }
  llvm.func @zext_false_val_must_be_zero_vec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[42, 12]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.select %arg0, %0, %1 : vector<2xi1>, vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
}
