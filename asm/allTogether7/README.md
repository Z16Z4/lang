# File permissions

File modes specify the permissions for files. Essentially, they specify who is allowed to read, write, and /or execute the file. 

Modes are stored as a three-digit octal value (base-8)

File permissions in Linux are set with four octal values. The least 3 significant octal values are for the files owners permissions. The group permissions, and the others permissions (those outside the group and not the file owner).

The most significant octal vaule is reserved for special permissions. 

Usually we do not need to use these however these consit of sticky bits, setgid, set uid.

If we were to create a file that we wanted the file owner to be able to read and write, and the group and others to be able to only read it we would use the numbers 0644_8 (base - 8)