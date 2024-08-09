module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @simple_fold(%arg0: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(13 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = "llvm.intr.uadd.with.overflow"(%2, %1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %3 : !llvm.struct<(i32, i1)>
  }
  llvm.func @fold_on_constant_add_no_overflow(%arg0: i8) -> !llvm.struct<(i8, i1)> {
    %0 = llvm.mlir.constant(-56 : i8) : i8
    %1 = llvm.mlir.constant(55 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %3 = "llvm.intr.uadd.with.overflow"(%2, %1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.return %3 : !llvm.struct<(i8, i1)>
  }
  llvm.func @no_fold_on_constant_add_overflow(%arg0: i8) -> !llvm.struct<(i8, i1)> {
    %0 = llvm.mlir.constant(-56 : i8) : i8
    %1 = llvm.mlir.constant(56 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %3 = "llvm.intr.uadd.with.overflow"(%2, %1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.return %3 : !llvm.struct<(i8, i1)>
  }
  llvm.func @no_fold_vector_no_overflow(%arg0: vector<2xi8>) -> !llvm.struct<(vector<2xi8>, vector<2xi1>)> {
    %0 = llvm.mlir.constant(dense<[-57, -56]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<55> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0 overflow<nuw>  : vector<2xi8>
    %3 = "llvm.intr.uadd.with.overflow"(%2, %1) : (vector<2xi8>, vector<2xi8>) -> !llvm.struct<(vector<2xi8>, vector<2xi1>)>
    llvm.return %3 : !llvm.struct<(vector<2xi8>, vector<2xi1>)>
  }
  llvm.func @no_fold_vector_overflow(%arg0: vector<2xi8>) -> !llvm.struct<(vector<2xi8>, vector<2xi1>)> {
    %0 = llvm.mlir.constant(dense<[-56, -55]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<55> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0 overflow<nuw>  : vector<2xi8>
    %3 = "llvm.intr.uadd.with.overflow"(%2, %1) : (vector<2xi8>, vector<2xi8>) -> !llvm.struct<(vector<2xi8>, vector<2xi1>)>
    llvm.return %3 : !llvm.struct<(vector<2xi8>, vector<2xi1>)>
  }
  llvm.func @fold_simple_splat_constant(%arg0: vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)> {
    %0 = llvm.mlir.constant(dense<12> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<30> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0 overflow<nuw>  : vector<2xi32>
    %3 = "llvm.intr.uadd.with.overflow"(%2, %1) : (vector<2xi32>, vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)>
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
    %8 = llvm.add %arg0, %6 overflow<nuw>  : vector<2xi32>
    %9 = "llvm.intr.uadd.with.overflow"(%8, %7) : (vector<2xi32>, vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)>
    llvm.return %9 : !llvm.struct<(vector<2xi32>, vector<2xi1>)>
  }
  llvm.func @no_fold_splat_not_constant(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)> {
    %0 = llvm.mlir.constant(dense<30> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.add %arg0, %arg1 overflow<nuw>  : vector<2xi32>
    %2 = "llvm.intr.uadd.with.overflow"(%1, %0) : (vector<2xi32>, vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)>
    llvm.return %2 : !llvm.struct<(vector<2xi32>, vector<2xi1>)>
  }
  llvm.func @fold_nuwnsw(%arg0: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw, nuw>  : i32
    %3 = "llvm.intr.uadd.with.overflow"(%2, %1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %3 : !llvm.struct<(i32, i1)>
  }
  llvm.func @no_fold_nsw(%arg0: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = "llvm.intr.uadd.with.overflow"(%2, %1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %3 : !llvm.struct<(i32, i1)>
  }
  llvm.func @no_fold_wrapped_add(%arg0: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = "llvm.intr.uadd.with.overflow"(%1, %2) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %3 : !llvm.struct<(i32, i1)>
  }
  llvm.func @fold_simple_splat_with_disjoint_or_constant(%arg0: vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)> {
    %0 = llvm.mlir.constant(dense<12> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<30> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.or %arg0, %0  : vector<2xi32>
    %3 = "llvm.intr.uadd.with.overflow"(%2, %1) : (vector<2xi32>, vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)>
    llvm.return %3 : !llvm.struct<(vector<2xi32>, vector<2xi1>)>
  }
  llvm.func @fold_simple_splat_constant_with_or_fail(%arg0: vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)> {
    %0 = llvm.mlir.constant(dense<12> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<30> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.or %arg0, %0  : vector<2xi32>
    %3 = "llvm.intr.uadd.with.overflow"(%2, %1) : (vector<2xi32>, vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)>
    llvm.return %3 : !llvm.struct<(vector<2xi32>, vector<2xi1>)>
  }
}
