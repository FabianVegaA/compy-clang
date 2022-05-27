run: clean
	mkdir -p bin
	ghc Main.hs -o Main
	
	mv *.o bin/
	mv *.hi bin/
	mv Main bin/

	echo "\nTranspiling..."
	./bin/Main

	mv *.c bin/
	mv *.h bin/
	cp lib/*.c bin/
	cp lib/*.h bin/

	echo "\nCompiling C code..."
	clang -o bin/exec bin/main.c bin/range.c

	echo "\nExecuting..."
	./bin/exec
	
test: clean
	mkdir -p bin
	ghc test/Test.hs -o bin/Test
	mv test/*.o bin/
	mv test/*.hi bin/
	mv test/ShowExpressionTests/*.o bin/
	mv test/ShowExpressionTests/*.hi bin/
	mv *.o bin/
	mv *.hi bin/
	./bin/Test

clean:
	rm -f bin/*