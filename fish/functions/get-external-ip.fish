function get-external-ip --description "Get external IP address"
    curl -s http://checkip.amazonaws.com
end
