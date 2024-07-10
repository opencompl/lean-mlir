module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @shl_add(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0  : i32
    %3 = llvm.add %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @shl_add_nsw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0  : i32
    %3 = llvm.add %2, %1 overflow<nsw>  : i32
    llvm.return %3 : i32
  }
  llvm.func @shl_add_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0  : i32
    %3 = llvm.add %2, %1 overflow<nuw>  : i32
    llvm.return %3 : i32
  }
  llvm.func @shl_add_nsw_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0  : i32
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : i32
    llvm.return %3 : i32
  }
  llvm.func @shl_nsw_add(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.add %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @shl_nsw_add_nsw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.add %2, %1 overflow<nsw>  : i32
    llvm.return %3 : i32
  }
  llvm.func @shl_nsw_add_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.add %2, %1 overflow<nuw>  : i32
    llvm.return %3 : i32
  }
  llvm.func @shl_nsw_add_nsw_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0 overflow<nsw>  : i32
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : i32
    llvm.return %3 : i32
  }
  llvm.func @shl_nuw_add(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0 overflow<nuw>  : i32
    %3 = llvm.add %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @shl_nuw_add_nsw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0 overflow<nuw>  : i32
    %3 = llvm.add %2, %1 overflow<nsw>  : i32
    llvm.return %3 : i32
  }
  llvm.func @shl_nuw_add_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0 overflow<nuw>  : i32
    %3 = llvm.add %2, %1 overflow<nuw>  : i32
    llvm.return %3 : i32
  }
  llvm.func @shl_nuw_add_nsw_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0 overflow<nuw>  : i32
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : i32
    llvm.return %3 : i32
  }
  llvm.func @shl_nsw_nuw_add(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0 overflow<nsw, nuw>  : i32
    %3 = llvm.add %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @shl_nsw_nuw_add_nsw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0 overflow<nsw, nuw>  : i32
    %3 = llvm.add %2, %1 overflow<nsw>  : i32
    llvm.return %3 : i32
  }
  llvm.func @shl_nsw_nuw_add_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0 overflow<nsw, nuw>  : i32
    %3 = llvm.add %2, %1 overflow<nuw>  : i32
    llvm.return %3 : i32
  }
  llvm.func @shl_nsw_nuw_add_nsw_nuw(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0 overflow<nsw, nuw>  : i32
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : i32
    llvm.return %3 : i32
  }
  llvm.func @shl_add_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.shl %0, %arg0  : vector<2xi32>
    %3 = llvm.add %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @shl_add_vec_poison0(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(dense<-1> : vector<3xi32>) : vector<3xi32>
    %10 = llvm.shl %8, %arg0  : vector<3xi32>
    %11 = llvm.add %10, %9  : vector<3xi32>
    llvm.return %11 : vector<3xi32>
  }
  llvm.func @shl_add_vec_poison1(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<3xi32>) : vector<3xi32>
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.undef : vector<3xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi32>
    %10 = llvm.shl %0, %arg0  : vector<3xi32>
    %11 = llvm.add %10, %9  : vector<3xi32>
    llvm.return %11 : vector<3xi32>
  }
  llvm.func @shl_add_vec_poison2(%arg0: vector<3xi32>) -> vector<3xi32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<3xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi32>
    %9 = llvm.mlir.constant(-1 : i32) : i32
    %10 = llvm.mlir.undef : vector<3xi32>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi32>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi32>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi32>
    %17 = llvm.shl %8, %arg0  : vector<3xi32>
    %18 = llvm.add %17, %16  : vector<3xi32>
    llvm.return %18 : vector<3xi32>
  }
  llvm.func @use32(i32)
  llvm.func @bad_oneuse0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.shl %0, %arg0  : i32
    llvm.call @use32(%2) : (i32) -> ()
    %3 = llvm.add %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @bad_shl(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.shl %arg0, %arg1  : i32
    %2 = llvm.add %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @bad_add0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg0  : i32
    %2 = llvm.add %1, %arg1  : i32
    llvm.return %2 : i32
  }
  llvm.func @bad_add1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.shl %0, %arg0  : i32
    %2 = llvm.add %1, %0  : i32
    llvm.return %2 : i32
  }
  llvm.func @bad_add2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.shl %0, %arg0  : i32
    %3 = llvm.add %2, %1  : i32
    llvm.return %3 : i32
  }
}
