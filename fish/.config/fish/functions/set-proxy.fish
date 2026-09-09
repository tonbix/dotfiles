function set-proxy-netns
    sudo ip netns exec proxyns sudo -u $USER $argv
end

function set-proxy
	set -l proxy_url "socks5h://127.0.0.1:2080"

	set -lx http_proxy $proxy_url
	set -lx https_proxy $proxy_url
	set -lx all_proxy $proxy_url
	set -lx HTTP_PROXY $proxy_url
	set -lx HTTPS_PROXY $proxy_url
	set -lx ALL_PROXY $proxy_url

	$argv
end
