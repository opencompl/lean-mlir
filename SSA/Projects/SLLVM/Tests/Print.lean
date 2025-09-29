import SSA.Projects.SLLVM.Dialect

/-!
# SLLVM dialect printing
-/

/-! ## SLLVM dialect print tests -/

/--
info: builtin.module {
  ^entry(%0 : !ptr, %1 : i64):
    %2 = "ptr.add"(%0, %1) : (!ptr, i64) -> (!ptr)
    "llvm.return"(%2) : (!ptr) -> ()
}
-/
#guard_msgs in #eval Com.printModule [sllvm| {
  ^entry(%p: !ptr, %x: i64):
    %q = "ptr.add"(%p, %x) : (!ptr, i64) -> (!ptr)
    "llvm.return"(%q) : (!ptr) -> ()
}]

/--
info: builtin.module {
  ^entry(%0 : !ptr):
    %1 = "ptr.load"(%0) : (!ptr) -> (i64)
    "llvm.return"(%1) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [sllvm| {
  ^entry(%p: !ptr):
    %x = "ptr.load"(%p) : (!ptr) -> (i64)
    "llvm.return"(%x) : (i64) -> ()
}]

/--
info: builtin.module {
  ^entry(%0 : !ptr, %1 : i64):
    "ptr.store"(%0, %1) : (!ptr, i64) -> ()
    "llvm.return"() : () -> ()
}
-/
#guard_msgs in #eval Com.printModule [sllvm| {
  ^entry(%p: !ptr, %x: i64):
    "ptr.store"(%p, %x) : (!ptr, i64) -> ()
    "llvm.return"() : () -> ()
}]

/--
info: builtin.module {
  ^entry():
    %0 = "ptr.alloca"() : () -> (!ptr)
    "llvm.return"(%0) : (!ptr) -> ()
}
-/
#guard_msgs in #eval Com.printModule [sllvm| {
  ^entry():
    %p = "ptr.alloca"() : () -> (!ptr)
    "llvm.return"(%p) : (!ptr) -> ()
}]

/--
info: builtin.module {
  ^entry(%0 : i64, %1 : i64):
    %2 = "llvm.add"(%0, %1)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [sllvm| {
  ^entry(%x: i64, %y: i64):
    %z = "llvm.add"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/--
info: builtin.module {
  ^entry(%0 : i64, %1 : i64):
    %2 = "llvm.add"(%0, %1)<{overflowFlags = #llvm.overflow<nsw,nuw>}> : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [sllvm| {
  ^entry(%x: i64, %y: i64):
    %z = "llvm.add"(%x, %y) {overflowFlags = #llvm.overflow<"nsw","nuw">} : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/--
info: builtin.module {
  ^entry(%0 : i64, %1 : i64):
    %2 = "llvm.udiv"(%0, %1) : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [sllvm| {
  ^entry(%x: i64, %y: i64):
    %z = "llvm.udiv"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/--
info: builtin.module {
  ^entry(%0 : i64, %1 : i64):
    %2 = "llvm.udiv"(%0, %1)<{isExact}>  : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [sllvm| {
  ^entry(%x: i64, %y: i64):
    %z = "llvm.udiv"(%x, %y) {isExact} : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
