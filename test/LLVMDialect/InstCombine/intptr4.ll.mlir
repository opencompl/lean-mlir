module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func unnamed_addr @test(%arg0: !llvm.ptr, %arg1: !llvm.ptr {llvm.readnone}, %arg2: i64, %arg3: !llvm.ptr) {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.icmp "ult" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.inttoptr %arg2 : i64 to !llvm.ptr
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%arg2 : i64)
  ^bb2:  // pred: ^bb0
    %4 = llvm.ptrtoint %arg3 : !llvm.ptr to i64
    llvm.br ^bb3(%4 : i64)
  ^bb3(%5: i64):  // 2 preds: ^bb1, ^bb2
    llvm.br ^bb4(%arg0, %3, %5 : !llvm.ptr, !llvm.ptr, i64)
  ^bb4(%6: !llvm.ptr, %7: !llvm.ptr, %8: i64):  // 2 preds: ^bb3, ^bb4
    %9 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> f32
    %10 = llvm.fmul %9, %0  : f32
    llvm.store %10, %6 {alignment = 4 : i64} : f32, !llvm.ptr
    %11 = llvm.inttoptr %8 : i64 to !llvm.ptr
    %12 = llvm.getelementptr inbounds %11[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %13 = llvm.ptrtoint %12 : !llvm.ptr to i64
    %14 = llvm.getelementptr inbounds %6[%1] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %15 = llvm.icmp "ult" %14, %arg1 : !llvm.ptr
    llvm.cond_br %15, ^bb4(%14, %12, %13 : !llvm.ptr, !llvm.ptr, i64), ^bb5
  ^bb5:  // pred: ^bb4
    llvm.return
  }
}
