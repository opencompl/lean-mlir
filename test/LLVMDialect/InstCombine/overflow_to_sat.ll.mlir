module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @uadd(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = "llvm.intr.uadd.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i32, i1)> 
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(i32, i1)> 
    %4 = llvm.select %2, %0, %3 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @usub(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = "llvm.intr.usub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %2 = llvm.extractvalue %1[1] : !llvm.struct<(i32, i1)> 
    %3 = llvm.extractvalue %1[0] : !llvm.struct<(i32, i1)> 
    %4 = llvm.select %2, %0, %3 : i1, i32
    llvm.return %4 : i32
  }
  llvm.func @sadd_x_lt_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "slt" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @sadd_x_lt_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "slt" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @sadd_x_le_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sle" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @sadd_x_le_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sle" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @sadd_x_gt_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sgt" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @sadd_x_gt_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sgt" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @sadd_x_ge_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sge" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @sadd_x_ge_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sge" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @sadd_y_lt_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "slt" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @sadd_y_lt_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "slt" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @sadd_y_le_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sle" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @sadd_y_le_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sle" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @sadd_y_gt_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sgt" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @sadd_y_gt_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sgt" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @sadd_y_ge_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sge" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @sadd_y_ge_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sge" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @ssub_x_lt_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "slt" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @ssub_x_lt_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "slt" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @ssub_x_le_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sle" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @ssub_x_le_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sle" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @ssub_x_lt2_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "slt" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @ssub_x_lt2_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "slt" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @ssub_x_gt_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sgt" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @ssub_x_gt_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sgt" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @ssub_x_ge_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sge" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @ssub_x_ge_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sge" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @ssub_x_gt2_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sgt" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @ssub_x_gt2_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sgt" %arg0, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @ssub_y_lt_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "slt" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @ssub_y_lt_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "slt" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @ssub_y_le_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sle" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @ssub_y_le_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sle" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @ssub_y_gt_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sgt" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @ssub_y_gt_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sgt" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @ssub_y_ge_min(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.mlir.constant(-128 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sge" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @ssub_y_ge_max(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.mlir.constant(127 : i8) : i8
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i8, i1)> 
    %6 = llvm.icmp "sge" %arg1, %0 : i8
    %7 = llvm.select %6, %1, %2 : i1, i8
    %8 = llvm.select %4, %7, %5 : i1, i8
    llvm.return %8 : i8
  }
  llvm.func @sadd_i32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.mlir.constant(2147483647 : i32) : i32
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i32, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i32, i1)> 
    %6 = llvm.icmp "slt" %arg0, %0 : i32
    %7 = llvm.select %6, %1, %2 : i1, i32
    %8 = llvm.select %4, %7, %5 : i1, i32
    llvm.return %8 : i32
  }
  llvm.func @ssub_i32(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.mlir.constant(2147483647 : i32) : i32
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i32, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i32, i1)> 
    %6 = llvm.icmp "slt" %arg0, %0 : i32
    %7 = llvm.select %6, %1, %2 : i1, i32
    %8 = llvm.select %4, %7, %5 : i1, i32
    llvm.return %8 : i32
  }
  llvm.func @sadd_bounds(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-128 : i32) : i32
    %2 = llvm.mlir.constant(127 : i32) : i32
    %3 = "llvm.intr.sadd.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i32, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i32, i1)> 
    %6 = llvm.icmp "slt" %arg0, %0 : i32
    %7 = llvm.select %6, %1, %2 : i1, i32
    %8 = llvm.select %4, %7, %5 : i1, i32
    llvm.return %8 : i32
  }
  llvm.func @ssub_bounds(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-128 : i32) : i32
    %2 = llvm.mlir.constant(127 : i32) : i32
    %3 = "llvm.intr.ssub.with.overflow"(%arg0, %arg1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    %4 = llvm.extractvalue %3[1] : !llvm.struct<(i32, i1)> 
    %5 = llvm.extractvalue %3[0] : !llvm.struct<(i32, i1)> 
    %6 = llvm.icmp "slt" %arg0, %0 : i32
    %7 = llvm.select %6, %1, %2 : i1, i32
    %8 = llvm.select %4, %7, %5 : i1, i32
    llvm.return %8 : i32
  }
}
