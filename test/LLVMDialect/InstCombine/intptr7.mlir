module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @matching_phi(%arg0: i64, %arg1: !llvm.ptr, %arg2: i1) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(1.000000e+01 : f32) : f32
    %4 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %5 = llvm.icmp "eq" %arg2, %0 : i1
    %6 = llvm.add %arg0, %1  : i64
    %7 = llvm.inttoptr %6 : i64 to !llvm.ptr
    %8 = llvm.getelementptr inbounds %arg1[%2] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %9 = llvm.ptrtoint %8 : !llvm.ptr to i64
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%8, %9 : !llvm.ptr, i64)
  ^bb2:  // pred: ^bb0
    llvm.store %3, %7 {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.br ^bb3(%7, %6 : !llvm.ptr, i64)
  ^bb3(%10: !llvm.ptr, %11: i64):  // 2 preds: ^bb1, ^bb2
    %12 = llvm.inttoptr %11 : i64 to !llvm.ptr
    %13 = llvm.load %12 {alignment = 4 : i64} : !llvm.ptr -> f32
    %14 = llvm.fmul %13, %4  : f32
    llvm.store %14, %10 {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.return
  }
  llvm.func @no_matching_phi(%arg0: i64, %arg1: !llvm.ptr, %arg2: i1) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(1.000000e+01 : f32) : f32
    %4 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %5 = llvm.icmp "eq" %arg2, %0 : i1
    %6 = llvm.add %arg0, %1  : i64
    %7 = llvm.inttoptr %6 : i64 to !llvm.ptr
    %8 = llvm.getelementptr inbounds %arg1[%2] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %9 = llvm.ptrtoint %8 : !llvm.ptr to i64
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%8, %6 : !llvm.ptr, i64)
  ^bb2:  // pred: ^bb0
    llvm.store %3, %7 {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.br ^bb3(%7, %9 : !llvm.ptr, i64)
  ^bb3(%10: !llvm.ptr, %11: i64):  // 2 preds: ^bb1, ^bb2
    %12 = llvm.inttoptr %11 : i64 to !llvm.ptr
    %13 = llvm.load %12 {alignment = 4 : i64} : !llvm.ptr -> f32
    %14 = llvm.fmul %13, %4  : f32
    llvm.store %14, %10 {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.return
  }
}
