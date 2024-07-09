module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @X() {addr_space = 0 : i32} : i32
  llvm.func @t0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.lshr %arg0, %2  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.lshr %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @t1_vec_splat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-2> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %0, %arg1  : vector<2xi32>
    %3 = llvm.lshr %arg0, %2  : vector<2xi32>
    %4 = llvm.add %arg1, %1  : vector<2xi32>
    %5 = llvm.lshr %3, %4  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @t2_vec_nonsplat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[32, 30]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-2, 0]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %0, %arg1  : vector<2xi32>
    %3 = llvm.lshr %arg0, %2  : vector<2xi32>
    %4 = llvm.add %arg1, %1  : vector<2xi32>
    %5 = llvm.lshr %3, %4  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @t3_vec_nonsplat_poison0(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(dense<-2> : vector<3xi32>) : vector<3xi32>
    %10 = llvm.sub %8, %arg1  : vector<3xi32>
    %11 = llvm.lshr %arg0, %10  : vector<3xi32>
    %12 = llvm.add %arg1, %9  : vector<3xi32>
    %13 = llvm.lshr %11, %12  : vector<3xi32>
    llvm.return %13 : vector<3xi32>
  }
  llvm.func @t4_vec_nonsplat_poison1(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<32> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.undef : vector<3xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi32>
    %10 = llvm.sub %0, %arg1  : vector<3xi32>
    %11 = llvm.lshr %arg0, %10  : vector<3xi32>
    %12 = llvm.add %arg1, %9  : vector<3xi32>
    %13 = llvm.lshr %11, %12  : vector<3xi32>
    llvm.return %13 : vector<3xi32>
  }
  llvm.func @t5_vec_nonsplat_poison1(%arg0: vector<3xi32>, %arg1: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(-2 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.sub %8, %arg1  : vector<3xi32>
    %18 = llvm.lshr %arg0, %17  : vector<3xi32>
    %19 = llvm.add %arg1, %16  : vector<3xi32>
    %20 = llvm.lshr %18, %19  : vector<3xi32>
    llvm.return %20 : vector<3xi32>
  }
  llvm.func @t6_shl(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.shl %arg0, %2 overflow<nuw>  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.shl %3, %4 overflow<nsw>  : i32
    llvm.return %5 : i32
  }
  llvm.func @t7_ashr(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.ashr %arg0, %2  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.ashr %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @t8_lshr_exact_flag_preservation(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.lshr %arg0, %2  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.lshr %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @t9_ashr_exact_flag_preservation(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.ashr %arg0, %2  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.ashr %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @t10_shl_nuw_flag_preservation(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.shl %arg0, %2 overflow<nuw>  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.shl %3, %4 overflow<nsw, nuw>  : i32
    llvm.return %5 : i32
  }
  llvm.func @t11_shl_nsw_flag_preservation(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.shl %arg0, %2 overflow<nsw>  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.shl %3, %4 overflow<nsw, nuw>  : i32
    llvm.return %5 : i32
  }
  llvm.func @constantexpr() -> i64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.addressof @X : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.undef : i64
    %5 = llvm.alloca %0 x i64 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %6 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i64
    %7 = llvm.add %2, %3  : i64
    %8 = llvm.shl %7, %3  : i64
    %9 = llvm.ashr %8, %6  : i64
    %10 = llvm.and %4, %9  : i64
    llvm.return %10 : i64
  }
  llvm.func @n12(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.lshr %arg0, %2  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.lshr %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @t13_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[32, 30]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<[-2, 2]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %0, %arg1  : vector<2xi32>
    %3 = llvm.lshr %arg0, %2  : vector<2xi32>
    %4 = llvm.add %arg1, %1  : vector<2xi32>
    %5 = llvm.lshr %3, %4  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @n13(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.lshr %arg0, %2  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.ashr %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @n14(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.lshr %arg0, %2  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.ashr %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @n15(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.ashr %arg0, %2  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.lshr %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @n16(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.ashr %arg0, %2  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.lshr %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @n17(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.shl %arg0, %2  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.lshr %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @n18(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.shl %arg0, %2  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.ashr %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @n19(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.lshr %arg0, %2  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.shl %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @n20(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.ashr %arg0, %2  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.shl %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @pr44802(%arg0: i3) -> i3 {
    %0 = llvm.mlir.constant(0 : i3) : i3
    %1 = llvm.sub %0, %arg0  : i3
    %2 = llvm.icmp "ne" %arg0, %0 : i3
    %3 = llvm.zext %2 : i1 to i3
    %4 = llvm.lshr %1, %3  : i3
    %5 = llvm.lshr %4, %3  : i3
    llvm.return %5 : i3
  }
}
