<details>
<summary>Ubuntu and Kali as Windows subsystems installed</summary>

![](screenshoots/Ubuntu.png)
<br/>
![](screenshoots/Debian.png)
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
![](screenshoots/sshd_config.png)
<br/>
![](screenshoots/ssh-server.png)
#### Client
![](screenshoots/client_access.png)
</details>
<br/>

<details>
<summary>
Established SSH connection with public key
</summary>

#### Client
![](screenshoots/scp_client.png)
<br/>

#### Remote server
![](screenshoots/pubkey_server.png)
```diff
! It's important to create authorized_keys file containing keys
user@DESKTOP-V7R5J56:~/.ssh$ cat uploaded_key.pub >> authorized_keys
```
<br/>
![](screenshoots/sshd_config2.png)

#### Client
![](screenshoots/client_pubkey-access.png)
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

![](screenshoots/port-forwarding.png)
</details>

