module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @extract_load(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> vector<4xi32>
    %2 = llvm.extractelement %1[%0 : i32] : vector<4xi32>
    llvm.return %2 : i32
  }
  llvm.func @extract_load_fp(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 32 : i64} : !llvm.ptr -> vector<4xf64>
    %2 = llvm.extractelement %1[%0 : i32] : vector<4xf64>
    llvm.return %2 : f64
  }
  llvm.func @extract_load_volatile(%arg0: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.load volatile %arg0 {alignment = 32 : i64} : !llvm.ptr -> vector<4xf64>
    %2 = llvm.extractelement %1[%0 : i32] : vector<4xf64>
    llvm.return %2 : f64
  }
  llvm.func @extract_load_extra_use(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> f64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> vector<4xf64>
    %2 = llvm.extractelement %1[%0 : i32] : vector<4xf64>
    llvm.store %1, %arg1 {alignment = 32 : i64} : vector<4xf64>, !llvm.ptr
    llvm.return %2 : f64
  }
  llvm.func @extract_load_variable_index(%arg0: !llvm.ptr, %arg1: i32) -> f64 {
    %0 = llvm.load %arg0 {alignment = 32 : i64} : !llvm.ptr -> vector<4xf64>
    %1 = llvm.extractelement %0[%arg1 : i32] : vector<4xf64>
    llvm.return %1 : f64
  }
  llvm.func @scalarize_phi(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(dense<2.330000e+00> : vector<4xf32>) : vector<4xf32>
    %5 = llvm.load volatile %arg1 {alignment = 4 : i64} : !llvm.ptr -> f32
    %6 = llvm.insertelement %5, %0[%1 : i32] : vector<4xf32>
    %7 = llvm.shufflevector %6, %0 [0, 0, 0, 0] : vector<4xf32> 
    %8 = llvm.insertelement %2, %0[%1 : i32] : vector<4xf32>
    llvm.br ^bb1(%7, %1 : vector<4xf32>, i32)
  ^bb1(%9: vector<4xf32>, %10: i32):  // 2 preds: ^bb0, ^bb2
    %11 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    %12 = llvm.icmp "ne" %10, %11 : i32
    llvm.cond_br %12, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %13 = llvm.extractelement %9[%3 : i32] : vector<4xf32>
    llvm.store volatile %13, %arg1 {alignment = 4 : i64} : f32, !llvm.ptr
    %14 = llvm.fmul %9, %4  : vector<4xf32>
    %15 = llvm.add %10, %3 overflow<nsw>  : i32
    llvm.br ^bb1(%14, %15 : vector<4xf32>, i32)
  ^bb3:  // pred: ^bb1
    llvm.return
  }
  llvm.func @extract_element_binop_splat_constant_index(%arg0: vector<4xf32>) -> f32 {
    %0 = llvm.mlir.constant(dense<2.330000e+00> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.fadd %arg0, %0  : vector<4xf32>
    %3 = llvm.extractelement %2[%1 : i32] : vector<4xf32>
    llvm.return %3 : f32
  }
  llvm.func @extract_element_binop_splat_with_undef_constant_index(%arg0: vector<2xf64>) -> f64 {
    %0 = llvm.mlir.undef : f64
    %1 = llvm.mlir.constant(4.200000e+01 : f64) : f64
    %2 = llvm.mlir.undef : vector<2xf64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf64>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.fdiv %6, %arg0  : vector<2xf64>
    %9 = llvm.extractelement %8[%7 : i32] : vector<2xf64>
    llvm.return %9 : f64
  }
  llvm.func @extract_element_binop_nonsplat_constant_index(%arg0: vector<2xf32>) -> f32 {
    %0 = llvm.mlir.constant(dense<[4.200000e+01, 4.300000e+01]> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.fmul %arg0, %0  : vector<2xf32>
    %3 = llvm.extractelement %2[%1 : i32] : vector<2xf32>
    llvm.return %3 : f32
  }
  llvm.func @extract_element_binop_splat_variable_index(%arg0: vector<4xi8>, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(dense<42> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.sdiv %arg0, %0  : vector<4xi8>
    %2 = llvm.extractelement %1[%arg1 : i32] : vector<4xi8>
    llvm.return %2 : i8
  }
  llvm.func @extract_element_binop_splat_with_undef_variable_index(%arg0: vector<4xi8>, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.undef : vector<4xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<4xi8>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %1, %6[%7 : i32] : vector<4xi8>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi8>
    %11 = llvm.mul %arg0, %10  : vector<4xi8>
    %12 = llvm.extractelement %11[%arg1 : i32] : vector<4xi8>
    llvm.return %12 : i8
  }
  llvm.func @extract_element_binop_nonsplat_variable_index(%arg0: vector<4xi8>, %arg1: i32) -> i8 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.undef : i8
    %2 = llvm.mlir.constant(3 : i8) : i8
    %3 = llvm.mlir.constant(4 : i8) : i8
    %4 = llvm.mlir.undef : vector<4xi8>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xi8>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<4xi8>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %1, %8[%9 : i32] : vector<4xi8>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<4xi8>
    %13 = llvm.lshr %arg0, %12  : vector<4xi8>
    %14 = llvm.extractelement %13[%arg1 : i32] : vector<4xi8>
    llvm.return %14 : i8
  }
  llvm.func @extract_element_load(%arg0: vector<4xf32>, %arg1: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.load %arg1 {alignment = 16 : i64} : !llvm.ptr -> vector<4xf32>
    %2 = llvm.fadd %arg0, %1  : vector<4xf32>
    %3 = llvm.extractelement %2[%0 : i32] : vector<4xf32>
    llvm.return %3 : f32
  }
  llvm.func @extract_element_multi_Use_load(%arg0: vector<4xf32>, %arg1: !llvm.ptr, %arg2: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.load %arg1 {alignment = 16 : i64} : !llvm.ptr -> vector<4xf32>
    llvm.store %1, %arg2 {alignment = 16 : i64} : vector<4xf32>, !llvm.ptr
    %2 = llvm.fadd %arg0, %1  : vector<4xf32>
    %3 = llvm.extractelement %2[%0 : i32] : vector<4xf32>
    llvm.return %3 : f32
  }
  llvm.func @extract_element_variable_index(%arg0: vector<4xf32>, %arg1: i32) -> f32 {
    %0 = llvm.mlir.constant(dense<1.000000e+00> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.fadd %arg0, %0  : vector<4xf32>
    %2 = llvm.extractelement %1[%arg1 : i32] : vector<4xf32>
    llvm.return %2 : f32
  }
  llvm.func @extelt_binop_insertelt(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.insertelement %arg2, %arg0[%0 : i32] : vector<4xf32>
    %2 = llvm.fmul %1, %arg1  {fastmathFlags = #llvm.fastmath<nnan>} : vector<4xf32>
    %3 = llvm.extractelement %2[%0 : i32] : vector<4xf32>
    llvm.return %3 : f32
  }
  llvm.func @extelt_binop_binop_insertelt(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.insertelement %arg2, %arg0[%0 : i32] : vector<4xi32>
    %2 = llvm.add %1, %arg1  : vector<4xi32>
    %3 = llvm.mul %2, %arg1 overflow<nsw>  : vector<4xi32>
    %4 = llvm.extractelement %3[%0 : i32] : vector<4xi32>
    llvm.return %4 : i32
  }
  llvm.func @extract_element_constant_vector_variable_index(%arg0: i32) -> f32 {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.extractelement %0[%arg0 : i32] : vector<4xf32>
    llvm.return %1 : f32
  }
  llvm.func @cheap_to_extract_icmp(%arg0: vector<4xi32>, %arg1: vector<4xi1>) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %1 : vector<4xi32>
    %4 = llvm.and %3, %arg1  : vector<4xi1>
    %5 = llvm.extractelement %4[%2 : i32] : vector<4xi1>
    llvm.return %5 : i1
  }
  llvm.func @cheap_to_extract_fcmp(%arg0: vector<4xf32>, %arg1: vector<4xi1>) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.fcmp "oeq" %arg0, %1 : vector<4xf32>
    %4 = llvm.and %3, %arg1  : vector<4xi1>
    %5 = llvm.extractelement %4[%2 : i32] : vector<4xi1>
    llvm.return %5 : i1
  }
  llvm.func @extractelt_vector_icmp_constrhs(%arg0: vector<2xi32>) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<2xi32>
    %3 = llvm.extractelement %2[%0 : i32] : vector<2xi1>
    llvm.return %3 : i1
  }
  llvm.func @extractelt_vector_fcmp_constrhs(%arg0: vector<2xf32>) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.fcmp "oeq" %arg0, %1 : vector<2xf32>
    %4 = llvm.extractelement %3[%2 : i32] : vector<2xi1>
    llvm.return %4 : i1
  }
  llvm.func @extractelt_vector_icmp_constrhs_dynidx(%arg0: vector<2xi32>, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<2xi32>
    %3 = llvm.extractelement %2[%arg1 : i32] : vector<2xi1>
    llvm.return %3 : i1
  }
  llvm.func @extractelt_vector_fcmp_constrhs_dynidx(%arg0: vector<2xf32>, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf32>) : vector<2xf32>
    %2 = llvm.fcmp "oeq" %arg0, %1 : vector<2xf32>
    %3 = llvm.extractelement %2[%arg1 : i32] : vector<2xi1>
    llvm.return %3 : i1
  }
  llvm.func @extractelt_vector_fcmp_not_cheap_to_scalarize_multi_use(%arg0: vector<2xf32>, %arg1: vector<2xf32>, %arg2: vector<2xf32>, %arg3: i32) -> i1 {
    %0 = llvm.mlir.undef : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.fadd %arg1, %arg2  : vector<2xf32>
    llvm.store volatile %2, %0 {alignment = 8 : i64} : vector<2xf32>, !llvm.ptr
    %3 = llvm.fcmp "oeq" %arg0, %2 : vector<2xf32>
    %4 = llvm.extractelement %3[%1 : i32] : vector<2xi1>
    llvm.return %4 : i1
  }
}
