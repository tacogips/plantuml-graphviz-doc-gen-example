## Example of document conversion using Plantuml and Graphviz

## Usage

Put your *.plantuml *.dot or *.md files to subdirectory in `/src` directory and run `make` command.
The output will be created in `out` directory

See `Makefile` for more details.
.
```shell

# convert only *.plantuml file
make gen-plantuml

# convert only *.dot file
make gen-dot

# copy files
make copy-file

# all
make all
```

## Dependencies
Thanks to

- https://hub.docker.com/r/think/plantuml
- https://hub.docker.com/r/nshine/dot
