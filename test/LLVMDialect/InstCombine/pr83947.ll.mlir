module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @c(0 : i32) {addr_space = 0 : i32, alignment = 4 : i64} : i32
  llvm.mlir.global external @b(0 : i32) {addr_space = 0 : i32, alignment = 4 : i64} : i32
  llvm.func @masked_scatter1() {
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
    %10 = llvm.mlir.poison : !llvm.vec<? x 4 x  ptr>
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.mlir.addressof @c : !llvm.ptr
    %13 = llvm.insertelement %12, %10[%11 : i64] : !llvm.vec<? x 4 x  ptr>
    %14 = llvm.shufflevector %13, %10 [0, 0, 0, 0] : !llvm.vec<? x 4 x  ptr> 
    %15 = llvm.mlir.poison : !llvm.vec<? x 4 x  i1>
    %16 = llvm.mlir.addressof @b : !llvm.ptr
    %17 = llvm.ptrtoint %16 : !llvm.ptr to i1
    %18 = llvm.insertelement %17, %15[%11 : i64] : !llvm.vec<? x 4 x  i1>
    %19 = llvm.shufflevector %18, %15 [0, 0, 0, 0] : !llvm.vec<? x 4 x  i1> 
    %20 = llvm.mlir.constant(4 : i32) : i32
    llvm.intr.masked.scatter %9, %14, %19 {alignment = 4 : i32} : !llvm.vec<? x 4 x  i32>, vector<[4]xi1> into !llvm.vec<? x 4 x  ptr>
    llvm.return
  }
  llvm.func @masked_scatter2() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.addressof @c : !llvm.ptr
    %3 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : !llvm.vec<2 x ptr>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : !llvm.vec<2 x ptr>
    %8 = llvm.mlir.constant(true) : i1
    %9 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %10 = llvm.mlir.constant(4 : i32) : i32
    llvm.intr.masked.scatter %1, %7, %9 {alignment = 4 : i32} : vector<2xi32>, vector<2xi1> into !llvm.vec<2 x ptr>
    llvm.return
  }
  llvm.func @masked_scatter3() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.addressof @c : !llvm.ptr
    %3 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : !llvm.vec<2 x ptr>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : !llvm.vec<2 x ptr>
    %8 = llvm.mlir.undef : vector<2xi1>
    %9 = llvm.mlir.constant(4 : i32) : i32
    llvm.intr.masked.scatter %1, %7, %8 {alignment = 4 : i32} : vector<2xi32>, vector<2xi1> into !llvm.vec<2 x ptr>
    llvm.return
  }
  llvm.func @masked_scatter4() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.addressof @c : !llvm.ptr
    %3 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : !llvm.vec<2 x ptr>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : !llvm.vec<2 x ptr>
    %8 = llvm.mlir.constant(false) : i1
    %9 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %10 = llvm.mlir.constant(4 : i32) : i32
    llvm.intr.masked.scatter %1, %7, %9 {alignment = 4 : i32} : vector<2xi32>, vector<2xi1> into !llvm.vec<2 x ptr>
    llvm.return
  }
  llvm.func @masked_scatter5() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.addressof @c : !llvm.ptr
    %3 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : !llvm.vec<2 x ptr>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : !llvm.vec<2 x ptr>
    %8 = llvm.mlir.constant(false) : i1
    %9 = llvm.mlir.constant(true) : i1
    %10 = llvm.mlir.constant(dense<[true, false]> : vector<2xi1>) : vector<2xi1>
    %11 = llvm.mlir.constant(4 : i32) : i32
    llvm.intr.masked.scatter %1, %7, %10 {alignment = 4 : i32} : vector<2xi32>, vector<2xi1> into !llvm.vec<2 x ptr>
    llvm.return
  }
  llvm.func @masked_scatter6() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.addressof @c : !llvm.ptr
    %3 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : !llvm.vec<2 x ptr>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : !llvm.vec<2 x ptr>
    %8 = llvm.mlir.constant(false) : i1
    %9 = llvm.mlir.undef : i1
    %10 = llvm.mlir.undef : vector<2xi1>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<2xi1>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %8, %12[%13 : i32] : vector<2xi1>
    %15 = llvm.mlir.constant(4 : i32) : i32
    llvm.intr.masked.scatter %1, %7, %14 {alignment = 4 : i32} : vector<2xi32>, vector<2xi1> into !llvm.vec<2 x ptr>
    llvm.return
  }
  llvm.func @masked_scatter7() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.addressof @c : !llvm.ptr
    %3 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : !llvm.vec<2 x ptr>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : !llvm.vec<2 x ptr>
    %8 = llvm.mlir.addressof @b : !llvm.ptr
    %9 = llvm.ptrtoint %8 : !llvm.ptr to i1
    %10 = llvm.mlir.undef : vector<2xi1>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<2xi1>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %9, %12[%13 : i32] : vector<2xi1>
    %15 = llvm.mlir.constant(4 : i32) : i32
    llvm.intr.masked.scatter %1, %7, %14 {alignment = 4 : i32} : vector<2xi32>, vector<2xi1> into !llvm.vec<2 x ptr>
    llvm.return
  }
}
