module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @entry(%arg0: i32, %arg1: i32, %arg2: i32, %arg3: i32, %arg4: i32) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %5 = llvm.mlir.constant(3 : i32) : i32
    %6 = llvm.mlir.zero : !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb3
    %7 = llvm.icmp "slt" %0, %arg4 : i32
    llvm.cond_br %7, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  ^bb3:  // 2 preds: ^bb1, ^bb4
    %8 = llvm.icmp "slt" %0, %arg2 : i32
    llvm.cond_br %8, ^bb4, ^bb1
  ^bb4:  // pred: ^bb3
    %9 = llvm.srem %1, %1  : vector<2xi32>
    %10 = llvm.extractelement %9[%2 : i32] : vector<2xi32>
    %11 = llvm.select %3, %0, %10 : i1, i32
    %12 = llvm.insertelement %11, %1[%2 : i32] : vector<2xi32>
    %13 = llvm.extractelement %12[%2 : i32] : vector<2xi32>
    %14 = llvm.insertelement %13, %4[%5 : i32] : vector<4xi32>
    %15 = llvm.sitofp %14 : vector<4xi32> to vector<4xf32>
    llvm.store %15, %6 {alignment = 16 : i64} : vector<4xf32>, !llvm.ptr
    llvm.br ^bb3
  }
}
