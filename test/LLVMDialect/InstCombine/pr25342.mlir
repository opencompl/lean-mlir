module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @dd() {addr_space = 0 : i32, alignment = 4 : i64} : !llvm.struct<"struct.std::complex", (struct<(f32, f32)>)>
  llvm.mlir.global external @dd2() {addr_space = 0 : i32, alignment = 4 : i64} : !llvm.struct<"struct.std::complex", (struct<(f32, f32)>)>
  llvm.func @_Z3fooi(%arg0: i32 {llvm.signext}) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @dd : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.getelementptr inbounds %1[%3, 0, 1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct.std::complex", (struct<(f32, f32)>)>
    %5 = llvm.mlir.addressof @dd2 : !llvm.ptr
    %6 = llvm.getelementptr inbounds %5[%3, 0, 1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct.std::complex", (struct<(f32, f32)>)>
    llvm.br ^bb1(%0, %0, %0 : i32, i32, i32)
  ^bb1(%7: i32, %8: i32, %9: i32):  // 2 preds: ^bb0, ^bb2
    %10 = llvm.icmp "slt" %9, %arg0 : i32
    llvm.cond_br %10, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %11 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> f32
    %12 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> f32
    %13 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> f32
    %14 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32
    %15 = llvm.fmul %11, %13  : f32
    %16 = llvm.fmul %12, %14  : f32
    %17 = llvm.fsub %15, %16  : f32
    %18 = llvm.fmul %12, %13  : f32
    %19 = llvm.fmul %11, %14  : f32
    %20 = llvm.fadd %18, %19  : f32
    %21 = llvm.bitcast %7 : i32 to f32
    %22 = llvm.fadd %17, %21  : f32
    %23 = llvm.bitcast %22 : f32 to i32
    %24 = llvm.bitcast %8 : i32 to f32
    %25 = llvm.fadd %20, %24  : f32
    %26 = llvm.bitcast %25 : f32 to i32
    %27 = llvm.add %9, %2 overflow<nsw>  : i32
    llvm.br ^bb1(%23, %26, %27 : i32, i32, i32)
  ^bb3:  // pred: ^bb1
    llvm.store %7, %1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %8, %4 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @multi_phi(%arg0: i32 {llvm.signext}) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @dd : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.getelementptr inbounds %1[%3, 0, 1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct.std::complex", (struct<(f32, f32)>)>
    %5 = llvm.mlir.addressof @dd2 : !llvm.ptr
    %6 = llvm.getelementptr inbounds %5[%3, 0, 1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct.std::complex", (struct<(f32, f32)>)>
    llvm.br ^bb1(%0, %0 : i32, i32)
  ^bb1(%7: i32, %8: i32):  // 2 preds: ^bb0, ^bb4
    %9 = llvm.icmp "slt" %8, %arg0 : i32
    llvm.cond_br %9, ^bb2, ^bb5
  ^bb2:  // pred: ^bb1
    %10 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> f32
    %11 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> f32
    %12 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> f32
    %13 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32
    %14 = llvm.fmul %10, %12  : f32
    %15 = llvm.fmul %11, %13  : f32
    %16 = llvm.fsub %14, %15  : f32
    %17 = llvm.bitcast %7 : i32 to f32
    %18 = llvm.fadd %16, %17  : f32
    %19 = llvm.bitcast %18 : f32 to i32
    %20 = llvm.add %8, %2 overflow<nsw>  : i32
    %21 = llvm.and %20, %2  : i32
    %22 = llvm.icmp "slt" %21, %2 : i32
    llvm.cond_br %22, ^bb3, ^bb4(%19 : i32)
  ^bb3:  // pred: ^bb2
    %23 = llvm.bitcast %19 : i32 to f32
    %24 = llvm.fadd %16, %23  : f32
    %25 = llvm.bitcast %24 : f32 to i32
    llvm.br ^bb4(%25 : i32)
  ^bb4(%26: i32):  // 2 preds: ^bb2, ^bb3
    llvm.br ^bb1(%26, %20 : i32, i32)
  ^bb5:  // pred: ^bb1
    llvm.store %7, %1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
}
