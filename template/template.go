:if search('<+CURSOR+>')
:  normal! "_da>
:endif
package main

import (
	"fmt"
	"os"
)

func main() {
	if err := _main(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}

func _main() error {
	<+CURSOR+>
	return nil
}

// vim: ff=unix
