
define i42 @main(i53 %0) {
  %2 = trunc nuw nsw i53 %0 to i42
  ret i42 %2
}
