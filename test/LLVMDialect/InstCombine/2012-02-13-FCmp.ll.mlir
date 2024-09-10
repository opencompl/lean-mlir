module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global private unnamed_addr constant @".str"("\0Ain_range input (should be 0): %f\0A\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.mlir.global external hidden unnamed_addr constant @".str1"() {addr_space = 0 : i32, alignment = 1 : i64, dso_local} : !llvm.array<35 x i8>
  llvm.func @printf(!llvm.ptr, ...) -> i32
  llvm.func @_Z8tempCastj(%arg0: i32) -> i64 attributes {passthrough = ["ssp", ["uwtable", "2"]]} {
    %0 = llvm.mlir.addressof @".str1" : !llvm.ptr
    %1 = llvm.mlir.constant("\0Ain_range input (should be 0): %f\0A\00") : !llvm.array<35 x i8>
    %2 = llvm.mlir.addressof @".str" : !llvm.ptr
    %3 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %4 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %5 = llvm.mlir.constant(-1 : i64) : i64
    %6 = llvm.mlir.constant(5.000000e-01 : f64) : f64
    %7 = llvm.call @printf(%0, %arg0) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, i32) -> i32
    %8 = llvm.uitofp %arg0 : i32 to f64
    %9 = llvm.call @printf(%2, %8) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    %10 = llvm.fcmp "oge" %8, %3 : f64
    llvm.cond_br %10, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %11 = llvm.fcmp "olt" %8, %4 : f64
    llvm.cond_br %11, ^bb2, ^bb4
  ^bb2:  // pred: ^bb1
    %12 = llvm.fadd %8, %6  : f64
    %13 = llvm.fptosi %12 : f64 to i64
    llvm.br ^bb5(%13 : i64)
  ^bb3:  // pred: ^bb0
    llvm.br ^bb4
  ^bb4:  // 2 preds: ^bb1, ^bb3
    llvm.br ^bb5(%5 : i64)
  ^bb5(%14: i64):  // 2 preds: ^bb2, ^bb4
    llvm.return %14 : i64
  }
}
