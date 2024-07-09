module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>>} {
  llvm.func @test1(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    "llvm.intr.assume"(%4) : (i1) -> ()
    %5 = llvm.and %arg0, %2  : i32
    llvm.return %5 : i32
  }
  llvm.func @test2(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(-11 : i32) : i32
    %3 = llvm.mlir.constant(7 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.xor %4, %1  : i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    "llvm.intr.assume"(%6) : (i1) -> ()
    %7 = llvm.and %arg0, %3  : i32
    llvm.return %7 : i32
  }
  llvm.func @test3(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(-16 : i32) : i32
    %1 = llvm.mlir.constant(-11 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.or %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    "llvm.intr.assume"(%4) : (i1) -> ()
    %5 = llvm.and %arg0, %2  : i32
    llvm.return %5 : i32
  }
  llvm.func @test4(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(-16 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(5 : i32) : i32
    %3 = llvm.mlir.constant(7 : i32) : i32
    %4 = llvm.or %arg0, %0  : i32
    %5 = llvm.xor %4, %1  : i32
    %6 = llvm.icmp "eq" %5, %2 : i32
    "llvm.intr.assume"(%6) : (i1) -> ()
    %7 = llvm.and %arg0, %3  : i32
    llvm.return %7 : i32
  }
  llvm.func @test5(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    "llvm.intr.assume"(%4) : (i1) -> ()
    %5 = llvm.and %arg0, %2  : i32
    llvm.return %5 : i32
  }
  llvm.func @test6(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(20 : i32) : i32
    %2 = llvm.mlir.constant(63 : i32) : i32
    %3 = llvm.shl %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    "llvm.intr.assume"(%4) : (i1) -> ()
    %5 = llvm.and %arg0, %2  : i32
    llvm.return %5 : i32
  }
  llvm.func @test7(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(252 : i32) : i32
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    "llvm.intr.assume"(%4) : (i1) -> ()
    %5 = llvm.and %arg0, %2  : i32
    llvm.return %5 : i32
  }
  llvm.func @test8(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(5 : i32) : i32
    %2 = llvm.mlir.constant(252 : i32) : i32
    %3 = llvm.lshr %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    "llvm.intr.assume"(%4) : (i1) -> ()
    %5 = llvm.and %arg0, %2  : i32
    llvm.return %5 : i32
  }
  llvm.func @test9(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.and %arg0, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @test10(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.icmp "sle" %arg0, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.and %arg0, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @test11(%arg0: i32) -> i32 attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(256 : i32) : i32
    %1 = llvm.mlir.constant(3072 : i32) : i32
    %2 = llvm.icmp "ule" %arg0, %0 : i32
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.and %arg0, %1  : i32
    llvm.return %3 : i32
  }
}
