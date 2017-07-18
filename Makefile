.PHONY: elm crystal go ocaml copy python

all: elm crystal go python

elm: proto/*.proto
	protoc3/bin/protoc --elm_out=elm $^

crystal: proto/*.proto
	protoc3/bin/protoc --crystal_out=crystal $^

go: proto/*.proto
	protoc3/bin/protoc --go_out=go $^

python: proto/*.proto
	protoc3/bin/protoc --python_out=python $^

ocaml: proto/*.proto
	for name in $^; do ocaml-protoc -ml_out ocaml $$name; done

copy:
	cp -r elm/Proto ../web-elm/src/
	cp -r go/proto ../api-go/src/cointhink

protoc: bin/protoc-gen-elm bin/protoc-gen-go
	wget --no-clobber https://github.com/google/protobuf/releases/download/v3.3.0/protoc-3.3.0-linux-x86_64.zip
	unzip -o protoc-3.3.0-linux-x86_64.zip -d protoc3
	rm protoc-3.3.0-linux-x86_64.zip

bin/protoc-gen-elm:
	GOPATH=`pwd` go get -u github.com/tiziano88/elm-protobuf/protoc-gen-elm
	GOPATH=`pwd` go build -o bin/protoc-gen-elm github.com/tiziano88/elm-protobuf/protoc-gen-elm

bin/protoc-gen-go:
	GOPATH=`pwd` go get -u github.com/golang/protobuf/protoc-gen-go

gen-ocaml:
	opam install ocaml-protoc
