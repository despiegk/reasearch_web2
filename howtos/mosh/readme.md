

```bash
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

mosh root@192.168.8.8 -A

```

mosh is udp based alternative on ssh, the command is the same see above, don't forget to export the locals

to install on server

```bash
curl https://raw.githubusercontent.com/despiegk/research_web2/main/howtos/mosh/install.sh | bash
```