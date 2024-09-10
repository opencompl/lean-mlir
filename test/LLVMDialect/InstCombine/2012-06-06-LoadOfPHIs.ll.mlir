module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @func(%arg0: f64, %arg1: f64, %arg2: f64, %arg3: !llvm.ptr, %arg4: !llvm.ptr, %arg5: !llvm.ptr) attributes {passthrough = ["nounwind", "ssp", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %3 = llvm.mlir.constant(4.000000e+00 : f64) : f64
    %4 = llvm.mlir.constant(6.000000e+00 : f64) : f64
    %5 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %6 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %7 = llvm.alloca %0 x f64 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %8 = llvm.alloca %0 x f64 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %9 = llvm.alloca %0 x f64 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    llvm.store %arg0, %7 {alignment = 8 : i64} : f64, !llvm.ptr
    llvm.store %arg1, %8 {alignment = 8 : i64} : f64, !llvm.ptr
    llvm.store %arg2, %9 {alignment = 8 : i64} : f64, !llvm.ptr
    %10 = llvm.fcmp "ogt" %arg0, %arg1 : f64
    llvm.cond_br %10, ^bb1, ^bb4
  ^bb1:  // pred: ^bb0
    %11 = llvm.fcmp "ogt" %arg0, %arg2 : f64
    llvm.cond_br %11, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.br ^bb7(%7 : !llvm.ptr)
  ^bb3:  // pred: ^bb1
    llvm.br ^bb7(%9 : !llvm.ptr)
  ^bb4:  // pred: ^bb0
    %12 = llvm.fcmp "ogt" %arg1, %arg2 : f64
    llvm.cond_br %12, ^bb5, ^bb6
  ^bb5:  // pred: ^bb4
    llvm.br ^bb7(%8 : !llvm.ptr)
  ^bb6:  // pred: ^bb4
    llvm.br ^bb7(%9 : !llvm.ptr)
  ^bb7(%13: !llvm.ptr):  // 4 preds: ^bb2, ^bb3, ^bb5, ^bb6
    %14 = llvm.load %7 {alignment = 8 : i64} : !llvm.ptr -> f64
    %15 = llvm.load %8 {alignment = 8 : i64} : !llvm.ptr -> f64
    %16 = llvm.fcmp "olt" %14, %15 : f64
    llvm.cond_br %16, ^bb8, ^bb11
  ^bb8:  // pred: ^bb7
    %17 = llvm.load %9 {alignment = 8 : i64} : !llvm.ptr -> f64
    %18 = llvm.fcmp "olt" %14, %17 : f64
    llvm.cond_br %18, ^bb9, ^bb10
  ^bb9:  // pred: ^bb8
    llvm.br ^bb14(%7 : !llvm.ptr)
  ^bb10:  // pred: ^bb8
    llvm.br ^bb14(%9 : !llvm.ptr)
  ^bb11:  // pred: ^bb7
    %19 = llvm.load %9 {alignment = 8 : i64} : !llvm.ptr -> f64
    %20 = llvm.fcmp "olt" %15, %19 : f64
    llvm.cond_br %20, ^bb12, ^bb13
  ^bb12:  // pred: ^bb11
    llvm.br ^bb14(%8 : !llvm.ptr)
  ^bb13:  // pred: ^bb11
    llvm.br ^bb14(%9 : !llvm.ptr)
  ^bb14(%21: !llvm.ptr):  // 4 preds: ^bb9, ^bb10, ^bb12, ^bb13
    %22 = llvm.load %21 {alignment = 8 : i64} : !llvm.ptr -> f64
    %23 = llvm.load %13 {alignment = 8 : i64} : !llvm.ptr -> f64
    %24 = llvm.fadd %22, %23  : f64
    %25 = llvm.fdiv %24, %1  : f64
    llvm.store %25, %arg5 {alignment = 8 : i64} : f64, !llvm.ptr
    %26 = llvm.load %21 {alignment = 8 : i64} : !llvm.ptr -> f64
    %27 = llvm.load %13 {alignment = 8 : i64} : !llvm.ptr -> f64
    %28 = llvm.fcmp "oeq" %26, %27 : f64
    llvm.cond_br %28, ^bb15, ^bb16
  ^bb15:  // pred: ^bb14
    llvm.store %5, %arg4 {alignment = 8 : i64} : f64, !llvm.ptr
    llvm.store %5, %arg3 {alignment = 8 : i64} : f64, !llvm.ptr
    llvm.br ^bb26
  ^bb16:  // pred: ^bb14
    %29 = llvm.fcmp "olt" %25, %2 : f64
    %30 = llvm.fsub %27, %26  : f64
    llvm.cond_br %29, ^bb17, ^bb18
  ^bb17:  // pred: ^bb16
    %31 = llvm.fadd %27, %26  : f64
    %32 = llvm.fdiv %30, %31  : f64
    llvm.store %32, %arg4 {alignment = 8 : i64} : f64, !llvm.ptr
    llvm.br ^bb19
  ^bb18:  // pred: ^bb16
    %33 = llvm.fsub %1, %27  : f64
    %34 = llvm.fsub %33, %26  : f64
    %35 = llvm.fdiv %30, %34  : f64
    llvm.store %35, %arg4 {alignment = 8 : i64} : f64, !llvm.ptr
    llvm.br ^bb19
  ^bb19:  // 2 preds: ^bb17, ^bb18
    %36 = llvm.icmp "eq" %13, %7 : !llvm.ptr
    llvm.cond_br %36, ^bb20, ^bb21
  ^bb20:  // pred: ^bb19
    %37 = llvm.load %8 {alignment = 8 : i64} : !llvm.ptr -> f64
    %38 = llvm.load %9 {alignment = 8 : i64} : !llvm.ptr -> f64
    %39 = llvm.fsub %37, %38  : f64
    %40 = llvm.load %13 {alignment = 8 : i64} : !llvm.ptr -> f64
    %41 = llvm.load %21 {alignment = 8 : i64} : !llvm.ptr -> f64
    %42 = llvm.fsub %40, %41  : f64
    %43 = llvm.fdiv %39, %42  : f64
    llvm.store %43, %arg3 {alignment = 8 : i64} : f64, !llvm.ptr
    llvm.br ^bb24
  ^bb21:  // pred: ^bb19
    %44 = llvm.icmp "eq" %13, %8 : !llvm.ptr
    llvm.cond_br %44, ^bb22, ^bb23
  ^bb22:  // pred: ^bb21
    %45 = llvm.load %9 {alignment = 8 : i64} : !llvm.ptr -> f64
    %46 = llvm.load %7 {alignment = 8 : i64} : !llvm.ptr -> f64
    %47 = llvm.fsub %45, %46  : f64
    %48 = llvm.load %13 {alignment = 8 : i64} : !llvm.ptr -> f64
    %49 = llvm.load %21 {alignment = 8 : i64} : !llvm.ptr -> f64
    %50 = llvm.fsub %48, %49  : f64
    %51 = llvm.fdiv %47, %50  : f64
    %52 = llvm.fadd %1, %51  : f64
    llvm.store %52, %arg3 {alignment = 8 : i64} : f64, !llvm.ptr
    llvm.br ^bb24
  ^bb23:  // pred: ^bb21
    %53 = llvm.load %7 {alignment = 8 : i64} : !llvm.ptr -> f64
    %54 = llvm.load %8 {alignment = 8 : i64} : !llvm.ptr -> f64
    %55 = llvm.fsub %53, %54  : f64
    %56 = llvm.load %13 {alignment = 8 : i64} : !llvm.ptr -> f64
    %57 = llvm.load %21 {alignment = 8 : i64} : !llvm.ptr -> f64
    %58 = llvm.fsub %56, %57  : f64
    %59 = llvm.fdiv %55, %58  : f64
    %60 = llvm.fadd %3, %59  : f64
    llvm.store %60, %arg3 {alignment = 8 : i64} : f64, !llvm.ptr
    llvm.br ^bb24
  ^bb24:  // 3 preds: ^bb20, ^bb22, ^bb23
    %61 = llvm.load %arg3 {alignment = 8 : i64} : !llvm.ptr -> f64
    %62 = llvm.fdiv %61, %4  : f64
    llvm.store %62, %arg3 {alignment = 8 : i64} : f64, !llvm.ptr
    %63 = llvm.fcmp "olt" %62, %5 : f64
    llvm.cond_br %63, ^bb25, ^bb26
  ^bb25:  // pred: ^bb24
    %64 = llvm.fadd %62, %6  : f64
    llvm.store %64, %arg3 {alignment = 8 : i64} : f64, !llvm.ptr
    llvm.br ^bb26
  ^bb26:  // 3 preds: ^bb15, ^bb24, ^bb25
    llvm.return
  }
}
