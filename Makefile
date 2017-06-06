.PHONY: elm crystal go copy

all: elm crystal go

elm: proto/*.proto
	protoc3/bin/protoc --elm_out=elm $^

crystal: proto/*.proto
	protoc3/bin/protoc --crystal_out=crystal $^

go: proto/*.proto
	protoc3/bin/protoc --go_out=go $^
		#echo $^ | xargs -n1 protoc3/bin/protoc --go_out=g

copy:
	cp -r elm/Proto ../web-elm/src/
	cp -r go/proto ../api-go/src/cointhink

protoc: protoc3 gen-elm gen-go
	wget --no-clobber https://github.com/google/protobuf/releases/download/v3.3.0/protoc-3.3.0-linux-x86_64.zip
	unzip -o protoc-3.3.0-linux-x86_64.zip -d protoc3
	rm protoc-3.3.0-linux-x86_64.zip

gen-elm:
	go get -u github.com/donpdonp/elm-protobuf/protoc-gen-elm
	go build -o bin/protoc-gen-elm github.com/donpdonp/elm-protobuf/protoc-gen-elm

gen-go: bin/protoc-gen-go
	go get -u github.com/golang/protobuf/protoc-gen-go

