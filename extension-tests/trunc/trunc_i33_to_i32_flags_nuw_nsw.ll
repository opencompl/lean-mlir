
define i32 @main(i33 %0) {
  %2 = trunc nuw nsw i33 %0 to i32
  ret i32 %2
}
