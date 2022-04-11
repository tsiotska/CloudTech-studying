<details>
<summary>Ubuntu and Kali as Windows subsystems installed</summary>

![](screenshots/Ubuntu.png)
<br/>
![](screenshots/Debian.png)
</details>
<br/>

<details>
<summary>
Established SSH connection with cleartext password authN
</summary>

#### Remote server
```diff
! Set PasswordAuth to Yes
```
![](screenshots/sshd_config.png)
<br/>
![](screenshots/ssh-server.png)
#### Client
![](screenshots/client_access.png)
</details>
<br/>

<details>
<summary>
Established SSH connection with public key
</summary>

#### Client
![](screenshots/scp_client.png)
<br/>

#### Remote server
![](screenshots/pubkey_server.png)
```diff
! It's important to create authorized_keys file containing keys
user@DESKTOP-V7R5J56:~/.ssh$ cat uploaded_key.pub >> authorized_keys
```
<br/>

![](screenshots/sshd_config2.png)

#### Client
![](screenshots/client_pubkey-access.png)
</details>
<br/>

<details>
<summary>
What is SSH port forwarding?
</summary>

<p>
SSH port forwarding is a mechanism in SSH for tunneling application ports from the client machine to the server machine, or vice versa. 
It can be used for adding encryption to legacy applications, going through firewalls,
and some system administrators and IT professionals use it for opening backdoors into the internal network from their home machines. 
It can also be abused by hackers and malware to open access from the Internet to the internal network.
</p>

![](screenshots/port-forwarding.png)
</details>

