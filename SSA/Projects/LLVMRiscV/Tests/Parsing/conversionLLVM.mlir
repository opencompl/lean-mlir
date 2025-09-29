"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i64)>, linkage = #llvm.linkage<external>, sym_name = "trunc64to32", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg13: i64):
    %39 = "llvm.trunc"(%arg13) : (i64) -> i32
    %40 = "llvm.trunc"(%arg13) : (i64) -> i32
    %41 = "llvm.trunc"(%arg13) : (i64) -> i32
    %42 = "llvm.trunc"(%arg13) : (i64) -> i32
    %43 = "llvm.add"(%39, %40) <{overflowFlags = #llvm.overflow<none>}> : (i32, i32) -> i32
    %44 = "llvm.add"(%41, %42) <{overflowFlags = #llvm.overflow<none>}> : (i32, i32) -> i32
    "llvm.return"(%44) : (i32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i8 (i32)>, linkage = #llvm.linkage<external>, sym_name = "trunc32to8", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg12: i32):
    %33 = "llvm.trunc"(%arg12) : (i32) -> i8
    %34 = "llvm.trunc"(%arg12) : (i32) -> i8
    %35 = "llvm.trunc"(%arg12) : (i32) -> i8
    %36 = "llvm.trunc"(%arg12) : (i32) -> i8
    %37 = "llvm.add"(%33, %34) <{overflowFlags = #llvm.overflow<none>}> : (i8, i8) -> i8
    %38 = "llvm.add"(%35, %36) <{overflowFlags = #llvm.overflow<none>}> : (i8, i8) -> i8
    "llvm.return"(%38) : (i8) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i16 (i32)>, linkage = #llvm.linkage<external>, sym_name = "trunc32to16", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg11: i32):
    %27 = "llvm.trunc"(%arg11) : (i32) -> i16
    %28 = "llvm.trunc"(%arg11) : (i32) -> i16
    %29 = "llvm.trunc"(%arg11) : (i32) -> i16
    %30 = "llvm.trunc"(%arg11) : (i32) -> i16
    %31 = "llvm.add"(%27, %28) <{overflowFlags = #llvm.overflow<none>}> : (i16, i16) -> i16
    %32 = "llvm.add"(%29, %30) <{overflowFlags = #llvm.overflow<none>}> : (i16, i16) -> i16
    "llvm.return"(%32) : (i16) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i1)>, linkage = #llvm.linkage<external>, sym_name = "zext1", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg10: i1):
    %23 = "llvm.zext"(%arg10) : (i1) -> i8
    %24 = "llvm.zext"(%arg10) : (i1) -> i16
    %25 = "llvm.zext"(%arg10) : (i1) -> i32
    %26 = "llvm.zext"(%arg10) : (i1) -> i64
    "llvm.return"(%26) : (i64) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i8)>, linkage = #llvm.linkage<external>, sym_name = "zext8", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg9: i8):
    %20 = "llvm.zext"(%arg9) : (i8) -> i16
    %21 = "llvm.zext"(%arg9) : (i8) -> i32
    %22 = "llvm.zext"(%arg9) : (i8) -> i64
    "llvm.return"(%22) : (i64) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i16)>, linkage = #llvm.linkage<external>, sym_name = "zext16", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg8: i16):
    %18 = "llvm.zext"(%arg8) : (i16) -> i32
    %19 = "llvm.zext"(%arg8) : (i16) -> i64
    "llvm.return"(%19) : (i64) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i1)>, linkage = #llvm.linkage<external>, sym_name = "sext1", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg7: i1):
    %14 = "llvm.sext"(%arg7) : (i1) -> i8
    %15 = "llvm.sext"(%arg7) : (i1) -> i16
    %16 = "llvm.sext"(%arg7) : (i1) -> i32
    %17 = "llvm.sext"(%arg7) : (i1) -> i64
    "llvm.return"(%17) : (i64) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i8)>, linkage = #llvm.linkage<external>, sym_name = "sext8", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg6: i8):
    %11 = "llvm.sext"(%arg6) : (i8) -> i16
    %12 = "llvm.sext"(%arg6) : (i8) -> i32
    %13 = "llvm.sext"(%arg6) : (i8) -> i64
    "llvm.return"(%13) : (i64) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i16)>, linkage = #llvm.linkage<external>, sym_name = "sext16", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg5: i16):
    %9 = "llvm.sext"(%arg5) : (i16) -> i32
    %10 = "llvm.sext"(%arg5) : (i16) -> i64
    "llvm.return"(%10) : (i64) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i64, i32, i1, i8, i16)>, linkage = #llvm.linkage<external>, sym_name = "main", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64, %arg1: i32, %arg2: i1, %arg3: i8, %arg4: i16):
    %0 = "llvm.call"(%arg0) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @trunc64to32, fastmathFlags = #llvm.fastmath<none>}> : (i64) -> i32
    %1 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @trunc32to8, fastmathFlags = #llvm.fastmath<none>}> : (i32) -> i8
    %2 = "llvm.call"(%arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @trunc32to16, fastmathFlags = #llvm.fastmath<none>}> : (i32) -> i16
    %3 = "llvm.call"(%arg2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @zext1, fastmathFlags = #llvm.fastmath<none>}> : (i1) -> i64
    %4 = "llvm.call"(%arg3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @zext8, fastmathFlags = #llvm.fastmath<none>}> : (i8) -> i64
    %5 = "llvm.call"(%arg4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @zext16, fastmathFlags = #llvm.fastmath<none>}> : (i16) -> i64
    %6 = "llvm.call"(%arg2) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @sext1, fastmathFlags = #llvm.fastmath<none>}> : (i1) -> i64
    %7 = "llvm.call"(%arg3) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @sext8, fastmathFlags = #llvm.fastmath<none>}> : (i8) -> i64
    %8 = "llvm.call"(%arg4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @sext16, fastmathFlags = #llvm.fastmath<none>}> : (i16) -> i64
    "llvm.return"(%0) : (i32) -> ()
  }) : () -> ()
}) {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} : () -> ()

