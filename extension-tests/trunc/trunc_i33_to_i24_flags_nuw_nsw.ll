
define i24 @main(i33 %0) {
  %2 = trunc nuw nsw i33 %0 to i24
  ret i24 %2
}
