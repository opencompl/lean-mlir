module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @foo()
  llvm.func @test1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.icmp "slt" %arg1, %0 : i32
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @test1_splat(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "slt" %arg0, %1 : vector<2xi32>
    %3 = llvm.icmp "slt" %arg1, %1 : vector<2xi32>
    %4 = llvm.or %2, %3  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @test1_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "slt" %arg1, %0 : i32
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @test2(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.icmp "sgt" %arg1, %0 : i32
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @test2_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg1, %0 : i32
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @test3(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %0 : i32
    %2 = llvm.icmp "slt" %arg1, %0 : i32
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @test3_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.icmp "slt" %arg1, %0 : i32
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @test4(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.icmp "sgt" %arg1, %0 : i32
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }
  llvm.func @test4_logical(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.icmp "sgt" %arg1, %0 : i32
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @test5(%arg0: i32) {
    %0 = llvm.mlir.constant(134217728 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.icmp "sgt" %arg0, %2 : i32
    %6 = llvm.and %4, %5  : i1
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo() : () -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }
  llvm.func @test5_logical(%arg0: i32) {
    %0 = llvm.mlir.constant(134217728 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.icmp "sgt" %arg0, %2 : i32
    %7 = llvm.select %5, %6, %3 : i1, i1
    llvm.cond_br %7, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo() : () -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }
  llvm.func @test6(%arg0: i32) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(134217728 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    %6 = llvm.and %3, %5  : i1
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo() : () -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }
  llvm.func @test6_logical(%arg0: i32) {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(134217728 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.icmp "sgt" %arg0, %0 : i32
    %5 = llvm.and %arg0, %1  : i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    %7 = llvm.select %4, %6, %3 : i1, i1
    llvm.cond_br %7, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo() : () -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }
  llvm.func @test7(%arg0: i32) {
    %0 = llvm.mlir.constant(134217728 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    %4 = llvm.icmp "slt" %arg0, %1 : i32
    %5 = llvm.or %3, %4  : i1
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo() : () -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }
  llvm.func @test7_logical(%arg0: i32) {
    %0 = llvm.mlir.constant(134217728 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.icmp "slt" %arg0, %1 : i32
    %6 = llvm.select %4, %2, %5 : i1, i1
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo() : () -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }
  llvm.func @test8(%arg0: i32) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(134217728 : i32) : i32
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.and %arg0, %1  : i32
    %4 = llvm.icmp "ne" %3, %0 : i32
    %5 = llvm.or %2, %4  : i1
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo() : () -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }
  llvm.func @test8_logical(%arg0: i32) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(134217728 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "slt" %arg0, %0 : i32
    %4 = llvm.and %arg0, %1  : i32
    %5 = llvm.icmp "ne" %4, %0 : i32
    %6 = llvm.select %3, %2, %5 : i1, i1
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo() : () -> ()
    llvm.return
  ^bb2:  // pred: ^bb0
    llvm.return
  }
  llvm.func @test9(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1073741824 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.icmp "sgt" %arg0, %2 : i32
    %6 = llvm.and %4, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @test9_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1073741824 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.icmp "sgt" %arg0, %2 : i32
    %7 = llvm.select %5, %6, %3 : i1, i1
    llvm.return %7 : i1
  }
  llvm.func @test10(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.icmp "ult" %arg0, %2 : i32
    %6 = llvm.and %4, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @test10_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.icmp "ult" %arg0, %2 : i32
    %7 = llvm.select %5, %6, %3 : i1, i1
    llvm.return %7 : i1
  }
  llvm.func @test11(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "ne" %3, %1 : i32
    %5 = llvm.icmp "ugt" %arg0, %2 : i32
    %6 = llvm.or %4, %5  : i1
    llvm.return %6 : i1
  }
  llvm.func @test11_logical(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "ne" %4, %1 : i32
    %6 = llvm.icmp "ugt" %arg0, %2 : i32
    %7 = llvm.select %5, %3, %6 : i1, i1
    llvm.return %7 : i1
  }
}
