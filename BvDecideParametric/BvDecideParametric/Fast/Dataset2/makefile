.PHONY: run clean

clean:
	rm *.lean

run: runner.py
	rm *.lean
	mv run.sqlite3 run$(date +'%Y-%m-%d-%H:%M:%S').sqlite3
	./runner.py --test-run run.sqlite

