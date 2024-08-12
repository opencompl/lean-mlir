module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @global(0 : i32) {addr_space = 0 : i32} : i32
  llvm.func @sitofp(%arg0: f32) -> f32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    llvm.br ^bb1(%0 : i32)
  ^bb1(%2: i32):  // 2 preds: ^bb0, ^bb2
    %3 = llvm.bitcast %2 : i32 to f32
    %4 = llvm.fcmp "ogt" %3, %arg0 : f32
    llvm.cond_br %4, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    %5 = llvm.fadd %3, %1  : f32
    %6 = llvm.bitcast %5 : f32 to i32
    llvm.br ^bb1(%6 : i32)
  ^bb3:  // pred: ^bb1
    %7 = llvm.sitofp %2 : i32 to f32
    llvm.return %7 : f32
  }
  llvm.func @bitcast(%arg0: f32) -> vector<2xi16> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    llvm.br ^bb1(%0 : i32)
  ^bb1(%2: i32):  // 2 preds: ^bb0, ^bb2
    %3 = llvm.bitcast %2 : i32 to f32
    %4 = llvm.fcmp "ogt" %3, %arg0 : f32
    llvm.cond_br %4, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    %5 = llvm.fadd %3, %1  : f32
    %6 = llvm.bitcast %5 : f32 to i32
    llvm.br ^bb1(%6 : i32)
  ^bb3:  // pred: ^bb1
    %7 = llvm.bitcast %2 : i32 to vector<2xi16>
    llvm.return %7 : vector<2xi16>
  }
  llvm.func @store_volatile(%arg0: f32) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %2 = llvm.mlir.addressof @global : !llvm.ptr
    llvm.br ^bb1(%0 : i32)
  ^bb1(%3: i32):  // 2 preds: ^bb0, ^bb2
    %4 = llvm.bitcast %3 : i32 to f32
    %5 = llvm.fcmp "ogt" %4, %arg0 : f32
    llvm.cond_br %5, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    %6 = llvm.fadd %4, %1  : f32
    %7 = llvm.bitcast %6 : f32 to i32
    llvm.br ^bb1(%7 : i32)
  ^bb3:  // pred: ^bb1
    llvm.store volatile %3, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @store_address(%arg0: i32) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @global : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i32) : i32
    llvm.br ^bb1(%1, %0 : !llvm.ptr, i32)
  ^bb1(%3: !llvm.ptr, %4: i32):  // 2 preds: ^bb0, ^bb2
    %5 = llvm.icmp "sgt" %4, %arg0 : i32
    llvm.cond_br %5, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    %6 = llvm.add %4, %0  : i32
    %7 = llvm.getelementptr %3[%2] : (!llvm.ptr, i32) -> !llvm.ptr, f32
    llvm.br ^bb1(%7, %6 : !llvm.ptr, i32)
  ^bb3:  // pred: ^bb1
    llvm.store %0, %3 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @multiple_phis(%arg0: f32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.mlir.addressof @global : !llvm.ptr
    llvm.br ^bb1(%0 : i32)
  ^bb1(%4: i32):  // 2 preds: ^bb0, ^bb4
    %5 = llvm.bitcast %4 : i32 to f32
    %6 = llvm.fcmp "ogt" %5, %arg0 : f32
    llvm.cond_br %6, ^bb5, ^bb2
  ^bb2:  // pred: ^bb1
    %7 = llvm.fcmp "ogt" %5, %1 : f32
    llvm.cond_br %7, ^bb3, ^bb4(%4 : i32)
  ^bb3:  // pred: ^bb2
    %8 = llvm.fadd %5, %2  : f32
    %9 = llvm.bitcast %8 : f32 to i32
    llvm.br ^bb4(%9 : i32)
  ^bb4(%10: i32):  // 2 preds: ^bb2, ^bb3
    llvm.store volatile %10, %3 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb1(%10 : i32)
  ^bb5:  // pred: ^bb1
    llvm.return %4 : i32
  }
}
