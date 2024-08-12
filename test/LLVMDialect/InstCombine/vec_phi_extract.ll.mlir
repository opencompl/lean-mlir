module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @f(%arg0: i64, %arg1: i32, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.undef : vector<16xi64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]> : vector<16xi64>) : vector<16xi64>
    %3 = llvm.mlir.constant(10 : i32) : i32
    %4 = llvm.mlir.constant(dense<16> : vector<16xi32>) : vector<16xi32>
    %5 = llvm.insertelement %arg0, %0[%1 : i32] : vector<16xi64>
    %6 = llvm.shufflevector %5, %0 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<16xi64> 
    %7 = llvm.add %6, %2  : vector<16xi64>
    %8 = llvm.trunc %7 : vector<16xi64> to vector<16xi32>
    llvm.br ^bb1(%8 : vector<16xi32>)
  ^bb1(%9: vector<16xi32>):  // 2 preds: ^bb0, ^bb1
    %10 = llvm.extractelement %9[%1 : i32] : vector<16xi32>
    %11 = llvm.icmp "ult" %10, %arg1 : i32
    %12 = llvm.add %3, %10  : i32
    %13 = llvm.sext %10 : i32 to i64
    %14 = llvm.getelementptr %arg2[%13] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %12, %14 {alignment = 4 : i64} : i32, !llvm.ptr
    %15 = llvm.add %9, %4  : vector<16xi32>
    llvm.cond_br %11, ^bb1(%15 : vector<16xi32>), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  }
  llvm.func @copy(%arg0: i64, %arg1: i32, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.undef : vector<16xi64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]> : vector<16xi64>) : vector<16xi64>
    %3 = llvm.mlir.constant(10 : i32) : i32
    %4 = llvm.mlir.constant(dense<16> : vector<16xi32>) : vector<16xi32>
    %5 = llvm.insertelement %arg0, %0[%1 : i32] : vector<16xi64>
    %6 = llvm.shufflevector %5, %0 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<16xi64> 
    %7 = llvm.add %6, %2  : vector<16xi64>
    %8 = llvm.trunc %7 : vector<16xi64> to vector<16xi32>
    llvm.br ^bb1(%8 : vector<16xi32>)
  ^bb1(%9: vector<16xi32>):  // 2 preds: ^bb0, ^bb1
    %10 = llvm.extractelement %9[%1 : i32] : vector<16xi32>
    %11 = llvm.extractelement %9[%1 : i32] : vector<16xi32>
    %12 = llvm.icmp "ult" %10, %arg1 : i32
    %13 = llvm.add %3, %11  : i32
    %14 = llvm.sext %10 : i32 to i64
    %15 = llvm.getelementptr %arg2[%14] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %13, %15 {alignment = 4 : i64} : i32, !llvm.ptr
    %16 = llvm.add %9, %4  : vector<16xi32>
    llvm.cond_br %12, ^bb1(%16 : vector<16xi32>), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  }
  llvm.func @nocopy(%arg0: i64, %arg1: i32, %arg2: !llvm.ptr) {
    %0 = llvm.mlir.undef : vector<16xi64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]> : vector<16xi64>) : vector<16xi64>
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(10 : i32) : i32
    %5 = llvm.mlir.constant(dense<16> : vector<16xi32>) : vector<16xi32>
    %6 = llvm.insertelement %arg0, %0[%1 : i32] : vector<16xi64>
    %7 = llvm.shufflevector %6, %0 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] : vector<16xi64> 
    %8 = llvm.add %7, %2  : vector<16xi64>
    %9 = llvm.trunc %8 : vector<16xi64> to vector<16xi32>
    llvm.br ^bb1(%9 : vector<16xi32>)
  ^bb1(%10: vector<16xi32>):  // 2 preds: ^bb0, ^bb1
    %11 = llvm.extractelement %10[%1 : i32] : vector<16xi32>
    %12 = llvm.extractelement %10[%3 : i32] : vector<16xi32>
    %13 = llvm.icmp "ult" %11, %arg1 : i32
    %14 = llvm.add %4, %12  : i32
    %15 = llvm.sext %11 : i32 to i64
    %16 = llvm.getelementptr %arg2[%15] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %14, %16 {alignment = 4 : i64} : i32, !llvm.ptr
    %17 = llvm.add %10, %5  : vector<16xi32>
    llvm.cond_br %13, ^bb1(%17 : vector<16xi32>), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  }
  llvm.func @g(%arg0: vector<3xi32>, %arg1: i1) -> i1 {
    %0 = llvm.mlir.poison : vector<3xi32>
    %1 = llvm.mlir.constant(dense<-1> : vector<3xi32>) : vector<3xi32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    llvm.br ^bb1(%arg0, %0 : vector<3xi32>, vector<3xi32>)
  ^bb1(%4: vector<3xi32>, %5: vector<3xi32>):  // 2 preds: ^bb0, ^bb2
    llvm.cond_br %arg1, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    %6 = llvm.add %5, %1  : vector<3xi32>
    %7 = llvm.sub %1, %6  : vector<3xi32>
    %8 = llvm.sdiv %4, %7  : vector<3xi32>
    llvm.br ^bb1(%8, %6 : vector<3xi32>, vector<3xi32>)
  ^bb3:  // pred: ^bb1
    %9 = llvm.extractelement %4[%2 : i32] : vector<3xi32>
    %10 = llvm.select %3, %2, %9 : i1, i32
    %11 = llvm.icmp "eq" %10, %2 : i32
    llvm.return %11 : i1
  }
}
