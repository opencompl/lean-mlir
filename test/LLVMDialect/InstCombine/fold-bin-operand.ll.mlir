module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "big">>} {
  llvm.func @f(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.inttoptr %0 : i32 to !llvm.ptr
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.inttoptr %2 : i32 to !llvm.ptr
    %4 = llvm.icmp "eq" %1, %3 : !llvm.ptr
    %5 = llvm.and %arg0, %4  : i1
    llvm.return %5 : i1
  }
  llvm.func @f_logical(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.inttoptr %0 : i32 to !llvm.ptr
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.inttoptr %2 : i32 to !llvm.ptr
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.icmp "eq" %1, %3 : !llvm.ptr
    %6 = llvm.select %arg0, %5, %4 : i1, i1
    llvm.return %6 : i1
  }
  llvm.func @g(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.inttoptr %0 : i32 to !llvm.ptr
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.inttoptr %2 : i32 to !llvm.ptr
    %4 = llvm.icmp "eq" %1, %3 : !llvm.ptr
    %5 = llvm.zext %4 : i1 to i32
    %6 = llvm.add %arg0, %5  : i32
    llvm.return %6 : i32
  }
  llvm.func @h(%arg0: i1, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.select %arg0, %0, %arg1 : i1, i32
    %3 = llvm.add %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @h1(%arg0: i1, %arg1: vector<4xi32>) -> vector<4xf32> {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.select %arg0, %0, %arg1 : i1, vector<4xi32>
    %2 = llvm.bitcast %1 : vector<4xi32> to vector<4xf32>
    llvm.return %2 : vector<4xf32>
  }
  llvm.func @h2(%arg0: i1, %arg1: !llvm.vec<? x 4 x  i32>) -> !llvm.vec<? x 4 x  f32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : !llvm.vec<? x 4 x  i32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<? x 4 x  i32>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<? x 4 x  i32>
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.insertelement %0, %5[%6 : i32] : !llvm.vec<? x 4 x  i32>
    %8 = llvm.mlir.constant(3 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : !llvm.vec<? x 4 x  i32>
    %10 = llvm.select %arg0, %9, %arg1 : i1, !llvm.vec<? x 4 x  i32>
    %11 = llvm.bitcast %10 : !llvm.vec<? x 4 x  i32> to !llvm.vec<? x 4 x  f32>
    llvm.return %11 : !llvm.vec<? x 4 x  f32>
  }
  llvm.func @h3(%arg0: i1, %arg1: !llvm.vec<? x 4 x  i32>) -> !llvm.vec<? x 2 x  i64> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : !llvm.vec<? x 4 x  i32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<? x 4 x  i32>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<? x 4 x  i32>
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.insertelement %0, %5[%6 : i32] : !llvm.vec<? x 4 x  i32>
    %8 = llvm.mlir.constant(3 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : !llvm.vec<? x 4 x  i32>
    %10 = llvm.select %arg0, %9, %arg1 : i1, !llvm.vec<? x 4 x  i32>
    %11 = llvm.bitcast %10 : !llvm.vec<? x 4 x  i32> to !llvm.vec<? x 2 x  i64>
    llvm.return %11 : !llvm.vec<? x 2 x  i64>
  }
}
