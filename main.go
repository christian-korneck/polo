package main

// #cgo pkg-config: python-3.8
// #include <Python.h>
import "C"
import (
	"fmt"
)

func main() {
	fmt.Println("-----------------------------------")
	fmt.Println("Python version via py C api:")
	C.Py_Initialize()
	fmt.Println(C.GoString(C.Py_GetVersion()))
	fmt.Println("-----------------------------------")
	fmt.Println("output from some python code:")

	pycode := `
import os
import sys
print("************************")
print("PATH env var:")
for path in os.environ['PATH'].split(";"):
  print(path)
print("************************")
print("Python Package Search Path:")
for path in sys.path:
  print(path)
print("************************")
`

	pycodeC := C.CString(pycode)

	C.PyRun_SimpleString(pycodeC)
	C.Py_Finalize()
	fmt.Println("-----------------------------------")
	//this would start an interactive python shell
	//C.Py_Main(0, nil)
}
