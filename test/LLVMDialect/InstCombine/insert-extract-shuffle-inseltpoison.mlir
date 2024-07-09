module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1(%arg0: vector<8xi8>) -> vector<1xi8> {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.poison : vector<1xi8>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.extractelement %arg0[%0 : i32] : vector<8xi8>
    %4 = llvm.insertelement %3, %1[%2 : i32] : vector<1xi8>
    llvm.return %4 : vector<1xi8>
  }
  llvm.func @test2(%arg0: vector<8xi16>, %arg1: vector<8xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.poison : vector<4xi16>
    %5 = llvm.extractelement %arg0[%0 : i32] : vector<8xi16>
    %6 = llvm.extractelement %arg0[%1 : i32] : vector<8xi16>
    %7 = llvm.extractelement %arg1[%2 : i32] : vector<8xi16>
    %8 = llvm.extractelement %arg0[%3 : i32] : vector<8xi16>
    %9 = llvm.insertelement %5, %4[%2 : i32] : vector<4xi16>
    %10 = llvm.insertelement %6, %9[%1 : i32] : vector<4xi16>
    %11 = llvm.insertelement %7, %10[%3 : i32] : vector<4xi16>
    %12 = llvm.insertelement %8, %11[%0 : i32] : vector<4xi16>
    llvm.return %12 : vector<4xi16>
  }
  llvm.func @test_vcopyq_lane_p64(%arg0: vector<2xi64>, %arg1: vector<1xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.extractelement %arg1[%0 : i32] : vector<1xi64>
    %3 = llvm.insertelement %2, %arg0[%1 : i32] : vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }
  llvm.func @widen_extract2(%arg0: vector<4xf32>, %arg1: vector<2xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.extractelement %arg1[%0 : i32] : vector<2xf32>
    %4 = llvm.extractelement %arg1[%1 : i32] : vector<2xf32>
    %5 = llvm.insertelement %3, %arg0[%1 : i32] : vector<4xf32>
    %6 = llvm.insertelement %4, %5[%2 : i32] : vector<4xf32>
    llvm.return %6 : vector<4xf32>
  }
  llvm.func @widen_extract3(%arg0: vector<4xf32>, %arg1: vector<3xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.extractelement %arg1[%0 : i32] : vector<3xf32>
    %4 = llvm.extractelement %arg1[%1 : i32] : vector<3xf32>
    %5 = llvm.extractelement %arg1[%2 : i32] : vector<3xf32>
    %6 = llvm.insertelement %3, %arg0[%2 : i32] : vector<4xf32>
    %7 = llvm.insertelement %4, %6[%1 : i32] : vector<4xf32>
    %8 = llvm.insertelement %5, %7[%0 : i32] : vector<4xf32>
    llvm.return %8 : vector<4xf32>
  }
  llvm.func @widen_extract4(%arg0: vector<8xf32>, %arg1: vector<2xf32>) -> vector<8xf32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.extractelement %arg1[%0 : i32] : vector<2xf32>
    %3 = llvm.insertelement %2, %arg0[%1 : i32] : vector<8xf32>
    llvm.return %3 : vector<8xf32>
  }
  llvm.func @pr26015(%arg0: vector<4xi16>) -> vector<8xi16> {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.mlir.constant(dense<0> : vector<8xi16>) : vector<8xi16>
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.mlir.constant(6 : i32) : i32
    %5 = llvm.mlir.constant(7 : i32) : i32
    %6 = llvm.extractelement %arg0[%0 : i32] : vector<4xi16>
    %7 = llvm.insertelement %6, %2[%3 : i32] : vector<8xi16>
    %8 = llvm.insertelement %1, %7[%4 : i32] : vector<8xi16>
    %9 = llvm.extractelement %arg0[%3 : i32] : vector<4xi16>
    %10 = llvm.insertelement %9, %8[%5 : i32] : vector<8xi16>
    llvm.return %10 : vector<8xi16>
  }
  llvm.func @pr25999(%arg0: vector<4xi16>, %arg1: i1) -> vector<8xi16> {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(4 : i16) : i16
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.mlir.constant(dense<0> : vector<8xi16>) : vector<8xi16>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(3 : i32) : i32
    %6 = llvm.mlir.constant(6 : i32) : i32
    %7 = llvm.mlir.constant(7 : i32) : i32
    %8 = llvm.extractelement %arg0[%0 : i32] : vector<4xi16>
    llvm.cond_br %arg1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %9 = llvm.insertelement %8, %3[%5 : i32] : vector<8xi16>
    %10 = llvm.insertelement %2, %9[%6 : i32] : vector<8xi16>
    %11 = llvm.extractelement %arg0[%5 : i32] : vector<4xi16>
    %12 = llvm.insertelement %11, %10[%7 : i32] : vector<8xi16>
    llvm.return %12 : vector<8xi16>
  ^bb2:  // pred: ^bb0
    %13 = llvm.add %8, %1  : i16
    %14 = llvm.insertelement %13, %3[%4 : i32] : vector<8xi16>
    llvm.return %14 : vector<8xi16>
  }
  llvm.func @pr25999_phis1(%arg0: i1, %arg1: vector<2xf64>, %arg2: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf64>) : vector<4xf64>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : vector<2xf64>, vector<4xf64>)
  ^bb1:  // pred: ^bb0
    %4 = llvm.call @dummy(%arg1) : (vector<2xf64>) -> vector<2xf64>
    llvm.br ^bb2(%4, %1 : vector<2xf64>, vector<4xf64>)
  ^bb2(%5: vector<2xf64>, %6: vector<4xf64>):  // 2 preds: ^bb0, ^bb1
    %7 = llvm.extractelement %5[%2 : i32] : vector<2xf64>
    %8 = llvm.insertelement %7, %6[%3 : i32] : vector<4xf64>
    llvm.return %8 : vector<4xf64>
  }
  llvm.func @dummy(vector<2xf64>) -> vector<2xf64>
  llvm.func @pr25999_phis2(%arg0: i1, %arg1: vector<2xf64>, %arg2: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf64>) : vector<4xf64>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : vector<2xf64>, vector<4xf64>)
  ^bb1:  // pred: ^bb0
    %4 = llvm.call @dummy(%arg1) : (vector<2xf64>) -> vector<2xf64>
    llvm.br ^bb2(%4, %1 : vector<2xf64>, vector<4xf64>)
  ^bb2(%5: vector<2xf64>, %6: vector<4xf64>):  // 2 preds: ^bb0, ^bb1
    %7 = llvm.fadd %5, %5  : vector<2xf64>
    %8 = llvm.extractelement %7[%2 : i32] : vector<2xf64>
    %9 = llvm.insertelement %8, %6[%3 : i32] : vector<4xf64>
    llvm.return %9 : vector<4xf64>
  }
  llvm.func @pr26354(%arg0: !llvm.ptr, %arg1: i1) -> f64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.undef : vector<4xf64>
    %3 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %4 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf64>) : vector<4xf64>
    %5 = llvm.mlir.constant(3 : i32) : i32
    %6 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> vector<2xf64>
    %7 = llvm.extractelement %6[%0 : i32] : vector<2xf64>
    %8 = llvm.extractelement %6[%1 : i32] : vector<2xf64>
    llvm.cond_br %arg1, ^bb1, ^bb2(%2 : vector<4xf64>)
  ^bb1:  // pred: ^bb0
    %9 = llvm.insertelement %8, %4[%5 : i32] : vector<4xf64>
    llvm.br ^bb2(%9 : vector<4xf64>)
  ^bb2(%10: vector<4xf64>):  // 2 preds: ^bb0, ^bb1
    %11 = llvm.extractelement %10[%1 : i32] : vector<4xf64>
    %12 = llvm.fmul %7, %11  : f64
    llvm.return %12 : f64
  }
  llvm.func @PR30923(%arg0: vector<2xf32>, %arg1: !llvm.ptr) -> vector<4xf32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.poison : vector<2xf32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.undef : f32
    %4 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %5 = llvm.mlir.undef : vector<4xf32>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %4, %5[%6 : i32] : vector<4xf32>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.insertelement %4, %7[%8 : i32] : vector<4xf32>
    %10 = llvm.mlir.constant(2 : i32) : i32
    %11 = llvm.insertelement %3, %9[%10 : i32] : vector<4xf32>
    %12 = llvm.mlir.constant(3 : i32) : i32
    %13 = llvm.insertelement %3, %11[%12 : i32] : vector<4xf32>
    %14 = llvm.mlir.constant(2 : i32) : i32
    %15 = llvm.mlir.constant(3 : i32) : i32
    %16 = llvm.extractelement %arg0[%0 : i32] : vector<2xf32>
    llvm.store %16, %arg1 {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %17 = llvm.shufflevector %arg0, %1 [0, 1, -1, -1] : vector<2xf32> 
    %18 = llvm.extractelement %17[%2 : i32] : vector<4xf32>
    %19 = llvm.insertelement %18, %13[%14 : i32] : vector<4xf32>
    %20 = llvm.insertelement %16, %19[%15 : i32] : vector<4xf32>
    llvm.return %20 : vector<4xf32>
  }
  llvm.func @extractelt_insertion(%arg0: vector<2xi32>, %arg1: i32) -> vector<4xi32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.extractelement %arg0[%0 : i32] : vector<2xi32>
    %6 = llvm.insertelement %5, %2[%3 : i64] : vector<4xi32>
    %7 = llvm.add %arg1, %4  : i32
    %8 = llvm.extractelement %arg0[%7 : i32] : vector<2xi32>
    %9 = llvm.icmp "eq" %8, %1 : i32
    %10 = llvm.select %9, %6, %2 : i1, vector<4xi32>
    llvm.return %10 : vector<4xi32>
  }
  llvm.func @collectShuffleElts(%arg0: vector<2xf32>, %arg1: f32) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.poison : vector<4xf32>
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.extractelement %arg0[%0 : i32] : vector<2xf32>
    %6 = llvm.extractelement %arg0[%1 : i32] : vector<2xf32>
    %7 = llvm.insertelement %5, %2[%1 : i32] : vector<4xf32>
    %8 = llvm.insertelement %6, %7[%3 : i32] : vector<4xf32>
    %9 = llvm.insertelement %arg1, %8[%4 : i32] : vector<4xf32>
    llvm.return %9 : vector<4xf32>
  }
  llvm.func @insert_shuffle(%arg0: f32, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %3 = llvm.shufflevector %2, %arg1 [0, 5, 6, 7] : vector<4xf32> 
    llvm.return %3 : vector<4xf32>
  }
  llvm.func @insert_shuffle_translate(%arg0: f32, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %3 = llvm.shufflevector %2, %arg1 [4, 0, 6, 7] : vector<4xf32> 
    llvm.return %3 : vector<4xf32>
  }
  llvm.func @insert_not_undef_shuffle_translate(%arg0: f32, %arg1: vector<4xf32>, %arg2: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.insertelement %arg0, %arg2[%0 : i32] : vector<4xf32>
    %2 = llvm.shufflevector %1, %arg1 [4, 5, 3, 7] : vector<4xf32> 
    llvm.return %2 : vector<4xf32>
  }
  llvm.func @insert_not_undef_shuffle_translate_commute(%arg0: f32, %arg1: vector<4xf32>, %arg2: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.insertelement %arg0, %arg2[%0 : i32] : vector<4xf32>
    %2 = llvm.shufflevector %arg1, %1 [0, 6, 2, -1] : vector<4xf32> 
    llvm.return %2 : vector<4xf32>
  }
  llvm.func @insert_insert_shuffle_translate(%arg0: f32, %arg1: f32, %arg2: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.insertelement %arg0, %arg2[%0 : i32] : vector<4xf32>
    %3 = llvm.insertelement %arg1, %arg2[%1 : i32] : vector<4xf32>
    %4 = llvm.shufflevector %2, %3 [4, 0, 6, 7] : vector<4xf32> 
    llvm.return %4 : vector<4xf32>
  }
  llvm.func @insert_insert_shuffle_translate_commute(%arg0: f32, %arg1: f32, %arg2: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.insertelement %arg0, %arg2[%0 : i32] : vector<4xf32>
    %3 = llvm.insertelement %arg1, %arg2[%1 : i32] : vector<4xf32>
    %4 = llvm.shufflevector %2, %3 [0, 6, 2, 3] : vector<4xf32> 
    llvm.return %4 : vector<4xf32>
  }
  llvm.func @insert_insert_shuffle_translate_wrong_mask(%arg0: f32, %arg1: f32, %arg2: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.insertelement %arg0, %arg2[%0 : i32] : vector<4xf32>
    %3 = llvm.insertelement %arg1, %arg2[%1 : i32] : vector<4xf32>
    %4 = llvm.shufflevector %2, %3 [0, 6, 2, 7] : vector<4xf32> 
    llvm.return %4 : vector<4xf32>
  }
  llvm.func @use(vector<4xf32>)
  llvm.func @insert_not_undef_shuffle_translate_commute_uses(%arg0: f32, %arg1: vector<4xf32>, %arg2: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.insertelement %arg0, %arg2[%0 : i32] : vector<4xf32>
    llvm.call @use(%1) : (vector<4xf32>) -> ()
    %2 = llvm.shufflevector %arg1, %1 [6, -1, 2, 3] : vector<4xf32> 
    llvm.return %2 : vector<4xf32>
  }
  llvm.func @insert_not_undef_shuffle_translate_commute_lengthen(%arg0: f32, %arg1: vector<4xf32>, %arg2: vector<4xf32>) -> vector<5xf32> {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.insertelement %arg0, %arg2[%0 : i32] : vector<4xf32>
    %2 = llvm.shufflevector %arg1, %1 [0, 6, 2, -1, -1] : vector<4xf32> 
    llvm.return %2 : vector<5xf32>
  }
  llvm.func @insert_nonzero_index_splat(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %3 = llvm.shufflevector %2, %0 [-1, 2, 2, -1] : vector<4xf32> 
    llvm.return %3 : vector<4xf32>
  }
  llvm.func @insert_nonzero_index_splat_narrow(%arg0: f64) -> vector<3xf64> {
    %0 = llvm.mlir.poison : vector<4xf64>
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf64>
    %3 = llvm.shufflevector %2, %0 [3, -1, 3] : vector<4xf64> 
    llvm.return %3 : vector<3xf64>
  }
  llvm.func @insert_nonzero_index_splat_widen(%arg0: i7) -> vector<5xi7> {
    %0 = llvm.mlir.poison : vector<4xi7>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xi7>
    %3 = llvm.shufflevector %2, %0 [-1, 1, 1, -1, 1] : vector<4xi7> 
    llvm.return %3 : vector<5xi7>
  }
  llvm.func @insert_nonzero_index_splat_extra_use(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    llvm.call @use(%2) : (vector<4xf32>) -> ()
    %3 = llvm.shufflevector %2, %0 [-1, 2, 2, -1] : vector<4xf32> 
    llvm.return %3 : vector<4xf32>
  }
  llvm.func @insert_nonzero_index_splat_wrong_base(%arg0: f32, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.poison : vector<4xf32>
    %2 = llvm.insertelement %arg0, %arg1[%0 : i32] : vector<4xf32>
    %3 = llvm.shufflevector %2, %1 [-1, 2, 3, -1] : vector<4xf32> 
    llvm.return %3 : vector<4xf32>
  }
  llvm.func @insert_nonzero_index_splat_wrong_index(%arg0: f32, %arg1: i32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.insertelement %arg0, %0[%arg1 : i32] : vector<4xf32>
    %2 = llvm.shufflevector %1, %0 [-1, 1, 1, -1] : vector<4xf32> 
    llvm.return %2 : vector<4xf32>
  }
  llvm.func @insert_in_splat(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %4 = llvm.shufflevector %3, %0 [-1, 0, 0, -1] : vector<4xf32> 
    %5 = llvm.insertelement %arg0, %4[%2 : i32] : vector<4xf32>
    llvm.return %5 : vector<4xf32>
  }
  llvm.func @insert_in_splat_extra_uses(%arg0: f32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    llvm.call @use(%3) : (vector<4xf32>) -> ()
    %4 = llvm.shufflevector %3, %0 [-1, 0, 0, -1] : vector<4xf32> 
    llvm.call @use(%4) : (vector<4xf32>) -> ()
    %5 = llvm.insertelement %arg0, %4[%2 : i32] : vector<4xf32>
    llvm.return %5 : vector<4xf32>
  }
  llvm.func @insert_in_splat_variable_index(%arg0: f32, %arg1: i32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %3 = llvm.shufflevector %2, %0 [-1, 0, 0, -1] : vector<4xf32> 
    %4 = llvm.insertelement %arg0, %3[%arg1 : i32] : vector<4xf32>
    llvm.return %4 : vector<4xf32>
  }
  llvm.func @insert_in_nonsplat(%arg0: f32, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.insertelement %arg0, %0[%1 : i32] : vector<4xf32>
    %4 = llvm.shufflevector %3, %arg1 [-1, 0, 4, -1] : vector<4xf32> 
    %5 = llvm.insertelement %arg0, %4[%2 : i32] : vector<4xf32>
    llvm.return %5 : vector<4xf32>
  }
  llvm.func @insert_in_nonsplat2(%arg0: f32, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.poison : vector<4xf32>
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.insertelement %arg0, %arg1[%0 : i32] : vector<4xf32>
    %4 = llvm.shufflevector %3, %1 [-1, 0, 1, -1] : vector<4xf32> 
    %5 = llvm.insertelement %arg0, %4[%2 : i32] : vector<4xf32>
    llvm.return %5 : vector<4xf32>
  }
  llvm.func @shuf_identity_padding(%arg0: vector<2xi8>, %arg1: i8) -> vector<4xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.shufflevector %arg0, %0 [0, 1, -1, -1] : vector<2xi8> 
    %4 = llvm.extractelement %arg0[%1 : i32] : vector<2xi8>
    %5 = llvm.insertelement %4, %3[%1 : i32] : vector<4xi8>
    %6 = llvm.insertelement %arg1, %5[%2 : i32] : vector<4xi8>
    llvm.return %6 : vector<4xi8>
  }
  llvm.func @shuf_identity_extract(%arg0: vector<4xi8>, %arg1: i8) -> vector<3xi8> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.shufflevector %arg0, %0 [0, -1, -1] : vector<4xi8> 
    %4 = llvm.extractelement %arg0[%1 : i32] : vector<4xi8>
    %5 = llvm.insertelement %4, %3[%1 : i32] : vector<3xi8>
    %6 = llvm.insertelement %arg1, %5[%2 : i32] : vector<3xi8>
    llvm.return %6 : vector<3xi8>
  }
  llvm.func @shuf_identity_extract_extra_use(%arg0: vector<6xf32>, %arg1: f32) -> vector<4xf32> {
    %0 = llvm.mlir.poison : vector<6xf32>
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.shufflevector %arg0, %0 [0, -1, -1, 3] : vector<6xf32> 
    llvm.call @use(%3) : (vector<4xf32>) -> ()
    %4 = llvm.extractelement %arg0[%1 : i32] : vector<6xf32>
    %5 = llvm.insertelement %4, %3[%1 : i32] : vector<4xf32>
    %6 = llvm.insertelement %arg1, %5[%2 : i32] : vector<4xf32>
    llvm.return %6 : vector<4xf32>
  }
  llvm.func @shuf_identity_padding_variable_index(%arg0: vector<2xi8>, %arg1: i8, %arg2: i32) -> vector<4xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.shufflevector %arg0, %0 [0, 1, -1, -1] : vector<2xi8> 
    %3 = llvm.extractelement %arg0[%arg2 : i32] : vector<2xi8>
    %4 = llvm.insertelement %3, %2[%arg2 : i32] : vector<4xi8>
    %5 = llvm.insertelement %arg1, %4[%1 : i32] : vector<4xi8>
    llvm.return %5 : vector<4xi8>
  }
  llvm.func @shuf_identity_padding_wrong_source_vec(%arg0: vector<2xi8>, %arg1: i8, %arg2: vector<2xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.shufflevector %arg0, %0 [0, 1, -1, -1] : vector<2xi8> 
    %4 = llvm.extractelement %arg2[%1 : i32] : vector<2xi8>
    %5 = llvm.insertelement %4, %3[%1 : i32] : vector<4xi8>
    %6 = llvm.insertelement %arg1, %5[%2 : i32] : vector<4xi8>
    llvm.return %6 : vector<4xi8>
  }
  llvm.func @shuf_identity_padding_wrong_index(%arg0: vector<2xi8>, %arg1: i8) -> vector<4xi8> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.shufflevector %arg0, %0 [0, 1, -1, -1] : vector<2xi8> 
    %5 = llvm.extractelement %arg0[%1 : i32] : vector<2xi8>
    %6 = llvm.insertelement %5, %4[%2 : i32] : vector<4xi8>
    %7 = llvm.insertelement %arg1, %6[%3 : i32] : vector<4xi8>
    llvm.return %7 : vector<4xi8>
  }
  llvm.func @insert_undemanded_element_op0(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.insertelement %0, %arg0[%1 : i32] : vector<4xf32>
    llvm.call @use(%2) : (vector<4xf32>) -> ()
    %3 = llvm.shufflevector %2, %arg1 [0, 7, 1, 4] : vector<4xf32> 
    llvm.return %3 : vector<4xf32>
  }
  llvm.func @insert_undemanded_element_op1(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.insertelement %0, %arg0[%1 : i32] : vector<4xf32>
    llvm.call @use(%2) : (vector<4xf32>) -> ()
    %3 = llvm.shufflevector %arg1, %2 [3, 2, 1, 4] : vector<4xf32> 
    llvm.return %3 : vector<4xf32>
  }
  llvm.func @insert_demanded_element_op0(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.insertelement %0, %arg0[%1 : i32] : vector<4xf32>
    llvm.call @use(%2) : (vector<4xf32>) -> ()
    %3 = llvm.shufflevector %2, %arg1 [3, 2, 1, 4] : vector<4xf32> 
    llvm.return %3 : vector<4xf32>
  }
  llvm.func @insert_demanded_element_op1(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(4.300000e+01 : f32) : f32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.insertelement %0, %arg0[%1 : i32] : vector<4xf32>
    llvm.call @use(%2) : (vector<4xf32>) -> ()
    %3 = llvm.shufflevector %arg1, %2 [0, 7, 1, 4] : vector<4xf32> 
    llvm.return %3 : vector<4xf32>
  }
  llvm.func @splat_constant(%arg0: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.poison : vector<4xf32>
    %3 = llvm.insertelement %0, %arg0[%1 : i32] : vector<4xf32>
    %4 = llvm.shufflevector %3, %2 [3, 3, 3, 3] : vector<4xf32> 
    %5 = llvm.fadd %3, %4  : vector<4xf32>
    llvm.return %5 : vector<4xf32>
  }
}
