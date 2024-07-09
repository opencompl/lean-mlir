module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @G() {addr_space = 0 : i32} : i8
  llvm.func @load_zeromask(%arg0: !llvm.ptr, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.intr.masked.load %arg0, %1, %arg1 {alignment = 1 : i32} : (!llvm.ptr, vector<2xi1>, vector<2xf64>) -> vector<2xf64>
    llvm.return %3 : vector<2xf64>
  }
  llvm.func @load_onemask(%arg0: !llvm.ptr, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.intr.masked.load %arg0, %1, %arg1 {alignment = 2 : i32} : (!llvm.ptr, vector<2xi1>, vector<2xf64>) -> vector<2xf64>
    llvm.return %3 : vector<2xf64>
  }
  llvm.func @load_undefmask(%arg0: !llvm.ptr, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.undef : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.undef : vector<2xi1>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi1>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi1>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.intr.masked.load %arg0, %6, %arg1 {alignment = 2 : i32} : (!llvm.ptr, vector<2xi1>, vector<2xf64>) -> vector<2xf64>
    llvm.return %8 : vector<2xf64>
  }
  llvm.func @load_cemask(%arg0: !llvm.ptr, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.addressof @G : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i1
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.undef : vector<2xi1>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<2xi1>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<2xi1>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.intr.masked.load %arg0, %7, %arg1 {alignment = 2 : i32} : (!llvm.ptr, vector<2xi1>, vector<2xf64>) -> vector<2xf64>
    llvm.return %9 : vector<2xf64>
  }
  llvm.func @load_lane0(%arg0: !llvm.ptr, %arg1: f64) -> vector<2xf64> {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.mlir.constant(dense<[true, false]> : vector<2xi1>) : vector<2xi1>
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.insertelement %arg1, %0[%1 : i64] : vector<2xf64>
    %8 = llvm.insertelement %arg1, %7[%2 : i64] : vector<2xf64>
    %9 = llvm.intr.masked.load %arg0, %5, %8 {alignment = 2 : i32} : (!llvm.ptr, vector<2xi1>, vector<2xf64>) -> vector<2xf64>
    llvm.return %9 : vector<2xf64>
  }
  llvm.func @load_all(%arg0: !llvm.ptr, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(dense<[0, 1, 2, 3]> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<[true, false, true, true]> : vector<4xi1>) : vector<4xi1>
    %4 = llvm.mlir.undef : vector<4xf64>
    %5 = llvm.mlir.constant(4 : i32) : i32
    %6 = llvm.mlir.constant(2 : i64) : i64
    %7 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, vector<4xi64>) -> !llvm.vec<4 x ptr>, f64
    %8 = llvm.intr.masked.gather %7, %3, %4 {alignment = 4 : i32} : (!llvm.vec<4 x ptr>, vector<4xi1>, vector<4xf64>) -> vector<4xf64>
    %9 = llvm.extractelement %8[%6 : i64] : vector<4xf64>
    llvm.return %9 : f64
  }
  llvm.func @load_generic(%arg0: !llvm.ptr, %arg1: f64, %arg2: vector<2xi1>) -> vector<2xf64> {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.insertelement %arg1, %0[%1 : i64] : vector<2xf64>
    %5 = llvm.insertelement %arg1, %4[%2 : i64] : vector<2xf64>
    %6 = llvm.intr.masked.load %arg0, %arg2, %5 {alignment = 4 : i32} : (!llvm.ptr, vector<2xi1>, vector<2xf64>) -> vector<2xf64>
    llvm.return %6 : vector<2xf64>
  }
  llvm.func @load_speculative(%arg0: !llvm.ptr {llvm.align = 4 : i64, llvm.dereferenceable = 16 : i64}, %arg1: f64, %arg2: vector<2xi1>) -> vector<2xf64> attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.insertelement %arg1, %0[%1 : i64] : vector<2xf64>
    %5 = llvm.insertelement %arg1, %4[%2 : i64] : vector<2xf64>
    %6 = llvm.intr.masked.load %arg0, %arg2, %5 {alignment = 4 : i32} : (!llvm.ptr, vector<2xi1>, vector<2xf64>) -> vector<2xf64>
    llvm.return %6 : vector<2xf64>
  }
  llvm.func @load_speculative_less_aligned(%arg0: !llvm.ptr {llvm.dereferenceable = 16 : i64}, %arg1: f64, %arg2: vector<2xi1>) -> vector<2xf64> attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.insertelement %arg1, %0[%1 : i64] : vector<2xf64>
    %5 = llvm.insertelement %arg1, %4[%2 : i64] : vector<2xf64>
    %6 = llvm.intr.masked.load %arg0, %arg2, %5 {alignment = 4 : i32} : (!llvm.ptr, vector<2xi1>, vector<2xf64>) -> vector<2xf64>
    llvm.return %6 : vector<2xf64>
  }
  llvm.func @load_spec_neg_size(%arg0: !llvm.ptr {llvm.dereferenceable = 8 : i64}, %arg1: f64, %arg2: vector<2xi1>) -> vector<2xf64> attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.insertelement %arg1, %0[%1 : i64] : vector<2xf64>
    %5 = llvm.insertelement %arg1, %4[%2 : i64] : vector<2xf64>
    %6 = llvm.intr.masked.load %arg0, %arg2, %5 {alignment = 4 : i32} : (!llvm.ptr, vector<2xi1>, vector<2xf64>) -> vector<2xf64>
    llvm.return %6 : vector<2xf64>
  }
  llvm.func @load_spec_lan0(%arg0: !llvm.ptr {llvm.dereferenceable = 8 : i64}, %arg1: f64, %arg2: vector<2xi1>) -> vector<2xf64> attributes {passthrough = ["nofree", "nosync"]} {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.mlir.constant(4 : i32) : i32
    %5 = llvm.insertelement %arg1, %0[%1 : i64] : vector<2xf64>
    %6 = llvm.insertelement %arg1, %5[%2 : i64] : vector<2xf64>
    %7 = llvm.insertelement %3, %arg2[%2 : i64] : vector<2xi1>
    %8 = llvm.intr.masked.load %arg0, %7, %6 {alignment = 4 : i32} : (!llvm.ptr, vector<2xi1>, vector<2xf64>) -> vector<2xf64>
    llvm.return %8 : vector<2xf64>
  }
  llvm.func @store_zeromask(%arg0: !llvm.ptr, %arg1: vector<2xf64>) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(4 : i32) : i32
    llvm.intr.masked.store %arg1, %arg0, %1 {alignment = 4 : i32} : vector<2xf64>, vector<2xi1> into !llvm.ptr
    llvm.return
  }
  llvm.func @store_onemask(%arg0: !llvm.ptr, %arg1: vector<2xf64>) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(4 : i32) : i32
    llvm.intr.masked.store %arg1, %arg0, %1 {alignment = 4 : i32} : vector<2xf64>, vector<2xi1> into !llvm.ptr
    llvm.return
  }
  llvm.func @store_demandedelts(%arg0: !llvm.ptr, %arg1: f64) {
    %0 = llvm.mlir.poison : vector<2xf64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.mlir.constant(dense<[true, false]> : vector<2xi1>) : vector<2xi1>
    %6 = llvm.mlir.constant(4 : i32) : i32
    %7 = llvm.insertelement %arg1, %0[%1 : i32] : vector<2xf64>
    %8 = llvm.insertelement %arg1, %7[%2 : i32] : vector<2xf64>
    llvm.intr.masked.store %8, %arg0, %5 {alignment = 4 : i32} : vector<2xf64>, vector<2xi1> into !llvm.ptr
    llvm.return
  }
  llvm.func @gather_generic(%arg0: !llvm.vec<2 x ptr>, %arg1: vector<2xi1>, %arg2: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.intr.masked.gather %arg0, %arg1, %arg2 {alignment = 4 : i32} : (!llvm.vec<2 x ptr>, vector<2xi1>, vector<2xf64>) -> vector<2xf64>
    llvm.return %1 : vector<2xf64>
  }
  llvm.func @gather_zeromask(%arg0: !llvm.vec<2 x ptr>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.intr.masked.gather %arg0, %1, %arg1 {alignment = 4 : i32} : (!llvm.vec<2 x ptr>, vector<2xi1>, vector<2xf64>) -> vector<2xf64>
    llvm.return %3 : vector<2xf64>
  }
  llvm.func @gather_onemask(%arg0: !llvm.vec<2 x ptr>, %arg1: vector<2xf64>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.intr.masked.gather %arg0, %1, %arg1 {alignment = 4 : i32} : (!llvm.vec<2 x ptr>, vector<2xi1>, vector<2xf64>) -> vector<2xf64>
    llvm.return %3 : vector<2xf64>
  }
  llvm.func @gather_lane2(%arg0: !llvm.ptr, %arg1: f64) -> vector<4xf64> {
    %0 = llvm.mlir.constant(dense<[0, 1, 2, 3]> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mlir.poison : vector<4xf64>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.mlir.constant(true) : i1
    %5 = llvm.mlir.constant(dense<[false, false, true, false]> : vector<4xi1>) : vector<4xi1>
    %6 = llvm.mlir.constant(4 : i32) : i32
    %7 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, vector<4xi64>) -> !llvm.vec<4 x ptr>, f64
    %8 = llvm.insertelement %arg1, %1[%2 : i64] : vector<4xf64>
    %9 = llvm.shufflevector %8, %1 [0, 0, 0, 0] : vector<4xf64> 
    %10 = llvm.intr.masked.gather %7, %5, %9 {alignment = 4 : i32} : (!llvm.vec<4 x ptr>, vector<4xi1>, vector<4xf64>) -> vector<4xf64>
    llvm.return %10 : vector<4xf64>
  }
  llvm.func @gather_lane0_maybe(%arg0: !llvm.ptr, %arg1: f64, %arg2: vector<2xi1>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.poison : vector<2xf64>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.mlir.constant(4 : i32) : i32
    %6 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, vector<2xi64>) -> !llvm.vec<2 x ptr>, f64
    %7 = llvm.insertelement %arg1, %1[%2 : i64] : vector<2xf64>
    %8 = llvm.insertelement %arg1, %7[%3 : i64] : vector<2xf64>
    %9 = llvm.insertelement %4, %arg2[%3 : i64] : vector<2xi1>
    %10 = llvm.intr.masked.gather %6, %9, %8 {alignment = 4 : i32} : (!llvm.vec<2 x ptr>, vector<2xi1>, vector<2xf64>) -> vector<2xf64>
    llvm.return %10 : vector<2xf64>
  }
  llvm.func @gather_lane0_maybe_spec(%arg0: !llvm.ptr, %arg1: f64, %arg2: vector<2xi1>) -> vector<2xf64> {
    %0 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.poison : vector<2xf64>
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.mlir.constant(4 : i32) : i32
    %6 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, vector<2xi64>) -> !llvm.vec<2 x ptr>, f64
    %7 = llvm.insertelement %arg1, %1[%2 : i64] : vector<2xf64>
    %8 = llvm.insertelement %arg1, %7[%3 : i64] : vector<2xf64>
    %9 = llvm.insertelement %4, %arg2[%3 : i64] : vector<2xi1>
    %10 = llvm.intr.masked.gather %6, %9, %8 {alignment = 4 : i32} : (!llvm.vec<2 x ptr>, vector<2xi1>, vector<2xf64>) -> vector<2xf64>
    llvm.return %10 : vector<2xf64>
  }
  llvm.func @scatter_zeromask(%arg0: !llvm.vec<2 x ptr>, %arg1: vector<2xf64>) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.mlir.constant(8 : i32) : i32
    llvm.intr.masked.scatter %arg1, %arg0, %1 {alignment = 8 : i32} : vector<2xf64>, vector<2xi1> into !llvm.vec<2 x ptr>
    llvm.return
  }
  llvm.func @scatter_demandedelts(%arg0: !llvm.ptr, %arg1: f64) {
    %0 = llvm.mlir.constant(dense<[0, 1]> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.poison : vector<2xf64>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(false) : i1
    %5 = llvm.mlir.constant(true) : i1
    %6 = llvm.mlir.constant(dense<[true, false]> : vector<2xi1>) : vector<2xi1>
    %7 = llvm.mlir.constant(8 : i32) : i32
    %8 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, vector<2xi64>) -> !llvm.vec<2 x ptr>, f64
    %9 = llvm.insertelement %arg1, %1[%2 : i32] : vector<2xf64>
    %10 = llvm.insertelement %arg1, %9[%3 : i32] : vector<2xf64>
    llvm.intr.masked.scatter %10, %8, %6 {alignment = 8 : i32} : vector<2xf64>, vector<2xi1> into !llvm.vec<2 x ptr>
    llvm.return
  }
}
