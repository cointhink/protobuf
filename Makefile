.PHONY: elm go

all: elm go

elm: protos/*.proto
	protoc3/bin/protoc --elm_out=elm protos/*.proto

go: protos/*.proto
	protoc3/bin/protoc --go_out=go protos/*.proto
		#echo $^ | xargs -n1 protoc3/bin/protoc --go_out=g

protoc: protoc3 gen-elm gen-go
	wget --no-clobber https://github.com/google/protobuf/releases/download/v3.3.0/protoc-3.3.0-linux-x86_64.zip
	unzip -o protoc-3.3.0-linux-x86_64.zip -d protoc3
	rm protoc-3.3.0-linux-x86_64.zip

gen-elm: bin/protoc-gen-elm
	go get -u github.com/tiziano88/elm-protobuf

gen-go: bin/protoc-gen-go
	go get -u github.com/golang/protobuf/protoc-gen-go

