module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @simple_fold(%arg0: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(13 : i32) : i32
    %2 = llvm.sub %arg0, %0 overflow<nsw>  : i32
    %3 = "llvm.intr.ssub.with.overflow"(%2, %1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %3 : !llvm.struct<(i32, i1)>
  }
  llvm.func @fold_mixed_signs(%arg0: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(13 : i32) : i32
    %1 = llvm.mlir.constant(-7 : i32) : i32
    %2 = llvm.sub %arg0, %0 overflow<nsw>  : i32
    %3 = "llvm.intr.ssub.with.overflow"(%2, %1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %3 : !llvm.struct<(i32, i1)>
  }
  llvm.func @fold_on_constant_sub_no_overflow(%arg0: i8) -> !llvm.struct<(i8, i1)> {
    %0 = llvm.mlir.constant(100 : i8) : i8
    %1 = llvm.mlir.constant(28 : i8) : i8
    %2 = llvm.sub %arg0, %0 overflow<nsw>  : i8
    %3 = "llvm.intr.ssub.with.overflow"(%2, %1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.return %3 : !llvm.struct<(i8, i1)>
  }
  llvm.func @no_fold_on_constant_sub_overflow(%arg0: i8) -> !llvm.struct<(i8, i1)> {
    %0 = llvm.mlir.constant(100 : i8) : i8
    %1 = llvm.mlir.constant(29 : i8) : i8
    %2 = llvm.sub %arg0, %0 overflow<nsw>  : i8
    %3 = "llvm.intr.ssub.with.overflow"(%2, %1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.return %3 : !llvm.struct<(i8, i1)>
  }
  llvm.func @fold_simple_splat_constant(%arg0: vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)> {
    %0 = llvm.mlir.constant(dense<12> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<30> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %arg0, %0 overflow<nsw>  : vector<2xi32>
    %3 = "llvm.intr.ssub.with.overflow"(%2, %1) : (vector<2xi32>, vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)>
    llvm.return %3 : !llvm.struct<(vector<2xi32>, vector<2xi1>)>
  }
  llvm.func @no_fold_splat_undef_constant(%arg0: vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)> {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(dense<30> : vector<2xi32>) : vector<2xi32>
    %8 = llvm.sub %arg0, %6 overflow<nsw>  : vector<2xi32>
    %9 = "llvm.intr.ssub.with.overflow"(%8, %7) : (vector<2xi32>, vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)>
    llvm.return %9 : !llvm.struct<(vector<2xi32>, vector<2xi1>)>
  }
  llvm.func @no_fold_splat_not_constant(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)> {
    %0 = llvm.mlir.constant(dense<30> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.sub %arg0, %arg1 overflow<nsw>  : vector<2xi32>
    %2 = "llvm.intr.ssub.with.overflow"(%1, %0) : (vector<2xi32>, vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)>
    llvm.return %2 : !llvm.struct<(vector<2xi32>, vector<2xi1>)>
  }
  llvm.func @fold_nuwnsw(%arg0: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.sub %arg0, %0 overflow<nsw, nuw>  : i32
    %3 = "llvm.intr.ssub.with.overflow"(%2, %1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %3 : !llvm.struct<(i32, i1)>
  }
  llvm.func @no_fold_nuw(%arg0: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.sub %arg0, %0 overflow<nuw>  : i32
    %3 = "llvm.intr.ssub.with.overflow"(%2, %1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %3 : !llvm.struct<(i32, i1)>
  }
  llvm.func @no_fold_wrapped_sub(%arg0: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.sub %arg0, %0  : i32
    %3 = "llvm.intr.ssub.with.overflow"(%1, %2) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %3 : !llvm.struct<(i32, i1)>
  }
  llvm.func @fold_add_simple(%arg0: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(-12 : i32) : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = "llvm.intr.ssub.with.overflow"(%2, %1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %3 : !llvm.struct<(i32, i1)>
  }
  llvm.func @keep_ssubo_undef(%arg0: vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)> {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = "llvm.intr.ssub.with.overflow"(%arg0, %6) : (vector<2xi32>, vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)>
    llvm.return %7 : !llvm.struct<(vector<2xi32>, vector<2xi1>)>
  }
  llvm.func @keep_ssubo_non_splat(%arg0: vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)> {
    %0 = llvm.mlir.constant(dense<[30, 31]> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.ssub.with.overflow"(%arg0, %0) : (vector<2xi32>, vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)>
    llvm.return %1 : !llvm.struct<(vector<2xi32>, vector<2xi1>)>
  }
  llvm.func @keep_ssubo_one_element_is_128(%arg0: vector<2xi8>) -> !llvm.struct<(vector<2xi8>, vector<2xi1>)> {
    %0 = llvm.mlir.constant(dense<[0, -128]> : vector<2xi8>) : vector<2xi8>
    %1 = "llvm.intr.ssub.with.overflow"(%arg0, %0) : (vector<2xi8>, vector<2xi8>) -> !llvm.struct<(vector<2xi8>, vector<2xi1>)>
    llvm.return %1 : !llvm.struct<(vector<2xi8>, vector<2xi1>)>
  }
  llvm.func @keep_ssubo_128(%arg0: i8) -> !llvm.struct<(i8, i1)> {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = "llvm.intr.ssub.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.return %1 : !llvm.struct<(i8, i1)>
  }
}
