
define i24 @main(i48 %0) {
  %2 = trunc nuw nsw i48 %0 to i24
  ret i24 %2
}
