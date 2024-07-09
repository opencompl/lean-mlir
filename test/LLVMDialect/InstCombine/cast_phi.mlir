module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @MainKernel(%arg0: i32, %arg1: i32, %arg2: i32) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(256 : i64) : i64
    %4 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %5 = llvm.mlir.constant(-4 : i32) : i32
    %6 = llvm.alloca %0 x !llvm.array<258 x f32> {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %7 = llvm.alloca %0 x !llvm.array<258 x f32> {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %8 = llvm.uitofp %arg0 : i32 to f32
    %9 = llvm.bitcast %8 : f32 to i32
    %10 = llvm.zext %arg1 : i32 to i64
    %11 = llvm.getelementptr inbounds %6[%1, %10] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<258 x f32>
    llvm.store %9, %11 {alignment = 4 : i64} : i32, !llvm.ptr
    %12 = llvm.getelementptr inbounds %7[%1, %10] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<258 x f32>
    llvm.store %9, %12 {alignment = 4 : i64} : i32, !llvm.ptr
    %13 = llvm.icmp "eq" %arg1, %2 : i32
    llvm.cond_br %13, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %14 = llvm.getelementptr inbounds %6[%1, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<258 x f32>
    llvm.store %8, %14 {alignment = 4 : i64} : f32, !llvm.ptr
    %15 = llvm.getelementptr inbounds %7[%1, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<258 x f32>
    llvm.store %4, %15 {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %16 = llvm.icmp "sgt" %arg0, %2 : i32
    llvm.cond_br %16, ^bb3(%9, %9, %arg0 : i32, i32, i32), ^bb8
  ^bb3(%17: i32, %18: i32, %19: i32):  // 2 preds: ^bb2, ^bb12
    %20 = llvm.icmp "ugt" %19, %arg2 : i32
    %21 = llvm.add %19, %0  : i32
    %22 = llvm.sext %21 : i32 to i64
    %23 = llvm.getelementptr inbounds %6[%1, %22] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<258 x f32>
    %24 = llvm.getelementptr inbounds %7[%1, %22] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<258 x f32>
    %25 = llvm.icmp "ult" %19, %arg2 : i32
    llvm.cond_br %20, ^bb4, ^bb5(%17, %18 : i32, i32)
  ^bb4:  // pred: ^bb3
    %26 = llvm.load %23 {alignment = 4 : i64} : !llvm.ptr -> i32
    %27 = llvm.load %24 {alignment = 4 : i64} : !llvm.ptr -> i32
    %28 = llvm.bitcast %27 : i32 to f32
    %29 = llvm.bitcast %26 : i32 to f32
    %30 = llvm.fadd %28, %29  : f32
    %31 = llvm.bitcast %17 : i32 to f32
    %32 = llvm.fadd %30, %31  : f32
    %33 = llvm.bitcast %32 : f32 to i32
    %34 = llvm.bitcast %18 : i32 to f32
    %35 = llvm.fadd %32, %34  : f32
    %36 = llvm.bitcast %35 : f32 to i32
    llvm.br ^bb5(%33, %36 : i32, i32)
  ^bb5(%37: i32, %38: i32):  // 2 preds: ^bb3, ^bb4
    llvm.cond_br %25, ^bb6, ^bb7
  ^bb6:  // pred: ^bb5
    llvm.store %38, %11 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %37, %12 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb7
  ^bb7:  // 2 preds: ^bb5, ^bb6
    llvm.cond_br %20, ^bb9, ^bb10(%37, %38 : i32, i32)
  ^bb8:  // 2 preds: ^bb2, ^bb12
    llvm.return
  ^bb9:  // pred: ^bb7
    %39 = llvm.load %23 {alignment = 4 : i64} : !llvm.ptr -> i32
    %40 = llvm.load %24 {alignment = 4 : i64} : !llvm.ptr -> i32
    %41 = llvm.bitcast %40 : i32 to f32
    %42 = llvm.bitcast %39 : i32 to f32
    %43 = llvm.fadd %41, %42  : f32
    %44 = llvm.bitcast %37 : i32 to f32
    %45 = llvm.fadd %43, %44  : f32
    %46 = llvm.bitcast %45 : f32 to i32
    %47 = llvm.bitcast %38 : i32 to f32
    %48 = llvm.fadd %45, %47  : f32
    %49 = llvm.bitcast %48 : f32 to i32
    llvm.br ^bb10(%46, %49 : i32, i32)
  ^bb10(%50: i32, %51: i32):  // 2 preds: ^bb7, ^bb9
    llvm.cond_br %25, ^bb11, ^bb12
  ^bb11:  // pred: ^bb10
    llvm.store %51, %11 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %50, %12 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb12
  ^bb12:  // 2 preds: ^bb10, ^bb11
    %52 = llvm.add %19, %5  : i32
    %53 = llvm.icmp "sgt" %52, %2 : i32
    llvm.cond_br %53, ^bb3(%50, %51, %52 : i32, i32, i32), ^bb8
  }
  llvm.func @get_i32() -> i32
  llvm.func @get_i3() -> i3
  llvm.func @bar()
  llvm.func @zext_from_legal_to_illegal_type(%arg0: i32) -> i37 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.call @get_i32() : () -> i32
    llvm.br ^bb3(%3 : i32)
  ^bb2:  // pred: ^bb0
    llvm.call @bar() : () -> ()
    llvm.br ^bb3(%1 : i32)
  ^bb3(%4: i32):  // 2 preds: ^bb1, ^bb2
    %5 = llvm.zext %4 : i32 to i37
    llvm.return %5 : i37
  }
  llvm.func @zext_from_illegal_to_illegal_type(%arg0: i32) -> i37 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(3 : i3) : i3
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.call @get_i3() : () -> i3
    llvm.br ^bb3(%3 : i3)
  ^bb2:  // pred: ^bb0
    llvm.call @bar() : () -> ()
    llvm.br ^bb3(%1 : i3)
  ^bb3(%4: i3):  // 2 preds: ^bb1, ^bb2
    %5 = llvm.zext %4 : i3 to i37
    llvm.return %5 : i37
  }
  llvm.func @zext_from_legal_to_legal_type(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.call @get_i32() : () -> i32
    llvm.br ^bb3(%3 : i32)
  ^bb2:  // pred: ^bb0
    llvm.call @bar() : () -> ()
    llvm.br ^bb3(%1 : i32)
  ^bb3(%4: i32):  // 2 preds: ^bb1, ^bb2
    %5 = llvm.zext %4 : i32 to i64
    llvm.return %5 : i64
  }
  llvm.func @zext_from_illegal_to_legal_type(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(3 : i3) : i3
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.call @get_i3() : () -> i3
    llvm.br ^bb3(%3 : i3)
  ^bb2:  // pred: ^bb0
    llvm.call @bar() : () -> ()
    llvm.br ^bb3(%1 : i3)
  ^bb3(%4: i3):  // 2 preds: ^bb1, ^bb2
    %5 = llvm.zext %4 : i3 to i64
    llvm.return %5 : i64
  }
  llvm.func @trunc_in_loop_exit_block() -> i8 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(100 : i32) : i32
    llvm.br ^bb1(%0, %1 : i32, i32)
  ^bb1(%3: i32, %4: i32):  // 2 preds: ^bb0, ^bb2
    %5 = llvm.icmp "ult" %3, %2 : i32
    llvm.cond_br %5, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %6 = llvm.add %3, %1  : i32
    llvm.br ^bb1(%6, %6 : i32, i32)
  ^bb3:  // pred: ^bb1
    %7 = llvm.trunc %4 : i32 to i8
    llvm.return %7 : i8
  }
  llvm.func @zext_in_loop_and_exit_block(%arg0: i8, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.br ^bb1(%0 : i8)
  ^bb1(%1: i8):  // 2 preds: ^bb0, ^bb2
    %2 = llvm.zext %1 : i8 to i32
    %3 = llvm.icmp "ne" %2, %arg1 : i32
    llvm.cond_br %3, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    %4 = llvm.zext %arg0 : i8 to i32
    %5 = llvm.add %2, %4  : i32
    %6 = llvm.trunc %5 : i32 to i8
    llvm.br ^bb1(%6 : i8)
  ^bb3:  // pred: ^bb1
    %7 = llvm.zext %1 : i8 to i32
    llvm.return %7 : i32
  }
}
