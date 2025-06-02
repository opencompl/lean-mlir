"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i32, i32, i1)>, linkage = #llvm.linkage<external>, sym_name = "select32", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg10: i32, %arg11: i32, %arg12: i1):
    %14 = "llvm.select"(%arg12, %arg10, %arg11) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i32, i32) -> i32
    "llvm.return"(%14) : (i32) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i64, i1)>, linkage = #llvm.linkage<external>, sym_name = "select64", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg7: i64, %arg8: i64, %arg9: i1):
    %13 = "llvm.select"(%arg9, %arg7, %arg8) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
    "llvm.return"(%13) : (i64) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i1 (i64, i64)>, linkage = #llvm.linkage<external>, sym_name = "icmp64", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg5: i64, %arg6: i64):
    %3 = "llvm.icmp"(%arg5, %arg6) <{predicate = 0 : i64}> : (i64, i64) -> i1
    %4 = "llvm.icmp"(%arg5, %arg6) <{predicate = 1 : i64}> : (i64, i64) -> i1
    %5 = "llvm.icmp"(%arg5, %arg6) <{predicate = 8 : i64}> : (i64, i64) -> i1
    %6 = "llvm.icmp"(%arg5, %arg6) <{predicate = 9 : i64}> : (i64, i64) -> i1
    %7 = "llvm.icmp"(%arg5, %arg6) <{predicate = 6 : i64}> : (i64, i64) -> i1
    %8 = "llvm.icmp"(%arg5, %arg6) <{predicate = 7 : i64}> : (i64, i64) -> i1
    %9 = "llvm.icmp"(%arg5, %arg6) <{predicate = 4 : i64}> : (i64, i64) -> i1
    %10 = "llvm.icmp"(%arg5, %arg6) <{predicate = 5 : i64}> : (i64, i64) -> i1
    %11 = "llvm.icmp"(%arg5, %arg6) <{predicate = 2 : i64}> : (i64, i64) -> i1
    %12 = "llvm.icmp"(%arg5, %arg6) <{predicate = 3 : i64}> : (i64, i64) -> i1
    "llvm.return"(%3) : (i1) -> ()
  }) : () -> ()
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i32 (i64, i64, i32, i32, i1)>, linkage = #llvm.linkage<external>, sym_name = "main", unnamed_addr = 0 : i64, visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64, %arg1: i64, %arg2: i32, %arg3: i32, %arg4: i1):
    %0 = "llvm.call"(%arg2, %arg3, %arg4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @select32, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (i32, i32, i1) -> i32
    %1 = "llvm.call"(%arg0, %arg1, %arg4) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @select64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 3, 0>}> : (i64, i64, i1) -> i64
    %2 = "llvm.call"(%arg0, %arg1) <{CConv = #llvm.cconv<ccc>, TailCallKind = #llvm.tailcallkind<none>, callee = @icmp64, fastmathFlags = #llvm.fastmath<none>, op_bundle_sizes = array<i32>, operandSegmentSizes = array<i32: 2, 0>}> : (i64, i64) -> i1
    "llvm.return"(%0) : (i32) -> ()
  }) : () -> ()
}) {dlti.dl_spec = #dlti.dl_spec<f16 = dense<16> : vector<2xi64>, f64 = dense<64> : vector<2xi64>, i64 = dense<[32, 64]> : vector<2xi64>, i32 = dense<32> : vector<2xi64>, i8 = dense<8> : vector<2xi64>, i16 = dense<16> : vector<2xi64>, !llvm.ptr = dense<64> : vector<4xi64>, i1 = dense<8> : vector<2xi64>, f128 = dense<128> : vector<2xi64>, "dlti.endianness" = "little">} : () -> ()

