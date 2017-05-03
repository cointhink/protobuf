all: elm go

elm:
	protoc3/bin/protoc --elm_out=e *.proto

go: *.proto
	echo $^ | xargs -n1 protoc3/bin/protoc --go_out=g