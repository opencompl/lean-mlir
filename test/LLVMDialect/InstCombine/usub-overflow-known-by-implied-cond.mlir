module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "uge" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %2 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %4, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.return %3 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %0 : i32
  }
  llvm.func @test2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "uge" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %2 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %4, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %3 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %0 : i32
  }
  llvm.func @test3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %2 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %4, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.return %3 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %0 : i32
  }
  llvm.func @test4(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %2 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %4, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %3 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %0 : i32
  }
  llvm.func @test5(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %2 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %4, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %3 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %0 : i32
  }
  llvm.func @test6(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ult" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %2 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %4, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %3 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %0 : i32
  }
  llvm.func @test7(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "slt" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %2 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %4, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %3 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %0 : i32
  }
  llvm.func @test8(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %arg1 : i32
    llvm.cond_br %1, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %2 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(i32, i1)> 
    %4 = llvm.extractvalue %2[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %4, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %3 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %0 : i32
  }
  llvm.func @test9(%arg0: i32, %arg1: i32, %arg2: i1) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %2 = llvm.and %1, %arg2  : i1
    llvm.cond_br %2, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %3 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %4 = llvm.extractvalue %3[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.extractvalue %3[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %5, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %4 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %0 : i32
  }
  llvm.func @test9_logical(%arg0: i32, %arg1: i32, %arg2: i1) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %3 = llvm.select %2, %arg2, %0 : i1, i1
    llvm.cond_br %3, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %4 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %5 = llvm.extractvalue %4[0] : !llvm.struct<(i32, i1)> 
    %6 = llvm.extractvalue %4[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %6, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %5 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %1 : i32
  }
  llvm.func @test10(%arg0: i32, %arg1: i32, %arg2: i1) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %2 = llvm.and %1, %arg2  : i1
    llvm.cond_br %2, ^bb3, ^bb1
  ^bb1:  // pred: ^bb0
    %3 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %4 = llvm.extractvalue %3[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.extractvalue %3[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %5, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %4 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %0 : i32
  }
  llvm.func @test10_logical(%arg0: i32, %arg1: i32, %arg2: i1) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %3 = llvm.select %2, %arg2, %0 : i1, i1
    llvm.cond_br %3, ^bb3, ^bb1
  ^bb1:  // pred: ^bb0
    %4 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %5 = llvm.extractvalue %4[0] : !llvm.struct<(i32, i1)> 
    %6 = llvm.extractvalue %4[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %6, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %5 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %1 : i32
  }
  llvm.func @test11(%arg0: i32, %arg1: i32, %arg2: i1) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %2 = llvm.or %1, %arg2  : i1
    llvm.cond_br %2, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %3 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %4 = llvm.extractvalue %3[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.extractvalue %3[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %5, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %4 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %0 : i32
  }
  llvm.func @test11_logical(%arg0: i32, %arg1: i32, %arg2: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %3 = llvm.select %2, %0, %arg2 : i1, i1
    llvm.cond_br %3, ^bb1, ^bb3
  ^bb1:  // pred: ^bb0
    %4 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %5 = llvm.extractvalue %4[0] : !llvm.struct<(i32, i1)> 
    %6 = llvm.extractvalue %4[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %6, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %5 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %1 : i32
  }
  llvm.func @test12(%arg0: i32, %arg1: i32, %arg2: i1) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %2 = llvm.or %1, %arg2  : i1
    llvm.cond_br %2, ^bb3, ^bb1
  ^bb1:  // pred: ^bb0
    %3 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %4 = llvm.extractvalue %3[0] : !llvm.struct<(i32, i1)> 
    %5 = llvm.extractvalue %3[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %5, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %4 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %0 : i32
  }
  llvm.func @test12_logical(%arg0: i32, %arg1: i32, %arg2: i1) -> i32 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i32
    %3 = llvm.select %2, %0, %arg2 : i1, i1
    llvm.cond_br %3, ^bb3, ^bb1
  ^bb1:  // pred: ^bb0
    %4 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %5 = llvm.extractvalue %4[0] : !llvm.struct<(i32, i1)> 
    %6 = llvm.extractvalue %4[1] : !llvm.struct<(i32, i1)> 
    llvm.cond_br %6, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %5 : i32
  ^bb3:  // 2 preds: ^bb0, ^bb1
    llvm.return %1 : i32
  }
}
