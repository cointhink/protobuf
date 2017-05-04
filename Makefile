all: elm go

elm: protos/*.proto
	protoc3/bin/protoc --elm_out=e protos/*.proto

go: protos/*.proto
	protoc3/bin/protoc --go_out=g protos/*.proto
		#echo $^ | xargs -n1 protoc3/bin/protoc --go_out=g