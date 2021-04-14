SRC_DIR=src
TARGET_DIRS=example1
OUTPUT_DIR=out
COPY_EXTS=md sql png jpg

gen-docs:
	@for each_dir in ${TARGET_DIRS}; do \
		echo "${OUTPUT_DIR}/$$each_dir" ; \
		[ -d "${OUTPUT_DIR}/$$each_dir" ] || mkdir -p ${SRC_DIR}/$${each_dir}; \
		for each_uml in ${SRC_DIR}/$$each_dir/*.plantuml; do \
			[ -f "$$each_uml" ] || continue; \
			echo "converting $$each_uml in $$each_dir"; \
			cat $$each_uml | docker run --rm -i think/plantuml -tsvg >  ${OUTPUT_DIR}/$$each_dir/$$(basename "$$each_uml" .plantuml).svg; \
		done; \
	done




