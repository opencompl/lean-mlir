
define i32 @main(i53 %0) {
  %2 = trunc nsw i53 %0 to i32
  ret i32 %2
}
