"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "add", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg26: i64, %arg27: i64):
    %47 = "llvm.add"(%arg26, %arg27) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    %48 = "llvm.add"(%arg26, %arg27) <{overflowFlags = #llvm.overflow<nuw>}> : (i64, i64) -> i64
    %49 = "llvm.add"(%arg26, %arg27) <{overflowFlags = #llvm.overflow<nsw>}> : (i64, i64) -> i64
    %50 = "llvm.add"(%arg26, %arg27) <{overflowFlags = #llvm.overflow<nsw, nuw>}> : (i64, i64) -> i64
    %51 = "llvm.add"(%47, %48) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    %52 = "llvm.add"(%49, %50) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    "llvm.return"(%52) : (i64) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "sub", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg24: i64, %arg25: i64):
    %41 = "llvm.sub"(%arg24, %arg25) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    %42 = "llvm.sub"(%arg24, %arg25) <{overflowFlags = #llvm.overflow<nuw>}> : (i64, i64) -> i64
    %43 = "llvm.sub"(%arg24, %arg25) <{overflowFlags = #llvm.overflow<nsw>}> : (i64, i64) -> i64
    %44 = "llvm.sub"(%arg24, %arg25) <{overflowFlags = #llvm.overflow<nsw, nuw>}> : (i64, i64) -> i64
    %45 = "llvm.sub"(%41, %42) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    %46 = "llvm.sub"(%43, %44) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    "llvm.return"(%46) : (i64) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "mul", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg22: i64, %arg23: i64):
    %35 = "llvm.mul"(%arg22, %arg23) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    %36 = "llvm.mul"(%arg22, %arg23) <{overflowFlags = #llvm.overflow<nuw>}> : (i64, i64) -> i64
    %37 = "llvm.mul"(%arg22, %arg23) <{overflowFlags = #llvm.overflow<nsw>}> : (i64, i64) -> i64
    %38 = "llvm.mul"(%arg22, %arg23) <{overflowFlags = #llvm.overflow<nsw, nuw>}> : (i64, i64) -> i64
    %39 = "llvm.mul"(%35, %36) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    %40 = "llvm.mul"(%37, %38) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    "llvm.return"(%40) : (i64) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "udiv", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg20: i64, %arg21: i64):
    %32 = "llvm.udiv"(%arg20, %arg21) : (i64, i64) -> i64
    %33 = "llvm.udiv"(%arg20, %arg21) : (i64, i64) -> i64
    %34 = "llvm.mul"(%32, %33) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    "llvm.return"(%34) : (i64) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "sdiv", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg18: i64, %arg19: i64):
    %29 = "llvm.sdiv"(%arg18, %arg19) : (i64, i64) -> i64
    %30 = "llvm.sdiv"(%arg18, %arg19) : (i64, i64) -> i64
    %31 = "llvm.mul"(%29, %30) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    "llvm.return"(%31) : (i64) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "urem", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg16: i64, %arg17: i64):
    %28 = "llvm.urem"(%arg16, %arg17) : (i64, i64) -> i64
    "llvm.return"(%28) : (i64) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "srem", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg14: i64, %arg15: i64):
    %27 = "llvm.srem"(%arg14, %arg15) : (i64, i64) -> i64
    "llvm.return"(%27) : (i64) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "shl", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg12: i64, %arg13: i64):
    %21 = "llvm.shl"(%arg12, %arg13) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    %22 = "llvm.shl"(%arg12, %arg13) <{overflowFlags = #llvm.overflow<nuw>}> : (i64, i64) -> i64
    %23 = "llvm.shl"(%arg12, %arg13) <{overflowFlags = #llvm.overflow<nsw>}> : (i64, i64) -> i64
    %24 = "llvm.shl"(%arg12, %arg13) <{overflowFlags = #llvm.overflow<nsw, nuw>}> : (i64, i64) -> i64
    %25 = "llvm.shl"(%21, %22) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    %26 = "llvm.shl"(%23, %24) <{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> i64
    "llvm.return"(%26) : (i64) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "lshr", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg10: i64, %arg11: i64):
    %18 = "llvm.lshr"(%arg10, %arg11) : (i64, i64) -> i64
    %19 = "llvm.lshr"(%arg10, %arg11) : (i64, i64) -> i64
    %20 = "llvm.lshr"(%18, %19) : (i64, i64) -> i64
    "llvm.return"(%20) : (i64) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "ashr", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg8: i64, %arg9: i64):
    %15 = "llvm.ashr"(%arg8, %arg9) : (i64, i64) -> i64
    %16 = "llvm.ashr"(%arg8, %arg9) : (i64, i64) -> i64
    %17 = "llvm.ashr"(%15, %16) : (i64, i64) -> i64
    "llvm.return"(%17) : (i64) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "and", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg6: i64, %arg7: i64):
    %14 = "llvm.and"(%arg6, %arg7) : (i64, i64) -> i64
    "llvm.return"(%14) : (i64) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "or", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg4: i64, %arg5: i64):
    %13 = "llvm.or"(%arg4, %arg5) : (i64, i64) -> i64
    "llvm.return"(%13) : (i64) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "xor", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg2: i64, %arg3: i64):
    %12 = "llvm.xor"(%arg2, %arg3) : (i64, i64) -> i64
    "llvm.return"(%12) : (i64) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "main", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64, %arg1: i64):
    %0 = "llvm.call"(%arg0, %arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @add, fastmathFlags = #llvm.fastmath<none>}> : (i64, i64) -> i64
    %1 = "llvm.call"(%arg0, %arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @sub, fastmathFlags = #llvm.fastmath<none>}> : (i64, i64) -> i64
    %2 = "llvm.call"(%arg0, %arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @mul, fastmathFlags = #llvm.fastmath<none>}> : (i64, i64) -> i64
    %3 = "llvm.call"(%arg0, %arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @udiv, fastmathFlags = #llvm.fastmath<none>}> : (i64, i64) -> i64
    %4 = "llvm.call"(%arg0, %arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @sdiv, fastmathFlags = #llvm.fastmath<none>}> : (i64, i64) -> i64
    %5 = "llvm.call"(%arg0, %arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @urem, fastmathFlags = #llvm.fastmath<none>}> : (i64, i64) -> i64
    %6 = "llvm.call"(%arg0, %arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @srem, fastmathFlags = #llvm.fastmath<none>}> : (i64, i64) -> i64
    %7 = "llvm.call"(%arg0, %arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @ashr, fastmathFlags = #llvm.fastmath<none>}> : (i64, i64) -> i64
    %8 = "llvm.call"(%arg0, %arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @and, fastmathFlags = #llvm.fastmath<none>}> : (i64, i64) -> i64
    %9 = "llvm.call"(%arg0, %arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @or, fastmathFlags = #llvm.fastmath<none>}> : (i64, i64) -> i64
    %10 = "llvm.call"(%arg0, %arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @xor, fastmathFlags = #llvm.fastmath<none>}> : (i64, i64) -> i64
    %11 = "llvm.call"(%arg0, %arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @xor, fastmathFlags = #llvm.fastmath<none>}> : (i64, i64) -> i64
    "llvm.return"(%11) : (i64) -> ()
  }) : () -> ()
}) {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} : () -> ()

