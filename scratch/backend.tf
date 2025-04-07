fatal: [ip-10-0-1-10.eu-central-1.compute.internal]: FAILED! => {"changed": true, "msg": "non-zero return code"
 "rc": 127, "stderr": "OpenSSH_8.9p1 Ubuntu-3ubuntu0.11, OpenSSL 3.0.2 15 Mar 2022
debug1: Reading configuration data /etc/ssh/ssh_config
debug1: /etc/ssh/ssh_config line 19: include /etc/ssh/ssh_config.d/*.conf matched no files
debug1: /etc/ssh/ssh_config line 21: Applying options for *
debug2: resolve_canonicalize: hostname 10.0.1.10 is address
debug1: auto-mux: Trying existing master
debug1: Control socket \"/home/reseke/.ansible/cp/7a8b62d733\" does not exist
debug1: Executing proxy command: exec ssh -W 10.0.1.10:22 -i /home/reseke/.ssh/lustretest ec2-user@18.199.81.57
debug1: identity file /home/reseke/.ssh/id_rsa type 0
debug1: identity file /home/reseke/.ssh/id_rsa-cert type -1
debug1: identity file /home/reseke/.ssh/id_ecdsa type -1
debug1: identity file /home/reseke/.ssh/id_ecdsa-cert type -1
debug1: identity file /home/reseke/.ssh/id_ecdsa_sk type -1
debug1: identity file /home/reseke/.ssh/id_ecdsa_sk-cert type -1
debug1: identity file /home/reseke/.ssh/id_ed25519 type -1
debug1: identity file /home/reseke/.ssh/id_ed25519-cert type -1
debug1: identity file /home/reseke/.ssh/id_ed25519_sk type -1
debug1: identity file /home/reseke/.ssh/id_ed25519_sk-cert type -1
debug1: identity file /home/reseke/.ssh/id_xmss type -1
debug1: identity file /home/reseke/.ssh/id_xmss-cert type -1
debug1: identity file /home/reseke/.ssh/id_dsa type -1
debug1: identity file /home/reseke/.ssh/id_dsa-cert type -1
debug1: Local version string SSH-2.0-OpenSSH_8.9p1 Ubuntu-3ubuntu0.11
debug1: Remote protocol version 2.0, remote software version OpenSSH_8.0
debug1: compat_banner: match: OpenSSH_8.0 pat OpenSSH* compat 0x04000000
debug2: fd 5 setting O_NONBLOCK
debug2: fd 4 setting O_NONBLOCK
debug1: Authenticating to 10.0.1.10:22 as 'ec2-user'
debug1: load_hostkeys: fopen /home/reseke/.ssh/known_hosts2: No such file or directory
debug1: load_hostkeys: fopen /etc/ssh/ssh_known_hosts: No such file or directory
debug1: load_hostkeys: fopen /etc/ssh/ssh_known_hosts2: No such file or directory
debug1: SSH2_MSG_KEXINIT sent
debug1: SSH2_MSG_KEXINIT received
debug2: local client KEXINIT proposal
debug2: KEX algorithms: curve25519-sha256,curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,sntrup761x25519-sha512@openssh.com,diffie-hellman-group-exchange-sha256,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512,diffie-hellman-group14-sha256,ext-info-c,kex-strict-c-v00@openssh.com
debug2: host key algorithms: ssh-ed25519-cert-v01@openssh.com,ecdsa-sha2-nistp256-cert-v01@openssh.com,ecdsa-sha2-nistp384-cert-v01@openssh.com,ecdsa-sha2-nistp521-cert-v01@openssh.com,sk-ssh-ed25519-cert-v01@openssh.com,sk-ecdsa-sha2-nistp256-cert-v01@openssh.com,rsa-sha2-512-cert-v01@openssh.com,rsa-sha2-256-cert-v01@openssh.com,ssh-ed25519,ecdsa-sha2-nistp256,ecdsa-sha2-nistp384,ecdsa-sha2-nistp521,sk-ssh-ed25519@openssh.com,sk-ecdsa-sha2-nistp256@openssh.com,rsa-sha2-512,rsa-sha2-256
debug2: ciphers ctos: chacha20-poly1305@openssh.com,aes128-ctr,aes192-ctr,aes256-ctr,aes128-gcm@openssh.com,aes256-gcm@openssh.com
debug2: ciphers stoc: chacha20-poly1305@openssh.com,aes128-ctr,aes192-ctr,aes256-ctr,aes128-gcm@openssh.com,aes256-gcm@openssh.com
debug2: MACs ctos: umac-64-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,hmac-sha1-etm@openssh.com,umac-64@openssh.com,umac-128@openssh.com,hmac-sha2-256,hmac-sha2-512,hmac-sha1
debug2: MACs stoc: umac-64-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,hmac-sha1-etm@openssh.com,umac-64@openssh.com,umac-128@openssh.com,hmac-sha2-256,hmac-sha2-512,hmac-sha1
debug2: compression ctos: none,zlib@openssh.com,zlib
debug2: compression stoc: none,zlib@openssh.com,zlib
debug2: languages ctos: 
debug2: languages stoc: 
debug2: first_kex_follows 0 
debug2: reserved 0 
debug2: peer server KEXINIT proposal
debug2: KEX algorithms: curve25519-sha256,curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512,diffie-hellman-group14-sha256,diffie-hellman-group14-sha1,kex-strict-s-v00@openssh.com
debug2: host key algorithms: rsa-sha2-512,rsa-sha2-256,ssh-rsa,ecdsa-sha2-nistp256,ssh-ed25519
debug2: ciphers ctos: chacha20-poly1305@openssh.com,aes128-ctr,aes192-ctr,aes256-ctr,aes128-gcm@openssh.com,aes256-gcm@openssh.com
debug2: ciphers stoc: chacha20-poly1305@openssh.com,aes128-ctr,aes192-ctr,aes256-ctr,aes128-gcm@openssh.com,aes256-gcm@openssh.com
debug2: MACs ctos: umac-64-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,hmac-sha1-etm@openssh.com,umac-64@openssh.com,umac-128@openssh.com,hmac-sha2-256,hmac-sha2-512,hmac-sha1
debug2: MACs stoc: umac-64-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,hmac-sha1-etm@openssh.com,umac-64@openssh.com,umac-128@openssh.com,hmac-sha2-256,hmac-sha2-512,hmac-sha1
debug2: compression ctos: none,zlib@openssh.com
debug2: compression stoc: none,zlib@openssh.com
debug2: languages ctos: 
debug2: languages stoc: 
debug2: first_kex_follows 0 
debug2: reserved 0 
debug1: kex: algorithm: curve25519-sha256
debug1: kex: host key algorithm: ssh-ed25519
debug1: kex: server->client cipher: chacha20-poly1305@openssh.com MAC: <implicit> compression: none
debug1: kex: client->server cipher: chacha20-poly1305@openssh.com MAC: <implicit> compression: none
debug1: expecting SSH2_MSG_KEX_ECDH_REPLY
debug1: SSH2_MSG_KEX_ECDH_REPLY received
debug1: Server host key: ssh-ed25519 SHA256:YMXsq6Vt5l+7YjRIuNvXqvo6H/CWJdcGCFqr3lvWxZE
debug1: load_hostkeys: fopen /home/reseke/.ssh/known_hosts2: No such file or directory
debug1: load_hostkeys: fopen /etc/ssh/ssh_known_hosts: No such file or directory
debug1: load_hostkeys: fopen /etc/ssh/ssh_known_hosts2: No such file or directory
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the ED25519 key sent by the remote host is\nSHA256:YMXsq6Vt5l+7YjRIuNvXqvo6H/CWJdcGCFqr3lvWxZE.
Please contact your system administrator.
Add correct host key in /home/reseke/.ssh/known_hosts to get rid of this message.
Offending ECDSA key in /home/reseke/.ssh/known_hosts:61
  remove with:
  ssh-keygen -f \"/home/reseke/.ssh/known_hosts\" -R \"10.0.1.10\"
UpdateHostkeys is disabled because the host key is not trusted.
debug1: ssh_packet_send2_wrapped: resetting send seqnr 3
debug2: ssh_set_newkeys: mode 1
debug1: rekey out after 134217728 blocks
debug1: SSH2_MSG_NEWKEYS sent
debug1: expecting SSH2_MSG_NEWKEYS
debug1: ssh_packet_read_poll2: resetting read seqnr 3
debug1: SSH2_MSG_NEWKEYS received
debug2: ssh_set_newkeys: mode 0
debug1: rekey in after 134217728 blocks
debug1: get_agent_identities: bound agent to hostkey
debug1: get_agent_identities: ssh_fetch_identitylist: agent contains no identities
debug1: Will attempt key: /home/reseke/.ssh/id_rsa RSA SHA256:xgtiZQeKDCMFk9pUzV9DQJysklfINzJ1ATRBXK+cWs0
debug1: Will attempt key: /home/reseke/.ssh/id_ecdsa 
debug1: Will attempt key: /home/reseke/.ssh/id_ecdsa_sk 
debug1: Will attempt key: /home/reseke/.ssh/id_ed25519 
debug1: Will attempt key: /home/reseke/.ssh/id_ed25519_sk 
debug1: Will attempt key: /home/reseke/.ssh/id_xmss 
debug1: Will attempt key: /home/reseke/.ssh/id_dsa 
debug2: pubkey_prepare: done
debug1: SSH2_MSG_EXT_INFO received
debug1: kex_input_ext_info: server-sig-algs=<ssh-ed25519,ssh-rsa,rsa-sha2-256,rsa-sha2-512,ssh-dss,ecdsa-sha2-nistp256,ecdsa-sha2-nistp384,ecdsa-sha2-nistp521>
debug2: service_accept: ssh-userauth
debug1: SSH2_MSG_SERVICE_ACCEPT received
debug1: Authentications that can continue: publickey,gssapi-keyex,gssapi-with-mic
debug1: Next authentication method: gssapi-with-mic
debug1: No credentials were supplied, or the credentials were unavailable or inaccessible\nNo Kerberos credentials available (default cache: FILE:/tmp/krb5cc_1000)\n\n
debug1: No credentials were supplied, or the credentials were unavailable or inaccessible\nNo Kerberos credentials available (default cache: FILE:/tmp/krb5cc_1000)\n\n
debug2: we did not send a packet, disable method
debug1: Next authentication method: publickey
debug1: Offering public key: /home/reseke/.ssh/id_rsa RSA SHA256:xgtiZQeKDCMFk9pUzV9DQJysklfINzJ1ATRBXK+cWs0
debug2: we sent a publickey packet, wait for reply
debug1: Server accepts key: /home/reseke/.ssh/id_rsa RSA SHA256:xgtiZQeKDCMFk9pUzV9DQJysklfINzJ1ATRBXK+cWs0
Authenticated to 10.0.1.10 (via proxy) using \"publickey\".
debug1: setting up multiplex master socket
debug2: fd 3 setting O_NONBLOCK
debug1: channel 0: new [/home/reseke/.ansible/cp/7a8b62d733]
debug1: control_persist_detach: backgrounding master process
debug2: control_persist_detach: background process is 3015231
debug2: fd 3 setting O_NONBLOCK
debug1: forking to background
debug1: Entering interactive session.
debug1: pledge: id
debug2: set_control_persist_exit_time: schedule exit in 60 seconds
debug1: multiplexing control connection
debug2: fd 6 setting O_NONBLOCK
debug1: channel 1: new [mux-control]
debug2: set_control_persist_exit_time: cancel scheduled exit
debug2: mux_master_process_hello: channel 1 client version 4
debug2: mux_client_hello_exchange: master version 4
debug2: mux_master_process_alive_check: channel 1: alive check
debug2: mux_master_process_new_session: channel 1: request tty 1, X 0, agent 0, subsys 0, term \"xterm-256color\"
 cmd \"'sudo scp ec2-user$:./python38 ec2_user@\"10.0.1.10\":.' \n\"
 env 9
debug1: channel 2: new [client-session]
debug2: mux_master_process_new_session: channel_new: 2 linked to control channel 1
debug2: channel 2: send open
debug1: client_input_global_request: rtype hostkeys-00@openssh.com want_reply 0
debug1: Remote: /home/ec2-user/.ssh/authorized_keys:1: key options: agent-forwarding port-forwarding pty user-rc x11-forwarding
debug1: Remote: /home/ec2-user/.ssh/authorized_keys:1: key options: agent-forwarding port-forwarding pty user-rc x11-forwarding
debug2: channel_input_open_confirmation: channel 2: callback start
debug2: client_session2_setup: id 2
debug2: channel 2: request pty-req confirm 1
debug1: Sending environment.
debug1: channel 2: setting env LC_ADDRESS = \"de_DE.UTF-8\"
debug2: channel 2: request env confirm 0
debug1: channel 2: setting env LC_NAME = \"de_DE.UTF-8\"
debug2: channel 2: request env confirm 0
debug1: channel 2: setting env LC_MONETARY = \"de_DE.UTF-8\"
debug2: channel 2: request env confirm 0
debug1: channel 2: setting env LC_PAPER = \"de_DE.UTF-8\"
debug2: channel 2: request env confirm 0
debug1: channel 2: setting env LANG = \"en_US.UTF-8\"
debug2: channel 2: request env confirm 0
debug1: channel 2: setting env LC_IDENTIFICATION = \"de_DE.UTF-8\"
debug2: channel 2: request env confirm 0
debug1: channel 2: setting env LC_TELEPHONE = \"de_DE.UTF-8\"
debug2: channel 2: request env confirm 0
debug1: channel 2: setting env LC_MEASUREMENT = \"de_DE.UTF-8\"
debug2: channel 2: request env confirm 0
debug1: channel 2: setting env LC_NUMERIC = \"de_DE.UTF-8\"
debug2: channel 2: request env confirm 0
debug1: Sending command: 'sudo scp ec2-user$:./python38 ec2_user@\"10.0.1.10\":.' \n
debug2: channel 2: request exec confirm 1
debug2: channel_input_open_confirmation: channel 2: callback done
debug2: channel 2: open confirm rwindow 0 rmax 32768
debug1: mux_client_request_session: master session id: 2
debug2: channel_input_status_confirm: type 99 id 2
debug2: PTY allocation request accepted on channel 2
debug2: channel 2: rcvd adjust 2097152
debug2: channel_input_status_confirm: type 99 id 2
debug2: exec request accepted on channel 2
debug2: channel 2: rcvd eof
debug2: channel 2: output open -> drain
debug1: client_input_channel_req: channel 2 rtype exit-status reply 0
debug1: client_input_channel_req: channel 2 rtype eow@openssh.com reply 0
debug2: channel 2: rcvd eow
debug2: chan_shutdown_read: channel 2: (i0 o1 sock -1 wfd 7 efd 9 [write])
debug2: channel 2: input open -> closed
debug2: channel 2: rcvd close
debug2: channel 2: obuf empty
debug2: chan_shutdown_write: channel 2: (i3 o1 sock -1 wfd 8 efd 9 [write])
debug2: channel 2: output drain -> closed
debug2: channel 2: send close
debug2: channel 2: is dead
debug2: channel 2: gc: notify user
debug2: channel 1: rcvd close
debug2: channel 1: output open -> drain
debug2: chan_shutdown_read: channel 1: (i0 o1 sock 6 wfd 6 efd -1 [closed])
debug2: channel 1: input open -> closed
debug2: channel 2: gc: user detached
debug2: channel 2: is dead
debug2: channel 2: garbage collecting
debug1: channel 2: free: client-session, nchannels 3
debug2: channel 1: obuf empty
debug2: chan_shutdown_write: channel 1: (i3 o1 sock 6 wfd 6 efd -1 [closed])
debug2: channel 1: output drain -> closed
debug2: channel 1: is dead (local)
debug2: channel 1: gc: notify user
debug2: channel 1: gc: user detached
debug2: channel 1: is dead (local)
debug2: channel 1: garbage collecting
debug1: channel 1: free: mux-control, nchannels 2
debug2: Received exit status from master 127
debug2: set_control_persist_exit_time: schedule exit in 60 seconds
Shared connection to 10.0.1.10 closed.
"
 "stderr_lines": ["OpenSSH_8.9p1 Ubuntu-3ubuntu0.11, OpenSSL 3.0.2 15 Mar 2022"
 "debug1: Reading configuration data /etc/ssh/ssh_config"
 "debug1: /etc/ssh/ssh_config line 19: include /etc/ssh/ssh_config.d/*.conf matched no files"
 "debug1: /etc/ssh/ssh_config line 21: Applying options for *"
 "debug2: resolve_canonicalize: hostname 10.0.1.10 is address"
 "debug1: auto-mux: Trying existing master"
 "debug1: Control socket \"/home/reseke/.ansible/cp/7a8b62d733\" does not exist"
 "debug1: Executing proxy command: exec ssh -W 10.0.1.10:22 -i /home/reseke/.ssh/lustretest ec2-user@18.199.81.57"
 "debug1: identity file /home/reseke/.ssh/id_rsa type 0"
 "debug1: identity file /home/reseke/.ssh/id_rsa-cert type -1"
 "debug1: identity file /home/reseke/.ssh/id_ecdsa type -1"
 "debug1: identity file /home/reseke/.ssh/id_ecdsa-cert type -1"
 "debug1: identity file /home/reseke/.ssh/id_ecdsa_sk type -1"
 "debug1: identity file /home/reseke/.ssh/id_ecdsa_sk-cert type -1"
 "debug1: identity file /home/reseke/.ssh/id_ed25519 type -1"
 "debug1: identity file /home/reseke/.ssh/id_ed25519-cert type -1"
 "debug1: identity file /home/reseke/.ssh/id_ed25519_sk type -1"
 "debug1: identity file /home/reseke/.ssh/id_ed25519_sk-cert type -1"
 "debug1: identity file /home/reseke/.ssh/id_xmss type -1"
 "debug1: identity file /home/reseke/.ssh/id_xmss-cert type -1"
 "debug1: identity file /home/reseke/.ssh/id_dsa type -1"
 "debug1: identity file /home/reseke/.ssh/id_dsa-cert type -1"
 "debug1: Local version string SSH-2.0-OpenSSH_8.9p1 Ubuntu-3ubuntu0.11"
 "debug1: Remote protocol version 2.0, remote software version OpenSSH_8.0"
 "debug1: compat_banner: match: OpenSSH_8.0 pat OpenSSH* compat 0x04000000"
 "debug2: fd 5 setting O_NONBLOCK"
 "debug2: fd 4 setting O_NONBLOCK"
 "debug1: Authenticating to 10.0.1.10:22 as 'ec2-user'"
 "debug1: load_hostkeys: fopen /home/reseke/.ssh/known_hosts2: No such file or directory"
 "debug1: load_hostkeys: fopen /etc/ssh/ssh_known_hosts: No such file or directory"
 "debug1: load_hostkeys: fopen /etc/ssh/ssh_known_hosts2: No such file or directory"
 "debug1: SSH2_MSG_KEXINIT sent"
 "debug1: SSH2_MSG_KEXINIT received"
 "debug2: local client KEXINIT proposal"
 "debug2: KEX algorithms: curve25519-sha256,curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,sntrup761x25519-sha512@openssh.com,diffie-hellman-group-exchange-sha256,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512,diffie-hellman-group14-sha256,ext-info-c,kex-strict-c-v00@openssh.com"
 "debug2: host key algorithms: ssh-ed25519-cert-v01@openssh.com,ecdsa-sha2-nistp256-cert-v01@openssh.com,ecdsa-sha2-nistp384-cert-v01@openssh.com,ecdsa-sha2-nistp521-cert-v01@openssh.com,sk-ssh-ed25519-cert-v01@openssh.com,sk-ecdsa-sha2-nistp256-cert-v01@openssh.com,rsa-sha2-512-cert-v01@openssh.com,rsa-sha2-256-cert-v01@openssh.com,ssh-ed25519,ecdsa-sha2-nistp256,ecdsa-sha2-nistp384,ecdsa-sha2-nistp521,sk-ssh-ed25519@openssh.com,sk-ecdsa-sha2-nistp256@openssh.com,rsa-sha2-512,rsa-sha2-256"
 "debug2: ciphers ctos: chacha20-poly1305@openssh.com,aes128-ctr,aes192-ctr,aes256-ctr,aes128-gcm@openssh.com,aes256-gcm@openssh.com"
 "debug2: ciphers stoc: chacha20-poly1305@openssh.com,aes128-ctr,aes192-ctr,aes256-ctr,aes128-gcm@openssh.com,aes256-gcm@openssh.com"
 "debug2: MACs ctos: umac-64-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,hmac-sha1-etm@openssh.com,umac-64@openssh.com,umac-128@openssh.com,hmac-sha2-256,hmac-sha2-512,hmac-sha1"
 "debug2: MACs stoc: umac-64-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,hmac-sha1-etm@openssh.com,umac-64@openssh.com,umac-128@openssh.com,hmac-sha2-256,hmac-sha2-512,hmac-sha1"
 "debug2: compression ctos: none,zlib@openssh.com,zlib"
 "debug2: compression stoc: none,zlib@openssh.com,zlib"
 "debug2: languages ctos: "
 "debug2: languages stoc: "
 "debug2: first_kex_follows 0 "
 "debug2: reserved 0 "
 "debug2: peer server KEXINIT proposal"
 "debug2: KEX algorithms: curve25519-sha256,curve25519-sha256@libssh.org,ecdh-sha2-nistp256,ecdh-sha2-nistp384,ecdh-sha2-nistp521,diffie-hellman-group-exchange-sha256,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512,diffie-hellman-group14-sha256,diffie-hellman-group14-sha1,kex-strict-s-v00@openssh.com"
 "debug2: host key algorithms: rsa-sha2-512,rsa-sha2-256,ssh-rsa,ecdsa-sha2-nistp256,ssh-ed25519"
 "debug2: ciphers ctos: chacha20-poly1305@openssh.com,aes128-ctr,aes192-ctr,aes256-ctr,aes128-gcm@openssh.com,aes256-gcm@openssh.com"
 "debug2: ciphers stoc: chacha20-poly1305@openssh.com,aes128-ctr,aes192-ctr,aes256-ctr,aes128-gcm@openssh.com,aes256-gcm@openssh.com"
 "debug2: MACs ctos: umac-64-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,hmac-sha1-etm@openssh.com,umac-64@openssh.com,umac-128@openssh.com,hmac-sha2-256,hmac-sha2-512,hmac-sha1"
 "debug2: MACs stoc: umac-64-etm@openssh.com,umac-128-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512-etm@openssh.com,hmac-sha1-etm@openssh.com,umac-64@openssh.com,umac-128@openssh.com,hmac-sha2-256,hmac-sha2-512,hmac-sha1"
 "debug2: compression ctos: none,zlib@openssh.com"
 "debug2: compression stoc: none,zlib@openssh.com"
 "debug2: languages ctos: "
 "debug2: languages stoc: "
 "debug2: first_kex_follows 0 "
 "debug2: reserved 0 "
 "debug1: kex: algorithm: curve25519-sha256"
 "debug1: kex: host key algorithm: ssh-ed25519"
 "debug1: kex: server->client cipher: chacha20-poly1305@openssh.com MAC: <implicit> compression: none"
 "debug1: kex: client->server cipher: chacha20-poly1305@openssh.com MAC: <implicit> compression: none"
 "debug1: expecting SSH2_MSG_KEX_ECDH_REPLY"
 "debug1: SSH2_MSG_KEX_ECDH_REPLY received"
 "debug1: Server host key: ssh-ed25519 SHA256:YMXsq6Vt5l+7YjRIuNvXqvo6H/CWJdcGCFqr3lvWxZE"
 "debug1: load_hostkeys: fopen /home/reseke/.ssh/known_hosts2: No such file or directory"
 "debug1: load_hostkeys: fopen /etc/ssh/ssh_known_hosts: No such file or directory"
 "debug1: load_hostkeys: fopen /etc/ssh/ssh_known_hosts2: No such file or directory"
 "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
 "@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @"
 "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
 "IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!"
 "Someone could be eavesdropping on you right now (man-in-the-middle attack)!"
 "It is also possible that a host key has just been changed."
 "The fingerprint for the ED25519 key sent by the remote host is"
 "SHA256:YMXsq6Vt5l+7YjRIuNvXqvo6H/CWJdcGCFqr3lvWxZE."
 "Please contact your system administrator."
 "Add correct host key in /home/reseke/.ssh/known_hosts to get rid of this message."
 "Offending ECDSA key in /home/reseke/.ssh/known_hosts:61"
 "  remove with:"
 "  ssh-keygen -f \"/home/reseke/.ssh/known_hosts\" -R \"10.0.1.10\""
 "UpdateHostkeys is disabled because the host key is not trusted."
 "debug1: ssh_packet_send2_wrapped: resetting send seqnr 3"
 "debug2: ssh_set_newkeys: mode 1"
 "debug1: rekey out after 134217728 blocks"
 "debug1: SSH2_MSG_NEWKEYS sent"
 "debug1: expecting SSH2_MSG_NEWKEYS"
 "debug1: ssh_packet_read_poll2: resetting read seqnr 3"
 "debug1: SSH2_MSG_NEWKEYS received"
 "debug2: ssh_set_newkeys: mode 0"
 "debug1: rekey in after 134217728 blocks"
 "debug1: get_agent_identities: bound agent to hostkey"
 "debug1: get_agent_identities: ssh_fetch_identitylist: agent contains no identities"
 "debug1: Will attempt key: /home/reseke/.ssh/id_rsa RSA SHA256:xgtiZQeKDCMFk9pUzV9DQJysklfINzJ1ATRBXK+cWs0"
 "debug1: Will attempt key: /home/reseke/.ssh/id_ecdsa "
 "debug1: Will attempt key: /home/reseke/.ssh/id_ecdsa_sk "
 "debug1: Will attempt key: /home/reseke/.ssh/id_ed25519 "
 "debug1: Will attempt key: /home/reseke/.ssh/id_ed25519_sk "
 "debug1: Will attempt key: /home/reseke/.ssh/id_xmss "
 "debug1: Will attempt key: /home/reseke/.ssh/id_dsa "
 "debug2: pubkey_prepare: done"
 "debug1: SSH2_MSG_EXT_INFO received"
 "debug1: kex_input_ext_info: server-sig-algs=<ssh-ed25519,ssh-rsa,rsa-sha2-256,rsa-sha2-512,ssh-dss,ecdsa-sha2-nistp256,ecdsa-sha2-nistp384,ecdsa-sha2-nistp521>"
 "debug2: service_accept: ssh-userauth"
 "debug1: SSH2_MSG_SERVICE_ACCEPT received"
 "debug1: Authentications that can continue: publickey,gssapi-keyex,gssapi-with-mic"
 "debug1: Next authentication method: gssapi-with-mic"
 "debug1: No credentials were supplied, or the credentials were unavailable or inaccessible"
 "No Kerberos credentials available (default cache: FILE:/tmp/krb5cc_1000)"
 ""
 ""
 "debug1: No credentials were supplied, or the credentials were unavailable or inaccessible"
 "No Kerberos credentials available (default cache: FILE:/tmp/krb5cc_1000)"
 ""
 ""
 "debug2: we did not send a packet, disable method"
 "debug1: Next authentication method: publickey"
 "debug1: Offering public key: /home/reseke/.ssh/id_rsa RSA SHA256:xgtiZQeKDCMFk9pUzV9DQJysklfINzJ1ATRBXK+cWs0"
 "debug2: we sent a publickey packet, wait for reply"
 "debug1: Server accepts key: /home/reseke/.ssh/id_rsa RSA SHA256:xgtiZQeKDCMFk9pUzV9DQJysklfINzJ1ATRBXK+cWs0"
 "Authenticated to 10.0.1.10 (via proxy) using \"publickey\"."
 "debug1: setting up multiplex master socket"
 "debug2: fd 3 setting O_NONBLOCK"
 "debug1: channel 0: new [/home/reseke/.ansible/cp/7a8b62d733]"
 "debug1: control_persist_detach: backgrounding master process"
 "debug2: control_persist_detach: background process is 3015231"
 "debug2: fd 3 setting O_NONBLOCK"
 "debug1: forking to background"
 "debug1: Entering interactive session."
 "debug1: pledge: id"
 "debug2: set_control_persist_exit_time: schedule exit in 60 seconds"
 "debug1: multiplexing control connection"
 "debug2: fd 6 setting O_NONBLOCK"
 "debug1: channel 1: new [mux-control]"
 "debug2: set_control_persist_exit_time: cancel scheduled exit"
 "debug2: mux_master_process_hello: channel 1 client version 4"
 "debug2: mux_client_hello_exchange: master version 4"
 "debug2: mux_master_process_alive_check: channel 1: alive check"
 "debug2: mux_master_process_new_session: channel 1: request tty 1, X 0, agent 0, subsys 0, term \"xterm-256color\"
 cmd \"'sudo scp ec2-user$:./python38 ec2_user@\"10.0.1.10\":.' "
 "\"
 env 9"
 "debug1: channel 2: new [client-session]"
 "debug2: mux_master_process_new_session: channel_new: 2 linked to control channel 1"
 "debug2: channel 2: send open"
 "debug1: client_input_global_request: rtype hostkeys-00@openssh.com want_reply 0"
 "debug1: Remote: /home/ec2-user/.ssh/authorized_keys:1: key options: agent-forwarding port-forwarding pty user-rc x11-forwarding"
 "debug1: Remote: /home/ec2-user/.ssh/authorized_keys:1: key options: agent-forwarding port-forwarding pty user-rc x11-forwarding"
 "debug2: channel_input_open_confirmation: channel 2: callback start"
 "debug2: client_session2_setup: id 2"
 "debug2: channel 2: request pty-req confirm 1"
 "debug1: Sending environment."
 "debug1: channel 2: setting env LC_ADDRESS = \"de_DE.UTF-8\""
 "debug2: channel 2: request env confirm 0"
 "debug1: channel 2: setting env LC_NAME = \"de_DE.UTF-8\""
 "debug2: channel 2: request env confirm 0"
 "debug1: channel 2: setting env LC_MONETARY = \"de_DE.UTF-8\""
 "debug2: channel 2: request env confirm 0"
 "debug1: channel 2: setting env LC_PAPER = \"de_DE.UTF-8\""
 "debug2: channel 2: request env confirm 0"
 "debug1: channel 2: setting env LANG = \"en_US.UTF-8\""
 "debug2: channel 2: request env confirm 0"
 "debug1: channel 2: setting env LC_IDENTIFICATION = \"de_DE.UTF-8\""
 "debug2: channel 2: request env confirm 0"
 "debug1: channel 2: setting env LC_TELEPHONE = \"de_DE.UTF-8\""
 "debug2: channel 2: request env confirm 0"
 "debug1: channel 2: setting env LC_MEASUREMENT = \"de_DE.UTF-8\""
 "debug2: channel 2: request env confirm 0"
 "debug1: channel 2: setting env LC_NUMERIC = \"de_DE.UTF-8\""
 "debug2: channel 2: request env confirm 0"
 "debug1: Sending command: 'sudo scp ec2-user$:./python38 ec2_user@\"10.0.1.10\":.' "
 ""
 "debug2: channel 2: request exec confirm 1"
 "debug2: channel_input_open_confirmation: channel 2: callback done"
 "debug2: channel 2: open confirm rwindow 0 rmax 32768"
 "debug1: mux_client_request_session: master session id: 2"
 "debug2: channel_input_status_confirm: type 99 id 2"
 "debug2: PTY allocation request accepted on channel 2"
 "debug2: channel 2: rcvd adjust 2097152"
 "debug2: channel_input_status_confirm: type 99 id 2"
 "debug2: exec request accepted on channel 2"
 "debug2: channel 2: rcvd eof"
 "debug2: channel 2: output open -> drain"
 "debug1: client_input_channel_req: channel 2 rtype exit-status reply 0"
 "debug1: client_input_channel_req: channel 2 rtype eow@openssh.com reply 0"
 "debug2: channel 2: rcvd eow"
 "debug2: chan_shutdown_read: channel 2: (i0 o1 sock -1 wfd 7 efd 9 [write])"
 "debug2: channel 2: input open -> closed"
 "debug2: channel 2: rcvd close"
 "debug2: channel 2: obuf empty"
 "debug2: chan_shutdown_write: channel 2: (i3 o1 sock -1 wfd 8 efd 9 [write])"
 "debug2: channel 2: output drain -> closed"
 "debug2: channel 2: send close"
 "debug2: channel 2: is dead"
 "debug2: channel 2: gc: notify user"
 "debug2: channel 1: rcvd close"
 "debug2: channel 1: output open -> drain"
 "debug2: chan_shutdown_read: channel 1: (i0 o1 sock 6 wfd 6 efd -1 [closed])"
 "debug2: channel 1: input open -> closed"
 "debug2: channel 2: gc: user detached"
 "debug2: channel 2: is dead"
 "debug2: channel 2: garbage collecting"
 "debug1: channel 2: free: client-session, nchannels 3"
 "debug2: channel 1: obuf empty"
 "debug2: chan_shutdown_write: channel 1: (i3 o1 sock 6 wfd 6 efd -1 [closed])"
 "debug2: channel 1: output drain -> closed"
 "debug2: channel 1: is dead (local)"
 "debug2: channel 1: gc: notify user"
 "debug2: channel 1: gc: user detached"
 "debug2: channel 1: is dead (local)"
 "debug2: channel 1: garbage collecting"
 "debug1: channel 1: free: mux-control, nchannels 2"
 "debug2: Received exit status from master 127"
 "debug2: set_control_persist_exit_time: schedule exit in 60 seconds"
 "Shared connection to 10.0.1.10 closed."], "stdout": "bash: sudo scp ec2-user$:./python38 ec2_user@\"10.0.1.10\":.: No such file or directory
"
 "stdout_lines": ["bash: sudo scp ec2-user$:./python38 ec2_user@\"10.0.1.10\":.: No such file or directory"]}
