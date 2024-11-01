curl --include \
    -H "Connection: Upgrade" \
    -H "Upgrade: websocket" \
    -H "Sec-WebSocket-Key: qwerty" \
    -H "Sec-WebSocket-Version: 13" \
    https://example.com -k



curl -v -i -N \
    -H "Connection: Upgrade" \
    -H "Upgrade: websocket" \
    -H "Host: pop-trtpggpasdev.extdev.eu" \
    -H "Origin: https://pop-trtpggpasdev.extdev.eu:8082" \
    --key /etc/ssl/private/RGS-MULTISITE-dev-cert-to-pop-PlaytechDevelopmentAPIAuthCAG1-20230927-20250927.pem \
    --cert /etc/ssl/private/RGS-MULTISITE-dev-cert-to-pop-PlaytechDevelopmentAPIAuthCAG1-20230927-20250927.pem \
    https://pop-trtpggpasdev.extdev.eu:8082


curl -v -i -N \
    -H "Connection: Upgrade" \
    -H "Upgrade: websocket" \
    -H "Host: cpppgstress3-pop.crossperf.eu" \
    -H "Origin: https://cpppgstress3-pop.crossperf.eu:8082" \
    --key /etc/ssl/private/RGS-CROSS-SITE-POP-GPAS-communication-CTASK0122785-PlaytechDevelopmentAPIAuthCAG1-20210113-20230113.pem \
    --cert /etc/ssl/private/RGS-CROSS-SITE-POP-GPAS-communication-CTASK0122785-PlaytechDevelopmentAPIAuthCAG1-20210113-20230113.pem \
    https://cpppgstress3-pop.crossperf.eu:8082/?gsId=gpas


curl -v -i -N \
    -H "Connection: Upgrade" \
    -H "Upgrade: websocket" \
    -H "Host: cpppgstress1-pop-crossperf-eu-cpp3-cpp1.gpas-proxy.service.consul" \
    -H "Origin: https://cpppgstress1-pop-crossperf-eu-cpp3-cpp1.gpas-proxy.service.consul:80" \
    http://cpppgstress1-pop-crossperf-eu-cpp3-cpp1.gpas-proxy.service.consul/?gsId=gpas

    cpppgstress1-pop-crossperf-eu-cpp3-cpp1.gpas-proxy.service.consul/?gsId=gpas


    combined_sslclient