module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>>} {
  llvm.mlir.global external constant @hello(dense<[104, 101, 108, 108, 111, 0]> : tensor<6xi32>) {addr_space = 0 : i32} : !llvm.array<6 x i32>
  llvm.mlir.global external constant @longer(dense<[108, 111, 110, 103, 101, 114, 0]> : tensor<7xi32>) {addr_space = 0 : i32} : !llvm.array<7 x i32>
  llvm.mlir.global external constant @null(dense<0> : tensor<1xi32>) {addr_space = 0 : i32} : !llvm.array<1 x i32>
  llvm.mlir.global external constant @null_hello(dense<[0, 104, 101, 108, 108, 111, 0]> : tensor<7xi32>) {addr_space = 0 : i32} : !llvm.array<7 x i32>
  llvm.mlir.global external constant @nullstring(0 : i32) {addr_space = 0 : i32} : i32
  llvm.mlir.global common @a(dense<0> : tensor<32xi32>) {addr_space = 0 : i32, alignment = 1 : i64} : !llvm.array<32 x i32>
  llvm.mlir.global external constant @null_hello_mid(dense<[104, 101, 108, 108, 111, 32, 119, 111, 114, 0, 108, 100, 0]> : tensor<13xi32>) {addr_space = 0 : i32} : !llvm.array<13 x i32>
  llvm.mlir.global external constant @str16(dense<0> : tensor<1xi16>) {addr_space = 0 : i32} : !llvm.array<1 x i16>
  llvm.mlir.global external constant @ws(dense<[9, 8, 7, 6, 5, 4, 3, 2, 1, 0]> : tensor<10xi32>) {addr_space = 0 : i32} : !llvm.array<10 x i32>
  llvm.mlir.global external constant @s8("\09\08\07\06\05\04\03\02\01\00") {addr_space = 0 : i32}
  llvm.func @wcslen(!llvm.ptr) -> i64
  llvm.func @test_simplify1() -> i64 {
    %0 = llvm.mlir.constant(dense<[104, 101, 108, 108, 111, 0]> : tensor<6xi32>) : !llvm.array<6 x i32>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.call @wcslen(%1) : (!llvm.ptr) -> i64
    llvm.return %2 : i64
  }
  llvm.func @test_simplify2() -> i64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi32>) : !llvm.array<1 x i32>
    %2 = llvm.mlir.addressof @null : !llvm.ptr
    %3 = llvm.call @wcslen(%2) : (!llvm.ptr) -> i64
    llvm.return %3 : i64
  }
  llvm.func @test_simplify3() -> i64 {
    %0 = llvm.mlir.constant(dense<[0, 104, 101, 108, 108, 111, 0]> : tensor<7xi32>) : !llvm.array<7 x i32>
    %1 = llvm.mlir.addressof @null_hello : !llvm.ptr
    %2 = llvm.call @wcslen(%1) : (!llvm.ptr) -> i64
    llvm.return %2 : i64
  }
  llvm.func @test_simplify4() -> i64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @nullstring : !llvm.ptr
    %2 = llvm.call @wcslen(%1) : (!llvm.ptr) -> i64
    llvm.return %2 : i64
  }
  llvm.func @test_simplify5() -> i1 {
    %0 = llvm.mlir.constant(dense<[104, 101, 108, 108, 111, 0]> : tensor<6xi32>) : !llvm.array<6 x i32>
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
    %0 = llvm.mlir.constant(dense<[104, 101, 108, 108, 111, 0]> : tensor<6xi32>) : !llvm.array<6 x i32>
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
    %0 = llvm.mlir.constant(dense<[104, 101, 108, 108, 111, 0]> : tensor<6xi32>) : !llvm.array<6 x i32>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(dense<[108, 111, 110, 103, 101, 114, 0]> : tensor<7xi32>) : !llvm.array<7 x i32>
    %3 = llvm.mlir.addressof @longer : !llvm.ptr
    %4 = llvm.select %arg0, %1, %3 : i1, !llvm.ptr
    %5 = llvm.call @wcslen(%4) : (!llvm.ptr) -> i64
    llvm.return %5 : i64
  }
  llvm.func @test_simplify10(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(dense<[104, 101, 108, 108, 111, 0]> : tensor<6xi32>) : !llvm.array<6 x i32>
    %1 = llvm.mlir.addressof @hello : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<6 x i32>
    %4 = llvm.call @wcslen(%3) : (!llvm.ptr) -> i64
    llvm.return %4 : i64
  }
  llvm.func @test_simplify11(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(dense<[104, 101, 108, 108, 111, 32, 119, 111, 114, 0, 108, 100, 0]> : tensor<13xi32>) : !llvm.array<13 x i32>
    %2 = llvm.mlir.addressof @null_hello_mid : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.getelementptr inbounds %2[%3, %4] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<13 x i32>
    %6 = llvm.call @wcslen(%5) : (!llvm.ptr) -> i64
    llvm.return %6 : i64
  }
  llvm.func @test_no_simplify1() -> i64 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : tensor<32xi32>) : !llvm.array<32 x i32>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.call @wcslen(%2) : (!llvm.ptr) -> i64
    llvm.return %3 : i64
  }
  llvm.func @test_no_simplify2(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(dense<[0, 104, 101, 108, 108, 111, 0]> : tensor<7xi32>) : !llvm.array<7 x i32>
    %1 = llvm.mlir.addressof @null_hello : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<7 x i32>
    %4 = llvm.call @wcslen(%3) : (!llvm.ptr) -> i64
    llvm.return %4 : i64
  }
  llvm.func @test_no_simplify2_no_null_opt(%arg0: i32) -> i64 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.constant(dense<[0, 104, 101, 108, 108, 111, 0]> : tensor<7xi32>) : !llvm.array<7 x i32>
    %1 = llvm.mlir.addressof @null_hello : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.getelementptr inbounds %1[%2, %arg0] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<7 x i32>
    %4 = llvm.call @wcslen(%3) : (!llvm.ptr) -> i64
    llvm.return %4 : i64
  }
  llvm.func @test_no_simplify3(%arg0: i32) -> i64 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(dense<[104, 101, 108, 108, 111, 32, 119, 111, 114, 0, 108, 100, 0]> : tensor<13xi32>) : !llvm.array<13 x i32>
    %2 = llvm.mlir.addressof @null_hello_mid : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.getelementptr inbounds %2[%3, %4] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<13 x i32>
    %6 = llvm.call @wcslen(%5) : (!llvm.ptr) -> i64
    llvm.return %6 : i64
  }
  llvm.func @test_no_simplify3_no_null_opt(%arg0: i32) -> i64 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(dense<[104, 101, 108, 108, 111, 32, 119, 111, 114, 0, 108, 100, 0]> : tensor<13xi32>) : !llvm.array<13 x i32>
    %2 = llvm.mlir.addressof @null_hello_mid : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.getelementptr inbounds %2[%3, %4] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<13 x i32>
    %6 = llvm.call @wcslen(%5) : (!llvm.ptr) -> i64
    llvm.return %6 : i64
  }
  llvm.func @test_simplify12() -> i64 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi16>) : !llvm.array<1 x i16>
    %2 = llvm.mlir.addressof @str16 : !llvm.ptr
    %3 = llvm.call @wcslen(%2) : (!llvm.ptr) -> i64
    llvm.return %3 : i64
  }
  llvm.func @fold_wcslen_1() -> i64 {
    %0 = llvm.mlir.constant(dense<[9, 8, 7, 6, 5, 4, 3, 2, 1, 0]> : tensor<10xi32>) : !llvm.array<10 x i32>
    %1 = llvm.mlir.addressof @ws : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(2 : i64) : i64
    %4 = llvm.getelementptr inbounds %1[%2, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<10 x i32>
    %5 = llvm.call @wcslen(%4) : (!llvm.ptr) -> i64
    llvm.return %5 : i64
  }
  llvm.func @no_fold_wcslen_1() -> i64 {
    %0 = llvm.mlir.constant(dense<[9, 8, 7, 6, 5, 4, 3, 2, 1, 0]> : tensor<10xi32>) : !llvm.array<10 x i32>
    %1 = llvm.mlir.addressof @ws : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<15 x i8>
    %5 = llvm.call @wcslen(%4) : (!llvm.ptr) -> i64
    llvm.return %5 : i64
  }
  llvm.func @no_fold_wcslen_2() -> i64 {
    %0 = llvm.mlir.constant("\09\08\07\06\05\04\03\02\01\00") : !llvm.array<10 x i8>
    %1 = llvm.mlir.addressof @s8 : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<10 x i8>
    %5 = llvm.call @wcslen(%4) : (!llvm.ptr) -> i64
    llvm.return %5 : i64
  }
}
