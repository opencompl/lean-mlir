module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @dec_mask_neg_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.add %3, %1  : i32
    llvm.return %4 : i32
  }
  llvm.func @dec_mask_commute_neg_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.sdiv %0, %arg0  : i32
    %4 = llvm.sub %1, %3  : i32
    %5 = llvm.and %3, %4  : i32
    %6 = llvm.add %5, %2  : i32
    llvm.return %6 : i32
  }
  llvm.func @dec_commute_mask_neg_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.add %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @dec_mask_neg_multiuse_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.add %3, %1  : i32
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %4 : i32
  }
  llvm.func @dec_mask_multiuse_neg_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.add %3, %1  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.return %4 : i32
  }
  llvm.func @dec_mask_neg_v2i32(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.sub %1, %arg0  : vector<2xi32>
    %4 = llvm.and %3, %arg0  : vector<2xi32>
    %5 = llvm.add %4, %2  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @dec_mask_neg_v2i32_poison(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.constant(-1 : i32) : i32
    %4 = llvm.mlir.undef : vector<2xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi32>
    %9 = llvm.sub %1, %arg0  : vector<2xi32>
    %10 = llvm.and %9, %arg0  : vector<2xi32>
    %11 = llvm.add %10, %8  : vector<2xi32>
    llvm.return %11 : vector<2xi32>
  }
  llvm.func @dec_mask_multiuse_neg_multiuse_v2i32(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.sub %1, %arg0  : vector<2xi32>
    %4 = llvm.and %3, %arg0  : vector<2xi32>
    %5 = llvm.add %4, %2  : vector<2xi32>
    llvm.call @usev(%3) : (vector<2xi32>) -> ()
    llvm.call @usev(%4) : (vector<2xi32>) -> ()
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @use(i32)
  llvm.func @usev(vector<2xi32>)
}
