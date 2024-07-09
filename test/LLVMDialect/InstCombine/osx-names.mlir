module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>>} {
  llvm.mlir.global private unnamed_addr constant @".str"("Hello world\0A\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.mlir.global private unnamed_addr constant @".str2"("%s\00") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.func @test1(%arg0: !llvm.ptr) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant("Hello world\0A\00") : !llvm.array<13 x i8>
    %1 = llvm.mlir.addressof @".str" : !llvm.ptr
    %2 = llvm.call @fprintf(%arg0, %1) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }
  llvm.func @test2(%arg0: !llvm.ptr, %arg1: !llvm.ptr) attributes {passthrough = ["nounwind", "ssp"]} {
    %0 = llvm.mlir.constant("%s\00") : !llvm.array<3 x i8>
    %1 = llvm.mlir.addressof @".str2" : !llvm.ptr
    %2 = llvm.call @fprintf(%arg0, %1, %arg1) vararg(!llvm.func<i32 (ptr, ptr, ...)>) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> i32
    llvm.return
  }
  llvm.func @fprintf(!llvm.ptr, !llvm.ptr, ...) -> i32 attributes {passthrough = ["nounwind"]}
}
