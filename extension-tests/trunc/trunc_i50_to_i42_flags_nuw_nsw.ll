
define i42 @main(i50 %0) {
  %2 = trunc nuw nsw i50 %0 to i42
  ret i42 %2
}
