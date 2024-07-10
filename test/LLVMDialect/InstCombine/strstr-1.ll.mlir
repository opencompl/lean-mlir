module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>>} {
  llvm.mlir.global private constant @".str"(dense<0> : tensor<1xi8>) {addr_space = 0 : i32, dso_local} : !llvm.array<1 x i8>
  llvm.mlir.global private constant @".str1"("a\00") {addr_space = 0 : i32, dso_local}
  llvm.mlir.global private constant @".str2"("abcde\00") {addr_space = 0 : i32, dso_local}
  llvm.mlir.global private constant @".str3"("bcd\00") {addr_space = 0 : i32, dso_local}
  llvm.func @strstr(!llvm.ptr, !llvm.ptr) -> !llvm.ptr
  llvm.func @test_simplify1(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @".str" : !llvm.ptr
    %3 = llvm.call @strstr(%arg0, %2) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @test_simplify2(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant("a\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @".str1" : !llvm.ptr
    %2 = llvm.call @strstr(%arg0, %1) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %2 : !llvm.ptr
  }
  llvm.func @test_simplify3() -> !llvm.ptr {
    %0 = llvm.mlir.constant("abcde\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @".str2" : !llvm.ptr
    %2 = llvm.mlir.constant("bcd\00") : !llvm.array<4 x i8>
    %3 = llvm.mlir.addressof @".str3" : !llvm.ptr
    %4 = llvm.call @strstr(%1, %3) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %4 : !llvm.ptr
  }
  llvm.func @test_simplify4(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.call @strstr(%arg0, %arg0) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @test_simplify5(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.call @strstr(%arg0, %arg1) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    %1 = llvm.icmp "eq" %0, %arg0 : !llvm.ptr
    llvm.return %1 : i1
  }
  llvm.func @test1(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.call @strstr(%arg0, %arg1) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @test2(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> !llvm.ptr attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.call @strstr(%arg0, %arg1) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
}
