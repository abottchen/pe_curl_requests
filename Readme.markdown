# PE Curl Repo!

Using Puppet Enterprise APIs is easy, but I constantly forget the curl syntax
because I'm not a damn computer. I noticed prettymuch EVERYONE did the same,
so I made this repo for easy copy/paste-ability.  Some things to remember about
these scripts:

1. Most have a shebang at the top (`#!/bin/bash`) that are needed for
   them to be executable. Some do not. Add/remove/modify as need arises.
2. Most ARE NOT executable, but will need to be MADE EXECUTABLE to be executed
   (I'll leave that as an exercise to the reader, too).
3. Most need to be run as `root` to access the correct Puppet certs. If you
   get an error about unauthenticated RBAC access or authentication, check
   to make sure you're running as root.
4. Most have variables for the server you're hitting as well as a node name
   (if applicable). Some early scripts use `$(puppet config print server)`
   to target a server. I'm gonna err on the side of setting a server variable
   when I see any scripts using the old style.

Feel free to add more scripts but try to keep them organized (and feel free to
correct me when I mess it up too).
