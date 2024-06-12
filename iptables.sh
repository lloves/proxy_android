# Accept TCP traffic on ports 8123 and 8124
iptables -A INPUT -i ap+ -p tcp --dport 8123 -j ACCEPT
iptables -A INPUT -i ap+ -p tcp --dport 8124 -j ACCEPT
iptables -A INPUT -i wlan1 -p tcp --dport 8123 -j ACCEPT
iptables -A INPUT -i wlan1 -p tcp --dport 8124 -j ACCEPT
iptables -A INPUT -i lo -p tcp --dport 8123 -j ACCEPT
iptables -A INPUT -i lo -p tcp --dport 8124 -j ACCEPT

# Accept UDP traffic on ports 8123 and 8124
iptables -A INPUT -i ap+ -p udp --dport 8123 -j ACCEPT
iptables -A INPUT -i ap+ -p udp --dport 8124 -j ACCEPT
iptables -A INPUT -i wlan1 -p udp --dport 8123 -j ACCEPT
iptables -A INPUT -i wlan1 -p udp --dport 8124 -j ACCEPT
iptables -A INPUT -i lo -p udp --dport 8123 -j ACCEPT
iptables -A INPUT -i lo -p udp --dport 8124 -j ACCEPT

# Drop TCP traffic on ports 8123 and 8124
iptables -A INPUT -p tcp --dport 8123 -j DROP
iptables -A INPUT -p tcp --dport 8124 -j DROP

# Drop UDP traffic on ports 8123 and 8124
iptables -A INPUT -p udp --dport 8123 -j DROP
iptables -A INPUT -p udp --dport 8124 -j DROP

# Redirect TCP traffic
iptables -t nat -A PREROUTING -i ap+ -p tcp -d 192.168.43.1/24 -j RETURN
iptables -t nat -A PREROUTING -i ap+ -p tcp -j REDIRECT --to 8123
iptables -t nat -A PREROUTING -i wlan1 -p tcp -d 192.168.43.1/24 -j RETURN
iptables -t nat -A PREROUTING -i wlan1 -p tcp -j REDIRECT --to 8123

# Redirect UDP traffic
iptables -t nat -A PREROUTING -i ap+ -p udp -d 192.168.43.1/24 -j RETURN
iptables -t nat -A PREROUTING -i ap+ -p udp -j REDIRECT --to 8123
iptables -t nat -A PREROUTING -i wlan1 -p udp -d 192.168.43.1/24 -j RETURN
iptables -t nat -A PREROUTING -i wlan1 -p udp -j REDIRECT --to 8123


/system/bin/iptables -t nat -A OUTPUT -p tcp -d 47.251.61.173 -j RETURN
/system/bin/iptables -t nat -A OUTPUT -p udp -d 47.251.61.173 -j RETURN
/system/bin/iptables -t nat -A OUTPUT -p tcp -j REDIRECT --to 8123
/system/bin/iptables -t nat -A OUTPUT -p udp -j REDIRECT --to 8123
