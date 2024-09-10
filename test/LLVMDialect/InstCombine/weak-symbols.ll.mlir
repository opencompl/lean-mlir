module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global weak_odr constant @real_init("y\00") {addr_space = 0 : i32}
  llvm.mlir.global weak constant @fake_init("y\00") {addr_space = 0 : i32}
  llvm.mlir.global private constant @".str"("y\00") {addr_space = 0 : i32, dso_local}
  llvm.func @foo() -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("y\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @fake_init : !llvm.ptr
    %2 = llvm.mlir.addressof @".str" : !llvm.ptr
    %3 = llvm.call @strcmp(%1, %2) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %3 : i32
  }
  llvm.func @bar() -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("y\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @real_init : !llvm.ptr
    %2 = llvm.mlir.addressof @".str" : !llvm.ptr
    %3 = llvm.call @strcmp(%1, %2) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return %3 : i32
  }
  llvm.func @strcmp(!llvm.ptr, !llvm.ptr) -> i32 attributes {memory = #llvm.memory_effects<other = read, argMem = read, inaccessibleMem = read>, passthrough = ["nounwind"]}
}
