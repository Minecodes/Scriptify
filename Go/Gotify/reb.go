package main

/**
 * Name: reboot
 * Alias: reb
 * Description: Reboots the device and sends an notification to the user.
 * Usage: reb
 * Permissions: root
 * OS: Linux, Darwin, Windows
 */

import (
	"fmt"
	"net/http"
	"net/url"
	"os/exec"
	"runtime"
	"syscall"
)

// Config:
var (
	gotifyURL 		string = "https://gotify.example.com"
	gotifyToken 	string = "token"
	gotifyTitle 	string = "Computer"
	gotifyMessage 	string = "Device rebooted"
)


func main() {
	if runtime.GOOS == "windows" {
		http.PostForm(gotifyURL + `/message?token=` + gotifyToken,
        url.Values{"message": {gotifyMessage}, "title": {gotifyTitle}})

		err := exec.Command("powershell", "-c", "Restart-Computer").Run()

		if err != nil {
			fmt.Println(err)
		}
	} else if runtime.GOOS == "darwin" {
		if syscall.Geteuid() != 0 {
			fmt.Println("You need to run this as root.")
			return
		}

		http.PostForm(gotifyURL + `/message?token=` + gotifyToken,
        url.Values{"message": {gotifyMessage}, "title": {gotifyTitle}})

		err := exec.Command("shutdown", "-r", "now").Run()

		if err != nil {
			fmt.Println(err)
		}
	} else if runtime.GOOS == "linux" {
		if syscall.Geteuid() != 0 {
			fmt.Println("You need to run this as root.")
			return
		}

		http.PostForm(gotifyURL + `/message?token=` + gotifyToken,
        url.Values{"message": {gotifyMessage}, "title": {gotifyTitle}})

		err := exec.Command("reboot", "now").Run()

		if err != nil {
			fmt.Println(err)
		}
	} else {
		fmt.Println("This command is not supported on this OS.")
		return
	}
}