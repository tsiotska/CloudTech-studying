## Linux basic commands

```ls``` - Lists information about file(s)

```pwd``` - Prints the full filename of the current working directory

```clear``` - Clears terminal screen

```cd``` - Changes the current working directory

```pushd``` - Saves and then changes the current directory

```popd``` - Restores the previous value of the current directory

```file``` - Determines file type

```find``` - Searches for files that meet a desired criteria

```which``` - Searches the user's $path for a program file

```history``` - Shows commands history

```whatis``` - Searches the manual page names and displays the manual page descriptions of any name matched

```apropos``` - Searches Help manual pages (man -k)

```man``` - Help manual

```mkdir``` - Creates new folder(s)

```touch``` - Changes file timestamps

```cp``` - Copies one or more files to another location

```mv``` - Moves or rename files or directories

```rm``` - 	Removes files

```rmdir``` - Removes folder

```cut``` - Divide a file into several parts

```nano``` - is a small and friendly editor

```vim``` - is a highly configurable text editor

### Redirecting the Output

---

We use the > symbol to redirect the output of a command. For example, to create a file called list1 containing a list of
fruit, type

```cat > list1```

Then type in the names of some fruit. Press [Return] after each one.

```orange banana apple ^D (Control D to stop)```

What happens is the cat command reads the standard input (the keyboard) and the > redirects the output, which normally
goes to the screen, into a file called list1 To read the contents of the file, type

```cat list1```

---

```echo ``` - Displays the string(s) to output.

```sudo``` - allows a permitted user to execute a command as the superuser or another user, as specified by the security
policy.

```su``` - Allows to run commands with a substitute user and group ID.

```users``` - Lists users currently logged in

```who``` - Prints information about users who are currently logged in.

```id``` - Prints user and group id's

```watch``` - Executes/displays a program periodically

```free``` - Displays memory usage

```df``` - displays the amount of disk space available on the file system containing each file name argument.

```kill``` - Kills a process by specifying its PID

```ps``` - displays information about a selection of the active processes.

```top``` - Lists processes running on the system

```grep``` - Searches file(s) for lines that match a given pattern

```alias``` - Enables a replacement of a word by another string. It is mainly used for abbreviating a system command, or
for adding default arguments to a regularly used command.

```wc``` - Prints byte, word, and line counts

```uniq``` - Filter adjacent matching lines from INPUT, writing to OUTPUT.

```sort``` - Sort text files.

```diff``` - Display the differences between two files.

```awk``` - Find and Replace text, database sort/validate/index.

```printenv``` - Print environment variables.

