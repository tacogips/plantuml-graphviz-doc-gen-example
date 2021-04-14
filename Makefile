SRC_DIR=src
TARGET_DIRS=example1
OUTPUT_DIR=out
COPY_EXTS=md sql png jpg
UML_IMG_EXT=png
DOT_IMG_EXT=png

gen-plantuml:
	@for each_dir in ${TARGET_DIRS}; do \
		if [ ! -d "${OUTPUT_DIR}/$$each_dir" ]; then \
	 		echo "creating ${OUTPUT_DIR}/$${each_dir}"; \
	 		mkdir -p ${OUTPUT_DIR}/$${each_dir}; \
		fi; \
		for each_uml in ${SRC_DIR}/$$each_dir/*.plantuml; do \
			[ -f "$$each_uml" ] || continue; \
			echo "converting $$each_uml in $$each_dir"; \
			cat $$each_uml | docker run --rm -i think/plantuml -t${UML_IMG_EXT} >  ${OUTPUT_DIR}/$$each_dir/$$(basename "$$each_uml" .plantuml).${UML_IMG_EXT}; \
		done; \
	done


gen-dot:
	@for each_dir in ${TARGET_DIRS}; do \
		if [ ! -d "${OUTPUT_DIR}/$$each_dir" ]; then \
	 		echo "creating ${OUTPUT_DIR}/$${each_dir}"; \
	 		mkdir -p ${OUTPUT_DIR}/$${each_dir}; \
		fi; \
		for each_dot in ${SRC_DIR}/$$each_dir/*.dot; do \
			[ -f "$$each_dot" ] || continue; \
			echo "converting $$each_dot in $$each_dir"; \
			cat $$each_dot | docker run --rm -i nshine/dot dot -T${DOT_IMG_EXT} >  ${OUTPUT_DIR}/$$each_dir/$$(basename "$$each_dot" .dot).${DOT_IMG_EXT}; \
		done; \
	done



copy-file:
	@for each_dir in ${TARGET_DIRS}; do \
		if [ ! -d "${OUTPUT_DIR}/$$each_dir" ]; then \
	 		echo "creating ${OUTPUT_DIR}/$${each_dir}"; \
	 		mkdir -p ${OUTPUT_DIR}/$${each_dir}; \
		fi; \
		for each_ext in ${COPY_EXTS}; do \
			for each_file in ${SRC_DIR}/$$each_dir/*.$$each_ext ; do \
				[ -f "$$each_file" ] || continue; \
				echo "copying $$each_file in $$each_dir"; \
				cp $${each_file} ${OUTPUT_DIR}/$$each_dir/$$(basename "$$each_file"); \
			done; \
		done; \
	done



all: gen-plantuml gen-dot copy-file
