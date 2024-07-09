module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @hello("hello\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @longer("longer\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @null(dense<0> : tensor<1xi8>) {addr_space = 0 : i32} : !llvm.array<1 x i8>
  llvm.mlir.global external constant @null_hello("\00hello\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @nullstring(0 : i8) {addr_space = 0 : i32} : i8
  llvm.mlir.global common @a(dense<0> : tensor<32xi8>) {addr_space = 0 : i32, alignment = 1 : i64} : !llvm.array<32 x i8>
  llvm.mlir.global external constant @null_hello_mid("hello wor\00ld\00") {addr_space = 0 : i32}
  llvm.func @strlen(!llvm.ptr) -> i32
  llvm.func @test_simplify1() -> i32 {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.call @strlen(%1) : (!llvm.ptr) -> i32
    llvm.return %2 : i32
  }
  llvm.func @test_simplify2() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %2 = llvm.mlir.addressof @null : !llvm.ptr
    %3 = llvm.call @strlen(%2) : (!llvm.ptr) -> i32
    llvm.return %3 : i32
  }
  llvm.func @test_simplify3() -> i32 {
    %0 = llvm.mlir.constant("\00hello\00") : !llvm.array<7 x i8>
    %1 = llvm.mlir.addressof @null_hello : !llvm.ptr
    %2 = llvm.call @strlen(%1) : (!llvm.ptr) -> i32
    llvm.return %2 : i32
  }
  llvm.func @test_simplify4() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.addressof @nullstring : !llvm.ptr
    %2 = llvm.call @strlen(%1) : (!llvm.ptr) -> i32
    llvm.return %2 : i32
  }
  llvm.func @test_simplify5() -> i1 {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strlen(%1) : (!llvm.ptr) -> i32
    %4 = llvm.icmp "eq" %3, %2 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_simplify6(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @strlen(%arg0) : (!llvm.ptr) -> i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @test_simplify7() -> i1 {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.call @strlen(%1) : (!llvm.ptr) -> i32
    %4 = llvm.icmp "ne" %3, %2 : i32
    llvm.return %4 : i1
  }
  llvm.func @test_simplify8(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @strlen(%arg0) : (!llvm.ptr) -> i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }
  llvm.func @test_simplify9(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant("longer\00") : !llvm.array<7 x i8>
    %3 = llvm.mlir.addressof @longer : !llvm.ptr
    %4 = llvm.select %arg0, %1, %3 : i1, !llvm.ptr
    %5 = llvm.call @strlen(%4) : (!llvm.ptr) -> i32
    llvm.return %5 : i32
  }
  llvm.func @test_simplify10_inbounds(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<6 x i8>
    %4 = llvm.call @strlen(%3) : (!llvm.ptr) -> i32
    llvm.return %4 : i32
  }
  llvm.func @test_simplify10_no_inbounds(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.getelementptr %1[%2, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<6 x i8>
    %4 = llvm.call @strlen(%3) : (!llvm.ptr) -> i32
    llvm.return %4 : i32
  }
  llvm.func @test_simplify11(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant("hello wor\00ld\00") : !llvm.array<13 x i8>
    %2 = llvm.mlir.addressof @null_hello_mid : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.getelementptr inbounds %2[%3, %4] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<13 x i8>
    %6 = llvm.call @strlen(%5) : (!llvm.ptr) -> i32
    llvm.return %6 : i32
  }
  llvm.func @test_no_simplify1() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.call @strlen(%2) : (!llvm.ptr) -> i32
    llvm.return %3 : i32
  }
  llvm.func @test_no_simplify2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant("\00hello\00") : !llvm.array<7 x i8>
    %1 = llvm.mlir.addressof @null_hello : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<7 x i8>
    %4 = llvm.call @strlen(%3) : (!llvm.ptr) -> i32
    llvm.return %4 : i32
  }
  llvm.func @test_no_simplify2_no_null_opt(%arg0: i32) -> i32 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.constant("\00hello\00") : !llvm.array<7 x i8>
    %1 = llvm.mlir.addressof @null_hello : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<7 x i8>
    %4 = llvm.call @strlen(%3) : (!llvm.ptr) -> i32
    llvm.return %4 : i32
  }
  llvm.func @test_no_simplify3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant("hello wor\00ld\00") : !llvm.array<13 x i8>
    %2 = llvm.mlir.addressof @null_hello_mid : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.getelementptr inbounds %2[%3, %4] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<13 x i8>
    %6 = llvm.call @strlen(%5) : (!llvm.ptr) -> i32
    llvm.return %6 : i32
  }
  llvm.func @test_no_simplify3_on_null_opt(%arg0: i32) -> i32 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant("hello wor\00ld\00") : !llvm.array<13 x i8>
    %2 = llvm.mlir.addressof @null_hello_mid : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.getelementptr inbounds %2[%3, %4] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<13 x i8>
    %6 = llvm.call @strlen(%5) : (!llvm.ptr) -> i32
    llvm.return %6 : i32
  }
  llvm.func @test1(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.call @strlen(%arg0) : (!llvm.ptr) -> i32
    llvm.return %0 : i32
  }
  llvm.func @test2(%arg0: !llvm.ptr) -> i32 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.call @strlen(%arg0) : (!llvm.ptr) -> i32
    llvm.return %0 : i32
  }
  llvm.func @strlen0_after_write_to_first_byte_global() -> i1 {
    %0 = llvm.mlir.constant(49 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %3 = llvm.mlir.addressof @a : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %0, %3 {alignment = 16 : i64} : i8, !llvm.ptr
    %5 = llvm.call @strlen(%3) : (!llvm.ptr) -> i32
    %6 = llvm.icmp "eq" %5, %4 : i32
    llvm.return %6 : i1
  }
  llvm.func @strlen0_after_write_to_second_byte_global() -> i1 {
    %0 = llvm.mlir.constant(49 : i8) : i8
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(0 : i8) : i8
    %4 = llvm.mlir.constant(dense<0> : tensor<32xi8>) : !llvm.array<32 x i8>
    %5 = llvm.mlir.addressof @a : !llvm.ptr
    %6 = llvm.getelementptr inbounds %5[%2, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<32 x i8>
    %7 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %0, %6 {alignment = 16 : i64} : i8, !llvm.ptr
    %8 = llvm.call @strlen(%5) : (!llvm.ptr) -> i32
    %9 = llvm.icmp "eq" %8, %7 : i32
    llvm.return %9 : i1
  }
  llvm.func @strlen0_after_write_to_first_byte(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(49 : i8) : i8
    %1 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr
    %2 = llvm.call @strlen(%arg0) : (!llvm.ptr) -> i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }
  llvm.func @strlen0_after_write_to_second_byte(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(49 : i8) : i8
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.getelementptr %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.store %1, %3 {alignment = 1 : i64} : i8, !llvm.ptr
    %4 = llvm.call @strlen(%arg0) : (!llvm.ptr) -> i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    llvm.return %5 : i1
  }
}
