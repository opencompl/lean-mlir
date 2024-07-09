module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>>} {
  llvm.mlir.global external constant @hello(dense<[104, 101, 108, 108, 111, 0]> : tensor<6xi16>) {addr_space = 0 : i32} : !llvm.array<6 x i16>
  llvm.mlir.global external constant @longer(dense<[108, 111, 110, 103, 101, 114, 0]> : tensor<7xi16>) {addr_space = 0 : i32} : !llvm.array<7 x i16>
  llvm.mlir.global external constant @null(dense<0> : tensor<1xi16>) {addr_space = 0 : i32} : !llvm.array<1 x i16>
  llvm.mlir.global external constant @null_hello(dense<[0, 104, 101, 108, 108, 111, 0]> : tensor<7xi16>) {addr_space = 0 : i32} : !llvm.array<7 x i16>
  llvm.mlir.global external constant @nullstring(0 : i16) {addr_space = 0 : i32} : i16
  llvm.mlir.global common @a(dense<0> : tensor<32xi16>) {addr_space = 0 : i32, alignment = 1 : i64} : !llvm.array<32 x i16>
  llvm.mlir.global external constant @null_hello_mid(dense<[104, 101, 108, 108, 111, 32, 119, 111, 114, 0, 108, 100, 0]> : tensor<13xi16>) {addr_space = 0 : i32} : !llvm.array<13 x i16>
  llvm.mlir.global external constant @str32(dense<0> : tensor<1xi32>) {addr_space = 0 : i32} : !llvm.array<1 x i32>
  llvm.func @wcslen(!llvm.ptr) -> i64
  llvm.func @test_simplify1() -> i64 {
    %0 = llvm.mlir.constant(dense<[104, 101, 108, 108, 111, 0]> : tensor<6xi16>) : !llvm.array<6 x i16>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.call @wcslen(%1) : (!llvm.ptr) -> i64
    llvm.return %2 : i64
  }
  llvm.func @test_simplify2() -> i64 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi16>) : !llvm.array<1 x i16>
    %2 = llvm.mlir.addressof @null : !llvm.ptr
    %3 = llvm.call @wcslen(%2) : (!llvm.ptr) -> i64
    llvm.return %3 : i64
  }
  llvm.func @test_simplify3() -> i64 {
    %0 = llvm.mlir.constant(dense<[0, 104, 101, 108, 108, 111, 0]> : tensor<7xi16>) : !llvm.array<7 x i16>
    %1 = llvm.mlir.addressof @null_hello : !llvm.ptr
    %2 = llvm.call @wcslen(%1) : (!llvm.ptr) -> i64
    llvm.return %2 : i64
  }
  llvm.func @test_simplify4() -> i64 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.addressof @nullstring : !llvm.ptr
    %2 = llvm.call @wcslen(%1) : (!llvm.ptr) -> i64
    llvm.return %2 : i64
  }
  llvm.func @test_simplify5() -> i1 {
    %0 = llvm.mlir.constant(dense<[104, 101, 108, 108, 111, 0]> : tensor<6xi16>) : !llvm.array<6 x i16>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.call @wcslen(%1) : (!llvm.ptr) -> i64
    %4 = llvm.icmp "eq" %3, %2 : i64
    llvm.return %4 : i1
  }
  llvm.func @test_simplify6(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @wcslen(%arg0) : (!llvm.ptr) -> i64
    %2 = llvm.icmp "eq" %1, %0 : i64
    llvm.return %2 : i1
  }
  llvm.func @test_simplify7() -> i1 {
    %0 = llvm.mlir.constant(dense<[104, 101, 108, 108, 111, 0]> : tensor<6xi16>) : !llvm.array<6 x i16>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.call @wcslen(%1) : (!llvm.ptr) -> i64
    %4 = llvm.icmp "ne" %3, %2 : i64
    llvm.return %4 : i1
  }
  llvm.func @test_simplify8(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.call @wcslen(%arg0) : (!llvm.ptr) -> i64
    %2 = llvm.icmp "ne" %1, %0 : i64
    llvm.return %2 : i1
  }
  llvm.func @test_simplify9(%arg0: i1) -> i64 {
    %0 = llvm.mlir.constant(dense<[104, 101, 108, 108, 111, 0]> : tensor<6xi16>) : !llvm.array<6 x i16>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(dense<[108, 111, 110, 103, 101, 114, 0]> : tensor<7xi16>) : !llvm.array<7 x i16>
    %3 = llvm.mlir.addressof @longer : !llvm.ptr
    %4 = llvm.select %arg0, %1, %3 : i1, !llvm.ptr
    %5 = llvm.call @wcslen(%4) : (!llvm.ptr) -> i64
    llvm.return %5 : i64
  }
  llvm.func @test_simplify10(%arg0: i16) -> i64 {
    %0 = llvm.mlir.constant(dense<[104, 101, 108, 108, 111, 0]> : tensor<6xi16>) : !llvm.array<6 x i16>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i16, i16) -> !llvm.ptr, !llvm.array<6 x i16>
    %4 = llvm.call @wcslen(%3) : (!llvm.ptr) -> i64
    llvm.return %4 : i64
  }
  llvm.func @test_simplify11(%arg0: i16) -> i64 {
    %0 = llvm.mlir.constant(7 : i16) : i16
    %1 = llvm.mlir.constant(dense<[104, 101, 108, 108, 111, 32, 119, 111, 114, 0, 108, 100, 0]> : tensor<13xi16>) : !llvm.array<13 x i16>
    %2 = llvm.mlir.addressof @null_hello_mid : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.and %arg0, %0  : i16
    %5 = llvm.getelementptr inbounds %2[%3, %4] : (!llvm.ptr, i16, i16) -> !llvm.ptr, !llvm.array<13 x i16>
    %6 = llvm.call @wcslen(%5) : (!llvm.ptr) -> i64
    llvm.return %6 : i64
  }
  llvm.func @test_no_simplify1() -> i64 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(dense<0> : tensor<32xi16>) : !llvm.array<32 x i16>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.call @wcslen(%2) : (!llvm.ptr) -> i64
    llvm.return %3 : i64
  }
  llvm.func @test_no_simplify2(%arg0: i16) -> i64 {
    %0 = llvm.mlir.constant(dense<[0, 104, 101, 108, 108, 111, 0]> : tensor<7xi16>) : !llvm.array<7 x i16>
    %1 = llvm.mlir.addressof @null_hello : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i16, i16) -> !llvm.ptr, !llvm.array<7 x i16>
    %4 = llvm.call @wcslen(%3) : (!llvm.ptr) -> i64
    llvm.return %4 : i64
  }
  llvm.func @test_no_simplify3(%arg0: i16) -> i64 {
    %0 = llvm.mlir.constant(15 : i16) : i16
    %1 = llvm.mlir.constant(dense<[104, 101, 108, 108, 111, 32, 119, 111, 114, 0, 108, 100, 0]> : tensor<13xi16>) : !llvm.array<13 x i16>
    %2 = llvm.mlir.addressof @null_hello_mid : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.and %arg0, %0  : i16
    %5 = llvm.getelementptr inbounds %2[%3, %4] : (!llvm.ptr, i16, i16) -> !llvm.ptr, !llvm.array<13 x i16>
    %6 = llvm.call @wcslen(%5) : (!llvm.ptr) -> i64
    llvm.return %6 : i64
  }
  llvm.func @test_no_simplify4() -> i64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi32>) : !llvm.array<1 x i32>
    %2 = llvm.mlir.addressof @str32 : !llvm.ptr
    %3 = llvm.call @wcslen(%2) : (!llvm.ptr) -> i64
    llvm.return %3 : i64
  }
}
