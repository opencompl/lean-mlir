module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @a() -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.mlir.constant(1 : i8) : i8
    %5 = llvm.bitcast %0 : i32 to i32
    %6 = llvm.call @malloc(%1) : (i32) -> !llvm.ptr
    %7 = llvm.getelementptr %6[%2] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    llvm.store %3, %7 {alignment = 1 : i64} : i8, !llvm.ptr
    %8 = llvm.getelementptr %6[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    llvm.store %4, %8 {alignment = 1 : i64} : i8, !llvm.ptr
    %9 = llvm.call @strlen(%6) : (!llvm.ptr) -> i32
    %10 = llvm.getelementptr %6[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    llvm.store %3, %10 {alignment = 1 : i64} : i8, !llvm.ptr
    %11 = llvm.call @b(%6) vararg(!llvm.func<i32 (...)>) : (!llvm.ptr) -> i32
    llvm.return %9 : i32
  }
  llvm.func @malloc(i32) -> !llvm.ptr attributes {passthrough = ["nounwind"]}
  llvm.func @strlen(!llvm.ptr) -> i32 attributes {memory = #llvm.memory_effects<other = read, argMem = read, inaccessibleMem = read>, passthrough = ["nounwind"]}
  llvm.func @b(...) -> i32
}
