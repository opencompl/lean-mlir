module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<!llvm.ptr<271>, dense<32> : vector<4xi64>>, #dlti.dl_entry<!llvm.ptr<270>, dense<32> : vector<4xi64>>, #dlti.dl_entry<!llvm.ptr<272>, dense<64> : vector<4xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f80, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>>} {
  llvm.mlir.global common @a(dense<0> : tensor<60xi8>) {addr_space = 0 : i32, alignment = 1 : i64} : !llvm.array<60 x i8>
  llvm.mlir.global common @b(dense<0> : tensor<60xi8>) {addr_space = 0 : i32, alignment = 1 : i64} : !llvm.array<60 x i8>
  llvm.mlir.global external constant @h("h\00") {addr_space = 0 : i32}
  llvm.func @foo() -> !llvm.ptr
  llvm.func @memcmp(!llvm.ptr {llvm.inreg, llvm.nocapture, llvm.noundef}, !llvm.ptr {llvm.inreg, llvm.nocapture, llvm.noundef}, i32 {llvm.inreg, llvm.noundef}) -> i32
  llvm.func @printf(!llvm.ptr, ...) -> i32
  llvm.func @exp2(f64) -> f64
  llvm.func @__sprintf_chk(!llvm.ptr, i32, i32, !llvm.ptr, ...) -> i32
  llvm.func @baz(%arg0: !llvm.ptr {llvm.inreg, llvm.noundef}, %arg1: i32 {llvm.inreg, llvm.noundef}) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @foo() : () -> !llvm.ptr
    %2 = llvm.call @memcmp(%1, %arg0, %arg1) : (!llvm.ptr, !llvm.ptr, i32) -> i32
    %3 = llvm.icmp "eq" %2, %0 : i32
    %4 = llvm.zext %3 : i1 to i32
    llvm.return %4 : i32
  }
  llvm.func @test_fewer_params_than_num_register_parameters() {
    %0 = llvm.mlir.constant("h\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @h : !llvm.ptr
    %2 = llvm.call @printf(%1) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr) -> i32
    llvm.return
  }
  llvm.func @test_non_int_params(%arg0: i16 {llvm.signext}) -> f64 {
    %0 = llvm.sitofp %arg0 : i16 to f64
    %1 = llvm.call @exp2(%0) : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @test_variadic() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<60xi8>) : !llvm.array<60 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(-1 : i32) : i32
    %5 = llvm.mlir.addressof @b : !llvm.ptr
    %6 = llvm.call @__sprintf_chk(%2, %3, %4, %5) vararg(!llvm.func<i32 (ptr, i32, i32, ptr, ...)>) : (!llvm.ptr, i32, i32, !llvm.ptr) -> i32
    llvm.return %6 : i32
  }
}
