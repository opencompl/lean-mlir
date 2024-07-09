module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @PR1738(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fcmp "ord" %arg0, %0 : f64
    %2 = llvm.fcmp "ord" %arg1, %0 : f64
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @PR1738_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.fcmp "ord" %arg0, %0 : f64
    %3 = llvm.fcmp "ord" %arg1, %0 : f64
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @PR1738_logical_noundef(%arg0: f64, %arg1: f64 {llvm.noundef}) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.fcmp "ord" %arg0, %0 : f64
    %3 = llvm.fcmp "ord" %arg1, %0 : f64
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @PR1738_vec_undef(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xi1> {
    %0 = llvm.mlir.undef : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.undef : vector<2xf64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf64>
    %7 = llvm.mlir.undef : vector<2xf64>
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<2xf64>
    %10 = llvm.mlir.constant(1 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<2xf64>
    %12 = llvm.fcmp "ord" %arg0, %6 : vector<2xf64>
    %13 = llvm.fcmp "ord" %arg1, %11 : vector<2xf64>
    %14 = llvm.and %12, %13  : vector<2xi1>
    llvm.return %14 : vector<2xi1>
  }
  llvm.func @PR1738_vec_poison(%arg0: vector<2xf64>, %arg1: vector<2xf64>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.undef : vector<2xf64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf64>
    %7 = llvm.mlir.undef : vector<2xf64>
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<2xf64>
    %10 = llvm.mlir.constant(1 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<2xf64>
    %12 = llvm.fcmp "ord" %arg0, %6 : vector<2xf64>
    %13 = llvm.fcmp "ord" %arg1, %11 : vector<2xf64>
    %14 = llvm.and %12, %13  : vector<2xi1>
    llvm.return %14 : vector<2xi1>
  }
  llvm.func @PR41069(%arg0: i1, %arg1: f32, %arg2: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ord" %arg1, %0 {fastmathFlags = #llvm.fastmath<arcp>} : f32
    %2 = llvm.and %1, %arg0  : i1
    %3 = llvm.fcmp "ord" %arg2, %0 {fastmathFlags = #llvm.fastmath<afn>} : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @PR41069_logical(%arg0: i1, %arg1: f32, %arg2: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.fcmp "ord" %arg1, %0 {fastmathFlags = #llvm.fastmath<arcp>} : f32
    %3 = llvm.select %2, %arg0, %1 : i1, i1
    %4 = llvm.fcmp "ord" %arg2, %0 {fastmathFlags = #llvm.fastmath<afn>} : f32
    %5 = llvm.select %3, %4, %1 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @PR41069_commute(%arg0: i1, %arg1: f32, %arg2: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.fcmp "ord" %arg1, %0 {fastmathFlags = #llvm.fastmath<ninf>} : f32
    %2 = llvm.and %1, %arg0  : i1
    %3 = llvm.fcmp "ord" %arg2, %0 {fastmathFlags = #llvm.fastmath<ninf, reassoc>} : f32
    %4 = llvm.and %3, %2  : i1
    llvm.return %4 : i1
  }
  llvm.func @PR41069_commute_logical(%arg0: i1, %arg1: f32, %arg2: f32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.fcmp "ord" %arg1, %0 {fastmathFlags = #llvm.fastmath<ninf>} : f32
    %3 = llvm.select %2, %arg0, %1 : i1, i1
    %4 = llvm.fcmp "ord" %arg2, %0 {fastmathFlags = #llvm.fastmath<ninf, reassoc>} : f32
    %5 = llvm.select %4, %3, %1 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @PR41069_vec(%arg0: vector<2xf64>, %arg1: vector<2xf64>, %arg2: vector<2xf64>, %arg3: vector<2xf64>) -> vector<2xi1> {
    %0 = llvm.mlir.undef : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.undef : vector<2xf64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf64>
    %7 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %8 = llvm.fcmp "ord" %arg0, %arg1 : vector<2xf64>
    %9 = llvm.fcmp "ord" %arg2, %6 : vector<2xf64>
    %10 = llvm.and %8, %9  : vector<2xi1>
    %11 = llvm.fcmp "ord" %arg3, %7 : vector<2xf64>
    %12 = llvm.and %10, %11  : vector<2xi1>
    llvm.return %12 : vector<2xi1>
  }
  llvm.func @PR41069_vec_commute(%arg0: vector<2xf64>, %arg1: vector<2xf64>, %arg2: vector<2xf64>, %arg3: vector<2xf64>) -> vector<2xi1> {
    %0 = llvm.mlir.undef : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.undef : vector<2xf64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf64>
    %7 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %8 = llvm.fcmp "ord" %arg0, %arg1 : vector<2xf64>
    %9 = llvm.fcmp "ord" %arg2, %6 : vector<2xf64>
    %10 = llvm.and %8, %9  : vector<2xi1>
    %11 = llvm.fcmp "ord" %arg3, %7 : vector<2xf64>
    %12 = llvm.and %11, %10  : vector<2xi1>
    llvm.return %12 : vector<2xi1>
  }
  llvm.func @PR15737(%arg0: f32, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.fcmp "ord" %arg0, %0 : f32
    %3 = llvm.fcmp "ord" %arg1, %1 : f64
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @PR15737_logical(%arg0: f32, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.fcmp "ord" %arg0, %0 : f32
    %4 = llvm.fcmp "ord" %arg1, %1 : f64
    %5 = llvm.select %3, %4, %2 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @t9(%arg0: vector<2xf32>, %arg1: vector<2xf64>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %3 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %4 = llvm.fcmp "ord" %arg0, %1 : vector<2xf32>
    %5 = llvm.fcmp "ord" %arg1, %3 : vector<2xf64>
    %6 = llvm.and %4, %5  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }
  llvm.func @fcmp_ord_nonzero(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.fcmp "ord" %arg0, %0 : f32
    %3 = llvm.fcmp "ord" %arg1, %1 : f32
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }
  llvm.func @fcmp_ord_nonzero_logical(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.fcmp "ord" %arg0, %0 : f32
    %4 = llvm.fcmp "ord" %arg1, %1 : f32
    %5 = llvm.select %3, %4, %2 : i1, i1
    llvm.return %5 : i1
  }
  llvm.func @fcmp_ord_nonzero_vec(%arg0: vector<3xf32>, %arg1: vector<3xf32>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00]> : vector<3xf32>) : vector<3xf32>
    %1 = llvm.mlir.constant(dense<[3.000000e+00, 2.000000e+00, 1.000000e+00]> : vector<3xf32>) : vector<3xf32>
    %2 = llvm.fcmp "ord" %arg0, %0 : vector<3xf32>
    %3 = llvm.fcmp "ord" %arg1, %1 : vector<3xf32>
    %4 = llvm.and %2, %3  : vector<3xi1>
    llvm.return %4 : vector<3xi1>
  }
  llvm.func @auto_gen_0(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %1 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_0_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_0_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_1(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %1 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_1_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_1_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "oeq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_2(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_2_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_2_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_3(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_3_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_3_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_4(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_4_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_4_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_5(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_5_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_5_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_6(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %1 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_6_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_6_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_7(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_7_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_7_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_8(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_8_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_8_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_9(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_9_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_9_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_10(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_10_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_10_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_11(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_11_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_11_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_12(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_12_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_12_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_13(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_13_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_13_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_14(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_14_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_14_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_15(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %1 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_15_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_15_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_16(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_16_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_16_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_17(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_17_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_17_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_18(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_18_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_18_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_19(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_19_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_19_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_20(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_20_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_20_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_21(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "one" %arg0, %arg1 : f64
    %1 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_21_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_21_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "one" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_22(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "one" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_22_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_22_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_23(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "one" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_23_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_23_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "one" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_24(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "one" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_24_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_24_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_25(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "one" %arg0, %arg1 : f64
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_25_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_25_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "one" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_26(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "one" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_26_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_26_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_27(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "one" %arg0, %arg1 : f64
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_27_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.fcmp "one" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_27_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "one" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "one" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_28(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %1 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_28_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_28_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_29(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_29_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_29_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ord" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_30(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_30_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_30_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_31(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_31_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_31_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ord" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_32(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_32_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_32_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_33(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_33_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_33_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ord" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_34(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_34_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.fcmp "one" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_34_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.fcmp "one" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_35(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_35_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_35_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ord" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "ord" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_36(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %1 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_36_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_36_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_37(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_37_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_37_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_38(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_38_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_38_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_39(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_39_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_39_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_40(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_40_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_40_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_41(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_41_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_41_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_42(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_42_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.fcmp "one" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_42_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.fcmp "one" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_43(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_43_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_43_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "ord" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_44(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_44_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_44_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_45(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_45_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_45_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_46(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_46_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_46_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_47(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_47_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_47_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_48(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_48_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_48_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_49(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_49_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_49_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_50(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_50_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_50_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_51(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_51_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "one" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_51_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "one" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_52(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_52_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_52_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ord" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_53(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_53_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_53_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_54(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_54_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_54_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ugt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_55(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %1 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_55_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_55_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_56(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_56_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_56_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_57(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_57_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_57_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_58(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_58_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_58_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_59(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_59_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_59_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_60(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_60_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_60_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_61(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_61_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "one" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_61_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "one" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_62(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_62_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_62_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ord" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_63(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_63_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_63_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_64(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_64_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_64_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ugt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_65(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_65_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_65_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_66(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %1 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_66_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_66_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_67(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_67_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_67_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_68(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_68_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_68_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_69(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_69_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_69_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_70(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_70_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_70_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_71(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_71_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_71_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_72(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_72_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.fcmp "one" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_72_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.fcmp "one" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_73(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_73_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_73_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "ord" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_74(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_74_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_74_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_75(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_75_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_75_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "ugt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_76(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_76_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_76_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_77(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_77_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_77_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ult" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "ult" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_78(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %1 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_78_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_78_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_79(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_79_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_79_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_80(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_80_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_80_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_81(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_81_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_81_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_82(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_82_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_82_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_83(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_83_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_83_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_84(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_84_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "one" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_84_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "one" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_85(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_85_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_85_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "ord" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_86(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_86_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_86_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_87(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_87_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_87_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "ugt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_88(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_88_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_88_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_89(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_89_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_89_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "ult" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_90(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_90_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_90_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ule" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_91(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    %1 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_91_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_91_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_92(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_92_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_92_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_93(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_93_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_93_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_94(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_94_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_94_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_95(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_95_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_95_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_96(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_96_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_96_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_97(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_97_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "one" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_97_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "one" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_98(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_98_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_98_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ord" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_99(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_99_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_99_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_100(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_100_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_100_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ugt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_101(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_101_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_101_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_102(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_102_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_102_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ult" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_103(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_103_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_103_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "ule" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_104(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "une" %arg0, %arg1 : f64
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_104_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "une" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_104_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.fcmp "une" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_105(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %1 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_105_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_105_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_106(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_106_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_106_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_107(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_107_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_107_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_108(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_108_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_108_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_109(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_109_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_109_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_110(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_110_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_110_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_111(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_111_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "one" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_111_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "one" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_112(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_112_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_112_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ord" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_113(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_113_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_113_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_114(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_114_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_114_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ugt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_115(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_115_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_115_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_116(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_116_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_116_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ult" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_117(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_117_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_117_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "ule" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_118(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_118_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "une" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_118_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "une" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_119(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_119_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_119_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "uno" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "uno" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_120(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %1 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_120_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_120_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_false" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_121(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_121_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_121_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "oeq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_122(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_122_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_122_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ogt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_123(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_123_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_123_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_124(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %1 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_124_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_124_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "olt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_125(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_125_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_125_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_126(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %1 = llvm.fcmp "one" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_126_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "one" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_126_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "one" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_127(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_127_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ord" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_127_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "ord" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_128(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_128_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ueq" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_128_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ueq" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_129(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_129_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ugt" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_129_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "ugt" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_130(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %1 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_130_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "uge" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_130_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "uge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_131(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_131_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ult" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_131_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "ult" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_132(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %1 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_132_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ule" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_132_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "ule" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_133(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %1 = llvm.fcmp "une" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_133_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "une" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_133_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "une" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_134(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %1 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_134_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "uno" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_134_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "uno" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_135(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @auto_gen_135_logical(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %2 = llvm.fcmp "_true" %arg0, %arg1 : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @auto_gen_135_logical_fmf(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.fcmp "_true" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.fcmp "_true" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @intersect_fmf_1(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %1 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @intersect_fmf_2(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %1 = llvm.fcmp "oge" %arg0, %arg1 : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @intersect_fmf_3(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ole" %arg0, %arg1 : f64
    %1 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<fast>} : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @intersect_fmf_4(%arg0: f64, %arg1: f64) -> i1 {
    %0 = llvm.fcmp "ole" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<ninf>} : f64
    %1 = llvm.fcmp "oge" %arg0, %arg1 {fastmathFlags = #llvm.fastmath<nnan>} : f64
    %2 = llvm.and %0, %1  : i1
    llvm.return %2 : i1
  }
  llvm.func @clang_builtin_isnormal_inf_check(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(0x7C00 : f16) : f16
    %2 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %3 = llvm.fcmp "ord" %2, %0 : f16
    %4 = llvm.fcmp "uge" %2, %1 : f16
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @clang_builtin_isnormal_inf_check_vector(%arg0: vector<2xf16>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf16>) : vector<2xf16>
    %2 = llvm.mlir.constant(dense<0x7C00> : vector<2xf16>) : vector<2xf16>
    %3 = llvm.intr.fabs(%arg0)  : (vector<2xf16>) -> vector<2xf16>
    %4 = llvm.fcmp "ord" %3, %1 : vector<2xf16>
    %5 = llvm.fcmp "uge" %3, %2 : vector<2xf16>
    %6 = llvm.and %4, %5  : vector<2xi1>
    llvm.return %6 : vector<2xi1>
  }
  llvm.func @clang_builtin_isnormal_inf_check_commute(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(0x7C00 : f16) : f16
    %2 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %3 = llvm.fcmp "ord" %2, %0 : f16
    %4 = llvm.fcmp "uge" %2, %1 : f16
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @clang_builtin_isnormal_inf_check_commute_nsz_rhs(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(0x7C00 : f16) : f16
    %2 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %3 = llvm.fcmp "ord" %2, %0 {fastmathFlags = #llvm.fastmath<nsz>} : f16
    %4 = llvm.fcmp "uge" %2, %1 : f16
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @clang_builtin_isnormal_inf_check_commute_nsz_lhs(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(0x7C00 : f16) : f16
    %2 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %3 = llvm.fcmp "ord" %2, %0 : f16
    %4 = llvm.fcmp "uge" %2, %1 {fastmathFlags = #llvm.fastmath<nsz>} : f16
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @clang_builtin_isnormal_inf_check_commute_nofabs_ueq(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(0x7C00 : f16) : f16
    %2 = llvm.fcmp "ord" %arg0, %0 : f16
    %3 = llvm.fcmp "ueq" %arg0, %1 : f16
    %4 = llvm.and %3, %2  : i1
    llvm.return %4 : i1
  }
  llvm.func @clang_builtin_isnormal_inf_check_commute_nsz(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(0x7C00 : f16) : f16
    %2 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %3 = llvm.fcmp "ord" %2, %0 {fastmathFlags = #llvm.fastmath<nsz>} : f16
    %4 = llvm.fcmp "uge" %2, %1 {fastmathFlags = #llvm.fastmath<nsz>} : f16
    %5 = llvm.and %4, %3  : i1
    llvm.return %5 : i1
  }
  llvm.func @clang_builtin_isnormal_inf_check_ugt(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(0x7C00 : f16) : f16
    %2 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %3 = llvm.fcmp "ord" %2, %0 : f16
    %4 = llvm.fcmp "ugt" %2, %1 : f16
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @clang_builtin_isnormal_inf_check_ult(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(0x7C00 : f16) : f16
    %2 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %3 = llvm.fcmp "ord" %2, %0 : f16
    %4 = llvm.fcmp "ult" %2, %1 : f16
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @clang_builtin_isnormal_inf_check_ule(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(0x7C00 : f16) : f16
    %2 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %3 = llvm.fcmp "ord" %2, %0 : f16
    %4 = llvm.fcmp "ule" %2, %1 : f16
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @clang_builtin_isnormal_inf_check_ueq(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(0x7C00 : f16) : f16
    %2 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %3 = llvm.fcmp "ord" %2, %0 : f16
    %4 = llvm.fcmp "ueq" %2, %1 : f16
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @clang_builtin_isnormal_inf_check_une(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(0x7C00 : f16) : f16
    %2 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %3 = llvm.fcmp "ord" %2, %0 : f16
    %4 = llvm.fcmp "une" %2, %1 : f16
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @clang_builtin_isnormal_inf_check_uno(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(0x7C00 : f16) : f16
    %2 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %3 = llvm.fcmp "ord" %2, %0 : f16
    %4 = llvm.fcmp "uno" %2, %1 : f16
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @clang_builtin_isnormal_inf_check_ord(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(0x7C00 : f16) : f16
    %2 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %3 = llvm.fcmp "ord" %2, %0 : f16
    %4 = llvm.fcmp "ord" %2, %1 : f16
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @clang_builtin_isnormal_inf_check_oge(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(0x7C00 : f16) : f16
    %2 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %3 = llvm.fcmp "ord" %2, %0 : f16
    %4 = llvm.fcmp "oge" %2, %1 : f16
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @clang_builtin_isnormal_inf_check_olt(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(0x7C00 : f16) : f16
    %2 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %3 = llvm.fcmp "ord" %2, %0 : f16
    %4 = llvm.fcmp "olt" %2, %1 : f16
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @clang_builtin_isnormal_inf_check_ole(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(0x7C00 : f16) : f16
    %2 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %3 = llvm.fcmp "ord" %2, %0 : f16
    %4 = llvm.fcmp "ole" %2, %1 : f16
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @clang_builtin_isnormal_inf_check_oeq(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(0x7C00 : f16) : f16
    %2 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %3 = llvm.fcmp "ord" %2, %0 : f16
    %4 = llvm.fcmp "oeq" %2, %1 : f16
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @clang_builtin_isnormal_inf_check_unnececcary_fabs(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(0x7C00 : f16) : f16
    %2 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %3 = llvm.fcmp "ord" %arg0, %0 : f16
    %4 = llvm.fcmp "uge" %2, %1 : f16
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @clang_builtin_isnormal_inf_check_not_ord(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(0x7C00 : f16) : f16
    %2 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %3 = llvm.fcmp "uno" %2, %0 : f16
    %4 = llvm.fcmp "uge" %2, %1 : f16
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @clang_builtin_isnormal_inf_check_missing_fabs(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(0x7C00 : f16) : f16
    %2 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %3 = llvm.fcmp "ord" %arg0, %0 : f16
    %4 = llvm.fcmp "uge" %arg0, %1 : f16
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @clang_builtin_isnormal_inf_check_neg_inf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(0xFC00 : f16) : f16
    %2 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %3 = llvm.fcmp "ord" %2, %0 : f16
    %4 = llvm.fcmp "uge" %2, %1 : f16
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @clang_builtin_isnormal_inf_check_not_inf(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(6.550400e+04 : f16) : f16
    %2 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %3 = llvm.fcmp "ord" %2, %0 : f16
    %4 = llvm.fcmp "uge" %2, %1 : f16
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @clang_builtin_isnormal_inf_check_nsz_lhs(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(0x7C00 : f16) : f16
    %2 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %3 = llvm.fcmp "ord" %2, %0 {fastmathFlags = #llvm.fastmath<nsz>} : f16
    %4 = llvm.fcmp "uge" %2, %1 : f16
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @clang_builtin_isnormal_inf_check_nsz_rhs(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(0x7C00 : f16) : f16
    %2 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %3 = llvm.fcmp "ord" %2, %0 : f16
    %4 = llvm.fcmp "uge" %2, %1 {fastmathFlags = #llvm.fastmath<nsz>} : f16
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @clang_builtin_isnormal_inf_check_nsz(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(0x7C00 : f16) : f16
    %2 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %3 = llvm.fcmp "ord" %2, %0 {fastmathFlags = #llvm.fastmath<nsz>} : f16
    %4 = llvm.fcmp "uge" %2, %1 {fastmathFlags = #llvm.fastmath<nsz>} : f16
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @clang_builtin_isnormal_inf_check_fneg(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(0x7C00 : f16) : f16
    %2 = llvm.fneg %arg0  : f16
    %3 = llvm.fcmp "ord" %2, %0 : f16
    %4 = llvm.fcmp "uge" %arg0, %1 : f16
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @clang_builtin_isnormal_inf_check_copysign(%arg0: f16, %arg1: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(0x7C00 : f16) : f16
    %2 = llvm.intr.copysign(%arg0, %arg1)  : (f16, f16) -> f16
    %3 = llvm.fcmp "ord" %arg0, %0 : f16
    %4 = llvm.fcmp "uge" %2, %1 : f16
    %5 = llvm.and %3, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @isnormal_logical_select_0(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(0x7C00 : f16) : f16
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %4 = llvm.fcmp "ord" %3, %0 : f16
    %5 = llvm.fcmp "uge" %3, %1 : f16
    %6 = llvm.select %4, %5, %2 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @isnormal_logical_select_1(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(0x7C00 : f16) : f16
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %4 = llvm.fcmp "ord" %3, %0 : f16
    %5 = llvm.fcmp "uge" %3, %1 : f16
    %6 = llvm.select %5, %4, %2 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @isnormal_logical_select_0_fmf0(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(0x7C00 : f16) : f16
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %4 = llvm.fcmp "ord" %3, %0 {fastmathFlags = #llvm.fastmath<nsz, arcp, reassoc>} : f16
    %5 = llvm.fcmp "uge" %3, %1 {fastmathFlags = #llvm.fastmath<nsz, arcp, reassoc>} : f16
    %6 = llvm.select %4, %5, %2 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @isnormal_logical_select_0_fmf1(%arg0: f16) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f16) : f16
    %1 = llvm.mlir.constant(0x7C00 : f16) : f16
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.intr.fabs(%arg0)  : (f16) -> f16
    %4 = llvm.fcmp "ord" %3, %0 : f16
    %5 = llvm.fcmp "uge" %3, %1 {fastmathFlags = #llvm.fastmath<nsz, arcp, reassoc>} : f16
    %6 = llvm.select %4, %5, %2 : i1, i1
    llvm.return %6 : i1
  }
}
