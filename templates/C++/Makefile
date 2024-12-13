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
	@rm -rf build && mkdir build
	@if [ ! -d ./lib ]; then \
		mkdir lib; \
		echo "Creating lib folder"; \
	else \
		echo "lib directory exists"; \
	fi

	@if [ -d .git ]; then \
		echo "Repository already initialized; skipping git init."; \
	else \
		echo "Initializing Git repository."; \
		git init; \
	fi

	@if [ -d ./lib/googletest ]; then \
		cd ./lib/googletest && git pull && cd ../..; \
		echo "Google Test already added; pulling latest updates."; \
	else \
		cd ./lib/ && git submodule add https://github.com/google/googletest/ && cd ../..; \
	fi
	@cd ./build && cmake .. -DCMAKE_BUILD_TYPE=Debug -G "Unix Makefiles" && cd ..
	@make all  
