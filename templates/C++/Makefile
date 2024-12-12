MAKEFLAGS += --no-print-directory
all:
	@make all -C build/
test:
	@make all
	@build/tests/PROJECTNAME_tst
run:
	@make all
	@build/src/PROJECTNAME_run
clean:
	rm -rf build && mkdir build
	git init
	cd ./lib/ && git submodule add https://github.com/google/googletest/ && cd ../.. 
	cd ./build && cmake .. -DCMAKE_BUILD_TYPE=Debug -G "Unix Makefiles" && cd ..
	@make all