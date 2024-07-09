module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @i32_cast_cmp_oeq_int_0_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_oeq_int_n0_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_oeq_int_0_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_oeq_int_n0_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_one_int_0_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "one" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_one_int_n0_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "one" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_one_int_0_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "one" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_one_int_n0_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "one" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_ueq_int_0_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "ueq" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_ueq_int_n0_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "ueq" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_ueq_int_0_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "ueq" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_ueq_int_n0_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "ueq" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_une_int_0_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "une" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_une_int_n0_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "une" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_une_int_0_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "une" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_une_int_n0_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "une" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_ogt_int_0_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "ogt" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_ogt_int_n0_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "ogt" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_ogt_int_0_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "ogt" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_ogt_int_n0_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-0.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "ogt" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_ole_int_0_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "ole" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_ole_int_0_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "ole" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_olt_int_0_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "olt" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i64_cast_cmp_oeq_int_0_uitofp(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.uitofp %arg0 : i64 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i64_cast_cmp_oeq_int_0_sitofp(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.sitofp %arg0 : i64 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i64_cast_cmp_oeq_int_0_uitofp_half(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.uitofp %arg0 : i64 to f16
    %2 = llvm.fcmp "oeq" %1, %0 : f16
    llvm.return %2 : i1
  }
  llvm.func @i64_cast_cmp_oeq_int_0_sitofp_half(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.sitofp %arg0 : i64 to f16
    %2 = llvm.fcmp "oeq" %1, %0 : f16
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_oeq_int_0_uitofp_ppcf128(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f128) : !llvm.ppc_fp128
    %1 = llvm.uitofp %arg0 : i32 to !llvm.ppc_fp128
    %2 = llvm.fcmp "oeq" %1, %0 : !llvm.ppc_fp128
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_oeq_int_i24max_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0x4B7FFFFF : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_oeq_int_i24max_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0x4B7FFFFF : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_oeq_int_i24maxp1_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0x4B800000 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_oeq_int_i24maxp1_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0x4B800000 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_oeq_int_i32umax_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4.2949673E+9 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_oeq_int_big_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(8.58993459E+9 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_oeq_int_i32umax_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(4.2949673E+9 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_oeq_int_i32imin_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-2.14748365E+9 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_oeq_int_i32imax_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2.14748365E+9 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_oeq_int_i32imax_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2.14748365E+9 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_oeq_int_negi32umax_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-4.2949673E+9 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_oeq_half_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_oeq_half_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_one_half_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "one" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_one_half_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "one" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_ueq_half_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "ueq" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_ueq_half_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "ueq" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_une_half_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "une" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_une_half_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(5.000000e-01 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "une" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_oeq_int_inf_uitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %1 = llvm.uitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_cast_cmp_oeq_int_inf_sitofp(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %1 = llvm.sitofp %arg0 : i32 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i128_cast_cmp_oeq_int_inf_uitofp(%arg0: i128) -> i1 {
    %0 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %1 = llvm.uitofp %arg0 : i128 to f32
    %2 = llvm.fcmp "oeq" %1, %0 : f32
    llvm.return %2 : i1
  }
  llvm.func @i32_vec_cast_cmp_oeq_vec_int_0_sitofp(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.sitofp %arg0 : vector<2xi32> to vector<2xf32>
    %3 = llvm.fcmp "oeq" %2, %1 : vector<2xf32>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @i32_vec_cast_cmp_oeq_vec_int_n0_sitofp(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.sitofp %arg0 : vector<2xi32> to vector<2xf32>
    %2 = llvm.fcmp "oeq" %1, %0 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @i32_vec_cast_cmp_oeq_vec_int_i32imax_sitofp(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<2.14748365E+9> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.sitofp %arg0 : vector<2xi32> to vector<2xf32>
    %2 = llvm.fcmp "oeq" %1, %0 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @i32_vec_cast_cmp_oeq_vec_int_negi32umax_sitofp(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-4.2949673E+9> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.sitofp %arg0 : vector<2xi32> to vector<2xf32>
    %2 = llvm.fcmp "oeq" %1, %0 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @i32_vec_cast_cmp_oeq_vec_half_sitofp(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<5.000000e-01> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.sitofp %arg0 : vector<2xi32> to vector<2xf32>
    %2 = llvm.fcmp "oeq" %1, %0 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @i32_vec_cast_cmp_oeq_vec_int_inf_sitofp(%arg0: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<0x7F800000> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.sitofp %arg0 : vector<2xi32> to vector<2xf32>
    %2 = llvm.fcmp "oeq" %1, %0 : vector<2xf32>
    llvm.return %2 : vector<2xi1>
  }
}
