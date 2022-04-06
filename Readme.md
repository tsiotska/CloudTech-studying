<details>
<summary>Ubuntu and Kali as Windows subsystems installed</summary>

![](screenshoots/Ubuntu.png)&nbsp;
![](screenshoots/Debian.png)
</details>
&nbsp;

<details>
<summary>
Established SSH connection with cleartext password authN
</summary>

#### Remote server
```diff
! Set PasswordAuth to Yes
```
![](screenshoots/sshd_config.png)&nbsp;
![](screenshoots/ssh-server.png)
#### Client
![](screenshoots/client_access.png)
</details>
&nbsp;

<details>
<summary>
Established SSH connection with public key
</summary>

#### Client
![](screenshoots/scp_client.png)&nbsp;

#### Remote server
![](screenshoots/pubkey_server.png)
```diff
! It's important to create authorized_keys file containing keys
user@DESKTOP-V7R5J56:~/.ssh$ cat uploaded_key.pub >> authorized_keys
```
&nbsp;
![](screenshoots/sshd_config2.png)

#### Client
![](screenshoots/client_pubkey-access.png)
</details>
