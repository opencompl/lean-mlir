module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i64, i1)> 
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(i64, i1)> 
    %4 = llvm.icmp "ne" %3, %0 : i64
    %5 = llvm.or %2, %4  : i1
    llvm.store %3, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr
    llvm.return %5 : i1
  }
  llvm.func @test1_logical(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(true) : i1
    %2 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i64, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i64, i1)> 
    %5 = llvm.icmp "ne" %4, %0 : i64
    %6 = llvm.select %3, %1, %5 : i1, i1
    llvm.store %4, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr
    llvm.return %6 : i1
  }
  llvm.func @test1_or_ops_swapped(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i64, i1)> 
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(i64, i1)> 
    %4 = llvm.icmp "ne" %3, %0 : i64
    %5 = llvm.or %4, %2  : i1
    llvm.store %3, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr
    llvm.return %5 : i1
  }
  llvm.func @test1_or_ops_swapped_logical(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(true) : i1
    %2 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i64, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i64, i1)> 
    %5 = llvm.icmp "ne" %4, %0 : i64
    %6 = llvm.select %5, %1, %3 : i1, i1
    llvm.store %4, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr
    llvm.return %6 : i1
  }
  llvm.func @test2(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i64, i1)> 
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(i64, i1)> 
    %4 = llvm.icmp "ne" %3, %0 : i64
    %5 = llvm.or %2, %4  : i1
    %6 = llvm.sub %0, %3  : i64
    llvm.store %6, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr
    llvm.return %5 : i1
  }
  llvm.func @test2_logical(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(true) : i1
    %2 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i64, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i64, i1)> 
    %5 = llvm.icmp "ne" %4, %0 : i64
    %6 = llvm.select %3, %1, %5 : i1, i1
    %7 = llvm.sub %0, %4  : i64
    llvm.store %7, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr
    llvm.return %6 : i1
  }
  llvm.func @use(i1)
  llvm.func @test3_multiple_overflow_users(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i64, i1)> 
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(i64, i1)> 
    %4 = llvm.icmp "ne" %3, %0 : i64
    %5 = llvm.or %2, %4  : i1
    llvm.call @use(%2) : (i1) -> ()
    llvm.return %5 : i1
  }
  llvm.func @test3_multiple_overflow_users_logical(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(true) : i1
    %2 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i64, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i64, i1)> 
    %5 = llvm.icmp "ne" %4, %0 : i64
    %6 = llvm.select %3, %1, %5 : i1, i1
    llvm.call @use(%3) : (i1) -> ()
    llvm.return %6 : i1
  }
  llvm.func @test3_multiple_overflow_and_mul_users(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i64, i1)> 
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(i64, i1)> 
    %4 = llvm.icmp "ne" %3, %0 : i64
    %5 = llvm.or %2, %4  : i1
    %6 = llvm.sub %0, %3  : i64
    llvm.store %6, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr
    llvm.call @use(%2) : (i1) -> ()
    llvm.return %5 : i1
  }
  llvm.func @test3_multiple_overflow_and_mul_users_logical(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(true) : i1
    %2 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i64, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i64, i1)> 
    %5 = llvm.icmp "ne" %4, %0 : i64
    %6 = llvm.select %3, %1, %5 : i1, i1
    %7 = llvm.sub %0, %4  : i64
    llvm.store %7, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr
    llvm.call @use(%3) : (i1) -> ()
    llvm.return %6 : i1
  }
  llvm.func @use.2(!llvm.struct<(i64, i1)>)
  llvm.func @test3_multiple_res_users(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i64, i1)> 
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(i64, i1)> 
    %4 = llvm.icmp "ne" %3, %0 : i64
    %5 = llvm.or %2, %4  : i1
    %6 = llvm.sub %0, %3  : i64
    llvm.store %6, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr
    llvm.call @use.2(%1) : (!llvm.struct<(i64, i1)>) -> ()
    llvm.return %5 : i1
  }
  llvm.func @test3_multiple_res_users_logical(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(true) : i1
    %2 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i64, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i64, i1)> 
    %5 = llvm.icmp "ne" %4, %0 : i64
    %6 = llvm.select %3, %1, %5 : i1, i1
    %7 = llvm.sub %0, %4  : i64
    llvm.store %7, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr
    llvm.call @use.2(%2) : (!llvm.struct<(i64, i1)>) -> ()
    llvm.return %6 : i1
  }
  llvm.func @use.3(i64)
  llvm.func @test3_multiple_mul_users(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i64, i1)> 
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(i64, i1)> 
    %4 = llvm.icmp "ne" %3, %0 : i64
    %5 = llvm.or %2, %4  : i1
    %6 = llvm.sub %0, %3  : i64
    llvm.store %6, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr
    llvm.call @use.3(%3) : (i64) -> ()
    llvm.return %5 : i1
  }
  llvm.func @test3_multiple_mul_users_logical(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(true) : i1
    %2 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i64, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i64, i1)> 
    %5 = llvm.icmp "ne" %4, %0 : i64
    %6 = llvm.select %3, %1, %5 : i1, i1
    %7 = llvm.sub %0, %4  : i64
    llvm.store %7, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr
    llvm.call @use.3(%4) : (i64) -> ()
    llvm.return %6 : i1
  }
  llvm.func @test4_no_icmp_ne(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i64, i1)> 
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(i64, i1)> 
    %4 = llvm.icmp "sgt" %3, %0 : i64
    %5 = llvm.or %2, %4  : i1
    %6 = llvm.sub %0, %3  : i64
    llvm.store %6, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr
    llvm.return %5 : i1
  }
  llvm.func @test4_no_icmp_ne_logical(%arg0: i64, %arg1: i64, %arg2: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(true) : i1
    %2 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i64, i64) -> !llvm.struct<(i64, i1)>
    %3 = llvm.extractvalue %2[1] : !llvm.struct<(i64, i1)> 
    %4 = llvm.extractvalue %2[0] : !llvm.struct<(i64, i1)> 
    %5 = llvm.icmp "sgt" %4, %0 : i64
    %6 = llvm.select %3, %1, %5 : i1, i1
    %7 = llvm.sub %0, %4  : i64
    llvm.store %7, %arg2 {alignment = 8 : i64} : i64, !llvm.ptr
    llvm.return %6 : i1
  }
}
